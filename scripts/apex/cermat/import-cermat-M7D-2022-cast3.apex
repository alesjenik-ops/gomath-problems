String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
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
  'CERMAT M7D 2022 – úloha 5',
  new List<String>{'Z nádvoří se chodí nahoru na ochoz věže po $80$ stejných vyšších schodech, zatímco zpět na nádvoří se chodí dolů jiným schodištěm po $96$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly.','Václav šel z nádvoří nahoru a po $60$ schodech potkal na 2. odpočívadle Danu, která šla dolů. Když Dana sešla ještě o $30$ schodů níže, potkala na 1. odpočívadle Evu, která šla nahoru.','5.1 Vypočtěte, kolik schodů sešla Dana dolů z ochozu, než potkala Václava.','5.2 Vypočtěte, kolik schodů vyšla Eva nahoru z nádvoří, než potkala Danu.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 300" font-family="sans-serif" font-size="13"> <polygon points="150,18 214,70 86,70" fill="none" stroke="#999"/> <line x1="86" y1="70" x2="86" y2="262" stroke="#999"/><line x1="214" y1="70" x2="214" y2="262" stroke="#999"/> <line x1="100" y1="80" x2="200" y2="80" stroke="#000" stroke-width="2"/><text x="80" y="84" text-anchor="end">ochoz</text> <line x1="100" y1="140" x2="200" y2="140" stroke="#000"/><text x="80" y="144" text-anchor="end">2. odpočívadlo</text> <line x1="100" y1="200" x2="200" y2="200" stroke="#000"/><text x="80" y="204" text-anchor="end">1. odpočívadlo</text> <line x1="100" y1="260" x2="200" y2="260" stroke="#000"/><text x="80" y="262" text-anchor="end">nádvoří</text> <line x1="128" y1="258" x2="128" y2="84" stroke="#000" stroke-dasharray="3 3"/><polygon points="128,80 124,89 132,89" fill="#000"/> <line x1="172" y1="84" x2="172" y2="258" stroke="#000" stroke-dasharray="3 3"/><polygon points="172,262 168,253 176,253" fill="#000"/> </svg>',
  'vez-schodiste.svg',
  'Schéma věže se dvěma schodišti mezi nádvořím a ochozem a dvěma odpočívadly.',
  'Věž se dvěma schodišti',
  new List<String>{'Výška je pro obě schodiště stejná. Václav vyšel $60$ z $80$ vyšších schodů, je tedy v $\\frac{60}{80}=\\frac{3}{4}$ výšky. Na nižším schodišti to odpovídá $\\frac{3}{4}\\cdot 96=72$ schodům od nádvoří, tj. $96-72=24$ schodům dolů z ochozu (2. odpočívadlo).','5.1 Dana sešla z ochozu $24$ schodů.','Dana sešla dalších $30$ schodů, celkem $24+30=54$ dolních schodů z ochozu, je tedy $96-54=42$ nižších schodů nad nádvořím. Výška 1. odpočívadla je $\\frac{42}{96}=\\frac{7}{16}$ celku, což na vyšším schodišti odpovídá $\\frac{7}{16}\\cdot 80=35$ schodům od nádvoří.','5.2 Eva vyšla z nádvoří $35$ schodů.'},
  '5.1: $24$ schodů; 5.2: $35$ schodů',
  4, 7, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2022 – úloha 6',
  new List<String>{'Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě mají čtyři krabice s činkami: dvě jsou plné, dvě poloprázdné, a vše dohromady váží $47$ kg. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16$ kg.','6.1 Vypočtěte, kolik kilogramů váží jedna plná krabice s činkami.','6.2 Vypočtěte, kolik kilogramů váží jedna činka.','6.3 Vypočtěte, kolik kilogramů váží jedna prázdná krabice.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hmotnost prázdné krabice $k$ a hmotnost jedné činky $c$. Poloprázdná krabice váží $k+3c$, plná $k+6c$.','6.1 Dvě poloprázdné: $2(k+3c)=16$, tj. $k+3c=8$. Všechny čtyři: $2(k+6c)+16=47$, tj. $2(k+6c)=31$, plná $k+6c=15{,}5$ kg.','6.2 Z $k+6c=15{,}5$ a $k+3c=8$ plyne $3c=7{,}5$, tedy $c=2{,}5$ kg.','6.3 $k=8-3\\cdot 2{,}5=0{,}5$ kg.'},
  '6.1: $15{,}5$ kg; 6.2: $2{,}5$ kg; 6.3: $0{,}5$ kg',
  3, 5, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
