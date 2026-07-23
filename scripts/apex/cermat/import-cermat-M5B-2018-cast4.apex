String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M5B 2018 – úloha 7.3 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $F$, $G$ a je sestrojen trojúhelník $EFG$ z úlohy 7.2 (viz obrázek).','Sestrojte a označte přímku $o$, která prochází bodem $F$ a je kolmá k přímce $EG$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif"> <rect x="6" y="6" width="468" height="328" fill="none" stroke="#ccc"/> <text x="178" y="90" font-size="16" text-anchor="middle">×</text> <text x="178" y="80" font-size="16" font-style="italic" text-anchor="middle">G</text> <text x="355" y="182" font-size="16" text-anchor="middle">×</text> <text x="362" y="198" font-size="16" font-style="italic">F</text> <text x="168" y="236" font-size="16" text-anchor="middle">×</text> <text x="168" y="252" font-size="16" font-style="italic" text-anchor="middle">A</text> </svg>',
  'body-AFG.svg',
  'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'Přímka $o$ je kolmice k přímce $EG$ vedená bodem $F$. Sestrojíme ji standardní konstrukcí kolmice z bodu $F$ k přímce $EG$.'},
  'Přímka $o$ prochází bodem $F$ a je kolmá k přímce $EG$ – viz nákres v klíči.',
  1, 3, '2',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 8',
  new List<String>{'Čtvercová síť je tvořena čtverečky s délkou strany $1$ cm a obsahem $1$ cm². Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 Obsah obrazce $A$ je stejný jako obsah obrazce $B$.','8.2 Obsah obrazce $A$ je větší než $12$ cm².','8.3 Obvod obrazce $A$ je větší než obvod obrazce $B$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 306" font-family="sans-serif"><g stroke="#8a8a8a" stroke-width="0.7"><line x1="22" y1="18" x2="22" y2="278"/><line x1="48" y1="18" x2="48" y2="278"/><line x1="74" y1="18" x2="74" y2="278"/><line x1="100" y1="18" x2="100" y2="278"/><line x1="126" y1="18" x2="126" y2="278"/><line x1="152" y1="18" x2="152" y2="278"/><line x1="178" y1="18" x2="178" y2="278"/><line x1="204" y1="18" x2="204" y2="278"/><line x1="230" y1="18" x2="230" y2="278"/><line x1="256" y1="18" x2="256" y2="278"/><line x1="282" y1="18" x2="282" y2="278"/><line x1="22" y1="18" x2="282" y2="18"/><line x1="22" y1="44" x2="282" y2="44"/><line x1="22" y1="70" x2="282" y2="70"/><line x1="22" y1="96" x2="282" y2="96"/><line x1="22" y1="122" x2="282" y2="122"/><line x1="22" y1="148" x2="282" y2="148"/><line x1="22" y1="174" x2="282" y2="174"/><line x1="22" y1="200" x2="282" y2="200"/><line x1="22" y1="226" x2="282" y2="226"/><line x1="22" y1="252" x2="282" y2="252"/><line x1="22" y1="278" x2="282" y2="278"/></g><polygon points="100,44 152,44 126,148 22,200" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="204,96 256,96 230,226 178,226" fill="#ffffff" stroke="#000" stroke-width="2"/><text x="100" y="96" font-size="15" font-weight="bold">A</text><text x="214.4" y="163.6" font-size="15" font-weight="bold">B</text></svg>',
  'ctvercova-sit-AB.svg',
  'Čtvercová síť s dvěma bílými čtyřúhelníky A a B; A je protáhlý s dlouhým cípem, B je kompaktnější rovnoběžník.',
  'Bílé obrazce A a B ve čtvercové síti (1 čtvereček = 1 cm²)',
  new List<String>{'Obsahy obou obrazců určíme pomocí mřížových bodů (např. doplněním do obdélníku a odečtením trojúhelníků). Obrazec $A$ má obsah $13$ cm² a obrazec $B$ rovněž $13$ cm².','8.1 Obsahy obou obrazců jsou stejné ($13$ cm²) → Ano.','8.2 Obsah obrazce $A$ je $13$ cm², což je více než $12$ cm² → Ano.','8.3 Obrazec $A$ je protáhlejší a jeho strany jsou delší než u kompaktnějšího obrazce $B$, proto má obrazec $A$ větší obvod → Ano.'},
  '8.1: Ano; 8.2: Ano; 8.3: Ano',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
