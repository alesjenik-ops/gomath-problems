String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M7A 2017 – úloha 14',
  new List<String>{'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma (9 dnů) a na chatě (12 dnů), další údaje chybí.','Kolik dnů strávila Katka u babičky?'},
  new List<String>{'A) 6 dnů','B) 7 dnů','C) 8 dnů','D) 9 dnů','E) jiný počet dnů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 285" font-family="sans-serif"><g stroke="#999" stroke-width="0.8"><line x1="195" y1="30" x2="195" y2="220"/><line x1="225" y1="30" x2="225" y2="220"/><line x1="255" y1="30" x2="255" y2="220"/><line x1="285" y1="30" x2="285" y2="220"/><line x1="315" y1="30" x2="315" y2="220"/><line x1="345" y1="30" x2="345" y2="220"/><line x1="375" y1="30" x2="375" y2="220"/><line x1="405" y1="30" x2="405" y2="220"/><line x1="435" y1="30" x2="435" y2="220"/><line x1="465" y1="30" x2="465" y2="220"/><line x1="495" y1="30" x2="495" y2="220"/><line x1="525" y1="30" x2="525" y2="220"/><line x1="555" y1="30" x2="555" y2="220"/><line x1="585" y1="30" x2="585" y2="220"/></g><g stroke="#555" stroke-width="1.4"><line x1="180" y1="30" x2="180" y2="220"/><line x1="210" y1="30" x2="210" y2="220"/><line x1="240" y1="30" x2="240" y2="220"/><line x1="270" y1="30" x2="270" y2="220"/><line x1="300" y1="30" x2="300" y2="220"/><line x1="330" y1="30" x2="330" y2="220"/><line x1="360" y1="30" x2="360" y2="220"/><line x1="390" y1="30" x2="390" y2="220"/><line x1="420" y1="30" x2="420" y2="220"/><line x1="450" y1="30" x2="450" y2="220"/><line x1="480" y1="30" x2="480" y2="220"/><line x1="510" y1="30" x2="510" y2="220"/><line x1="540" y1="30" x2="540" y2="220"/><line x1="570" y1="30" x2="570" y2="220"/><line x1="600" y1="30" x2="600" y2="220"/></g><g fill="none" stroke="#000" stroke-width="1.6"><rect x="180" y="30" width="420" height="38"/><rect x="180" y="68" width="420" height="38"/><rect x="180" y="106" width="420" height="38"/><rect x="180" y="144" width="420" height="38"/><rect x="180" y="182" width="420" height="38"/></g><g font-size="14" text-anchor="end"><text x="170" y="54">doma</text><text x="170" y="92">na táboře</text><text x="170" y="130">u babičky</text><text x="170" y="168">u kamarádky</text><text x="170" y="206">na chatě</text></g><g fill="#c9c9c9" stroke="#000" stroke-width="1.6"><rect x="180" y="40" width="135" height="18"/><rect x="180" y="192" width="180" height="18"/></g><g font-size="13" text-anchor="middle"><text x="180" y="240">0</text><text x="210" y="240">2</text><text x="240" y="240">4</text><text x="270" y="240">6</text><text x="300" y="240">8</text><text x="330" y="240">10</text><text x="360" y="240">12</text><text x="390" y="240">14</text><text x="420" y="240">16</text><text x="450" y="240">18</text><text x="480" y="240">20</text><text x="510" y="240">22</text><text x="540" y="240">24</text><text x="570" y="240">26</text><text x="600" y="240">28</text><text x="390" y="264" font-size="14">počet dnů</text></g></svg>',
  'graf-prazdniny.svg',
  'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pruhy doma 9 dnů a na chatě 12 dnů, osa 0 až 28 dnů.',
  'Počet dnů strávených na jednotlivých místech',
  new List<String>{'Doma $9$ dnů. Na táboře o třetinu více: $9+3=12$ dnů.','U babičky o čtvrtinu kratší dobu než na táboře: $12-3=9$ dnů.'},
  'D) 9 dnů',
  2, 3, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
