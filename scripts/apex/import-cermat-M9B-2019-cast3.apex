String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 2. řádný termín (M9B)';
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
  'CERMAT 2019 M9B · úloha 10',
  new List<String>{'V rovině leží přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).','Bod $A$ je vrchol čtverce $ABCD$, bod $S$ leží uvnitř tohoto čtverce a na přímce $p$ leží strana $AB$. Právě dva ze čtyř vrcholů čtverce $ABCD$ leží na kružnici $k$.','Sestrojte a označte písmeny chybějící vrcholy čtverce $ABCD$ a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 307 262"><path d="M4 166L303 258M169 115L175 120M169 120L175 115M59 117C59 55 110 4 172 4C235 4 286 55 286 117C286 180 235 231 172 231C110 231 59 180 59 117" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="9" y="179" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="81" y="204" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="78" y="45" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="179" y="132" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text></svg>',
  'obr.svg',
  'V rovině leží přímka p a kružnice k se středem S; bod A je jedním ze dvou průsečíků přímky p a kružnice k.',
  '',
  new List<String>{'Strana $AB$ leží na přímce $p$, proto je vrchol $B$ druhý průsečík přímky $p$ s kružnicí $k$ (aby $A$ i $B$ ležely na $k$ — to jsou ony dva vrcholy na kružnici). Délka strany je $|AB|$.','Zbývající vrcholy $C$, $D$ sestrojíme jako kolmice k $AB$ v bodech $B$ a $A$ o délce $|AB|$ na té straně, kde leží střed $S$ (bod $S$ musí být uvnitř čtverce). Úloha vede na jedno řešení splňující všechny podmínky.'},
  'Konstrukce čtverce $ABCD$: $B$ = druhý průsečík $p$ a $k$, vrcholy $C$, $D$ kolmo k $AB$ na straně bodu $S$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 11',
  new List<String>{'Do tabulky se zapisují počty telefonních hovorů tří dětí (Aleš, Běla, Cyril) v prvním čtvrtletí kalendářního roku; některé údaje chybí. Známé údaje: Aleš měl v březnu $12$ hovorů; Běla měla v únoru $12$ hovorů; Cyril měl v únoru $9$ hovorů a jeho aritmetický průměr za měsíc je $9$; součet hovorů všech tří dětí v lednu je $36$.','V lednu měly všechny tři děti stejný počet hovorů. Aleš měl v březnu o třetinu hovorů méně než v únoru. Běla měla v březnu o polovinu hovorů více než v únoru.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V prvním čtvrtletí byl aritmetický průměr počtu hovorů Aleše za měsíc menší než $14$.','11.2 Běla měla za první čtvrtletí celkem $42$ hovorů.','11.3 V březnu měl Cyril třikrát méně hovorů než Běla.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'V lednu všichni stejně: $36:3=12$ hovorů každý. Aleš: březen $12=\\frac{2}{3}\\cdot$ únor $\\Rightarrow$ únor $=18$; průměr Aleše $\\frac{12+18+12}{3}=14$. Běla: březen $=\\frac{3}{2}\\cdot12=18$; součet $12+12+18=42$. Cyril: průměr $9\\Rightarrow$ součet $27$; březen $27-12-9=6$.','11.1: průměr Aleše $=14$, není menší než $14$ — \\textbf{N}.','11.2: Běla má $42$ hovorů — \\textbf{A}.','11.3: Cyril v březnu $6$, Běla $18$; $18:3=6$ — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD19C0T02', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
