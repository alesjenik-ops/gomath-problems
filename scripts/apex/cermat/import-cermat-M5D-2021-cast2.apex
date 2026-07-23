String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M5D 2021 – úloha 4',
  new List<String>{'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $3$ autíčka, za $3$ mince lze koupit $4$ figurky.','4.1 Amélie si chce koupit několik autíček a dvakrát tolik figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.','4.2 Franta si chce koupit přesně o $10$ autíček více než figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Autíčka se kupují po $3$, figurky po $4$. Počet figurek je dvojnásobek počtu autíček, proto počet autíček musí být sudý a dělitelný $3$, tedy nejméně $6$. Pak $6$ autíček ($2\\cdot 5=10$ mincí) a $12$ figurek ($3\\cdot 3=9$ mincí), celkem $19$ mincí.','4.2 Počet figurek je násobek $4$, počet autíček násobek $3$ a o $10$ větší. Nejmenší řešení: $8$ figurek a $18$ autíček. Mince: $18$ autíček $=6\\cdot 5=30$, $8$ figurek $=2\\cdot 3=6$, celkem $36$ mincí.'},
  '4.1: $19$ mincí; 4.2: $36$ mincí',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2021 – úloha 5',
  new List<String>{'Bílá krabička je prázdná, v zelené krabičce jsou jen zelené kuličky a v modré krabičce jsou jen modré kuličky. Modrých kuliček je $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky tak musíme přendat o $9$ kuliček více než z modré krabičky.','5.1 Určete počet všech zelených kuliček.','5.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.','5.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Po přendání je ve všech třech krabičkách stejný počet $t$. Z modré přendáme $m$ kuliček, ze zelené $m+9$. Modrá: $60-m=t$; bílá: $(m+9)+m=t$. Odtud $2m+9=60-m$, tedy $m=17$ a $t=43$.','5.1 Zelených bylo $t+(m+9)=43+26=69$.','5.2 V modré zůstane $t=43$ kuliček.','5.3 Ze zelené přendáme $m+9=26$ kuliček.'},
  '5.1: $69$ zelených kuliček; 5.2: $43$ kuliček; 5.3: $26$ zelených kuliček',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2021 – úloha 6',
  new List<String>{'Obrazec $ABCDEF$ se skládá ze čtverce, rovnostranného a rovnoramenného trojúhelníku. Obvod čtverce je $24$ cm, obvod rovnoramenného trojúhelníku je o třetinu větší než obvod čtverce.','6.1 Vypočtěte v cm obvod rovnostranného trojúhelníku.','6.2 Vypočtěte v cm obvod rovnoramenného trojúhelníku.','6.3 Vypočtěte v cm obvod celého obrazce $ABCDEF$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 260" font-family="sans-serif"> <polygon points="180,80 300,80 300,200 180,200" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="180,80 80,140 180,200" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="300,80 560,140 300,200" fill="none" stroke="#000" stroke-width="1.5"/> <text x="168" y="74" font-size="15" font-style="italic">E</text> <text x="304" y="74" font-size="15" font-style="italic">D</text> <text x="166" y="218" font-size="15" font-style="italic">A</text> <text x="300" y="218" font-size="15" font-style="italic">B</text> <text x="60" y="144" font-size="15" font-style="italic">F</text> <text x="568" y="144" font-size="15" font-style="italic">C</text> </svg>',
  'obrazec-abcdef.svg',
  'Obrazec ABCDEF: uprostřed čtverec, vlevo rovnostranný trojúhelník, vpravo rovnoramenný trojúhelník.',
  'Obrazec ABCDEF',
  new List<String>{'Strana čtverce je $24:4=6$ cm.','6.1 Rovnostranný trojúhelník má stranu $6$ cm, obvod $3\\cdot 6=18$ cm.','6.2 Obvod rovnoramenného trojúhelníku je o třetinu větší než $24$ cm, tj. $24+8=32$ cm.','6.3 Ramena rovnoramenného trojúhelníku měří $(32-6):2=13$ cm. Obvod obrazce $=6+6+6+6+13+13=50$ cm (strany $AB$ a $DE$ čtverce, ramena $EF$ a $FA$ rovnostranného a ramena $BC$ a $CD$ rovnoramenného trojúhelníku).'},
  '6.1: $18$ cm; 6.2: $32$ cm; 6.3: $50$ cm',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
