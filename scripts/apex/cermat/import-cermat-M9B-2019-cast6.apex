String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M9B 2019 – úloha 12',
  new List<String>{'V trojúhelníku na obrázku je vrchol rozdělen na tři shodné úhly $\\varphi$, jedna z úseček je kolmá k základně (pravý úhel) a u paty je vyznačen úhel $116^\\circ$; u dolních vrcholů jsou úhly $\\alpha$ a $\\beta$.','Kolik je $\\alpha+\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $90^\\circ$','B) $92^\\circ$','C) $102^\\circ$','D) $112^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 300" font-family="sans-serif"> <line x1="60" y1="250" x2="520" y2="250" stroke="#000" stroke-width="2"/> <line x1="240" y1="50" x2="60" y2="250" stroke="#000" stroke-width="2"/> <line x1="240" y1="50" x2="240" y2="250" stroke="#000" stroke-width="1.4"/> <line x1="240" y1="50" x2="360" y2="250" stroke="#000" stroke-width="1.4"/> <line x1="240" y1="50" x2="520" y2="250" stroke="#000" stroke-width="2"/> <path d="M 226 250 L 226 236 L 240 236" fill="none" stroke="#000" stroke-width="1.2"/> <text x="200" y="118" font-size="17" font-style="italic">φ</text> <text x="240" y="112" font-size="17" font-style="italic" text-anchor="middle">φ</text> <text x="278" y="120" font-size="17" font-style="italic">φ</text> <text x="82" y="242" font-size="17" font-style="italic">α</text> <text x="500" y="242" font-size="17" font-style="italic">β</text> <text x="352" y="240" font-size="15" text-anchor="middle">116°</text> </svg>',
  'uhly-trojuhelnik.svg',
  'Trojúhelník se svislou výškou z horního vrcholu; horní vrchol je rozdělen na tři shodné úhly φ, u paty výšky je pravý úhel a vpravo úhel 116°, u dolních vrcholů úhly α a β.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'V pravoúhlém trojúhelníku s výškou platí $\\alpha=90^\\circ-\\varphi$. Úhel u paty šikmé úsečky je $116^\\circ=90^\\circ+\\varphi$, odtud $\\varphi=26^\\circ$. Vrcholový úhel je $3\\varphi=78^\\circ$, proto $\\alpha+\\beta=180^\\circ-3\\varphi=180^\\circ-78^\\circ=102^\\circ$.'},
  'C) $102^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 13',
  new List<String>{'Rotační válec s podstavou o poloměru $5$ cm stojící na vodorovné podložce jsme svislými řezy rozdělili na čtyři shodná nová tělesa. Povrch válce byl šedý (včetně podstav), ale všechny nové plochy vytvořené rozříznutím jsou bílé. Součet obsahů obou bílých ploch na jednom z nových těles je $80$ cm².','Jaký je objem jednoho z nových těles? Výsledek je zaokrouhlen na celé cm³.'},
  new List<String>{'A) menší než $125$ cm³','B) $126$ cm³','C) $141$ cm³','D) $157$ cm³','E) větší než $158$ cm³'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif"> <path d="M 80 115 L 80 255 A 95 34 0 0 0 250 255 L 250 115 A 95 34 0 0 1 80 115 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.5"/> <path d="M 160 80 L 80 115 L 80 255 L 160 220 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <path d="M 160 80 L 250 115 L 250 255 L 160 220 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <path d="M 160 80 L 80 115 A 95 34 0 0 0 250 115 Z" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/> <line x1="160" y1="80" x2="250" y2="115" stroke="#000" stroke-width="1"/> <text x="212" y="86" font-size="14" text-anchor="middle">5 cm</text> <text x="165" y="285" font-size="14" text-anchor="middle" fill="#333">jedno nové těleso</text> </svg>',
  'valec-ctvrtina.svg',
  'Jedno ze čtyř shodných těles vzniklých rozříznutím válce – čtvrtinový válec se dvěma bílými obdélníkovými řeznými plochami; poloměr 5 cm.',
  'Jedno z nových těles (čtvrtina válce)',
  new List<String>{'Každá bílá plocha je obdélník o rozměrech $r\\times v=5\\times v$. Dvě plochy: $2\\cdot 5\\cdot v=80$, tedy $v=8$ cm. Objem celého válce $\\pi r^2 v=\\pi\\cdot 25\\cdot 8=200\\pi$ cm³; jedna čtvrtina $\\frac{200\\pi}{4}=50\\pi\\doteq 157$ cm³.'},
  'D) $157$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
