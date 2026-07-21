String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)';
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
  'CERMAT 2019 M9A · úloha 10',
  new List<String>{'V rovině leží přímka $c$ a mimo ni dva různé body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy obdélníku $ABCD$. Vrchol $C$ obdélníku $ABCD$ leží na přímce $c$.','10.1 Sestrojte a označte písmenem chybějící vrchol $C$ obdélníku $ABCD$.','10.2 Sestrojte a označte písmenem chybějící vrchol $A$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 233"><path d="M55 4L60 4L60 19L55 19Z" style="fill:#ffffff"/><path d="M254 213L261 213L261 228L254 228Z" style="fill:#ffffff"/><path d="M4 99L12 99L12 114L4 114Z" style="fill:#ffffff"/><path d="M50 19L316 95M23 100L17 106M17 100L23 106M253 210L247 216M247 210L253 216" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="58" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">c</text><text x="258" y="227" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="9" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Přímka c a mimo ni dva různé body B a D.',
  '',
  new List<String>{'V obdélníku $ABCD$ jsou $B$ a $D$ protější vrcholy (úhlopříčka $BD$) a při vrcholu $C$ je pravý úhel $BCD$. Vrchol $C$ proto leží na Thaletově kružnici sestrojené nad průměrem $BD$ a současně na přímce $c$ — je jejich průsečíkem.','Střed $S$ úhlopříčky $BD$ je i středem úhlopříčky $AC$, takže vrchol $A$ je se $C$ souměrně sdružený podle bodu $S$. Podle počtu průsečíků přímky $c$ s Thaletovou kružnicí má úloha až dvě řešení.'},
  'Vrchol $C$ = průsečík přímky $c$ s Thaletovou kružnicí nad průměrem $BD$; vrchol $A$ souměrný s $C$ podle středu úsečky $BD$. Úloha má až $2$ řešení.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 11',
  new List<String>{'Škola má dvě deváté třídy (9. A a 9. B). V 9. A je třikrát více chlapců než dívek a celkem je v této třídě $24$ žáků. Počet všech žáků 9. B je o třetinu větší než počet všech žáků 9. A. V 9. B je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $3:5$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V 9. A je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $1:2$.','11.2 Celkový počet dívek z obou 9. tříd je stejný jako počet chlapců v 9. A.','11.3 V 9. B je počet dívek o $8$ menší než počet chlapců.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'9. A: $24$ žáků, chlapců je $3\\times$ více než dívek, tedy dívek $6$ a chlapců $18$.','9. B: žáků je o třetinu více, tj. $24+8=32$; poměr dívek a chlapců $3:5$ ($8$ dílů) dává dívek $12$ a chlapců $20$.','11.1: poměr v 9. A je $6:18=1:3$, nikoli $1:2$ — \\textbf{N}.','11.2: dívek celkem $6+12=18$, chlapců v 9. A je $18$ — shodné, \\textbf{A}.','11.3: v 9. B je $20-12=8$ — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','pomer','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 12',
  new List<String>{'Rovinný obrazec je složen z kosočtverce a trojúhelníku, které mají společnou stranu. Kosočtverec má všechny čtyři strany stejně dlouhé. Vnitřní úhel kosočtverce při jednom (horním) vrcholu má velikost $\\alpha+24^\\circ$. Pravá strana kosočtverce je prodloužena za dolní vrchol; v trojúhelníku, který tím vznikne, svírá dolní strana kosočtverce s tímto prodloužením úhel $68^\\circ$ a při zbývajícím (dolním) vrcholu trojúhelníku je úhel $\\alpha$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $88^\\circ$','B) $90^\\circ$','C) $92^\\circ$','D) $94^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Kosočtverec má protější úhly shodné, takže vnitřní úhel kosočtverce při dolním (společném) vrcholu je rovněž $\\alpha+24^\\circ$.','Protože pravá strana kosočtverce je prodloužena, jsou tento vnitřní úhel a vyznačený úhel $68^\\circ$ úhly vedlejší: $(\\alpha+24^\\circ)+68^\\circ=180^\\circ$, tedy $\\alpha+92^\\circ=180^\\circ$ a $\\alpha=88^\\circ$.'},
  'A) $88^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PAD19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
