String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD17C0T02';
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
  'CERMAT M9B 2017 – úloha 6',
  new List<String>{'V promítacím sále bylo přítomno 100 platících osob. Cena vstupenky pro dospělého je 200 Kč, pro dítě 150 Kč. V pokladně vybrali za vstupenky 16 000 Kč.','6.1 Vypočtěte, o kolik procent je vstupenka pro dítě levnější než vstupenka pro dospělého.','6.2 Vypočtěte, kolik dětí bylo v promítacím sále.','6.3 Vypočtěte, kolik Kč vybrali v pokladně za vstupné pro dospělé.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Rozdíl cen je $200-150=50$ Kč, což je $\\frac{50}{200}=0{,}25$, tedy o $25$ %.','6.2 Je-li $d$ počet dětí, pak dospělých je $100-d$: $150d+200(100-d)=16\\,000$, tj. $20\\,000-50d=16\\,000$, odtud $d=80$.','6.3 Dospělých bylo $100-80=20$, zaplatili $20\\cdot 200=4\\,000$ Kč.'},
  '6.1: o $25$ %; 6.2: $80$ dětí; 6.3: $4\\,000$ Kč',
  4, 7, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2017 – úloha 7',
  new List<String>{'Na kružnici $k$ s poloměrem $r=5$ cm ($r=|SA|$) leží vrcholy obdélníku $ABCD$. Delší strana obdélníku měří $8$ cm.','7.1 Vypočtěte délku kružnice a výsledek v cm zaokrouhlete na desetiny.','7.2 Vypočtěte v cm obvod obdélníku $ABCD$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"> <circle cx="200" cy="150" r="90" fill="none" stroke="#000" stroke-width="2"/> <rect x="128" y="96" width="144" height="108" fill="none" stroke="#000" stroke-width="2"/> <line x1="128" y1="96" x2="272" y2="204" stroke="#000"/> <line x1="272" y1="96" x2="128" y2="204" stroke="#000"/> <line x1="200" y1="150" x2="128" y2="204" stroke="#000"/> <text x="200" y="90" font-size="14" text-anchor="middle">8 cm</text> <text x="112" y="92" font-size="16" font-style="italic">D</text> <text x="278" y="92" font-size="16" font-style="italic">C</text> <text x="112" y="220" font-size="16" font-style="italic">A</text> <text x="278" y="220" font-size="16" font-style="italic">B</text> <text x="286" y="76" font-size="16" font-style="italic">k</text> <text x="152" y="176" font-size="15" font-style="italic">r</text> <text x="206" y="156" font-size="14">x</text> <text x="206" y="172" font-size="15" font-style="italic">S</text> </svg>',
  'kruznice-obdelnik.svg',
  'Kružnice k se středem S a poloměrem r, do níž je vepsán obdélník ABCD s delší stranou 8 cm.',
  'Obdélník ABCD vepsaný kružnici k',
  new List<String>{'7.1 $o=2\\pi r=2\\cdot 3{,}14\\cdot 5=31{,}4$ cm.','7.2 Úhlopříčka obdélníku je průměr kružnice, tedy $10$ cm. Podle Pythagorovy věty je kratší strana $\\sqrt{10^2-8^2}=\\sqrt{36}=6$ cm.','Obvod $=2\\cdot(8+6)=28$ cm.'},
  '7.1: $31{,}4$ cm; 7.2: $28$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2017 – úloha 8',
  new List<String>{'Doplňte na vyznačená místa čísla tak, aby platila rovnost:','8.1 $3$ dm² $= 1$ dm² $+$ ___ cm²','8.2 $1{,}2$ litru $=$ ___ dm³ $-$ $100$ cm³','8.3 ___ $\\cdot\\ 1{,}5$ hodiny $+ 20$ minut $= 1$ hodina $5$ minut'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 $3$ dm² $-1$ dm² $=2$ dm² $=200$ cm².','8.2 $1{,}2$ litru $=1{,}2$ dm³ a $100$ cm³ $=0{,}1$ dm³, tedy hledané číslo je $1{,}2+0{,}1=1{,}3$.','8.3 $1$ hodina $5$ minut $=65$ minut, $65-20=45$ minut; $1{,}5$ hodiny $=90$ minut a $45:90=0{,}5$.'},
  '8.1: $200$; 8.2: $1{,}3$; 8.3: $0{,}5$',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
