String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
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
  'CERMAT 2025 M9D · úloha 11',
  new List<String>{'Kružnice se středem $S$ prochází body $A$, $B$, $K$, $L$; úsečky $AB$ a $KL$ se protínají v bodě $S$ (jsou to průměry). V obrázku je vyznačen úhel $64^\\circ$ a úhly $\\alpha$, $\\beta$, $\\gamma$, $\\delta$.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 $\\alpha>64^\\circ$.','11.2 $\\alpha+\\beta>90^\\circ$.','11.3 $\\gamma-\\alpha>\\delta$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 169"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 93L466 93Z" style="fill:#000000"/><path d="M466 93L467 93L467 112L466 112Z" style="fill:#000000"/><path d="M466 112L467 112L467 137L466 137Z" style="fill:#000000"/><path d="M466 137L467 137L467 165L466 165Z" style="fill:#000000"/><path d="M302 85C302 45 334 14 373 14C412 14 444 45 444 85C444 124 412 155 373 155C334 155 302 124 302 85M302 85L444 85M325 33L421 136M325 33L302 85M325 33L444 85" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M311 65C319 68 323 76 323 84M400 66C397 72 396 78 396 84M361 72C368 65 379 66 385 73C388 76 390 80 390 84M355 65C350 70 347 77 347 85M343 53C335 60 324 62 314 58" style="fill:none;stroke:#000000;stroke-width:1"/><text x="214" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="220" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">K</text><text x="225" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="230" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="237" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="370" y="99" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="296" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="451" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="322" y="32" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">K</text><text x="426" y="148" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="326" y="58" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">64</text><text x="334" y="58" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="313" y="82" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="402" y="81" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text><text x="377" y="80" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛾</text><text x="354" y="82" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛿</text></svg>',
  'obr.svg',
  'Kružnice se středem S procházející body A, B, K, L; úsečky AB a KL se protínají v S; vyznačen úhel 64° a úhly alfa, beta, gama, delta.',
  '',
  new List<String>{'$AB$ i $KL$ jsou průměry, trojúhelníky s vrcholy na kružnici jsou rovnoramenné (ramena jsou poloměry).','Z vlastností rovnoramenných trojúhelníků a vrcholových úhlů u středu $S$ vyjde: $\\alpha<64^\\circ$ — N; $\\alpha+\\beta<90^\\circ$ — N; $\\gamma-\\alpha>\\delta$ — A.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 12',
  new List<String>{'Povrch malé krychle je o $42\\ \\mathrm{cm}^2$ menší než povrch velké krychle. Součet délek všech hran malé krychle je $36\\ \\mathrm{cm}$.','O kolik $\\mathrm{cm}^3$ se liší objem malé a velké krychle?'},
  new List<String>{'A) o $14\\ \\mathrm{cm}^3$','B) o $27\\ \\mathrm{cm}^3$','C) o $37\\ \\mathrm{cm}^3$','D) o $46\\ \\mathrm{cm}^3$','E) o jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Malá krychle: $12a=36\\Rightarrow a=3$, povrch $6\\cdot9=54\\ \\mathrm{cm}^2$. Velká: povrch $54+42=96\\Rightarrow b^2=16\\Rightarrow b=4$.','Objemy $27$ a $64\\ \\mathrm{cm}^3$; rozdíl $37\\ \\mathrm{cm}^3$.'},
  'C) o $37\\ \\mathrm{cm}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
