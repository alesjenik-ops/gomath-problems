String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený F6 – středověké jednotky délky',
  new List<String>{'Středověké jednotky délky byly často poněkud zvláštního původu. Např. $1$ hon byl odvozen od $60$ otočení kolečka pluhu, přičemž délka $1$ honu se rovnala $5$ provazcům po $42$ loktech pražských. Délka $1$ sáhu pak byla odvozena od délky rozpažení panovníka a ve vrcholném středověku se do něj vešlo „tré loktů pražských". Délka $1$ pražského lokte nám zůstala věrně zachována, neboť „jeden loket" je zazděn na průčelí pražské novoměstské radnice jako etalon a činí zhruba $60$ cm.','6.1 Vypočtěte, jak velký průměr mělo kolečko zmíněného středověkého pluhu. Výsledek zaokrouhlete na cm.','6.2 Vypočtěte, kolik hektarů měly polnosti tvaru obdélníku o rozměrech 100 × 300 sáhů. Počet hektarů zaokrouhlete na jednotky.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 $1$ hon $= 5\\cdot 42 = 210$ loktů $= 210\\cdot 0{,}6 = 126$ m a odpovídá $60$ otáčkám, takže obvod kolečka je $126:60 = 2{,}1$ m. Průměr $d = \\frac{2{,}1}{\\pi} \\approx \\frac{2{,}1}{3{,}14} \\approx 0{,}67$ m $= 67$ cm.','6.2 $1$ sáh $= 3$ lokty $= 1{,}8$ m. Rozměry $100 \\times 300$ sáhů $= 180 \\times 540$ m, obsah $180\\cdot 540 = 97\\,200$ m² $= 9{,}72$ ha $\\approx 10$ ha.'},
  '6.1: $67$ cm; 6.2: $10$ hektarů',
  4, 8, '4',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F7.1 – šestina úhlu',
  new List<String>{'Vypočtěte, jak velká je jedna šestina úhlu o velikosti 123° 12\'.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$123°\\,12\' = 123\\cdot 60 + 12 = 7392\'$. Šestina: $7392\' : 6 = 1232\' = 20°\\,32\'$.'},
  '20° 32\'',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F7.2 – obvod dlážděné místnosti',
  new List<String>{'Vypočtěte obvod čtvercové místnosti vydlážděné $625$ čtvercovými dlaždicemi o hraně $20$ cm.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$625 = 25^2$, strana místnosti má $25$ dlaždic po $20$ cm, tj. $25\\cdot 20 = 500$ cm $= 5$ m. Obvod $4\\cdot 5 = 20$ m.'},
  '$20$ metrů',
  1, 3, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F7.3 – hmotnost smrkového dřeva',
  new List<String>{'Vypočtěte hmotnost $1$ m³ smrkového dřeva, jestliže kláda volně plovoucí ve vodě vyčnívá nad její hladinu čtvrtinou svého objemu. Hmotnost jednoho litru vody je $1000$ gramů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Kláda plave, nad hladinou je $\\frac{1}{4}$ objemu, ponořeny jsou $\\frac{3}{4}$. Vztlak se rovná tíze, proto hustota dřeva $= \\frac{3}{4}\\cdot 1000 = 750$ kg/m³. Hmotnost $1$ m³ je tedy $750$ kg.'},
  '$750$ kg',
  1, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
