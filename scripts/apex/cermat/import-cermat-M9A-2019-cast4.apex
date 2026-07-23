String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M9A 2019 – úloha 10',
  new List<String>{'V rovině leží přímka $c$ a mimo ni dva různé body $B$, $D$ (viz obrázek). Body $B$, $D$ jsou vrcholy obdélníku $ABCD$. Vrchol $C$ obdélníku $ABCD$ leží na přímce $c$.','10.1 Sestrojte a označte písmenem chybějící vrchol $C$ obdélníku $ABCD$.','10.2 Sestrojte a označte písmenem chybějící vrchol $A$ obdélníku $ABCD$ a obdélník narýsujte.','Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 380" font-family="sans-serif"> <line x1="115" y1="115" x2="410" y2="185" stroke="#000" stroke-width="2"/> <text x="120" y="105" font-size="16" font-style="italic">c</text> <text x="150" y="235" font-size="16">×</text><text x="132" y="238" font-size="16" font-style="italic">D</text> <text x="330" y="315" font-size="16">×</text><text x="348" y="320" font-size="16" font-style="italic">B</text> </svg>',
  'primka-c-bd.svg',
  'Šikmá přímka c a pod ní dva body B a D vyznačené křížky.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Body $B$ a $D$ jsou protější vrcholy obdélníku, $BD$ je úhlopříčka. Střed $S$ úsečky $BD$ je i středem druhé úhlopříčky $AC$. Ve vrcholu $C$ je pravý úhel $BCD$, proto $C$ leží na Thaletově kružnici nad průměrem $BD$ (střed $S$, poloměr $\\frac{|BD|}{2}$). Průsečíky této kružnice s přímkou $c$ dávají vrcholy $C_1$, $C_2$. Vrchol $A$ získáme jako obraz bodu $C$ ve středové souměrnosti se středem $S$ ($A_1$, $A_2$). Úloha má dvě řešení.'},
  'Střed $S$ úsečky $BD$; vrchol $C$ je průsečík přímky $c$ s Thaletovou kružnicí nad průměrem $BD$; vrchol $A$ je obraz $C$ ve středové souměrnosti se středem $S$. Dvě řešení (viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2019 – úloha 11',
  new List<String>{'Škola má dvě deváté třídy (9. A a 9. B). V 9. A je třikrát více chlapců než dívek a celkem je v této třídě $24$ žáků. Počet všech žáků 9. B je o třetinu větší než počet všech žáků 9. A. V 9. B je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $3:5$ (viz tabulka).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 V 9. A je poměr počtu dívek a počtu chlapců (v uvedeném pořadí) $1:2$.','11.2 Celkový počet dívek z obou 9. tříd je stejný jako počet chlapců v 9. A.','11.3 V 9. B je počet dívek o $8$ menší než počet chlapců.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 210" font-family="sans-serif"> <rect x="20" y="20" width="390" height="168" fill="none" stroke="#000"/> <line x1="130" y1="20" x2="130" y2="188" stroke="#000"/> <line x1="230" y1="20" x2="230" y2="188" stroke="#000"/> <line x1="320" y1="20" x2="320" y2="188" stroke="#000"/> <line x1="20" y1="62" x2="410" y2="62" stroke="#000"/> <line x1="20" y1="104" x2="410" y2="104" stroke="#000"/> <line x1="20" y1="146" x2="410" y2="146" stroke="#000"/> <text x="180" y="47" font-size="14" text-anchor="middle">Dívky</text> <text x="275" y="47" font-size="14" text-anchor="middle">Chlapci</text> <text x="365" y="47" font-size="14" text-anchor="middle">Celkem</text> <text x="75" y="89" font-size="14" text-anchor="middle">9. A</text> <text x="75" y="131" font-size="14" text-anchor="middle">9. B</text> <text x="75" y="173" font-size="14" text-anchor="middle">Celkem</text> <text x="365" y="89" font-size="14" text-anchor="middle">24</text> </svg>',
  'tabulka-tridy.svg',
  'Tabulka s hlavičkou Dívky, Chlapci, Celkem a řádky 9. A, 9. B, Celkem; vyplněno je pouze pole 9. A Celkem hodnotou 24.',
  'Počty žáků ve třídách 9. A a 9. B',
  new List<String>{'V 9. A: dívky $d$ a chlapci $3d$, $d + 3d = 24 \\Rightarrow d = 6$ dívek, $18$ chlapců. V 9. B: celkem $24 + \\frac{24}{3} = 32$ žáků; poměr $3:5$ (8 dílů) dává $12$ dívek a $20$ chlapců.','11.1 Poměr v 9. A je $6:18 = 1:3$, nikoli $1:2$ → Ne.','11.2 Dívek celkem $6 + 12 = 18$, chlapců v 9. A je $18$; jsou stejné → Ano.','11.3 V 9. B je dívek $12$ a chlapců $20$, rozdíl $20 - 12 = 8$ → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
