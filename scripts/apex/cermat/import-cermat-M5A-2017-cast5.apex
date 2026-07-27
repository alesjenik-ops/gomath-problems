String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD17C0T01';
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
  'CERMAT M5A 2017 – úloha 12',
  new List<String>{'Katka strávila prázdniny na několika místech. Nejprve byla doma. Na táboře strávila o třetinu více času než doma. U babičky byla o čtvrtinu kratší dobu než na táboře. Pak zůstala u kamarádky. Od ní odjela na chatu, kde pobývala o polovinu delší dobu než u kamarádky. V grafu je vyznačen tmavými pásy počet dnů strávených doma a na chatě, další údaje chybí.','Kolik dnů strávila Katka u kamarádky?'},
  new List<String>{'A) 6 dnů','B) 7 dnů','C) 8 dnů','D) 9 dnů','E) jiný počet dnů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 570 205" font-family="sans-serif"><path d="M128 20V150M143 20V150M158 20V150M173 20V150M188 20V150M203 20V150M218 20V150M233 20V150M248 20V150M263 20V150M278 20V150M293 20V150M308 20V150M323 20V150M338 20V150M353 20V150M368 20V150M383 20V150M398 20V150M413 20V150M428 20V150M443 20V150M458 20V150M473 20V150M488 20V150M503 20V150M518 20V150M533 20V150M548 20V150M128 20H548M128 46H548M128 72H548M128 98H548M128 124H548M128 150H548" stroke="#777" fill="none"/><rect x="128" y="25" width="135" height="16" fill="#b5b5b5" stroke="#000"/><text x="120" y="39" font-size="15" text-anchor="end">doma</text><text x="120" y="65" font-size="15" text-anchor="end">na táboře</text><text x="120" y="91" font-size="15" text-anchor="end">u babičky</text><text x="120" y="117" font-size="15" text-anchor="end">u kamarádky</text><rect x="128" y="129" width="180" height="16" fill="#b5b5b5" stroke="#000"/><text x="120" y="143" font-size="15" text-anchor="end">na chatě</text><text x="128" y="168" font-size="14" text-anchor="middle">0</text><text x="158" y="168" font-size="14" text-anchor="middle">2</text><text x="188" y="168" font-size="14" text-anchor="middle">4</text><text x="218" y="168" font-size="14" text-anchor="middle">6</text><text x="248" y="168" font-size="14" text-anchor="middle">8</text><text x="278" y="168" font-size="14" text-anchor="middle">10</text><text x="308" y="168" font-size="14" text-anchor="middle">12</text><text x="338" y="168" font-size="14" text-anchor="middle">14</text><text x="368" y="168" font-size="14" text-anchor="middle">16</text><text x="398" y="168" font-size="14" text-anchor="middle">18</text><text x="428" y="168" font-size="14" text-anchor="middle">20</text><text x="458" y="168" font-size="14" text-anchor="middle">22</text><text x="488" y="168" font-size="14" text-anchor="middle">24</text><text x="518" y="168" font-size="14" text-anchor="middle">26</text><text x="548" y="168" font-size="14" text-anchor="middle">28</text><text x="338" y="192" font-size="15" text-anchor="middle">počet dnů</text></svg>',
  'graf-prazdniny.svg',
  'Pruhový graf s pěti řádky (doma, na táboře, u babičky, u kamarádky, na chatě); vyplněny jsou jen pásy doma 9 dnů a na chatě 12 dnů, osa je popsána po dvou dnech do 28.',
  'Počet dnů strávených na jednotlivých místech',
  new List<String>{'Z grafu: na chatě $12$ dnů. Doba na chatě je o polovinu delší než u kamarádky, tedy $12$ je jeden a půl násobek doby u kamarádky.','Je-li u kamarádky $x$ dnů, platí $x+\\frac{x}{2}=12$, tj. $\\frac{3x}{2}=12$ a $x=8$ dnů.'},
  'C) 8 dnů',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
