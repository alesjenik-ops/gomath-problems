String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M7D 2023 - uloha 4',
  new List<String>{'Male opicky maji pravidelny denni rezim (viz diagram). Po kazdem $4$hodinovem useku (I.-VI.) se u nich stridaji osetrovatele. Bile plochy predstavuji casti dne, ktere travi opicky venku, sede plochy casti dne, po ktere jsou uvnitr sveho pribytku. Dva $4$hodinove useky jsou rozdeleny, nebot jednu petinu z II. useku dne jsou opicky uvnitr pribytku, zatimco jednu sestinu ze VI. useku dne travi opicky venku.','4.1 Urcete, v kolik hodin a minut opicky rano vylezaji z pribytku ven.','4.2 Urcete, v kolik hodin a minut opicky vecer zalezaji do pribytku.','4.3 Urcete, o kolik minut vice stravi kazdy den opicky uvnitr pribytku nez venku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif"><g fill="#c9c9c9"><path d="M 170 150 L 170.0 50.0 A 100 100 0 0 1 256.6 100.0 Z"/><path d="M 170 150 L 170.0 250.0 A 100 100 0 0 1 83.4 200.0 Z"/><path d="M 170 150 L 83.4 100.0 A 100 100 0 0 1 170.0 50.0 Z"/></g><circle cx="170" cy="150" r="48" fill="#fff"/><circle cx="170" cy="150" r="100" fill="none" stroke="#000"/><circle cx="170" cy="150" r="48" fill="none" stroke="#000"/><g stroke="#000"><line x1="170.0" y1="102.0" x2="170.0" y2="50.0"/><line x1="211.6" y1="126.0" x2="256.6" y2="100.0"/><line x1="211.6" y1="174.0" x2="256.6" y2="200.0"/><line x1="170.0" y1="198.0" x2="170.0" y2="250.0"/><line x1="128.4" y1="174.0" x2="83.4" y2="200.0"/><line x1="128.4" y1="126.0" x2="83.4" y2="100.0"/></g><g font-size="12" text-anchor="middle"><text x="207.0" y="89.9">I.</text><text x="244.0" y="154.0">II.</text><text x="207.0" y="218.1">III.</text><text x="133.0" y="218.1">IV.</text><text x="96.0" y="154.0">V.</text><text x="133.0" y="89.9">VI.</text><text x="170" y="40">pulnoc</text><text x="170" y="278">poledne</text><text x="302" y="154">8:00</text><text x="40" y="154">16:00</text></g></svg>',
  'diagram-opicky.svg',
  'Kruhovy diagram dne rozdeleny na sest 4hodinovych useku I az VI; pulnoc nahore, poledne dole, 8:00 vpravo, 16:00 vlevo.',
  'Denni rezim opicek (schematicky nakres)',
  new List<String>{'Usek II je $4:00$-$8:00$; jedna petina ($48$ min) na zacatku jsou opicky uvnitr, ven vylezaji v $4:48$.','4.1 $4:48$.','Usek VI je $20:00$-$24:00$; jedna sestina ($40$ min) na zacatku jsou venku, do pribytku zalezaji v $20:40$.','4.2 $20:40$.','4.3 Uvnitr: useky I a IV cele ($480$ min), z II $48$ min a z VI $200$ min, celkem $728$ min. Venku $1440-728=712$ min. Rozdil $728-712=16$ min.'},
  '4.1: $4:48$; 4.2: $20:40$; 4.3: o $16$ minut',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2023 - uloha 5',
  new List<String>{'Na miskach vah lezi jedno velke, jedno stredni a tri stejna mala zavazi. Hmotnost stredniho zavazi je o tretinu mensi nez hmotnost velkeho zavazi. Jedno velke a jedno male zavazi vazi dohromady $100$ g, stejne jako jedno stredni a dve mala zavazi.','5.1 Urcete, kolikrat vetsi je hmotnost velkeho zavazi nez hmotnost maleho zavazi.','5.2 Urcete, kolik gramu vazi stredni zavazi.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 210" font-family="sans-serif"> <polygon points="210,150 195,185 225,185" fill="#777" stroke="#000"/> <g stroke="#000" fill="none" stroke-width="2"> <line x1="70" y1="120" x2="350" y2="120"/> <line x1="210" y1="120" x2="210" y2="150"/> <path d="M 70 150 A 40 40 0 0 0 150 150"/> <path d="M 270 150 A 40 40 0 0 0 350 150"/> </g> <g stroke="#000"><line x1="110" y1="120" x2="110" y2="150"/><line x1="310" y1="120" x2="310" y2="150"/></g> <g fill="#bcbcbc" stroke="#000"> <rect x="82" y="112" width="30" height="34"/> <rect x="120" y="130" width="16" height="16"/> <rect x="276" y="120" width="24" height="26"/> <rect x="306" y="130" width="16" height="16"/> <rect x="326" y="130" width="16" height="16"/> </g> <g stroke="#000" fill="none"> <path d="M 80 104 L 80 100 L 140 100 L 140 104"/> <path d="M 274 104 L 274 100 L 344 100 L 344 104"/> </g> <g font-size="13" text-anchor="middle"><text x="110" y="95">100 g</text><text x="310" y="95">100 g</text></g> </svg>',
  'vahy-zavazi.svg',
  'Rovnoramenne vahy: vlevo velke a male zavazi, vpravo stredni a dve mala zavazi; nad kazdou miskou 100 g.',
  'Vychozi obrazek k uloze 5',
  new List<String>{'Oznacme velke $V$, stredni $S$, male $m$. Plati $S=\\frac{2}{3}V$, $V+m=100$ a $S+2m=100$. Z poslednich dvou $V+m=S+2m$, tedy $V=S+m=\\frac{2}{3}V+m$, odkud $\\frac{1}{3}V=m$, tj. $V=3m$.','5.1 Velke je $3$krat vetsi nez male.','5.2 Z $S=\\frac{2}{3}V=2m$ a $V+m=100$ je $4m=100$, $m=25$ g, tedy $S=2m=50$ g.'},
  '5.1: $3$krat; 5.2: $50$ gramu',
  3, 5, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
