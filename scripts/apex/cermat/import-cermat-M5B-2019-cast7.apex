String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD19C0T02';
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
  'CERMAT M5B 2019 – úloha 14',
  new List<String>{'Obkladač vytváří obdélníkovou mozaiku z šedých a bílých čtvercových dlaždic stejné velikosti. V $1$. kroku položil vedle sebe dvě šedé dlaždice. Ve $2$. kroku dlaždice obklopil zleva a shora jednou vrstvou bílých dlaždic. Ve $3$. kroku sestavenou část obklopil zleva a shora jednou vrstvou šedých dlaždic a ve $4$. kroku zleva a shora jednou vrstvou bílých dlaždic.','Každá přidaná vrstva má tvar písmene L. V dalších krocích se stejným způsobem přidává střídavě vrstva šedých a vrstva bílých dlaždic. V dokončené mozaice bude $20$ řad dlaždic.','14.1 Určete, v kolikátém kroku přidá obkladač k mozaice $18$ dlaždic.','14.2 Určete, kolik dlaždic dohromady bude obsahovat dokončená mozaika (s $20$ řadami).','14.3 Určete, kolik šedých dlaždic bude v dokončené mozaice (s $20$ řadami) v $11$. řadě zdola.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 130" font-family="sans-serif"><g stroke="#000" stroke-width="1"><rect x="35" y="80" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="20" y="80" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="98" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="83" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="68" y="80" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="98" y="65" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="83" y="65" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="68" y="65" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="176" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="161" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="146" y="80" width="15" height="15" fill="#ffffff"/><rect x="131" y="80" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="176" y="65" width="15" height="15" fill="#ffffff"/><rect x="161" y="65" width="15" height="15" fill="#ffffff"/><rect x="146" y="65" width="15" height="15" fill="#ffffff"/><rect x="131" y="65" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="176" y="50" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="161" y="50" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="146" y="50" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="131" y="50" width="15" height="15" fill="#b9b9b9" stroke-dasharray="3 2"/><rect x="269" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="254" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="239" y="80" width="15" height="15" fill="#ffffff"/><rect x="224" y="80" width="15" height="15" fill="#b9b9b9"/><rect x="209" y="80" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="269" y="65" width="15" height="15" fill="#ffffff"/><rect x="254" y="65" width="15" height="15" fill="#ffffff"/><rect x="239" y="65" width="15" height="15" fill="#ffffff"/><rect x="224" y="65" width="15" height="15" fill="#b9b9b9"/><rect x="209" y="65" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="269" y="50" width="15" height="15" fill="#b9b9b9"/><rect x="254" y="50" width="15" height="15" fill="#b9b9b9"/><rect x="239" y="50" width="15" height="15" fill="#b9b9b9"/><rect x="224" y="50" width="15" height="15" fill="#b9b9b9"/><rect x="209" y="50" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="269" y="35" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="254" y="35" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="239" y="35" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="224" y="35" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/><rect x="209" y="35" width="15" height="15" fill="#ffffff" stroke-dasharray="3 2"/></g><g font-size="11" text-anchor="middle"><text x="35" y="115">1. krok</text><text x="90" y="115">2. krok</text><text x="161" y="115">3. krok</text><text x="246" y="115">4. krok</text></g><text x="300" y="60" font-size="16">…</text><text x="308" y="42" font-size="9">4. řada</text><text x="308" y="88" font-size="9">1. řada</text></svg>',
  'mozaika.svg',
  'Čtyři kroky vzniku mozaiky: střídavě přidávané L-vrstvy šedých a bílých dlaždic, poslední přidaná vrstva je vyznačena čárkovaně.',
  'První čtyři kroky tvorby mozaiky',
  new List<String>{'Po $k$. kroku má mozaika rozměr $k$ řad krát $k + 1$ sloupců; v $k$. kroku ($k \\ge 2$) přibude $2k$ dlaždic.','14.1 $2k = 18 \\Rightarrow k = 9$, tedy v $9$. kroku.','14.2 Dokončená mozaika má $20$ řad, tj. rozměr $20 \\times 21$, celkem $20 \\cdot 21 = 420$ dlaždic.','14.3 V $11$. řadě zdola je $21$ dlaždic. Prvních $12$ (vzniklých v $11$. kroku, který je lichý) je šedých; z dalších sloupců přidaných v lichých krocích $13$, $15$, $17$, $19$ jsou šedé ještě $4$. Celkem $12 + 4 = 16$ šedých dlaždic.'},
  '14.1: v $9$. kroku; 14.2: $420$ dlaždic; 14.3: $16$ šedých dlaždic',
  4, 7, '4',
  new List<String>{'zs1','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
