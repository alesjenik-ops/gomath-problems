String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M5D 2023 – úloha 4',
  new List<String>{'Malé opičky mají pravidelný denní režim (viz diagram). Po každém 4hodinovém úseku (I.–VI.) se u nich střídají ošetřovatelé. V diagramu představují bílé plochy části dne, které tráví opičky venku, a šedé plochy části dne, po které jsou uvnitř svého příbytku. Dva 4hodinové úseky jsou v diagramu rozděleny, neboť jednu pětinu z II. úseku dne jsou opičky uvnitř příbytku, zatímco jednu šestinu ze VI. úseku dne tráví opičky venku.','4.1 Určete, v kolik hodin a minut opičky ráno vylézají z příbytku ven.','4.2 Určete, v kolik hodin a minut opičky večer zalézají do příbytku.','4.3 Určete, o kolik minut více stráví každý den opičky uvnitř příbytku než venku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"><path d="M200 150 L200.0 32.0 A118 118 0 0 1 302.2 91.0 Z" fill="#c9c9c9"/><path d="M200 150 L302.2 209.0 A118 118 0 0 1 200.0 268.0 Z" fill="#c9c9c9"/><path d="M200 150 L97.8 91.0 A118 118 0 0 1 200.0 32.0 Z" fill="#c9c9c9"/><circle cx="200" cy="150" r="118" fill="none" stroke="#000" stroke-width="2"/><line x1="200" y1="150" x2="200.0" y2="32.0" stroke="#000" stroke-width="1"/><line x1="200" y1="150" x2="302.2" y2="91.0" stroke="#000" stroke-width="1"/><line x1="200" y1="150" x2="302.2" y2="209.0" stroke="#000" stroke-width="1"/><line x1="200" y1="150" x2="200.0" y2="268.0" stroke="#000" stroke-width="1"/><line x1="200" y1="150" x2="97.8" y2="209.0" stroke="#000" stroke-width="1"/><line x1="200" y1="150" x2="97.8" y2="91.0" stroke="#000" stroke-width="1"/><text x="236.6" y="90.6" font-size="13" text-anchor="middle">I.</text><text x="273.2" y="154.0" font-size="13" text-anchor="middle">II.</text><text x="236.6" y="217.4" font-size="13" text-anchor="middle">III.</text><text x="163.4" y="217.4" font-size="13" text-anchor="middle">IV.</text><text x="126.8" y="154.0" font-size="13" text-anchor="middle">V.</text><text x="163.4" y="90.6" font-size="13" text-anchor="middle">VI.</text><text x="200" y="26" font-size="12" text-anchor="middle">pulnoc</text><text x="200" y="286" font-size="12" text-anchor="middle">poledne</text><text x="310" y="213" font-size="12">8:00</text><text x="58" y="213" font-size="12">16:00</text></svg>',
  'diagram-den.svg',
  'Kruhový denní diagram rozdělený na šest 4hodinových úseků I až VI; šedé části jsou uvnitř příbytku, bílé venku.',
  'Schematický denní diagram (šedé = uvnitř příbytku)',
  new List<String>{'4.1 II. úsek je 4:00–8:00. Jedna pětina úseku je $\\frac{4}{5}$ h $=48$ minut, tuto dobu jsou opičky ještě uvnitř; ven vylézají v 4:48.','4.2 VI. úsek je 20:00–24:00. Jedna šestina úseku je $\\frac{4}{6}$ h $=40$ minut, tuto dobu jsou opičky ještě venku; do příbytku zalézají ve 20:40.','4.3 Podle diagramu jsou opičky uvnitř úseky I a III celé a části úseků II ($48$ min) a VI ($200$ min): $240+240+48+200=728$ minut. Venku jsou $1440-728=712$ minut. Rozdíl je $728-712=16$ minut.'},
  '4.1: v 4:48; 4.2: ve 20:40; 4.3: o $16$ minut',
  4, 7, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2023 – úloha 5',
  new List<String>{'Na miskách vah leží jedno velké, jedno střední a tři stejná malá závaží. Hmotnost středního závaží je o třetinu menší než hmotnost velkého závaží. Jedno velké a jedno malé závaží váží dohromady 100 g, stejně jako jedno střední a dvě malá závaží.','5.1 Určete, kolikrát větší je hmotnost velkého závaží než hmotnost malého závaží.','5.2 Určete, kolik gramů váží střední závaží.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Označme velké $V$, střední $S$, malé $m$. Platí $S=\\frac{2}{3}V$, dále $V+m=100$ a $S+2m=100$. Porovnáním $V+m=S+2m$ plyne $V-S=m$; protože $S=\\frac{2}{3}V$, je $\\frac{1}{3}V=m$, tedy $V=3m$ — velké závaží je $3$krát těžší než malé.','5.2 Z $V+m=100$ a $V=3m$ plyne $4m=100$, $m=25$ g a $V=75$ g. Střední $S=\\frac{2}{3}\\cdot 75=50$ g.'},
  '5.1: $3$krát; 5.2: $50$ gramů',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
