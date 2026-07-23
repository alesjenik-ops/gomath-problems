String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
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
  'CERMAT M9D 2021 – úloha 9',
  new List<String>{'V rovině leží úsečka $LM$ a bod $U$ (viz obrázek).','Úsečka $LM$ je strana rovnoramenného trojúhelníku $KLM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.','Sestrojte vrchol $K$ trojúhelníku $KLM$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 400" font-family="sans-serif"> <line x1="340" y1="100" x2="388" y2="335" stroke="#000" stroke-width="2.5"/> <text x="348" y="97" font-size="16" font-weight="bold">M</text> <text x="396" y="342" font-size="16" font-weight="bold">L</text> <text x="243" y="219" font-size="16">×</text> <text x="247" y="235" font-size="14" font-style="italic">U</text> </svg>',
  'usecka-LM-U.svg',
  'Úsečka LM (M nahoře, L dole vpravo) a bod U ležící vlevo od ní.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Základnou rovnoramenného trojúhelníku může být kterákoli z jeho tří stran, proto vznikají tři řešení: (K1) $LM$ je základna a $|KL|=|KM|=2\\cdot|LM|$ – vrchol $K$ leží na ose úsečky $LM$; (K2) $LM$ je rameno, základnou je $KL$ ($|LM|=|KM|=2\\cdot|KL|$); (K3) $LM$ je rameno, základnou je $KM$ ($|LM|=|KL|=2\\cdot|KM|$). Poloha $K$ se volí tak, aby bod $U$ ležel uvnitř trojúhelníku.'},
  'Tři řešení $K_1$, $K_2$, $K_3$: rovnoramenný trojúhelník $KLM$ s rameny dvakrát delšími než základna, podle volby základny $LM$, $KL$, resp. $KM$ – viz obrázek v klíči.',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 10',
  new List<String>{'V rovině leží body $A$, $S$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$ a bod $S$ je střed tohoto obdélníku. Vrchol $C$ má od vrcholu $D$ i od středu $S$ stejnou vzdálenost, tedy $|CD|=|CS|$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 400" font-family="sans-serif"> <text x="296" y="171" font-size="16">×</text> <text x="304" y="161" font-size="14" font-weight="bold">S</text> <text x="210" y="321" font-size="16">×</text> <text x="205" y="339" font-size="14" font-weight="bold" text-anchor="end">A</text> </svg>',
  'body-A-S.svg',
  'Body A a S v rovině; bod S leží nad bodem A.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Střed $S$ je střed úhlopříčky $AC$, proto je $C$ obrazem $A$ ve středové souměrnosti se středem $S$ (tím je $C$ určen a $|SC|=|SA|$). Dále $|SC|=|SD|=|SA|$ (polovina úhlopříčky). Podmínka $|CD|=|CS|$ znamená, že trojúhelník $SCD$ je rovnostranný, tedy $|\\angle CSD|=60^\\circ$; tím sestrojíme $D$ a bod $B$ jako obraz $D$ podle $S$. Úloha má dvě souměrná řešení.'},
  'Dvě řešení: $C$ je souměrné s $A$ podle středu $S$ ($|AC|=2|AS|$), vrcholy $D$, $B$ leží na druhé úhlopříčce vedené bodem $S$ tak, že trojúhelník $SCD$ je rovnostranný ($|CD|=|CS|$) – obdélníky $AB_1CD_1$ a $AB_2CD_2$ viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 11',
  new List<String>{'Číslo $A$ může být kterékoli celé číslo větší než $9$. Číslo $B$ je o $3$ větší než číslo $A$. Číslo $C$ je dvojnásobkem čísla $B$.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).','11.1 Číslo, které je výsledkem výpočtu $A+B+C$, může být sudé.','11.2 Číslo, které je výsledkem výpočtu $A\\cdot B+C$, musí být vždy sudé.','11.3 Číslo, které je výsledkem výpočtu $A+B-C$, musí být vždy záporné.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $B=A+3$ a $C=2B=2A+6$.','11.1 $A+B+C=4A+9$ je vždy liché, sudé být nemůže → Ne.','11.2 $A\\cdot B+C=A^2+5A+6=(A+2)(A+3)$ je součin dvou po sobě jdoucích čísel, tedy vždy sudé → Ano.','11.3 $A+B-C=-3$ je vždy záporné → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
