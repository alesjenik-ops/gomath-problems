String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD26C0T01';
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
  'CERMAT M5A 2026 – úloha 8',
  new List<String>{'Farmář prodával na trhu tři druhy ovoce – jablka, meruňky a broskve. Každé z nich nabízel pouze v baleních po 5 kg. Graf udává, kolik kg ovoce prodal v průběhu pěti dnů. V pátek farmář neprodal žádné meruňky, ale jablek prodal dvakrát více kg než broskví. Ceny: jablka $30$ korun/kg, meruňky $120$ korun/kg, broskve $60$ korun/kg.','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Za uvedených 5 dnů dohromady prodal farmář více než $80$ kg meruněk.','8.2 Hmotnost broskví prodaných v pondělí a v pátek se lišila o $5$ kg.','8.3 Nejvyšší celkovou částku za prodané ovoce dostal farmář ve čtvrtek.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 360" font-family="sans-serif"><line x1="70" y1="30" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="500" y2="300" stroke="#000"/><line x1="66" y1="300.0" x2="70" y2="300.0" stroke="#000"/><text x="62" y="304.0" font-size="11" text-anchor="end">0</text><line x1="66" y1="264.0" x2="70" y2="264.0" stroke="#000"/><text x="62" y="268.0" font-size="11" text-anchor="end">10</text><line x1="66" y1="228.0" x2="70" y2="228.0" stroke="#000"/><text x="62" y="232.0" font-size="11" text-anchor="end">20</text><line x1="66" y1="192.0" x2="70" y2="192.0" stroke="#000"/><text x="62" y="196.0" font-size="11" text-anchor="end">30</text><line x1="66" y1="156.0" x2="70" y2="156.0" stroke="#000"/><text x="62" y="160.0" font-size="11" text-anchor="end">40</text><line x1="66" y1="120.0" x2="70" y2="120.0" stroke="#000"/><text x="62" y="124.0" font-size="11" text-anchor="end">50</text><line x1="66" y1="84.0" x2="70" y2="84.0" stroke="#000"/><text x="62" y="88.0" font-size="11" text-anchor="end">60</text><line x1="66" y1="48.0" x2="70" y2="48.0" stroke="#000"/><text x="62" y="52.0" font-size="11" text-anchor="end">70</text><rect x="94" y="228.0" width="54" height="72.0" fill="#555" stroke="#000"/><rect x="94" y="174.0" width="54" height="54.0" fill="#dcdcdc" stroke="#000"/><rect x="94" y="120.0" width="54" height="54.0" fill="#9a9a9a" stroke="#000"/><text x="121.0" y="316" font-size="11" text-anchor="middle">Pondělí</text><rect x="172" y="210.0" width="54" height="90.0" fill="#555" stroke="#000"/><rect x="172" y="120.0" width="54" height="90.0" fill="#dcdcdc" stroke="#000"/><rect x="172" y="84.0" width="54" height="36.0" fill="#9a9a9a" stroke="#000"/><text x="199.0" y="316" font-size="11" text-anchor="middle">Úterý</text><rect x="250" y="210.0" width="54" height="90.0" fill="#555" stroke="#000"/><rect x="250" y="138.0" width="54" height="72.0" fill="#dcdcdc" stroke="#000"/><rect x="250" y="102.0" width="54" height="36.0" fill="#9a9a9a" stroke="#000"/><text x="277.0" y="316" font-size="11" text-anchor="middle">Středa</text><rect x="328" y="138.0" width="54" height="162.0" fill="#555" stroke="#000"/><rect x="328" y="102.0" width="54" height="36.0" fill="#dcdcdc" stroke="#000"/><rect x="328" y="66.0" width="54" height="36.0" fill="#9a9a9a" stroke="#000"/><text x="355.0" y="316" font-size="11" text-anchor="middle">Čtvrtek</text><rect x="406" y="156.0" width="54" height="144.0" fill="#555" stroke="#000"/><rect x="406" y="84.0" width="54" height="72.0" fill="#9a9a9a" stroke="#000"/><text x="433.0" y="316" font-size="11" text-anchor="middle">Pátek</text><rect x="470" y="70" width="14" height="14" fill="#9a9a9a" stroke="#000"/><text x="490" y="82" font-size="12">Broskve</text><rect x="470" y="92" width="14" height="14" fill="#dcdcdc" stroke="#000"/><text x="490" y="104" font-size="12">Meruňky</text><rect x="470" y="114" width="14" height="14" fill="#555" stroke="#000"/><text x="490" y="126" font-size="12">Jablka</text></svg>',
  'graf-ovoce.svg',
  'Skládaný sloupcový graf prodeje jablek, meruněk a broskví za pondělí až pátek.',
  'Prodej ovoce v jednotlivých dnech (kg)',
  new List<String>{'8.1 Meruňky: $15+25+20+10+0=70$ kg, tj. ne více než 80 → Ne.','8.2 Broskve: pondělí $15$ kg, pátek $20$ kg, rozdíl $5$ kg → Ano.','8.3 Tržby: Po $3300$, Út $4350$, St $3750$, Čt $3150$, Pá $2400$ Kč; nejvíce v úterý, ne ve čtvrtek → Ne.'},
  '8.1: Ne; 8.2: Ano; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2026 – úloha 9',
  new List<String>{'Ve třídě visí na nástěnce tabulka, v níž jsou uvedena všechna kladná celá čísla od 1 do 100 a žádná jiná.','Kolikrát se v tabulce vyskytuje číslice 4?'},
  new List<String>{'A) 10krát','B) 11krát','C) 19krát','D) 20krát','E) 21krát'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Na místě jednotek: 4,14,24,…,94 → 10×. Na místě desítek: 40–49 → 10×. Celkem $20$×.'},
  'D) 20krát',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
