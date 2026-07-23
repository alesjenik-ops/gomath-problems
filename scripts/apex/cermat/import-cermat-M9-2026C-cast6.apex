String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD26C0T03';
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
  'CERMAT M9C 2026 – úloha 11',
  new List<String>{'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U každého jídla pomáhala v kuchyni služba. U snídaně měly mít službu vždy 4 osoby, u oběda 5 osob a u večeře také 5 osob. Každé z 35 dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi. Přitom každý instruktor měl službu v kuchyni nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.','Rozhodněte o každém z tvrzení 11.1 až 11.3, zda je pravdivé (A), nebo nepravdivé (N).','11.1 V pátek mělo službu v kuchyni celkem 9 dětí.','11.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše 3 instruktoři.','11.3 Instruktorů muselo být na táboře nejméně 8.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 240" font-family="sans-serif"><text x="18" y="110" font-size="12" text-anchor="middle" transform="rotate(-90 18 110)">Počet dětí</text><line x1="60" y1="30" x2="60" y2="190" stroke="#000"/><line x1="60" y1="190" x2="510" y2="190" stroke="#000"/><line x1="56" y1="190" x2="60" y2="190" stroke="#000"/><text x="52" y="194" font-size="11" text-anchor="end">0</text><line x1="56" y1="162" x2="60" y2="162" stroke="#000"/><text x="52" y="166" font-size="11" text-anchor="end">1</text><line x1="56" y1="134" x2="60" y2="134" stroke="#000"/><text x="52" y="138" font-size="11" text-anchor="end">2</text><line x1="56" y1="106" x2="60" y2="106" stroke="#000"/><text x="52" y="110" font-size="11" text-anchor="end">3</text><line x1="56" y1="78" x2="60" y2="78" stroke="#000"/><text x="52" y="82" font-size="11" text-anchor="end">4</text><line x1="56" y1="50" x2="60" y2="50" stroke="#000"/><text x="52" y="54" font-size="11" text-anchor="end">5</text><rect x="76" y="134" width="13" height="56" fill="#555555" stroke="#000"/><rect x="92" y="78" width="13" height="112" fill="#eeeeee" stroke="#000"/><rect x="108" y="162" width="13" height="28" fill="#9a9a9a" stroke="#000"/><text x="98" y="206" font-size="11" text-anchor="middle">Pondělí</text><rect x="154" y="162" width="13" height="28" fill="#555555" stroke="#000"/><rect x="170" y="106" width="13" height="84" fill="#eeeeee" stroke="#000"/><rect x="186" y="106" width="13" height="84" fill="#9a9a9a" stroke="#000"/><text x="176" y="206" font-size="11" text-anchor="middle">Úterý</text><rect x="232" y="106" width="13" height="84" fill="#555555" stroke="#000"/><rect x="248" y="106" width="13" height="84" fill="#eeeeee" stroke="#000"/><rect x="264" y="134" width="13" height="56" fill="#9a9a9a" stroke="#000"/><text x="254" y="206" font-size="11" text-anchor="middle">Středa</text><rect x="310" y="162" width="13" height="28" fill="#555555" stroke="#000"/><rect x="326" y="134" width="13" height="56" fill="#eeeeee" stroke="#000"/><rect x="342" y="106" width="13" height="84" fill="#9a9a9a" stroke="#000"/><text x="332" y="206" font-size="11" text-anchor="middle">Čtvrtek</text><rect x="388" y="162" width="13" height="28" fill="none" stroke="#999" stroke-dasharray="3 3"/><rect x="404" y="162" width="13" height="28" fill="none" stroke="#999" stroke-dasharray="3 3"/><text x="410" y="206" font-size="11" text-anchor="middle">Pátek</text><rect x="150" y="206" width="12" height="12" fill="#555555" stroke="#000"/><text x="166" y="216" font-size="11">Snídaně</text><rect x="250" y="206" width="12" height="12" fill="#eeeeee" stroke="#000"/><text x="266" y="216" font-size="11">Oběd</text><rect x="330" y="206" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="346" y="216" font-size="11">Večeře</text></svg>',
  'graf-sluzby.svg',
  'Sloupcový graf počtu dětí ve službě u snídaně, oběda a večeře v pondělí až čtvrtek; páteční údaje chybí.',
  'Rozpis služeb dětí (počet dětí)',
  new List<String>{'Z grafu mají děti službu (pondělí až čtvrtek): snídaně $2+1+3+1=7$, oběd $4+3+3+2=12$, večeře $1+3+2+3=9$, celkem 28 dětí. V pátek (jen snídaně a oběd) má tedy službu $35-28=7$ dětí.','11.1 V pátek má službu 7 dětí, nikoli 9 – tvrzení je nepravdivé (N).','11.2 Instruktoři doplňují počet na 4 (snídaně), resp. 5 (oběd i večeře). Např. v pondělí u večeře byla jen 1 dítě, tedy $5-1=4$ instruktoři, což je více než 3 – nepravdivé (N).','11.3 Každý instruktor má službu nejvýše jednou za den, proto je jich za den potřeba tolik, kolik je součet doplnění u snídaně, oběda a večeře. Nejvíce ve čtvrtek: $(4-1)+(5-2)+(5-3)=3+3+2=8$. Instruktorů muselo být nejméně 8 – pravdivé (A).'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 8, '4',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
