String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2017 M9B · úloha 7',
  new List<String>{'Na kružnici $k$ s poloměrem $r=5\\ \\mathrm{cm}$ (kde $r=|SA|$) leží vrcholy obdélníku $ABCD$. Delší strana obdélníku měří $8\\ \\mathrm{cm}$. Úhlopříčky obdélníku se protínají ve středu $S$ kružnice (viz obrázek).','7.1 Vypočtěte délku kružnice a výsledek v cm zaokrouhlete na desetiny.','7.2 Vypočtěte v cm obvod obdélníku $ABCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 124 117"><path d="M6 58L6 56L6 53L6 50L7 47L7 45L8 42L9 40L10 37L11 35L12 32L14 30L15 28L17 26L18 24L20 22L22 20L24 18L26 16L28 15L30 13L32 12L34 11L37 9L39 8L41 7L44 7L47 6L49 5L52 5L55 4L57 4L60 4L63 4L66 4L68 5L71 5L74 6L76 7L79 7L81 8L84 9L86 11L88 12L91 13L93 15L95 16L97 18L99 20L100 22L102 24L104 26L105 28L107 30L108 32L109 35L110 37L111 40L112 42L113 45L113 47L114 50L114 53L114 56L114 61L114 64L114 67L113 69L113 72L112 75L111 77L110 80L109 82L108 84L107 87L105 89L104 91L102 93L100 95L99 97L97 99L95 100L93 102L91 103L88 105L86 106L84 107L81 109L79 109L76 110L74 111L71 112L68 112L66 112L63 113L57 113L55 112L52 112L49 112L47 111L44 110L41 109L39 109L37 107L34 106L32 105L30 103L28 102L26 100L24 99L22 97L20 95L18 93L17 91L15 89L14 87L12 84L11 82L10 80L9 77L8 75L7 72L7 69L6 67L6 64L6 61L6 58M7 61L7 61L8 64L8 64L8 67L8 66L8 69L9 72L9 72L10 74L10 74L10 77L11 79L12 81L12 81L14 84L15 86L15 86L16 88L18 90L19 92L21 94L23 96L25 98L25 97L27 99L29 101L29 101L31 102L33 104L35 105L37 106L37 106L40 107L42 108L44 109L47 110L50 110L49 110L52 111L55 111L57 111L57 111L60 111L63 111L66 111L68 111L68 111L71 110L73 110L76 109L78 108L81 107L83 106L83 106L85 105L88 104L90 102L90 102L92 101L92 101L94 99L94 99L96 97L96 98L98 96L99 94L101 92L101 92L102 90L104 88L104 88L105 86L107 84L107 84L108 81L108 81L109 79L110 77L111 74L111 74L111 72L111 72L112 69L112 66L112 67L113 64L113 64L113 61L113 58L113 56L113 56L113 53L112 50L112 48L112 48L111 45L111 43L110 40L109 38L108 35L107 33L107 33L105 31L104 29L104 29L102 27L101 25L99 23L98 21L96 19L96 19L94 18L94 18L92 16L90 15L90 15L88 13L88 13L85 12L83 11L81 10L78 9L78 9L76 8L73 7L71 7L68 6L68 6L66 6L63 6L60 6L57 6L57 6L55 6L52 6L49 7L50 7L47 7L44 8L42 9L42 9L40 10L37 11L35 12L33 13L33 13L31 15L29 16L27 18L25 19L23 21L21 23L19 25L18 27L16 29L15 31L15 31L14 33L12 35L11 38L10 40L10 43L10 43L9 45L8 48L8 48L8 50L8 53L7 56L7 56L7 58Z" style="fill:#000000"/><path d="M14 84L107 84L107 86L14 86Z" style="fill:#000000"/><path d="M106 33L107 33L107 85L106 85Z" style="fill:#000000"/><path d="M14 32L107 32L107 33L14 33Z" style="fill:#000000"/><path d="M13 33L15 33L15 85L13 85Z" style="fill:#000000"/><path d="M14 32L107 84L107 86L14 33Z" style="fill:#000000"/><path d="M14 86L107 33L107 32L14 84Z" style="fill:#000000"/><text x="61" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="99" y="16" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="10" y="97" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="113" y="95" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="114" y="34" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="7" y="34" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="60" y="32" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="36" y="70" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">r</text></svg>',
  'obr.svg',
  'Kružnice k se středem S a poloměrem r; do kružnice je vepsán obdélník ABCD s úhlopříčkami procházejícími středem S, delší strana DC měří 8 cm.',
  '',
  new List<String>{'7.1: délka (obvod) kružnice $o=2\\pi r=2\\pi\\cdot5=10\\pi\\doteq31{,}4\\ \\mathrm{cm}$.','7.2: úhlopříčka obdélníku je průměr kružnice, tedy $|AC|=2r=10\\ \\mathrm{cm}$; kratší strana $\\sqrt{10^2-8^2}=\\sqrt{36}=6\\ \\mathrm{cm}$; obvod $2\\cdot(8+6)=28\\ \\mathrm{cm}$.'},
  '7.1: $o\\doteq31{,}4\\ \\mathrm{cm}$; 7.2: obvod $=28\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','bez-kalkulacky'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 8',
  new List<String>{'Doplňte do rámečku čísla tak, aby platila rovnost (rámeček je značen jako $\\square$):','8.1 \\quad $3\\ \\mathrm{dm}^2=1\\ \\mathrm{dm}^2+\\square\\ \\mathrm{cm}^2$','8.2 \\quad $1{,}2\\ \\mathrm{litru}=\\square\\ \\mathrm{dm}^3-100\\ \\mathrm{cm}^3$','8.3 \\quad $\\square\\cdot1{,}5\\ \\mathrm{hodiny}+20\\ \\mathrm{minut}=1\\ \\mathrm{hodina}\\ 5\\ \\mathrm{minut}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: $3\\ \\mathrm{dm}^2-1\\ \\mathrm{dm}^2=2\\ \\mathrm{dm}^2=200\\ \\mathrm{cm}^2$; do rámečku patří $200$.','8.2: $1{,}2\\ \\mathrm{litru}=1{,}2\\ \\mathrm{dm}^3=1\\,200\\ \\mathrm{cm}^3$; $1\\,200+100=1\\,300\\ \\mathrm{cm}^3=1{,}3\\ \\mathrm{dm}^3$; do rámečku patří $1{,}3$.','8.3: $1\\ \\mathrm{hodina}\\ 5\\ \\mathrm{minut}=65\\ \\mathrm{minut}$; $65-20=45\\ \\mathrm{minut}$; $45:90=0{,}5$; do rámečku patří $0{,}5$.'},
  '8.1: $200$; 8.2: $1{,}3$; 8.3: $0{,}5$',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
