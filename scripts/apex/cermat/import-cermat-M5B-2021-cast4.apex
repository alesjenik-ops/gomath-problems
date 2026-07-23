String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M5B 2021 – úloha 8',
  new List<String>{'V grafu jsou znázorněny počty dívek a počty chlapců v jazykových školách A a B. Ve škole A je v každé třídě $10$ dětí a ve škole B je v každé třídě $20$ dětí (viz graf).','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 Ve škole A je o polovinu méně chlapců než ve škole B.','8.2 Ve škole B je o třetinu více chlapců než dívek.','8.3 Ve škole B je o třetinu méně tříd než ve škole A.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 350" font-family="sans-serif"><line x1="60" y1="30" x2="60" y2="300" stroke="#000"/><line x1="60" y1="300" x2="430" y2="300" stroke="#000"/><line x1="56" y1="300.0" x2="60" y2="300.0" stroke="#000"/><text x="52" y="304.0" font-size="11" text-anchor="end">0</text><line x1="56" y1="264.0" x2="60" y2="264.0" stroke="#000"/><text x="52" y="268.0" font-size="11" text-anchor="end">20</text><line x1="56" y1="228.0" x2="60" y2="228.0" stroke="#000"/><text x="52" y="232.0" font-size="11" text-anchor="end">40</text><line x1="56" y1="192.0" x2="60" y2="192.0" stroke="#000"/><text x="52" y="196.0" font-size="11" text-anchor="end">60</text><line x1="56" y1="156.0" x2="60" y2="156.0" stroke="#000"/><text x="52" y="160.0" font-size="11" text-anchor="end">80</text><line x1="56" y1="120.0" x2="60" y2="120.0" stroke="#000"/><text x="52" y="124.0" font-size="11" text-anchor="end">100</text><line x1="56" y1="84.0" x2="60" y2="84.0" stroke="#000"/><text x="52" y="88.0" font-size="11" text-anchor="end">120</text><line x1="56" y1="48.0" x2="60" y2="48.0" stroke="#000"/><text x="52" y="52.0" font-size="11" text-anchor="end">140</text><rect x="104" y="138" width="34" height="162" fill="#1a1a1a" stroke="#000"/><rect x="144" y="156" width="34" height="144" fill="#c9c9c9" stroke="#000"/><text x="138" y="316" font-size="13" text-anchor="middle">Dívky</text><rect x="246" y="192" width="34" height="108" fill="#1a1a1a" stroke="#000"/><rect x="286" y="84" width="34" height="216" fill="#c9c9c9" stroke="#000"/><text x="280" y="316" font-size="13" text-anchor="middle">Chlapci</text><text x="30" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 30 170)">Počet dětí</text><rect x="360" y="60" width="13" height="13" fill="#1a1a1a" stroke="#000"/><text x="379" y="71" font-size="12">Škola A</text><rect x="360" y="82" width="13" height="13" fill="#c9c9c9" stroke="#000"/><text x="379" y="93" font-size="12">Škola B</text></svg>',
  'graf-skoly.svg',
  'Sloupcový graf počtů dívek a chlapců ve školách A a B.',
  'Počty dětí ve školách A a B',
  new List<String>{'8.1 Chlapců ve škole A je $60$, ve škole B $120$; $60$ je polovina ze $120$, tvrzení platí → Ano.','8.2 Ve škole B je $120$ chlapců a $80$ dívek; $120$ je o polovinu (ne o třetinu) více → Ne.','8.3 Škola A: $90+60=150$ dětí po $10$ → $15$ tříd; škola B: $80+120=200$ dětí po $20$ → $10$ tříd; $10$ je o třetinu méně než $15$ → Ano.'},
  '8.1: Ano; 8.2: Ne; 8.3: Ano',
  4, 5, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
