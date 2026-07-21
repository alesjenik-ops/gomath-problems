String SRC   = 'CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2018 M9I · úloha 8',
  new List<String>{'8.1 Chlapec klusal po pláži rovnoměrným tempem. Za $1$ hodinu tak překonal vzdálenost $7{,}5\\ \\mathrm{km}$. Vypočtěte, kolik metrů uběhl za $2$ minuty.','8.2 V trojúhelníku $ABC$ pro velikosti dvou vnitřních úhlů platí $\\alpha=\\beta=45^\\circ\\,45\'$. Vypočtěte velikost třetího vnitřního úhlu $\\gamma$.','8.3 Plocha o rozloze $90\\,000\\ \\mathrm{m}^2$ je rozdělena na $36$ shodných čtverců. Určete v metrech délku strany jednoho čtverce.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: $7{,}5\\ \\mathrm{km}=7\\,500\\ \\mathrm{m}$ za $60$ minut, tj. $125\\ \\mathrm{m}$ za minutu; za $2$ minuty $250\\ \\mathrm{m}$.','8.2: $\\alpha+\\beta=45^\\circ45\'+45^\\circ45\'=91^\\circ30\'$; $\\gamma=180^\\circ-91^\\circ30\'=88^\\circ30\'$ (tj. $88{,}5^\\circ$).','8.3: obsah jednoho čtverce $=\\frac{90\\,000}{36}=2\\,500\\ \\mathrm{m}^2$; strana $=\\sqrt{2\\,500}=50\\ \\mathrm{m}$.'},
  '8.1: $250\\ \\mathrm{m}$; 8.2: $\\gamma=88^\\circ30\'$ (resp. $88{,}5^\\circ$); 8.3: $50\\ \\mathrm{m}$',
  3, 4, '2',
  new List<String>{'zs2','r9','vypocet','uhly','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 9',
  new List<String>{'V rovině leží obdélník $ABCD$, bod $X$, který je vnitřním bodem strany $AD$, a bod $Y$, který je vnitřním bodem strany $CD$.','Sestrojte kružnici $k$, na níž leží vrcholy pravoúhlého trojúhelníku $DXY$. Střed kružnice označte $S$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Trojúhelník $DXY$ má pravý úhel při vrcholu $D$ (roh obdélníku, $AD\\perp CD$). Vrcholy pravoúhlého trojúhelníku leží na Thaletově kružnici sestrojené nad přeponou; přepona je úsečka $XY$.','Sestrojíme střed úsečky $XY$, označíme jej $S$, a narýsujeme kružnici $k$ se středem $S$ a poloměrem $\\frac{|XY|}{2}$; ta prochází body $D$, $X$, $Y$.'},
  'Kružnice $k$ je Thaletova kružnice nad přeponou $XY$ se středem $S$ ve středu úsečky $XY$ (prochází body $D$, $X$, $Y$).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 10',
  new List<String>{'V rovině leží přímka $p$, na níž leží bod $B$, a mimo ni body $X$ a $Y$. Bod $B$ je vrchol obdélníku $ABCD$ a na přímce $p$ leží úhlopříčka $BD$ tohoto obdélníku. Bod $X$ je vnitřní bod strany $AD$ a bod $Y$ vnitřní bod strany $CD$ obdélníku $ABCD$.','Sestrojte chybějící vrcholy $D$, $A$, $C$ obdélníku $ABCD$ a obdélník narýsujte.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Strany $AD$ a $CD$ jsou na sebe kolmé a procházejí po řadě body $X$ a $Y$. Z vrcholu $D$ je tedy úsečka $XY$ vidět pod pravým úhlem — $D$ leží na Thaletově kružnici nad úsečkou $XY$. Vrchol $D$ získáme jako průsečík této Thaletovy kružnice s přímkou $p$.','Přímka $DX$ nese stranu $AD$, přímka $DY$ nese stranu $CD$. Úhly při vrcholech $A$ a $C$ jsou pravé, proto $A$ i $C$ leží na Thaletově kružnici nad úhlopříčkou $BD$: $A$ je průsečík přímky $DX$ s touto kružnicí, $C$ je průsečík přímky $DY$ s touto kružnicí. Obdélník $ABCD$ narýsujeme.'},
  '$D$ = průsečík přímky $p$ s Thaletovou kružnicí nad $XY$; $A$, $C$ = průsečíky přímek $DX$, $DY$ s Thaletovou kružnicí nad úhlopříčkou $BD$.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 11',
  new List<String>{'Naši koně mají zásobu ovsa na $12$ dnů. Soused má o polovinu větší zásobu ovsa než my, ale dvakrát více koní. Každý kůň (náš i sousedův) dostává denně stejné množství ovsa.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Sousedovy zásoby ovsa by našim koním vydržely na $24$ dnů.','11.2 Naše zásoby ovsa by sousedovým koním vydržely na $6$ dnů.','11.3 Sousedovy zásoby ovsa vydrží jeho koním na $9$ dnů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet našich koní $h$ a denní dávku na jednoho koně $1$. Naše zásoba $=12h$. Sousedova zásoba $=1{,}5\\cdot12h=18h$, sousedových koní $=2h$.','11.1: $18h$ pro naše koně ($h$) vydrží $18$ dnů, ne $24$ — \\textbf{N}.','11.2: $12h$ pro sousedovy koně ($2h$) vydrží $6$ dnů — \\textbf{A}.','11.3: $18h$ pro sousedovy koně ($2h$) vydrží $9$ dnů — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 4, '3',
  new List<String>{'zs2','r9','slovni','uvazovani','aritmetika','pomer','bez-kalkulacky','bezny-zivot'},
  'M9PID18C0T01', 2018
);

System.debug('Vytvořeno úloh: '+c.created);
