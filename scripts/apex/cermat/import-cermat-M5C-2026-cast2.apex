String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
Integer YEAR = 2026;

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
  'CERMAT M5C 2026 – úloha 4',
  new List<String>{'Sadu tvoří 27 závaží. Celková hmotnost všech závaží v sadě je 1 kg. Sada obsahuje pouze malá, střední a velká závaží, viz tabulka.','4.1 Určete počet velkých závaží v sadě.','4.2 Určete v gramech celkovou hmotnost všech středních závaží v sadě.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 130" font-family="sans-serif"><rect x="20" y="20" width="150" height="30" fill="#ffffff" stroke="#000"/><text x="95.0" y="39.0" font-size="12" text-anchor="middle">Závaží</text><rect x="170" y="20" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="205.0" y="39.0" font-size="12" text-anchor="middle">Malé</text><rect x="240" y="20" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="275.0" y="39.0" font-size="12" text-anchor="middle">Střední</text><rect x="310" y="20" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="345.0" y="39.0" font-size="12" text-anchor="middle">Velké</text><rect x="20" y="50" width="150" height="30" fill="#ffffff" stroke="#000"/><text x="95.0" y="69.0" font-size="12" text-anchor="middle">Hmotnost 1 kusu</text><rect x="170" y="50" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="205.0" y="69.0" font-size="12" text-anchor="middle">15 g</text><rect x="240" y="50" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="275.0" y="69.0" font-size="12" text-anchor="middle">25 g</text><rect x="310" y="50" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="345.0" y="69.0" font-size="12" text-anchor="middle">50 g</text><rect x="20" y="80" width="150" height="30" fill="#ffffff" stroke="#000"/><text x="95.0" y="99.0" font-size="12" text-anchor="middle">Počet kusů v sadě</text><rect x="170" y="80" width="70" height="30" fill="#ffffff" stroke="#000"/><text x="205.0" y="99.0" font-size="12" text-anchor="middle">5</text><rect x="240" y="80" width="70" height="30" fill="#ffffff" stroke="#000"/><rect x="310" y="80" width="70" height="30" fill="#ffffff" stroke="#000"/></svg>',
  'zavazi.svg',
  'Tabulka s hmotností jednoho kusu a počtem malých, středních a velkých závaží.',
  'Tabulka závaží',
  new List<String>{'Malá závaží mají hmotnost $5\\cdot 15 = 75$ g. Na střední a velká zbývá $1000-75 = 925$ g a $27-5 = 22$ kusů.','4.1 Označme počet velkých $v$ a středních $m$: $m+v = 22$ a $25m+50v = 925$. Z toho $m+2v = 37$, tedy $v = 15$. Velkých závaží je $15$.','4.2 Středních je $m = 22-15 = 7$, jejich hmotnost je $7\\cdot 25 = 175$ g.'},
  '4.1: $15$ velkých závaží; 4.2: $175$ gramů',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
