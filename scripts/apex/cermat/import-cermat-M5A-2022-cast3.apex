String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M5A 2022 – úloha 5',
  new List<String>{'Na miskách vah leží koule, válce a závaží; obě váhy jsou v rovnováze. Na první váze jsou dva válce a závaží $50$ g v rovnováze se třemi koulemi. Na druhé váze je jeden válec a závaží $70$ g v rovnováze se dvěma koulemi.','5.1 Vypočtěte, kolik gramů váží jedna koule.','5.2 Vypočtěte, kolik gramů váží jeden válec.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif"> <text x="20" y="20" font-size="12">1. váha (rovnovaha)</text> <line x1="30" y1="60" x2="250" y2="60" stroke="#000" stroke-width="2"/> <polygon points="140,60 132,88 148,88" fill="#999" stroke="#000"/> <rect x="40" y="30" width="12" height="26" fill="#ccc" stroke="#000"/> <rect x="56" y="30" width="12" height="26" fill="#ccc" stroke="#000"/> <rect x="74" y="34" width="28" height="22" fill="#eee" stroke="#000"/> <text x="88" y="49" font-size="11" text-anchor="middle">50 g</text> <circle cx="180" cy="46" r="10" fill="none" stroke="#000"/> <circle cx="205" cy="46" r="10" fill="none" stroke="#000"/> <circle cx="230" cy="46" r="10" fill="none" stroke="#000"/> <text x="20" y="130" font-size="12">2. váha (rovnovaha)</text> <line x1="30" y1="170" x2="250" y2="170" stroke="#000" stroke-width="2"/> <polygon points="140,170 132,198 148,198" fill="#999" stroke="#000"/> <rect x="46" y="140" width="12" height="26" fill="#ccc" stroke="#000"/> <rect x="66" y="144" width="28" height="22" fill="#eee" stroke="#000"/> <text x="80" y="159" font-size="11" text-anchor="middle">70 g</text> <circle cx="190" cy="156" r="10" fill="none" stroke="#000"/> <circle cx="215" cy="156" r="10" fill="none" stroke="#000"/> <text x="300" y="100" font-size="12">koule = kruh, valec = obdelnik</text> </svg>',
  'vahy.svg',
  'Dvě rovnoramenné váhy v rovnováze: dva válce a závaží 50 g proti třem koulím; jeden válec a závaží 70 g proti dvěma koulím.',
  'Schematický nákres dvou vah v rovnováze',
  new List<String>{'Označme hmotnost jedné koule $k$ a jednoho válce $v$ (v gramech). První váha: $2v+50=3k$. Druhá váha: $v+70=2k$.','5.1 Z druhé rovnice $v=2k-70$; dosazením do první $2(2k-70)+50=3k$, tj. $4k-90=3k$, odtud $k=90$ g.','5.2 Válec: $v=2\\cdot 90-70=110$ g.'},
  '5.1: $90$ g; 5.2: $110$ g',
  3, 6, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2022 – úloha 6',
  new List<String>{'Každý z obrazců A, B, C, D má obsah $96$ cm² a skládá se ze čtyř stejných trojúhelníků. V trojúhelníku mají dvě kratší strany délky $4$ cm a $13$ cm. Obvod obrazce B je o $4$ cm menší než obvod obrazce C.','6.1 Vypočtěte v cm² obsah jednoho trojúhelníku.','6.2 Vypočtěte v cm obvod obrazce A.','6.3 Vypočtěte v cm obvod jednoho trojúhelníku.','6.4 Vypočtěte v cm obvod obrazce D.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 200" font-family="sans-serif"> <polygon points="40,160 300,160 360,60" fill="#d9d9d9" stroke="#000" stroke-width="2"/> <text x="170" y="180" font-size="14" text-anchor="middle">13 cm</text> <text x="342" y="118" font-size="14">4 cm</text> <text x="150" y="100" font-size="14">15 cm</text> <text x="40" y="30" font-size="12">Jeden ze ctyr shodnych trojuhelniku; obrazce A-D viz testovy sesit.</text> </svg>',
  'obrazce.svg',
  'Jeden ze čtyř shodných trojúhelníků se stranami 4 cm, 13 cm a 15 cm; obrazce A–D jsou z těchto trojúhelníků složeny.',
  'Schematický nákres trojúhelníku (obrazce A–D viz sešit)',
  new List<String>{'6.1 Obsah jednoho trojúhelníku $=96:4=24$ cm².','6.3 Trojúhelník má obsah $24$ cm² a dvě nejkratší strany $4$ cm a $13$ cm; třetí (nejdelší) strana je $15$ cm. Obvod jednoho trojúhelníku $=4+13+15=32$ cm.','6.2 V obrazci A se do obvodu započítají jen strany na okraji (slepené strany se nepočítají); obvod obrazce A $=60$ cm.','6.4 Obdobně obvod obrazce D $=46$ cm.'},
  '6.1: $24$ cm²; 6.2: $60$ cm; 6.3: $32$ cm; 6.4: $46$ cm',
  4, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
