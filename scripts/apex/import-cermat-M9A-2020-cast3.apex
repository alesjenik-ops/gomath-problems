String SRC   = 'CERMAT – Jednotná přijímací zkouška 2020, řádný termín (M9A)';
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
  'CERMAT 2020 M9A · úloha 9',
  new List<String>{'V rovině leží přímka $AC$ a přímka $b$ (viz obrázek).','Body $A$, $C$ jsou vrcholy trojúhelníku $ABC$. Na přímce $b$ leží vrchol $B$. Délka těžnice $t_b$ na stranu $AC$ je $6\\ \\mathrm{cm}$.','Sestrojte vrchol $B$ trojúhelníku $ABC$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 348 228"><path d="M4 224L342 171M68 107L65 101M24 127L253 4M222 25L219 19" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="338" y="189" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">b</text><text x="222" y="16" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="67" y="99" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text></svg>',
  'obr.svg',
  'V rovině leží přímka AC (s vyznačenými body A a C) a přímka b.',
  '',
  new List<String>{'Těžnice $t_b$ spojuje vrchol $B$ se středem $S_{AC}$ strany $AC$. Sestrojíme střed $S_{AC}$ úsečky $AC$.','Vrchol $B$ leží na přímce $b$ a zároveň na kružnici se středem $S_{AC}$ a poloměrem $6\\ \\mathrm{cm}$ (podmínka $|BS_{AC}|=t_b=6\\ \\mathrm{cm}$).','Průsečíky přímky $b$ s touto kružnicí dávají dvě polohy vrcholu $B$ ($B_1$, $B_2$) — úloha má dvě řešení.'},
  'Konstrukce vrcholu $B$ na přímce $b$ tak, že $|BS_{AC}|=6\\ \\mathrm{cm}$; úloha má dvě řešení ($B_1$, $B_2$).',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 10',
  new List<String>{'V rovině leží přímka $o$ a body $A$, $M$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $M$ je střed jeho ramene $BC$. Přímka $o$ je osou lichoběžníku $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 157 257"><path d="M80 239L4 4M15 231L21 236M15 236L21 231M141 113L147 118M141 118L147 113" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="147" y="133" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="15" y="14" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text><text x="16" y="251" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text></svg>',
  'obr.svg',
  'V rovině leží přímka o a body A, M (označené křížky).',
  '',
  new List<String>{'Přímka $o$ je osou souměrnosti rovnoramenného lichoběžníku, proto se vrchol $B$ zobrazí na vrchol $A$. Vrchol $B$ tedy sestrojíme jako obraz bodu $A$ v osové souměrnosti podle osy $o$.','Bod $M$ je střed ramene $BC$, proto vrchol $C$ sestrojíme tak, aby $M$ byl středem úsečky $BC$ (bod $C$ je středově souměrný s $B$ podle bodu $M$).','Vrchol $D$ získáme jako obraz vrcholu $C$ v osové souměrnosti podle osy $o$.'},
  'Konstrukce lichoběžníku $ABCD$: $B$ je obraz $A$ podle osy $o$, $C$ tak, že $M$ je střed $BC$, $D$ je obraz $C$ podle osy $o$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','soumernost','rysovani','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 11',
  new List<String>{'Všichni pracovníci natírají plot stejným tempem. Polovinu plotu by natřeli všichni pracovníci společně za $6$ hodin.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 \\quad Celý plot by natřeli všichni pracovníci společně za $9$ hodin.','11.2 \\quad Polovinu plotu by natřela třetina pracovníků společně za $18$ hodin.','11.3 \\quad Čtvrtinu plotu by natřela čtvrtina pracovníků společně za $12$ hodin.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Všichni pracovníci natřou polovinu plotu za $6$ hodin, tedy celý plot za $12$ hodin.','11.1: celý plot trvá $12$ hodin, ne $9$ hodin — \\textbf{N}.','11.2: třetina pracovníků potřebuje na stejnou práci trojnásobný čas: polovinu plotu za $3\\cdot6=18$ hodin — \\textbf{A}.','11.3: všichni natřou čtvrtinu plotu za $12:4=3$ hodiny; čtvrtina pracovníků čtyřikrát déle, tj. $4\\cdot3=12$ hodin — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '4',
  new List<String>{'zs2','r9','pomer','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
