String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
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
  'CERMAT M5A 2021 – úloha 5',
  new List<String>{'Na pódiu má tančit stejný počet chlapců a dívek. Při tanci všichni tančící vytvoří několik velkých a několik malých kroužků. V každém velkém kroužku bude sedm chlapců a jedna dívka, v každém malém kroužku budou čtyři dívky.','5.1 Určete nejmenší možný počet všech tančících (chlapců i dívek) na pódiu.','5.2 Určete nejmenší možný počet malých kroužků.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Při $v$ velkých a $m$ malých kroužcích je chlapců $7v$ a dívek $v+4m$. Rovnost $7v=v+4m$ dává $3v=2m$.','5.1 Nejmenší řešení je $v=2$, $m=3$: chlapců $14$, dívek $14$, celkem $28$ tančících.','5.2 Malých kroužků jsou $3$.'},
  '5.1: $28$ tančících; 5.2: $3$ malé kroužky',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2021 – úloha 6',
  new List<String>{'Na vytvoření každého obrazce použijeme beze zbytku dva čtverce o straně délky $6$ cm. Čtverce rozstříháme a ze všech získaných dílů sestavíme obrazec, jehož strany (úsečky po obvodu) mají pouze dvě různé délky. (Čtverec o straně délky $6$ cm má obsah $36$ cm².)','6.1 Vypočtěte v cm obvod obrazce A.','6.2 Vypočtěte, kolik cm měří nejdelší svislá strana obrazce B.','6.3 Určete, o kolik cm² se liší obsahy obrazců A, B.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 210" font-family="sans-serif"><rect x="20" y="50" width="70" height="70" fill="none" stroke="#000"/><line x1="20" y1="50" x2="90" y2="120" stroke="#888" stroke-dasharray="3 4"/><line x1="90" y1="50" x2="20" y2="120" stroke="#888" stroke-dasharray="3 4"/><text x="55" y="140" font-size="12" text-anchor="middle">6 cm</text><text x="205" y="38" font-size="13" text-anchor="middle">Obrazec A</text><polygon points="150,55 185,55 185,90 220,90 220,125 255,125 255,160 150,160" fill="none" stroke="#000"/><line x1="150" y1="55" x2="255" y2="160" stroke="#999"/><text x="450" y="38" font-size="13" text-anchor="middle">Obrazec B</text><polygon points="360,55 500,55 500,175 465,175 465,140 430,140 430,105 395,105 395,70 360,70" fill="none" stroke="#000"/><line x1="360" y1="55" x2="500" y2="175" stroke="#999"/><line x1="514" y1="55" x2="514" y2="175" stroke="#000"/><text x="530" y="115" font-size="11" transform="rotate(90 530 115)" text-anchor="middle">nejdelší svislá strana</text></svg>',
  'obrazce-ctverce.svg',
  'Zdrojový čtverec o straně 6 cm a dva schodovité obrazce A a B sestavené ze dvou takových čtverců.',
  'Schematický nákres (obsah čtverce 36 cm²)',
  new List<String>{'Oba obrazce vzniknou z týchž dvou čtverců o obsahu $36$ cm², proto mají stejný obsah $2\\cdot 36=72$ cm².','6.1 Součtem délek stran (mají jen dvě různé délky) vyjde obvod obrazce A $54$ cm.','6.2 Nejdelší svislá strana obrazce B měří $8$ cm.','6.3 Obsahy obou obrazců jsou stejné, liší se o $0$ cm².'},
  '6.1: $54$ cm; 6.2: $8$ cm; 6.3: o $0$ cm²',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2021 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $K$, $L$. Bodem $A$ prochází přímka $p$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží ještě jeden vrchol tohoto obdélníku. Bod $K$ leží uvnitř jedné strany obdélníku $ABCD$ a bod $L$ uvnitř sousední strany.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" font-family="sans-serif"><line x1="40" y1="250" x2="610" y2="95" stroke="#000" stroke-width="2"/><text x="28" y="262" font-size="15" font-style="italic">p</text><line x1="150" y1="223" x2="163" y2="214" stroke="#000" stroke-width="2"/><text x="150" y="240" font-size="14" font-style="italic">A</text><text x="255" y="152" font-size="14" font-style="italic">L</text><text x="252" y="168" font-size="14" text-anchor="middle">×</text><text x="470" y="120" font-size="14" font-style="italic">K</text><text x="470" y="136" font-size="14" text-anchor="middle">×</text></svg>',
  'bod-A-primka-p.svg',
  'Přímka p procházející bodem A a dva body K a L nad přímkou.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Jeden z vrcholů sousedících s $A$ leží na přímce $p$, proto jedna strana obdélníku leží na $p$. Vrcholy $B$, $C$, $D$ sestrojíme tak, aby $ABCD$ byl obdélník, jehož dvě sousední strany procházejí danými body $K$ a $L$. Úloha má dvě řešení.'},
  'Konstrukce obdélníku $ABCD$ s jednou stranou na přímce $p$ a stranami procházejícími body $K$, $L$; dvě řešení $AB_1C_1D_1$ a $AB_2C_2D_2$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
