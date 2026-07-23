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
  'CERMAT M5C 2026 – úloha 8',
  new List<String>{'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), nebo nepravdivé (N).','8.1 V pátek mělo službu v kuchyni celkem 9 dětí.','8.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.','8.3 Instruktorů muselo být na táboře nejméně 8.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 275" font-family="sans-serif"><line x1="60" y1="30" x2="60" y2="210" stroke="#000"/><line x1="60" y1="210" x2="540" y2="210" stroke="#000"/><line x1="56" y1="210" x2="60" y2="210" stroke="#000"/><text x="52" y="214" font-size="11" text-anchor="end">0</text><line x1="56" y1="180" x2="60" y2="180" stroke="#000"/><text x="52" y="184" font-size="11" text-anchor="end">1</text><line x1="56" y1="150" x2="60" y2="150" stroke="#000"/><text x="52" y="154" font-size="11" text-anchor="end">2</text><line x1="56" y1="120" x2="60" y2="120" stroke="#000"/><text x="52" y="124" font-size="11" text-anchor="end">3</text><line x1="56" y1="90" x2="60" y2="90" stroke="#000"/><text x="52" y="94" font-size="11" text-anchor="end">4</text><line x1="56" y1="60" x2="60" y2="60" stroke="#000"/><text x="52" y="64" font-size="11" text-anchor="end">5</text><text x="26" y="120" font-size="12" text-anchor="middle" transform="rotate(-90 26 120)">Počet dětí</text><rect x="82" y="150" width="15" height="60" fill="#555" stroke="#000"/><rect x="99" y="90" width="15" height="120" fill="#dcdcdc" stroke="#000"/><rect x="116" y="180" width="15" height="30" fill="#9a9a9a" stroke="#000"/><text x="106.5" y="226" font-size="11" text-anchor="middle">Pondělí</text><rect x="153" y="180" width="15" height="30" fill="#555" stroke="#000"/><rect x="170" y="120" width="15" height="90" fill="#dcdcdc" stroke="#000"/><rect x="187" y="120" width="15" height="90" fill="#9a9a9a" stroke="#000"/><text x="177.5" y="226" font-size="11" text-anchor="middle">Úterý</text><rect x="224" y="120" width="15" height="90" fill="#555" stroke="#000"/><rect x="241" y="120" width="15" height="90" fill="#dcdcdc" stroke="#000"/><rect x="258" y="150" width="15" height="60" fill="#9a9a9a" stroke="#000"/><text x="248.5" y="226" font-size="11" text-anchor="middle">Středa</text><rect x="295" y="180" width="15" height="30" fill="#555" stroke="#000"/><rect x="312" y="150" width="15" height="60" fill="#dcdcdc" stroke="#000"/><rect x="329" y="120" width="15" height="90" fill="#9a9a9a" stroke="#000"/><text x="319.5" y="226" font-size="11" text-anchor="middle">Čtvrtek</text><rect x="366" y="120" width="15" height="90" fill="none" stroke="#888" stroke-dasharray="3 3"/><rect x="383" y="120" width="15" height="90" fill="none" stroke="#888" stroke-dasharray="3 3"/><rect x="400" y="120" width="15" height="90" fill="none" stroke="#888" stroke-dasharray="3 3"/><text x="390.5" y="226" font-size="11" text-anchor="middle">Pátek</text><rect x="120" y="252" width="12" height="12" fill="#555" stroke="#000"/><text x="136" y="262" font-size="11">Snídaně</text><rect x="215" y="252" width="12" height="12" fill="#dcdcdc" stroke="#000"/><text x="231" y="262" font-size="11">Oběd</text><rect x="295" y="252" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="311" y="262" font-size="11">Večeře</text></svg>',
  'graf-sluzby.svg',
  'Skupinový sloupcový graf služeb dětí u snídaně, oběda a večeře od pondělí do čtvrtka; páteční údaje chybí.',
  'Rozpis služeb dětí (počet dětí)',
  new List<String>{'Každé z 35 dětí mělo službu právě jednou. Součet dětských služeb od pondělí do čtvrtka je $7+12+9 = 28$, v pátek tedy $35-28 = 7$ dětí.','8.1 V pátek mělo službu $7$ dětí, ne $9$ → N.','8.2 Instruktoři doplňují do 4 (snídaně) a 5 (oběd i večeře). V pondělí u večeře mělo službu jen $1$ dítě, doplnili tedy $4$ instruktoři – tj. více než $3$ → N.','8.3 Denní počty služeb instruktorů jsou Po $7$, Út $7$, St $6$, Čt $8$, Pá $7$; každý instruktor má nejvýše jednu službu za den, proto jich muselo být nejméně $8$ → A.'},
  '8.1: N; 8.2: N; 8.3: A',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
