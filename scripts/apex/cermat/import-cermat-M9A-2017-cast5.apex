String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD17C0T01';
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
  'CERMAT M9A 2017 – úloha 14',
  new List<String>{'V lahvi je $1{,}5$ litru minerálky. Všechnu minerálku z lahve přelijeme do prázdných skleniček o objemu $\\frac{1}{3}$ litru. Kromě poslední skleničky budou všechny ostatní skleničky naplněné po okraj.','Jakou část objemu poslední skleničky vyplní zbytek minerálky?'},
  new List<String>{'A) $\\frac{1}{2}$','B) $\\frac{1}{3}$','C) $\\frac{1}{5}$','D) $\\frac{2}{3}$','E) jinou část'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}5:\\frac{1}{3}=1{,}5\\cdot 3=4{,}5$.','Plných skleniček je 4 a zbývá $1{,}5-4\\cdot\\frac{1}{3}=1{,}5-\\frac{4}{3}=\\frac{1}{6}$ litru.','$\\frac{1}{6}:\\frac{1}{3}=\\frac{1}{2}$, tedy polovina objemu poslední skleničky.'},
  'A) $\\frac{1}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2017 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Celkem $70\\,\\%$ z $520$ důchodců používá kartu do bankomatu. Kolik důchodců nepoužívá kartu do bankomatu?','15.2 Do oddílu přibyli 3 noví členové a počet členů se tak zvýšil o $2\\,\\%$. Kolik členů má nyní oddíl?','15.3 Ve sportovním gymnáziu hraje $20\\,\\%$ chlapců hokej a zbývajících $192$ chlapců florbal. Chlapci tvoří $60\\,\\%$ všech žáků tohoto gymnázia. Kolik dívek navštěvuje sportovní gymnázium?'},
  new List<String>{'A) méně než $151$','B) $151$','C) $153$','D) $156$','E) $160$','F) více než $160$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Kartu nepoužívá $30\\,\\%$ z $520$, tedy $0{,}3\\cdot 520=156$ → D.','15.2 $2\\,\\%$ původního počtu jsou 3 členové, původně tedy $150$ členů; nyní $150+3=153$ → C.','15.3 $192$ chlapců je $80\\,\\%$ chlapců, chlapců je $192:0{,}8=240$. To je $60\\,\\%$ žáků, žáků je $240:0{,}6=400$. Dívek je $400-240=160$ → E.'},
  '15.1: D ($156$); 15.2: C ($153$); 15.3: E ($160$)',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
