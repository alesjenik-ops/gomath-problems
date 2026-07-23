String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M9 nanečisto 2026 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Stejné sýry se prodávají v menších baleních po dvou sýrech a ve větších baleních po třech sýrech. Menší balení stojí 100 korun, větší balení 123 korun. O kolik procent je jeden sýr ve větším balení levnější než jeden sýr v menším balení?','15.2 V půjčovně se za půjčení každé lodě platí jednotná cena za každý den. Sportovní klub vybral peníze na půjčení 10 lodí na 5 dní. Z vybraných peněz klub dosud utratil jen část, a to za půjčení 2 lodí na 4 dny. Kolik procent vybraných peněz klub dosud utratil?','15.3 Vítek šetří na nákup lyží. Našetřené peníze mu nyní vystačí buď na 92 % ceny loňského modelu lyží, nebo na 80 % ceny letošního modelu lyží. Loňský model lyží stojí 10 tisíc korun. O kolik procent je letošní model lyží dražší než loňský?'},
  new List<String>{'A) méně než $15$ %','B) $15$ %','C) $16$ %','D) $18$ %','E) $19$ %','F) více než $19$ %'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Menší balení: $1$ sýr $=100:2=50$ Kč; větší: $1$ sýr $=123:3=41$ Kč. Rozdíl $\\frac{50-41}{50}=0{,}18=18$ % → D.','15.2 Vybráno na $10\\cdot 5=50$ loďodní, utraceno za $2\\cdot 4=8$ loďodní. $\\frac{8}{50}=0{,}16=16$ % → C.','15.3 Peníze $=0{,}92\\cdot 10\\,000=9200$ Kč, což je $80$ % ceny letošního: letošní $=9200:0{,}8=11\\,500$ Kč. Nárůst $\\frac{11\\,500-10\\,000}{10\\,000}=15$ % → B.'},
  '15.1: D ($18$ %); 15.2: C ($16$ %); 15.3: B ($15$ %)',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 16',
  new List<String>{'Na začátku promítání je na plátně zobrazen šedý pravoúhlý trojúhelník $ABC$ s odvěsnami 5 cm a 12 cm a přeponou 13 cm. V každém kroku se objeví nový větší pravoúhlý trojúhelník s vrcholem $A$ a přeponou na polopřímce $AC$; jeho delší odvěsna leží na polopřímce $AB$ a je vždy o 2 cm delší než v předchozím trojúhelníku. Poměr délek obou odvěsen je ve všech trojúhelnících stejný. V 1. kroku se objeví trojúhelník $AB_1C_1$, ve 2. kroku $AB_2C_2$ atd.','16.1 Určete, v kolikátém kroku se objeví trojúhelník, v němž se délky obou odvěsen liší o 14 cm.','16.2 Určete, kolik cm měří kratší odvěsna $B_{60}C_{60}$ trojúhelníku $AB_{60}C_{60}$, který se objeví v 60. kroku.','16.3 Určete, v kolikátém kroku se objeví trojúhelník, jehož kratší odvěsna bude naposledy měřit méně než 300 cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif"> <line x1="40" y1="180" x2="430" y2="180" stroke="#000"/> <line x1="40" y1="180" x2="410" y2="42" stroke="#000"/> <polygon points="40,180 250,180 250,102" fill="#dcdcdc" stroke="#000"/> <line x1="310" y1="180" x2="310" y2="80" stroke="#000"/> <line x1="360" y1="180" x2="360" y2="61" stroke="#000"/> <text x="34" y="196" font-size="13" font-style="italic">A</text> <text x="245" y="196" font-size="13" font-style="italic">B</text> <text x="302" y="196" font-size="12" font-style="italic">B1</text> <text x="352" y="196" font-size="12" font-style="italic">B2</text> <text x="256" y="100" font-size="13" font-style="italic">C</text> <text x="316" y="78" font-size="12" font-style="italic">C1</text> <text x="366" y="58" font-size="12" font-style="italic">C2</text> <text x="120" y="150" font-size="12">13 cm</text> <text x="140" y="196" font-size="12">12 cm</text> <text x="258" y="148" font-size="12">5 cm</text> <text x="382" y="70" font-size="16">...</text> </svg>',
  'trojuhelniky-promitani.svg',
  'Rostoucí pravoúhlé trojúhelníky se společným vrcholem A; přepony na jedné polopřímce, delší odvěsny na druhé.',
  'Schematický nákres promítaných trojúhelníků',
  new List<String>{'Delší odvěsna v $k$-tém kroku je $12+2k$ cm, kratší je $\\frac{5}{12}$ delší, tj. $\\frac{5}{12}(12+2k)$ cm.','16.1 Rozdíl odvěsen $(12+2k)\\left(1-\\frac{5}{12}\\right)=\\frac{7}{12}(12+2k)=14\\Rightarrow 12+2k=24\\Rightarrow k=6$. V 6. kroku.','16.2 Delší $=12+2\\cdot 60=132$ cm, kratší $=\\frac{5}{12}\\cdot 132=55$ cm.','16.3 $\\frac{5}{12}(12+2k)<300\\Rightarrow 12+2k<720\\Rightarrow k<354$. Naposledy pro $k=353$ (kratší $\\doteq 299{,}2$ cm). V 353. kroku.'},
  '16.1: v 6. kroku; 16.2: $55$ cm; 16.3: v 353. kroku',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
