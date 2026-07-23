String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
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
  'CERMAT M7A 2025 - uloha 4',
  new List<String>{'Sourozenci Adam, Bara a Cyril prispeli na vycvik asistencniho psa. Adam prispel castkou o 300 korun vyssi nez Bara. Pritom tretina Adamova prispevku je stejna jako polovina Barina prispevku a tretina Barina prispevku je stejna jako polovina Cyrilova prispevku.','4.1 Vypoctete, kolika korunami prispela Bara.','4.2 Vypoctete, o kolik korun se lisi Barin a Cyriluv prispevek.','4.3 Vypoctete, kolika korunami prispeli vsichni tri sourozenci dohromady.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Ze vztahu $\\frac{A}{3}=\\frac{B}{2}$ plyne $A=\\frac{3}{2}B$. Zaroven $A=B+300$, tedy $\\frac{3}{2}B=B+300$, $\\frac{1}{2}B=300$, $B=600$ (a $A=900$).','4.1 Bara prispela 600 korun.','4.2 Z $\\frac{B}{3}=\\frac{C}{2}$ plyne $C=\\frac{2}{3}B=400$. Rozdil $B-C=600-400=200$ korun.','4.3 Dohromady $900+600+400=1900$ korun.'},
  '4.1: 600 korun; 4.2: o 200 korun; 4.3: 1900 korun',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 5',
  new List<String>{'V obchode se za jednotnou cenu prodavaji ruzne figurky. Lida mela presny obnos na nakup 7 figurek po 39 korunach. Figurky vsak byly zdrazeny. Lida proto koupila jen 6 figurek a zbylo ji presne tolik korun, kolik ji chybelo na nakup sedme figurky.','5.1 Vypoctete, kolik korun zbylo Lide po nakupu 6 figurek.','5.2 Vypoctete, kolik korun stala jedna figurka po zdrazeni.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Lida mela $7\\cdot 39=273$ korun. Nova cena $c$: po koupi 6 figurek zbylo $273-6c$, coz se rovna tomu, co chybelo na sedmou, tj. $c-(273-6c)$. Rovnice $273-6c=7c-273$ dava $546=13c$, $c=42$.','5.2 Jedna figurka po zdrazeni stala 42 korun.','5.1 Zbylo $273-6\\cdot 42=273-252=21$ korun.'},
  '5.1: 21 korun; 5.2: 42 korun',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 6',
  new List<String>{'Petr, Tonda a Jirka prinesli do klubu sve sbirky karticek s fotbalisty a nektere karticky si vymenili. Tonda vymenil 4 sve karticky za 6 Petrovych a nekolik dalsich svych karticek za 4 Jirkovy. Petr potom vymenil 2 sve karticky za 3 Jirkovy. Pred odchodem dostal kazdy z chlapcu jeste 4 karticky od vedouciho klubu. Petr tak rozsiril svou sbirku na 80 karticek a Jirka mel nakonec o 2 karticky vice nez pri prichodu do klubu.','6.1 Vypoctete, kolik karticek si do klubu prinesl Petr.','6.2 Vypoctete, kolik karticek ziskal Jirka od Tondy.','6.3 Vypoctete, o kolik karticek rozsiril svou sbirku Tonda.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Petr: vymenou s Tondou $-6+4=-2$, vymenou s Jirkou $-2+3=+1$, od vedouciho $+4$; celkem $+3$. Prinesl tedy $80-3=77$ karticek.','6.2 Necht Jirka dostal od Tondy $x$ karticek a Tondovi dal 4. S Petrem: $+2-3=-1$. Od vedouciho $+4$. Zmena Jirky: $x-4-1+4=x-1=2$, tedy $x=3$.','6.3 Tonda: s Petrem $-4+6=+2$, s Jirkou $-3+4=+1$, od vedouciho $+4$; celkem rozsiril sbirku o 7 karticek.'},
  '6.1: 77 karticek; 6.2: 3 karticky; 6.3: o 7 karticek',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 7',
  new List<String>{'Osove soumerny petiuhelnik ve tvaru domecku se sklada ze dvou ctvercu a rovnoramenneho trojuhelniku. Obvod petiuhelniku je 46 cm. V rovnoramennem trojuhelniku je rameno o 3 cm delsi nez zakladna a vyska na zakladnu je o 1 cm kratsi nez rameno.','7.1 Vypoctete v cm delku strany ctverce.','7.2 Vypoctete v cm2 obsah petiuhelniku.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 200 210" font-family="sans-serif"> <polygon points="30,120 170,120 100,25" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/> <rect x="30" y="120" width="140" height="70" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/> <line x1="100" y1="120" x2="100" y2="190" stroke="#000" stroke-width="1.5"/> </svg>',
  'domecek.svg',
  'Petiuhelnik ve tvaru domecku: dolni obdelnik rozdeleny na dva ctverce a nahore rovnoramenny trojuhelnik.',
  'Schematicky nakres petiuhelniku',
  new List<String>{'7.1 Necht strana ctverce je $a$. Zakladna trojuhelniku je horni strana dvou ctvercu, tj. $2a$, rameno je $2a+3$. Obvod petiuhelniku (spodni strana $2a$, dve bocni strany $a$, dve ramena) je $2a+2a+2(2a+3)=8a+6=46$, tedy $a=5$ cm.','7.2 Obsah dvou ctvercu $2a^2=2\\cdot 25=50$ cm2. Trojuhelnik ma zakladnu $2a=10$ cm a vysku rameno $-1=13-1=12$ cm, obsah $\\frac{10\\cdot 12}{2}=60$ cm2. Celkem $50+60=110$ cm2.'},
  '7.1: 5 cm; 7.2: 110 cm2',
  4, 7, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
