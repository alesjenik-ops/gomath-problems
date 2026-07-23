String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
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
  'CERMAT M9A 2019 – úloha 8',
  new List<String>{'Z místa $A$ do místa $B$ šla Iva přímou cestou dlouhou $2$ km. Dan šel z místa $A$ do místa $B$ vycházkovou trasou, která má tvar půlkružnice nad průměrem $AB$ (viz obrázek).','8.1 Vypočtěte, kolikrát delší byla cesta Dana než cesta Ivy. (Výsledek zaokrouhlete na setiny.)','8.2 Vypočtěte, o kolik kilometrů více ušel Dan než Iva. (Výsledek zaokrouhlete na setiny km.)'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif"> <line x1="60" y1="55" x2="300" y2="55" stroke="#000" stroke-width="2" stroke-dasharray="7 6"/> <path d="M60 55 A120 120 0 0 0 300 55" fill="none" stroke="#000" stroke-width="2"/> <circle cx="60" cy="55" r="3" fill="#000"/><circle cx="300" cy="55" r="3" fill="#000"/> <text x="52" y="48" font-size="16" font-style="italic">A</text> <text x="304" y="48" font-size="16" font-style="italic">B</text> <line x1="178" y1="49" x2="182" y2="61" stroke="#000"/> <line x1="350" y1="55" x2="390" y2="55" stroke="#000" stroke-width="2" stroke-dasharray="7 6"/> <text x="398" y="60" font-size="13">Iva</text> <line x1="350" y1="85" x2="390" y2="85" stroke="#000" stroke-width="2"/> <text x="398" y="90" font-size="13">Dan</text> </svg>',
  'pulkruznice.svg',
  'Body A a B spojené přímou úsečkou (Ivina cesta) a půlkružnicí nad průměrem AB (Danova cesta).',
  'Přímá cesta a půlkružnice mezi A a B',
  new List<String>{'Průměr půlkružnice je $|AB| = 2$ km, poloměr $r = 1$ km. Délka Danovy trasy (půlkružnice) je $\\pi r = \\pi \\approx 3{,}14$ km.','8.1 Poměr délek $\\frac{\\pi r}{2} = \\frac{\\pi}{2} \\approx 1{,}57$; Danova cesta byla asi $1{,}57$krát delší.','8.2 Rozdíl $\\pi - 2 \\approx 3{,}14 - 2 = 1{,}14$ km.'},
  '8.1: $1{,}57$krát; 8.2: o $1{,}14$ km',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2019 – úloha 9',
  new List<String>{'V rovině leží přímka $KL$ (viz obrázek). Body $K$, $L$ jsou vrcholy trojúhelníku $KLM$. Velikost úhlu $LKM$ je $30^\\circ$. Vzdálenost bodu $L$ od bodu $K$ je stejná jako vzdálenost bodu $L$ od bodu $M$.','Sestrojte jeden trojúhelník $KLM$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif"> <line x1="30" y1="70" x2="430" y2="70" stroke="#000" stroke-width="2"/> <line x1="180" y1="63" x2="180" y2="77" stroke="#000" stroke-width="2"/> <line x1="300" y1="63" x2="300" y2="77" stroke="#000" stroke-width="2"/> <text x="176" y="95" font-size="16" font-style="italic">K</text> <text x="296" y="95" font-size="16" font-style="italic">L</text> </svg>',
  'primka-kl.svg',
  'Vodorovná přímka KL se dvěma vyznačenými body K a L.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'V bodě $K$ sestrojíme rameno úhlu o velikosti $30^\\circ$ k přímce $KL$; vrchol $M$ leží na tomto rameni. Zároveň $|LM| = |LK|$, tedy $M$ leží na kružnici se středem $L$ a poloměrem $|LK|$. Průsečík ramene s touto kružnicí (různý od $K$) je vrchol $M$. Trojúhelník $KLM$ je rovnoramenný se základnou $KM$.'},
  'Konstrukce: rameno úhlu $LKM = 30^\\circ$ v bodě $K$; vrchol $M$ je průsečík tohoto ramene s kružnicí se středem $L$ a poloměrem $|LK|$ (viz obrázek v klíči).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
