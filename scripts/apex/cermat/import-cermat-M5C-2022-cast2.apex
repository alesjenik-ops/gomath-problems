String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD22C0T03';
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
  'CERMAT M5C 2022 – úloha 6',
  new List<String>{'Po jarních prázdninách postupně onemocnělo mnoho žáků. V pondělí chyběla $\\frac{1}{6}$ všech žáků školy. V úterý byla nemocná již $\\frac{1}{4}$ všech žáků školy. V pátek byla ve škole už jen $\\frac{1}{3}$ všech žáků školy, tedy $80$ nejodolnějších žáků. Všichni ostatní žáci školy byli nemocní.','6.1 Vypočtěte, kolik žáků měla škola.','6.2 Vypočtěte, kolik žáků bylo v pondělí ve škole.','6.3 Vypočtěte, o kolik nemocných žáků bylo v pátek více než v úterý.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 V pátek je ve škole $\\frac{1}{3}$ všech žáků, což je $80$. Škola má $3 \\cdot 80 = 240$ žáků.','6.2 V pondělí chybí $\\frac{1}{6}$, ve škole je $\\frac{5}{6}$ žáků: $\\frac{5}{6} \\cdot 240 = 200$ žáků.','6.3 V úterý nemocných $\\frac{1}{4} \\cdot 240 = 60$. V pátek nemocných $240 - 80 = 160$. Rozdíl $160 - 60 = 100$ žáků.'},
  '6.1: $240$ žáků; 6.2: $200$ žáků; 6.3: o $100$ žáků',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $K$, $S$ a přímka $q$ procházející bodem $K$ (viz obrázek).','Bod $K$ je vrchol trojúhelníku $KLM$. Všechny tři vrcholy $K$, $L$, $M$ tohoto trojúhelníku leží na kružnici se středem $S$. Na přímce $q$ leží ještě druhý vrchol trojúhelníku $KLM$ a třetí vrchol leží na přímce $s$, která prochází bodem $S$ a je kolmá k přímce $q$.','Sestrojte vrcholy $L$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="60" y1="150" x2="420" y2="240" stroke="#000" stroke-width="2"/> <text x="66" y="146" font-size="16" font-style="italic">q</text> <circle cx="150" cy="172" r="3" fill="#000"/> <text x="142" y="192" font-size="15" font-style="italic">K</text> <text x="330" y="150" font-size="15" text-anchor="middle">×</text> <text x="340" y="150" font-size="15" font-style="italic">S</text> </svg>',
  'primka-q.svg',
  'Body K a S a přímka q procházející bodem K.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Sestrojíme kružnici se středem $S$ a poloměrem $|SK|$. Přímka $q$ protne tuto kružnici (kromě bodu $K$) v bodě $L$. Přímka $s$ vedená bodem $S$ kolmo k $q$ protne kružnici ve dvou bodech $M_1$, $M_2$; každý z nich dává jedno řešení trojúhelníku $KLM$. Dvě řešení.'},
  'Kružnice se středem $S$ a poloměrem $|SK|$; $L$ je druhý průsečík přímky $q$ s kružnicí; třetí vrchol leží na přímce $s$ (kolmá k $q$ v bodě $S$) a na kružnici – dvě polohy $M_1$, $M_2$. Dvě řešení (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2022 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="60" y1="90" x2="400" y2="90" stroke="#000" stroke-width="2"/> <text x="42" y="95" font-size="16" font-style="italic">c</text> <line x1="60" y1="170" x2="400" y2="170" stroke="#000" stroke-width="2"/> <text x="42" y="175" font-size="16" font-style="italic">p</text> <text x="250" y="228" font-size="15" text-anchor="middle">×</text> <text x="252" y="246" font-size="15" font-style="italic">X</text> <text x="180" y="270" font-size="15" text-anchor="middle">×</text> <text x="182" y="288" font-size="15" font-style="italic">A</text> </svg>',
  'primky-cp.svg',
  'Body A a X a dvě rovnoběžné přímky c a p.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Strana $AB$ leží na přímce určené body $A$ a $X$. Zbývající strany jsou k ní kolmé. Vrchol $C$ hledáme na přímce $c$ tak, aby jeden ze zbývajících vrcholů ($B$, nebo $D$) ležel na přímce $p$; úloha má dvě řešení (polohy $C_1$, $C_2$).'},
  'Strana $AB$ leží na přímce $AX$; vrchol $C$ na přímce $c$, jeden ze zbývajících vrcholů na přímce $p$. Dvě řešení – polohy $C_1$, $C_2$ (s vrcholy $B_1$, $D_1$ / $B_2$, $D_2$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
