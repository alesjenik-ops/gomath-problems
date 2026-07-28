String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
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
  'CERMAT M7A 2016 – úloha 17',
  new List<String>{'Ve čtverci jsou obě úhlopříčky překryty tmavými čtverečky s délkou strany 4 cm podobně jako na obrázku. Zbytek plochy čtverce je bílý.','Uveďte postup řešení.','17.1 Vypočtěte délku strany čtverce, který má celkem 9 tmavých čtverečků.','17.2 Vypočtěte délku strany čtverce, který má celkem 69 tmavých čtverečků.','17.3 Vypočtěte celkový počet tmavých čtverečků, je-li délka strany čtverce 884 cm.'},
  null,
  5,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 264" font-family="sans-serif"><rect x="30" y="76" width="22" height="22" fill="#bdbdbd"/><rect x="118" y="76" width="22" height="22" fill="#bdbdbd"/><rect x="52" y="98" width="22" height="22" fill="#bdbdbd"/><rect x="96" y="98" width="22" height="22" fill="#bdbdbd"/><rect x="74" y="120" width="22" height="22" fill="#bdbdbd"/><rect x="52" y="142" width="22" height="22" fill="#bdbdbd"/><rect x="96" y="142" width="22" height="22" fill="#bdbdbd"/><rect x="30" y="164" width="22" height="22" fill="#bdbdbd"/><rect x="118" y="164" width="22" height="22" fill="#bdbdbd"/><line x1="30" y1="76" x2="30" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="76" x2="140" y2="76" stroke="#666" stroke-width="1"/><line x1="52" y1="76" x2="52" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="98" x2="140" y2="98" stroke="#666" stroke-width="1"/><line x1="74" y1="76" x2="74" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="120" x2="140" y2="120" stroke="#666" stroke-width="1"/><line x1="96" y1="76" x2="96" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="142" x2="140" y2="142" stroke="#666" stroke-width="1"/><line x1="118" y1="76" x2="118" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="164" x2="140" y2="164" stroke="#666" stroke-width="1"/><line x1="140" y1="76" x2="140" y2="186" stroke="#666" stroke-width="1"/><line x1="30" y1="186" x2="140" y2="186" stroke="#666" stroke-width="1"/><rect x="30" y="76" width="110" height="110" fill="none" stroke="#000" stroke-width="2"/><rect x="250" y="22" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="450" y="22" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="270" y="42" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="430" y="42" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="410" y="62" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="290" y="62" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="350" y="122" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="410" y="182" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="290" y="182" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="430" y="202" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="270" y="202" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="250" y="222" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><rect x="450" y="222" width="20" height="20" fill="#bdbdbd" stroke="#555" stroke-width="1"/><circle cx="320.0" cy="92.0" r="2.5" fill="#333"/><circle cx="400.0" cy="92.0" r="2.5" fill="#333"/><circle cx="340.0" cy="112.0" r="2.5" fill="#333"/><circle cx="380.0" cy="112.0" r="2.5" fill="#333"/><circle cx="340.0" cy="152.0" r="2.5" fill="#333"/><circle cx="380.0" cy="152.0" r="2.5" fill="#333"/><circle cx="320.0" cy="172.0" r="2.5" fill="#333"/><circle cx="400.0" cy="172.0" r="2.5" fill="#333"/><rect x="250" y="22" width="220" height="220" fill="none" stroke="#000" stroke-width="2"/></svg>',
  'ctverec-uhlopricky.svg',
  'Dva čtverce, jejichž obě úhlopříčky jsou překryty tmavými čtverečky se stranou 4 cm; menší čtverec má 9 tmavých čtverečků, u většího je řada naznačena tečkami.',
  'Čtverce s tmavými čtverečky na obou úhlopříčkách',
  new List<String>{'Je-li strana čtverce $4n$ cm, leží na každé úhlopříčce $n$ tmavých čtverečků a prostřední čtvereček je oběma úhlopříčkám společný. Celkem je tmavých čtverečků $2n-1$.','17.1 $2n-1=9$, tedy $n=5$ a strana čtverce je $5\\cdot 4=20$ cm.','17.2 $2n-1=69$, tedy $n=35$ a strana čtverce je $35\\cdot 4=140$ cm.','17.3 $884:4=221$, tmavých čtverečků je $2\\cdot 221-1=441$.'},
  '17.1: $20$ cm; 17.2: $140$ cm; 17.3: $441$ čtverečků',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
