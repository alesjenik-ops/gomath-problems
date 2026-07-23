String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
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
  'CERMAT M7C 2026 – úloha 10',
  new List<String>{'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.','Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), nebo nepravdivé (N).','10.1 V pátek mělo službu v kuchyni celkem 9 dětí.','10.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.','10.3 Instruktorů muselo být na táboře nejméně 8.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 360" font-family="sans-serif" font-size="13"><line x1="70" y1="50" x2="70" y2="280" stroke="#000"/><line x1="70" y1="280" x2="600" y2="280" stroke="#000"/><line x1="70" y1="280" x2="600" y2="280" stroke="#eeeeee"/><line x1="66" y1="280" x2="70" y2="280" stroke="#000"/><text x="61" y="284" text-anchor="end">0</text><line x1="70" y1="236" x2="600" y2="236" stroke="#eeeeee"/><line x1="66" y1="236" x2="70" y2="236" stroke="#000"/><text x="61" y="240" text-anchor="end">1</text><line x1="70" y1="192" x2="600" y2="192" stroke="#eeeeee"/><line x1="66" y1="192" x2="70" y2="192" stroke="#000"/><text x="61" y="196" text-anchor="end">2</text><line x1="70" y1="148" x2="600" y2="148" stroke="#eeeeee"/><line x1="66" y1="148" x2="70" y2="148" stroke="#000"/><text x="61" y="152" text-anchor="end">3</text><line x1="70" y1="104" x2="600" y2="104" stroke="#eeeeee"/><line x1="66" y1="104" x2="70" y2="104" stroke="#000"/><text x="61" y="108" text-anchor="end">4</text><line x1="70" y1="60" x2="600" y2="60" stroke="#eeeeee"/><line x1="66" y1="60" x2="70" y2="60" stroke="#000"/><text x="61" y="64" text-anchor="end">5</text><text x="22" y="165" text-anchor="middle" transform="rotate(-90 22 165)">Počet dětí</text><rect x="95" y="192" width="20" height="88" fill="#555555" stroke="#000"/><rect x="119" y="104" width="20" height="176" fill="#dcdcdc" stroke="#000"/><rect x="143" y="236" width="20" height="44" fill="#9a9a9a" stroke="#000"/><text x="119" y="296" text-anchor="middle">Pondělí</text><rect x="200" y="236" width="20" height="44" fill="#555555" stroke="#000"/><rect x="224" y="148" width="20" height="132" fill="#dcdcdc" stroke="#000"/><rect x="248" y="148" width="20" height="132" fill="#9a9a9a" stroke="#000"/><text x="224" y="296" text-anchor="middle">Úterý</text><rect x="305" y="148" width="20" height="132" fill="#555555" stroke="#000"/><rect x="329" y="148" width="20" height="132" fill="#dcdcdc" stroke="#000"/><rect x="353" y="192" width="20" height="88" fill="#9a9a9a" stroke="#000"/><text x="329" y="296" text-anchor="middle">Středa</text><rect x="410" y="236" width="20" height="44" fill="#555555" stroke="#000"/><rect x="434" y="192" width="20" height="88" fill="#dcdcdc" stroke="#000"/><rect x="458" y="148" width="20" height="132" fill="#9a9a9a" stroke="#000"/><text x="434" y="296" text-anchor="middle">Čtvrtek</text><rect x="515" y="236" width="20" height="44" fill="none" stroke="#888888" stroke-dasharray="4 3"/><rect x="539" y="236" width="20" height="44" fill="none" stroke="#888888" stroke-dasharray="4 3"/><rect x="563" y="236" width="20" height="44" fill="none" stroke="#888888" stroke-dasharray="4 3"/><text x="539" y="296" text-anchor="middle">Pátek</text><rect x="150" y="326" width="13" height="13" fill="#555555" stroke="#000"/><text x="168" y="337">Snídaně</text><rect x="270" y="326" width="13" height="13" fill="#dcdcdc" stroke="#000"/><text x="288" y="337">Oběd</text><rect x="360" y="326" width="13" height="13" fill="#9a9a9a" stroke="#000"/><text x="378" y="337">Večeře</text></svg>',
  'graf-sluzby.svg',
  'Skupinový sloupcový graf počtu dětí ve službě u snídaně, oběda a večeře pondělí až čtvrtek; páteční sloupce chybí.',
  'Rozpis služeb dětí (počet dětí)',
  new List<String>{'Z grafu je počet dětí ve službě od pondělí do čtvrtka $28$; protože dětí je $35$ a každé slouží právě jednou, v pátek slouží $35-28=7$ dětí. Tvrzení 10.1 je tedy nepravdivé (N).','Počet instruktorů u jídla je roven požadovanému počtu zmenšenému o počet dětí. V pondělí u večeře je jen $1$ dítě, tedy $5-1=4$ instruktoři – více než 3. Tvrzení 10.2 je nepravdivé (N).','Každý instruktor slouží nejvýše jednou za den, proto je potřeba tolik instruktorů, kolik je jejich služeb v nejnáročnějším dni. Ve čtvrtek: snídaně $4-1=3$, oběd $5-2=3$, večeře $5-3=2$, celkem $8$. Instruktorů muselo být nejméně $8$. Tvrzení 10.3 je pravdivé (A).'},
  '10.1: N; 10.2: N; 10.3: A',
  4, 7, '4',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
