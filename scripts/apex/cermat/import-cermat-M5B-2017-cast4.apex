String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD17C0T02';
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
  'CERMAT M5B 2017 – úloha 10',
  new List<String>{'Každé ze 100 dětí uvedlo jednu aktivitu, kterou má ze všech nabízených nejraději. Výsledky jsou v diagramu: lezení 19 dětí, plavání 26 dětí.','Lezení, nebo kino má nejraději polovina všech dětí. Dětí, které mají nejraději fotbal, je dvakrát více než těch, které mají nejraději cyklistiku.','Kolik dětí má nejraději fotbal?'},
  new List<String>{'A) 12 dětí','B) 14 dětí','C) 16 dětí','D) 18 dětí','E) 20 dětí'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 430" font-family="sans-serif"><text x="230" y="26" font-size="18" text-anchor="middle" font-weight="bold">AKTIVITY</text><path d="M 215 205 L 215.0 85.0 A 120 120 0 0 1 326.6 249.2 Z" fill="none" stroke="#000" stroke-width="1.5"/><text x="337.4" y="121.8" font-size="13" text-anchor="middle">kino</text><path d="M 215 205 L 326.6 249.2 A 120 120 0 0 1 237.5 322.9 Z" fill="none" stroke="#000" stroke-width="1.5"/><text x="309.3" y="319.0" font-size="13" text-anchor="middle">fotbal</text><path d="M 215 205 L 237.5 322.9 A 120 120 0 0 1 95.9 220.0 Z" fill="none" stroke="#000" stroke-width="1.5"/><text x="128.0" y="324.7" font-size="13" text-anchor="middle">plavání</text><text x="128.0" y="339.7" font-size="11" text-anchor="middle">26 dětí</text><path d="M 215 205 L 95.9 220.0 A 120 120 0 0 1 103.4 160.8 Z" fill="none" stroke="#000" stroke-width="1.5"/><text x="68.2" y="186.5" font-size="13" text-anchor="middle">cyklistika</text><path d="M 215 205 L 103.4 160.8 A 120 120 0 0 1 215.0 85.0 Z" fill="none" stroke="#000" stroke-width="1.5"/><text x="131.8" y="82.6" font-size="13" text-anchor="middle">lezení</text><text x="131.8" y="97.6" font-size="11" text-anchor="middle">19 dětí</text></svg>',
  'aktivity.svg',
  'Kruhový diagram aktivit: lezení 19, plavání 26, kino, fotbal, cyklistika.',
  'Diagram oblíbených aktivit',
  new List<String>{'Lezení a kino dohromady $50$ dětí, tedy kino $50 - 19 = 31$. Na cyklistiku a fotbal zbývá $100 - 19 - 31 - 26 = 24$. Fotbal je dvojnásobek cyklistiky: $c + 2c = 24$, $c = 8$, fotbal $= 16$ dětí.'},
  'C) 16 dětí',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2017 – úloha 11',
  new List<String>{'Ve čtvercové síti jsou zakresleni tři trpaslíci se šedými čepicemi $A$, $B$, $C$ (viz obrázek).','Která ze zakreslených čepic pokrývá na obrázku největší část plochy?'},
  new List<String>{'A) čepice A','B) čepice B','C) čepice C','D) dvě ze tří čepic pokrývají stejně velké části plochy, jedna pokrývá menší část','E) čepice A, B i C pokrývají stejně velké části plochy'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif"><line x1="0" y1="20" x2="0" y2="240" stroke="#eaeaea"/><line x1="40" y1="20" x2="40" y2="240" stroke="#eaeaea"/><line x1="80" y1="20" x2="80" y2="240" stroke="#eaeaea"/><line x1="120" y1="20" x2="120" y2="240" stroke="#eaeaea"/><line x1="160" y1="20" x2="160" y2="240" stroke="#eaeaea"/><line x1="200" y1="20" x2="200" y2="240" stroke="#eaeaea"/><line x1="240" y1="20" x2="240" y2="240" stroke="#eaeaea"/><line x1="280" y1="20" x2="280" y2="240" stroke="#eaeaea"/><line x1="320" y1="20" x2="320" y2="240" stroke="#eaeaea"/><line x1="360" y1="20" x2="360" y2="240" stroke="#eaeaea"/><line x1="400" y1="20" x2="400" y2="240" stroke="#eaeaea"/><line x1="440" y1="20" x2="440" y2="240" stroke="#eaeaea"/><line x1="480" y1="20" x2="480" y2="240" stroke="#eaeaea"/><line x1="520" y1="20" x2="520" y2="240" stroke="#eaeaea"/><line x1="560" y1="20" x2="560" y2="240" stroke="#eaeaea"/><line x1="0" y1="20" x2="560" y2="20" stroke="#eaeaea"/><line x1="0" y1="60" x2="560" y2="60" stroke="#eaeaea"/><line x1="0" y1="100" x2="560" y2="100" stroke="#eaeaea"/><line x1="0" y1="140" x2="560" y2="140" stroke="#eaeaea"/><line x1="0" y1="180" x2="560" y2="180" stroke="#eaeaea"/><line x1="0" y1="220" x2="560" y2="220" stroke="#eaeaea"/><polygon points="80,200 200,200 140,120" fill="#cfcfcf" stroke="#555"/><text x="140" y="188" font-size="16" text-anchor="middle">A</text><polygon points="250,200 330,200 300,90" fill="#cfcfcf" stroke="#555"/><text x="291" y="150" font-size="16" text-anchor="middle">B</text><polygon points="380,200 500,200 500,120" fill="#cfcfcf" stroke="#555"/><text x="448" y="188" font-size="16" text-anchor="middle">C</text></svg>',
  'cepice.svg',
  'Tři trpaslíci se šedými trojúhelníkovými čepicemi A, B, C ve čtvercové síti.',
  'Čepice A, B, C ve čtvercové síti (schematicky)',
  new List<String>{'Obsah každé trojúhelníkové čepice určíme ze čtvercové sítě (např. jako polovinu opsaného obdélníku). Všechny tři čepice mají stejný obsah.'},
  'E) čepice A, B i C pokrývají stejně velké části plochy',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
