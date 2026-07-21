String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 1. řádný termín (M9A)';
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
  'CERMAT 2022 M9A · úloha 9',
  new List<String>{'V rovině leží body C, S a přímka $q$ (viz obrázek).','Bod C je vrchol rovnoramenného trojúhelníku ABC se základnou AB. Bod S je střed jednoho ramene tohoto trojúhelníku a na přímce $q$ leží jeden z vrcholů A, B.','Sestrojte vrcholy A, B trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 383 151"><path d="M178 130L183 125M183 130L178 125M212 48L218 42M218 48L212 43M4 4L376 4" style="fill:none;stroke:#000000;stroke-width:2"/><text x="180" y="145" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="213" y="41" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="373" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text></svg>',
  'obr.svg',
  'V rovině leží body C a S a přímka q; bod S je nad bodem C, přímka q je vodorovná nad nimi.',
  '',
  new List<String>{'Bod S je střed ramene, tedy střed úsečky spojující vrchol C s jedním z vrcholů A, B, který leží na přímce $q$. Ve středové souměrnosti se středem S se vrchol C zobrazí na tento vrchol ležící na $q$: sestrojíme obraz $C\'$ bodu C v souměrnosti podle S a jeho průsečík s přímkou $q$ dává hledaný vrchol (A nebo B).','Druhý vrchol základny doplníme tak, aby trojúhelník ABC byl rovnoramenný se základnou AB (vrchol C je od obou vrcholů základny stejně vzdálen). Úloha se řeší konstrukcí; podle polohy může mít jedno řešení.','Jde o konstrukční úlohu, hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce rovnoramenného trojúhelníku ABC (S střed ramene, jeden vrchol základny na přímce $q$); nutno nalézt všechna řešení.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 10',
  new List<String>{'V rovině leží bod O a přímka $p$ (viz obrázek).','Bod O je střed čtverce ABCD, jehož strana BC leží na přímce $p$.','Sestrojte všechny vrcholy čtverce ABCD, označte je písmeny a čtverec narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 314"><path d="M4 309L466 309L466 310L4 310Z" style="fill:#000000"/><path d="M466 309L467 309L467 310L466 310Z" style="fill:#000000"/><path d="M466 309L467 309L467 310L466 310Z" style="fill:#000000"/><path d="M466 4L467 4L467 309L466 309Z" style="fill:#000000"/><path d="M208 162L202 156M202 162L208 156M196 25L365 215" style="fill:none;stroke:#000000;stroke-width:2"/><text x="205" y="175" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">O</text><text x="359" y="223" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'V rovině leží bod O a šikmá přímka p vpravo od bodu O.',
  '',
  new List<String>{'Vzdálenost středu O od přímky $p$ (na níž leží strana BC) je rovna polovině strany čtverce; strana čtverce má tedy délku $2\\cdot|Op|$, kde $|Op|$ je vzdálenost bodu O od přímky $p$.','Sestrojíme kolmici z O na $p$, její patu a od ní naneseme na obě strany po $|Op|$ (vrcholy B, C); protější stranu AD získáme posunutím o $2\\cdot|Op|$ kolmo od $p$ přes bod O. Označíme vrcholy a čtverec narýsujeme.','Jde o konstrukční úlohu, hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce čtverce ABCD se středem O a stranou BC na přímce $p$ (strana $=2\\cdot|Op|$).',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 11',
  new List<String>{'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 \\quad Tři čtvrtiny z $200$ minut je totéž jako polovina ze $3$ hodin.','11.2 \\quad Dvě třetiny z $2{,}4$ hodiny je více než $1$ hodina a $40$ minut.','11.3 \\quad Tři osminy z $5$ dnů je totéž jako pět osmin ze $3$ dnů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'11.1: $\\frac{3}{4}\\cdot200=150$ min; polovina ze $3$ hodin $=1{,}5$ h $=90$ min. $150\\neq90$ — \\textbf{N}.','11.2: $\\frac{2}{3}\\cdot2{,}4$ h $=1{,}6$ h $=1$ h $36$ min; to je méně než $1$ h $40$ min — \\textbf{N}.','11.3: $\\frac{3}{8}\\cdot5=\\frac{15}{8}$ a $\\frac{5}{8}\\cdot3=\\frac{15}{8}$ — jsou stejné — \\textbf{A}.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
