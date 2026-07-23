String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
Integer YEAR = 2022;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M9A 2022 – úloha 12',
  new List<String>{'V rovině leží čtyři vzájemně různoběžné přímky. Tři z nich procházejí bodem $A$ (viz obrázek).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $24^\\circ$','B) $27^\\circ$','C) $32^\\circ$','D) $36^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 500" font-family="sans-serif"> <line x1="361" y1="96" x2="321" y2="482" stroke="#000" stroke-width="2"/> <line x1="149" y1="465" x2="577" y2="311" stroke="#000" stroke-width="2"/> <line x1="270" y1="20" x2="581" y2="331" stroke="#000" stroke-width="2"/> <line x1="215" y1="250" x2="446" y2="498" stroke="#000" stroke-width="2"/> <text x="333" y="176" font-size="20">60°</text> <text x="495" y="300" font-size="20">132°</text> <text x="303" y="356" font-size="18" font-style="italic">α</text> <text x="276" y="424" font-size="18">3α</text> <text x="340" y="424" font-size="17" font-style="italic">A</text> </svg>',
  'uhly-A.svg',
  'Čtyři různoběžné přímky, tři procházejí bodem A; vyznačené úhly 60 stupňů, 132 stupňů, alfa a 3 alfa.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Přímky procházející bodem $A$ (nejstrmější a šikmá) a čtvrtá přímka tvoří trojúhelník s vrcholem $A$ nahoře i vpravo. U horního vrcholu je úhel $60^\\circ$, u pravého vrcholu je vnitřní úhel $180^\\circ-132^\\circ=48^\\circ$. Vnitřní úhel u vrcholu $A$ je $180^\\circ-(\\alpha+3\\alpha)=180^\\circ-4\\alpha$. Ze součtu úhlů v trojúhelníku $60^\\circ+48^\\circ+(180^\\circ-4\\alpha)=180^\\circ$ plyne $4\\alpha=108^\\circ$, tedy $\\alpha=27^\\circ$.'},
  'B) $27^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 13',
  new List<String>{'Papír tvaru kruhu se středem $S$ a poloměrem $10$ cm byl rozstříhán na $5$ shodných výsečí dle obrázku.','Jaký je obvod jedné výseče? Výsledek je zaokrouhlen na celé cm.'},
  new List<String>{'A) menší než $25$ cm','B) $25$ cm','C) $30$ cm','D) $33$ cm','E) větší než $33$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"> <circle cx="150" cy="150" r="88" fill="none" stroke="#000" stroke-width="2"/> <line x1="150" y1="150" x2="150" y2="62" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="150" x2="66" y2="123" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="150" x2="98" y2="221" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="150" x2="202" y2="221" stroke="#000" stroke-width="1.5"/> <line x1="150" y1="150" x2="234" y2="123" stroke="#000" stroke-width="1.5"/> <text x="156" y="146" font-size="15" font-style="italic">S</text> <path d="M 330 160 L 414 130 A 84 84 0 0 1 408 190 Z" fill="none" stroke="#000" stroke-width="2"/> <text x="372" y="104" font-size="15">Výseč</text> <text x="320" y="168" font-size="15" font-style="italic">S</text> </svg>',
  'kruh-vysece.svg',
  'Kruh se středem S rozdělený pěti poloměry na 5 shodných výsečí a vedle jedna samostatná výseč.',
  'Kruh rozdělený na 5 shodných výsečí',
  new List<String>{'Výseč má středový úhel $\\dfrac{360^\\circ}{5}=72^\\circ$. Její obvod tvoří dva poloměry a oblouk: $2\\cdot 10+\\dfrac{72}{360}\\cdot 2\\pi\\cdot 10=20+4\\pi\\doteq 20+12{,}6=32{,}6$ cm, po zaokrouhlení $33$ cm.'},
  'D) $33$ cm',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
