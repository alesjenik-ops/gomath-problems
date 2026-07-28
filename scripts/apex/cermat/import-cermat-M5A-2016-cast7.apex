String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M5A 2016 – úloha 16',
  new List<String>{'Ve čtverci jsou obě úhlopříčky překryty tmavými čtverečky s délkou strany 4 cm podobně jako na obrázku. Zbytek plochy čtverce je bílý.','16.1 Vypočtěte délku strany čtverce, který má celkem 9 tmavých čtverečků.','16.2 Vypočtěte délku strany čtverce, který má celkem 29 tmavých čtverečků.','16.3 Vypočtěte celkový počet tmavých čtverečků, je-li délka strany čtverce 140 cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 240" font-family="sans-serif"><rect x="20" y="20" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="20" y="180" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="60" y="60" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="60" y="140" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="100" y="100" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="140" y="60" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="140" y="140" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="180" y="20" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="180" y="180" width="40" height="40" fill="#b9b9b9" stroke="#555"/><rect x="20" y="20" width="200" height="200" fill="none" stroke="#000" stroke-width="3"/></svg>',
  'ctverec-uhlopricky.svg',
  'Čtverec rozdělený na 5 krát 5 čtverečků, na obou úhlopříčkách je 9 tmavých čtverečků.',
  'Schematický nákres (čtverec s 9 tmavými čtverečky)',
  new List<String>{'Je-li strana čtverce složena z $n$ čtverečků, leží na každé úhlopříčce $n$ tmavých čtverečků a pro liché $n$ mají jeden společný (prostřední). Celkem je tedy $2n-1$ tmavých čtverečků.','16.1 $2n-1=9$ dává $n=5$, strana měří $5\\cdot 4=20$ cm.','16.2 $2n-1=29$ dává $n=15$, strana měří $15\\cdot 4=60$ cm.','16.3 $140:4=35$ čtverečků na straně, tedy $2\\cdot 35-1=69$ tmavých čtverečků.'},
  '16.1: $20$ cm; 16.2: $60$ cm; 16.3: $69$ čtverečků',
  4, 8, '4',
  new List<String>{'zs1','posloupnosti','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
