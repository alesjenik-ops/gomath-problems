String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, druhý náhradní termín (M9D)';
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
  'CERMAT 2021 M9D · úloha 9',
  new List<String>{'V rovině leží úsečka LM a bod U (viz obrázek).','Úsečka LM je strana rovnoramenného trojúhelníku KLM. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod U leží uvnitř trojúhelníku KLM.','Sestrojte vrchol K trojúhelníku KLM, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 99 172"><path d="M8 10L79 164M75 166L82 162M4 11L11 8M11 70L17 75M11 75L17 70" style="fill:none;stroke:#000000;stroke-width:2"/><text x="89" y="166" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="20" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="14" y="90" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">U</text></svg>',
  'obr.svg',
  'V rovině leží úsečka LM (M vlevo nahoře, L vpravo dole) a bod U ležící vlevo od úsečky.',
  '',
  new List<String>{'Úsečka LM může být buď základnou, nebo ramenem trojúhelníku (rameno $=2\\times$ základna).','a) LM je základna: pak $|KL|=|KM|=2\\,|LM|$; vrchol K leží na ose úsečky LM a na kružnicích $k(L;2|LM|)$, $k(M;2|LM|)$ — dá řešení, u něhož U leží uvnitř.','b) LM je rameno: apexem je L, nebo M. Je-li apexem L, je $|LK|=|LM|$ a základna $|MK|=\\tfrac{1}{2}|LM|$; symetricky pro apex M. Vrchol K sestrojíme jako průsečík odpovídajících kružnic.','Celkem podmínce „U uvnitř trojúhelníku“ vyhovují tři řešení (tři trojúhelníky KLM). Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce tří rovnoramenných trojúhelníků KLM (rameno $=2\\times$ základna, bod U uvnitř); tři řešení.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 10',
  new List<String>{'V rovině leží body A, S. Bod A je vrchol obdélníku ABCD a bod S je střed tohoto obdélníku.','Vrchol C má od vrcholu D i od středu S stejnou vzdálenost, tedy $|CD|=|CS|$.','Sestrojte vrcholy B, C, D obdélníku ABCD, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Střed S je střed úhlopříčky AC, proto vrchol C je obraz bodu A ve středové souměrnosti se středem S (tj. C je souměrný s A podle S) — je určen jednoznačně.','V obdélníku platí $|SA|=|SB|=|SC|=|SD|=r$ (polovina úhlopříčky). Z podmínky $|CD|=|CS|=r$ sestrojíme vrchol D jako průsečík kružnic $k(S;r)$ a $k(C;r)$ — dva průsečíky dávají dvě řešení. Vrchol B je obraz bodu D podle S.','Vzniká obdélník se stranami $r$ a $r\\sqrt{3}$; úloha má dvě řešení. Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce dvou obdélníků ABCD (C souměrný s A podle S, $|CD|=|CS|$); dvě řešení.',
  3, 7, '5',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 11',
  new List<String>{'Číslo $A$ může být kterékoli celé číslo větší než $9$. Číslo $B$ je o $3$ větší než číslo $A$. Číslo $C$ je dvojnásobkem čísla $B$.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Číslo, které je výsledkem výpočtu $A+B+C$, může být sudé.','11.2 Číslo, které je výsledkem výpočtu $A\\cdot B+C$, musí být vždy sudé.','11.3 Číslo, které je výsledkem výpočtu $A+B-C$, musí být vždy záporné.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $B=A+3$ a $C=2B=2A+6$.','11.1: $A+B+C=A+(A+3)+(2A+6)=4A+9$ — vždy liché číslo, nikdy sudé — \\textbf{N}.','11.2: $A\\cdot B+C=A(A+3)+2A+6=A^2+5A+6=(A+2)(A+3)$ — součin dvou po sobě jdoucích celých čísel, tedy vždy sudé — \\textbf{A}.','11.3: $A+B-C=A+(A+3)-(2A+6)=-3$ — vždy záporné — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','algebra','vyrazy','cisla','uvazovani','bez-kalkulacky','bez-kontextu'},
  'M9PDD21C0T04', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
