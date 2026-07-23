String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M5D 2024 – úloha 14',
  new List<String>{'Standa se rozhodl, že bude prodávat domácí vajíčka. Koupil $99$ slepic, za které zaplatil $12\\,000$ Kč. Slepice snášely vajíčka takto: každá třetí slepice snášela vajíčko každý den ráno, každá druhá slepice ze zbývajících snášela vajíčko každý druhý den ráno a zbylé slepice snášely vajíčko každý třetí den ráno. Standa sesbíral každé odpoledne všechna snesená vajíčka a prodával jedno za $3$ Kč.','14.1 Kolik vajíček sesbíral Standa za prvních šest dní?','14.2 Kolik peněz Standa utržil za vajíčka, pokud prodal všechna vajíčka snesená za prvních $30$ dní?','14.3 Po čtyřiceti dvou dnech musel Standa slepice prodat. Prodal je dohromady za $6\\,000$ Kč. Kolik peněz Standa utržil za slepice a vajíčka za celou dobu (za $42$ dní), pokud prodal všechna vajíčka, která slepice za $42$ dní snesly?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Slepice se dělí na tři skupiny po $33$: skupina A ($33$ slepic) snáší každý den, skupina B ($33$) každý druhý den, skupina C ($33$) každý třetí den.','14.1 Za $6$ dní: A $33\\cdot 6=198$, B $33\\cdot 3=99$, C $33\\cdot 2=66$; celkem $198+99+66=363$ vajíček.','14.2 Za $30$ dní: A $33\\cdot 30=990$, B $33\\cdot 15=495$, C $33\\cdot 10=330$; celkem $1\\,815$ vajíček, tržba $1\\,815\\cdot 3=5\\,445$ Kč.','14.3 Za $42$ dní: A $33\\cdot 42=1\\,386$, B $33\\cdot 21=693$, C $33\\cdot 14=462$; celkem $2\\,541$ vajíček, za ně $2\\,541\\cdot 3=7\\,623$ Kč. Se slepicemi: $7\\,623+6\\,000=13\\,623$ Kč.'},
  '14.1: $363$ vajíček; 14.2: $5\\,445$ Kč; 14.3: $13\\,623$ Kč',
  6, 10, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
