String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
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
  'CERMAT M7A 2026 - uloha 7',
  new List<String>{'V pekarne pecou vsechny babovky podle stejneho receptu. Podle tohoto receptu spotrebuji na kazdych 6 babovek 840 g cukru.','7.1 Vypoctete, kolik gramu cukru spotrebuji v pekarne na 21 babovek.','7.2 Vypoctete, na kolik babovek v pekarne spotrebuji presne 7 kg cukru.','7.3 Na kazdou vanocku spotrebuji v pekarne o 25 % mene cukru nez na babovku. Na vsechny vanocky spotrebovali v pekarne tolik cukru jako na 27 babovek. Vypoctete, kolik vanocek v pekarne upekli.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Na 1 babovku pripada $840:6=140$ g cukru.','7.1 $21\\cdot 140=2940$ g cukru.','7.2 $7$ kg $=7000$ g; $7000:140=50$ babovek.','7.3 Na 1 vanocku $140\\cdot 0{,}75=105$ g cukru. Na 27 babovek je $27\\cdot 140=3780$ g; pocet vanocek $3780:105=36$.'},
  '7.1: $2940$ gramu; 7.2: $50$ babovek; 7.3: $36$ vanocek',
  4, 7, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2026 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi poloprimky $AP$, $AQ$ a primka $c$ kolma k poloprimce $AP$ (viz obrazek).','Bod $A$ je vrchol rovnobezniku $ABCD$. Na poloprimce $AP$ lezi vrchol $B$ tohoto rovnobezniku, na poloprimce $AQ$ vrchol $D$ a na primce $c$ vrchol $C$. Vyska na stranu $AB$ rovnobezniku $ABCD$ meri 4 cm.','Sestrojte vrcholy $B$, $C$, $D$ rovnobezniku $ABCD$, oznacte je pismeny a rovnobeznik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 430" font-family="sans-serif"> <rect x="8" y="8" width="604" height="414" fill="none" stroke="#ccc"/> <line x1="120" y1="300" x2="565" y2="406" stroke="#000" stroke-width="2"/> <line x1="120" y1="300" x2="380" y2="72" stroke="#000" stroke-width="2"/> <line x1="525" y1="95" x2="430" y2="495" stroke="#000" stroke-width="2"/> <text x="100" y="306" font-size="16" font-style="italic">A</text> <text x="548" y="424" font-size="16" font-style="italic">P</text> <text x="384" y="70" font-size="16" font-style="italic">Q</text> <text x="530" y="90" font-size="16" font-style="italic">c</text> <text x="360" y="96" font-size="14">&#215;</text> <line x1="516" y1="386" x2="532" y2="392" stroke="#000" stroke-width="1.5"/> </svg>',
  'poloprimky-AP-AQ-c.svg',
  'Poloprimky AP a AQ z bodu A a primka c kolma k poloprimce AP.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Strana $AB$ lezi na poloprimce $AP$. Vyska na $AB$ je vzdalenost strany $DC$ od primky $AB$, tedy 4 cm. Vrcholy $D$ a $C$ proto lezi na rovnobezce $r$ s poloprimkou $AP$ ve vzdalenosti 4 cm (na strane, kde je bod $Q$).','Vrchol $D$ je prusecik rovnobezky $r$ s poloprimkou $AQ$. Vrchol $C$ je prusecik primky $c$ s rovnobezkou $r$ (v rovnobezniku je $DC\\parallel AB$). Vrchol $B$ lezi na poloprimce $AP$ tak, aby $ABCD$ byl rovnobeznik, tj. $|AB|=|DC|$ a $AB\\parallel DC$.'},
  'Konstrukce rovnobezniku $ABCD$: vrcholy $D$ a $C$ lezi na rovnobezce s $AP$ ve vzdalenosti 4 cm ($D$ na poloprimce $AQ$, $C$ na primce $c$), vrchol $B$ na poloprimce $AP$ tak, aby $ABCD$ byl rovnobeznik. Viz obrazek v klici.',
  2, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2026 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $A$, $M$ (viz obrazek).','Body $A$, $M$ jsou vrcholy rovnostranneho trojuhelniku $AMC$. Body $A$, $C$ jsou zaroven vrcholy trojuhelniku $ABC$. Bod $M$ lezi uvnitr strany $BC$ trojuhelniku $ABC$ a strana $BC$ je dvakrat delsi nez strana $AC$.','Sestrojte vrcholy $B$, $C$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <rect x="8" y="8" width="444" height="304" fill="none" stroke="#ccc"/> <text x="252" y="152" font-size="16">&#215;</text><text x="262" y="146" font-size="15" font-style="italic">M</text> <text x="168" y="236" font-size="16">&#215;</text><text x="168" y="258" font-size="15" font-style="italic">A</text> </svg>',
  'body-AM.svg',
  'Body A a M v rovine.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'Sestrojime rovnostranny trojuhelnik $AMC$: vrchol $C$ je prusecik kruznic se stredy $A$ a $M$ a polomerem $|AM|$. Existuji dve polohy $C_1$, $C_2$.','Protoze $|MC|=|AC|$ a $|BC|=2|AC|$, je bod $M$ stred strany $BC$; vrchol $B$ lezi na poloprimce $CM$ za bodem $M$ ve vzdalenosti $|CM|$. Uloha ma dve reseni.'},
  'Dve reseni: rovnostranny trojuhelnik $AMC$ (dve polohy $C_1$, $C_2$), $M$ je stred strany $BC$, $|BC|=2|AC|$. Viz obrazek v klici.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
