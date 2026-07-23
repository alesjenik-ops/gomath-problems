String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD22C0T04';
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
  'CERMAT M9D 2022 – úloha 6',
  new List<String>{'Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě mají čtyři krabice s činkami: dvě jsou plné, dvě poloprázdné a vše dohromady váží $47$ kg. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16$ kg.','Vypočtěte, kolik kilogramů váží','6.1 jedna plná krabice s činkami,','6.2 jedna činka,','6.3 jedna prázdná krabice.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hmotnost jedné činky $c$ a prázdné krabice $b$. Poloprázdná krabice váží $b+3c$; dvě poloprázdné $2(b+3c)=16$, tj. $b+3c=8$. Všechny čtyři krabice $2(b+6c)+2(b+3c)=47$, tj. $4b+18c=47$.','Z $2b+6c=16$ a $4b+18c=47$ plyne $6c=15$, tedy $c=2{,}5$ kg a $b=0{,}5$ kg.','6.1 Plná krabice $b+6c=0{,}5+15=15{,}5$ kg. 6.2 Jedna činka $2{,}5$ kg. 6.3 Prázdná krabice $0{,}5$ kg.'},
  '6.1: $15{,}5$ kg; 6.2: $2{,}5$ kg; 6.3: $0{,}5$ kg',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2022 – úloha 7',
  new List<String>{'Z nádvoří se chodí nahoru na ochoz věže po $80$ stejných vyšších schodech, zpět dolů se chodí jiným schodištěm po $96$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly. Václav šel z nádvoří nahoru a po $60$ schodech potkal na 2. odpočívadle Danu, která šla dolů. Když Dana sešla ještě o $30$ schodů níže, potkala na 1. odpočívadle Evu, která šla nahoru.','Vypočtěte,','7.1 kolik schodů sešla Dana dolů z ochozu, než potkala Václava,','7.2 kolik schodů vyšla Eva nahoru z nádvoří, než potkala Danu.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 335" font-family="sans-serif"> <polygon points="175,72 295,72 235,34" fill="none" stroke="#999"/> <line x1="175" y1="72" x2="175" y2="300" stroke="#999"/> <line x1="295" y1="72" x2="295" y2="300" stroke="#999"/> <line x1="150" y1="92" x2="295" y2="92" stroke="#000"/> <line x1="175" y1="150" x2="295" y2="150" stroke="#000"/> <line x1="175" y1="220" x2="295" y2="220" stroke="#000"/> <line x1="150" y1="300" x2="345" y2="300" stroke="#000" stroke-width="2"/> <line x1="212" y1="96" x2="212" y2="298" stroke="#444" stroke-dasharray="3 4"/> <polygon points="212,96 208,107 216,107" fill="#444"/> <line x1="258" y1="94" x2="258" y2="296" stroke="#444" stroke-dasharray="3 4"/> <polygon points="258,296 254,285 262,285" fill="#444"/> <text x="145" y="96" font-size="13" text-anchor="end">ochoz</text> <text x="145" y="154" font-size="13" text-anchor="end">2. odpočívadlo</text> <text x="145" y="224" font-size="13" text-anchor="end">1. odpočívadlo</text> <text x="145" y="304" font-size="13" text-anchor="end">nádvoří</text> <text x="207" y="320" font-size="12" text-anchor="middle">nahoru</text> <text x="262" y="320" font-size="12" text-anchor="middle">dolů</text> </svg>',
  'schodiste.svg',
  'Věž se dvěma schodišti (nahoru 80 schodů, dolů 96 schodů) a dvěma odpočívadly mezi nádvořím a ochozem.',
  'Věž se dvěma schodišti a odpočívadly (schematicky)',
  new List<String>{'2. odpočívadlo je ve výšce $\\frac{60}{80}=\\frac{3}{4}$ celkové výšky. 7.1 Z ochozu k němu vede $\\frac{1}{4}$ z $96$ nižších schodů, tj. $24$ schodů.','1. odpočívadlo je o $30$ nižších schodů níže, tedy $24+30=54$ schodů od ochozu; to odpovídá výšce $1-\\frac{54}{96}=\\frac{42}{96}=\\frac{7}{16}$. 7.2 Eva k němu vyšla $\\frac{7}{16}$ z $80$ vyšších schodů, tj. $35$ schodů.'},
  '7.1: $24$ schodů; 7.2: $35$ schodů',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
