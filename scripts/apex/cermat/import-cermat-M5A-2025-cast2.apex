String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M5A 2025 – úloha 4',
  new List<String>{'Velká kulička váží 30 gramů a malá kulička váží 20 gramů. Anička položila na prázdnou váhu určitý počet velkých kuliček a dvojnásobný počet malých kuliček. Váha ukázala celkovou hmotnost 560 gramů.','4.1 Určete počet všech kuliček (malých i velkých dohromady) položených na váze.','4.2 Určete v gramech celkovou hmotnost všech malých kuliček položených na váze.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Velkých kuliček je $n$, malých $2n$. Hmotnost: $30n + 20\\cdot 2n = 70n = 560$, tedy $n = 8$.','4.1 Celkem $n + 2n = 3n = 24$ kuliček.','4.2 Malých kuliček je $16$, jejich hmotnost je $16\\cdot 20 = 320$ g.'},
  '4.1: $24$ kuliček; 4.2: $320$ g',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2025 – úloha 5',
  new List<String>{'Náš dům má tři patra a bydlí v něm celkem 11 dětí. V prvním a druhém patře bydlí dohromady 8 dětí. Ve druhém patře bydlí jen dívky. V prvním a třetím patře bydlí dohromady 5 chlapců a 3 dívky. Ze všech chlapců z našeho domu pouze 3 chlapci nebydlí ve třetím patře.','5.1 Vypočtěte, kolik chlapců bydlí ve druhém patře.','5.2 Vypočtěte, kolik dětí bydlí v prvním patře.','5.3 Vypočtěte, kolik dívek bydlí v našem domě.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Ve druhém patře bydlí jen dívky, chlapců tam bydlí $0$ (žádný chlapec).','5.2 V prvním a druhém patře je $8$ dětí, celkem je jich $11$, ve třetím patře tedy $11 - 8 = 3$ děti. V prvním a třetím patře je dohromady $5 + 3 = 8$ dětí, v prvním patře proto $8 - 3 = 5$ dětí.','5.3 V prvním a třetím patře je $5$ chlapců, ve druhém $0$; protože jen $3$ chlapci nebydlí ve třetím patře, v prvním patře jsou $3$ chlapci a ve třetím $5 - 3 = 2$. Celkem chlapců $5$, dívek je tedy $11 - 5 = 6$.'},
  '5.1: žádný chlapec; 5.2: $5$ dětí; 5.3: $6$ dívek',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2025 – úloha 6',
  new List<String>{'Šestiúhelník tvaru domečku má obvod 24 cm. Domeček lze rozdělit na dva čtyřúhelníky – střechu a přízemí. Oba tyto čtyřúhelníky mají stejný obvod. Střecha je složena ze tří rovnostranných trojúhelníků, přízemí má tvar obdélníku.','6.1 Vypočtěte v cm obvod čtyřúhelníku představujícího střechu.','6.2 Vypočtěte v cm délku kratší strany obdélníku představujícího přízemí.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 170" font-family="sans-serif"> <polygon points="30,140 120,140 120,95 98,58 52,58 30,95" fill="none" stroke="#000" stroke-width="2"/> <text x="75" y="122" font-size="12" text-anchor="middle">Domeček</text> <polygon points="195,82 285,82 262,50 218,50" fill="none" stroke="#000" stroke-width="2"/> <text x="240" y="72" font-size="12" text-anchor="middle">Střecha</text> <rect x="195" y="95" width="90" height="30" fill="none" stroke="#000" stroke-width="2"/> <text x="240" y="115" font-size="12" text-anchor="middle">Přízemí</text> <polygon points="360,95 450,95 428,58 382,58" fill="none" stroke="#000" stroke-width="2"/> <line x1="382" y1="58" x2="405" y2="95" stroke="#000" stroke-dasharray="4 4"/> <line x1="428" y1="58" x2="405" y2="95" stroke="#000" stroke-dasharray="4 4"/> <text x="405" y="118" font-size="11" text-anchor="middle" fill="#666">střecha = 3 trojúhelníky</text> </svg>',
  'domecek.svg',
  'Domeček (šestiúhelník) rozdělený na střechu (lichoběžník ze tří rovnostranných trojúhelníků) a přízemí (obdélník).',
  'Schematický nákres domečku, střechy a přízemí',
  new List<String>{'Strana rovnostranného trojúhelníku ať je $s$, kratší strana obdélníku (přízemí) $h$; delší strana obdélníku i spodní základna střechy má délku $2s$.','Střecha (lichoběžník) má obvod $2s + s + s + s = 5s$, přízemí (obdélník) obvod $2\\cdot(2s + h) = 4s + 2h$. Mají být stejné: $5s = 4s + 2h$, tedy $s = 2h$.','Obvod domečku (šestiúhelníku) je $2s + 2h + 3s = 5s + 2h = 24$. Dosazením $s = 2h$: $12h = 24$, $h = 2$, $s = 4$.','6.1 Obvod střechy $= 5s = 20$ cm.','6.2 Kratší strana přízemí $= h = 2$ cm.'},
  '6.1: $20$ cm; 6.2: $2$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
