String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
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
  'CERMAT M5B 2023 – úloha 6',
  new List<String>{'Obdélník se stranami délek $10$ cm a $24$ cm byl rozdělen úhlopříčkami na čtyři rovnoramenné trojúhelníky. Z takových čtyř trojúhelníků je sestaven každý z obrazců A, B, C, D (viz obrázek). Obvody obrazců A, B se liší o $4$ cm.','6.1 Vypočtěte, kolik cm měří obvod obrazce A.','6.2 Vypočtěte, o kolik cm se liší obvody obrazců B, C.','6.3 Vypočtěte, kolik cm měří obvod obrazce D.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 175" font-family="sans-serif"> <g fill="none" stroke="#000" stroke-width="1.5"> <rect x="26" y="30" width="40" height="96"/> <line x1="26" y1="30" x2="66" y2="126"/> <line x1="66" y1="30" x2="26" y2="126"/> </g> <text x="46" y="145" font-size="12" text-anchor="middle">10 cm</text> <text x="16" y="80" font-size="12" text-anchor="middle" transform="rotate(-90 16 80)">24 cm</text> <g fill="#cfcfcf" stroke="#000" stroke-width="1.2"> <polygon points="150,45 195,45 205,72 172,120 140,72"/> <polygon points="250,120 320,120 285,45"/> <polygon points="410,45 424,72 452,80 424,88 410,120 396,88 368,80 396,72"/> <polygon points="480,105 545,72 565,95 500,128"/> </g> <g font-size="12" text-anchor="middle"> <text x="172" y="140">Obrazec A</text> <text x="285" y="140">Obrazec B</text> <text x="410" y="140">Obrazec C</text> <text x="522" y="145">Obrazec D</text> </g> </svg>',
  'obdelnik-obrazce.svg',
  'Obdélník 10 cm krát 24 cm rozdělený úhlopříčkami na čtyři rovnoramenné trojúhelníky a schematické obrazce A, B, C, D z těchto trojúhelníků.',
  'Schematický nákres (obrazce A–D viz testový sešit)',
  new List<String>{'Úhlopříčky obdélníku $10\\times 24$ mají délku $\\sqrt{10^2+24^2}=26$ cm a rozdělují ho na čtyři rovnoramenné trojúhelníky s rameny $13$ cm: dva se základnou $10$ cm a dva se základnou $24$ cm.','6.1 Obvod obrazce A tvoří čtyři základny: $10+10+24+24=68$ cm.','6.2 Obvod obrazce B je $10+10+13+13+13+13=72$ cm, obvod obrazce C je $24+24+13+13+13+13=100$ cm; liší se o $28$ cm.','6.3 Obvod obrazce D tvoří šest ramen: $6\\cdot 13=78$ cm.'},
  '6.1: $68$ cm; 6.2: o $28$ cm; 6.3: $78$ cm',
  4, 6, '4',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $F$ a přímka $g$ (viz obrázek).','Bod $F$ je vrchol rovnoramenného trojúhelníku $EFG$. Strana $EF$ tohoto trojúhelníku měří $5$ cm a leží na kolmici k přímce $g$. Na přímce $g$ leží vrchol $G$ trojúhelníku $EFG$.','Sestrojte vrcholy $E$, $G$ trojúhelníku $EFG$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 230" font-family="sans-serif"> <line x1="40" y1="60" x2="420" y2="130" stroke="#000" stroke-width="2"/> <text x="426" y="132" font-size="16" font-style="italic">g</text> <text x="150" y="190" font-size="15" font-style="italic">F</text> <text x="162" y="184" font-size="14">×</text> </svg>',
  'bod-primka-g.svg',
  'Bod F a přímka g v rovině; přímka g mírně klesá zleva doprava, bod F leží pod ní.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Vrchol $E$ leží na kolmici k přímce $g$ vedené bodem $F$, ve vzdálenosti $|EF|=5$ cm od bodu $F$ (na straně k přímce $g$). Trojúhelník $EFG$ je rovnoramenný s rameny $|EF|=|EG|=5$ cm, proto vrchol $G$ leží na kružnici se středem $E$ a poloměrem $5$ cm. Průsečíky této kružnice s přímkou $g$ dávají dvě polohy vrcholu $G$ (dvě řešení).'},
  'Dvě řešení: $E$ je bod na kolmici k $g$ vedené bodem $F$ ve vzdálenosti $5$ cm od $F$; vrcholy $G_1$, $G_2$ jsou průsečíky kružnice se středem $E$ a poloměrem $5$ cm s přímkou $g$ (viz náčrt v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
