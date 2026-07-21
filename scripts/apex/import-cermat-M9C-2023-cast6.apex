String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Encyklopedie má o $25\\ \\%$ více stran než atlas, který má $200$ stran. Kolik stran má encyklopedie?','15.2 Róza čte knihu, která má $500$ stran. Počet stran, které Róza již přečetla, je o $50\\ \\%$ větší než počet stran, které dosud nepřečetla. Kolik stran knihy Róza dosud nepřečetla?','15.3 V knihovně jsou některé knihy psané německy, jiné anglicky a ostatní česky. Německy psaných je $30$ knih, což je $10\\ \\%$ všech knih. Anglicky psané tvoří pětinu všech knih. Kolik je v knihovně česky psaných knih?','Nabídka: A) méně než $210$; B) $210$; C) $220$; D) $240$; E) $250$; F) jiný počet.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $200\\cdot1{,}25=250$ — \\textbf{E}.','15.2: nepřečteno $x$, přečteno $1{,}5x$; $x+1{,}5x=500\\Rightarrow2{,}5x=500\\Rightarrow x=200$ — méně než $210$, tedy \\textbf{A}.','15.3: $30$ knih $=10\\ \\%\\Rightarrow$ celkem $300$; anglicky $\\frac{1}{5}\\cdot300=60$; česky $300-30-60=210$ — \\textbf{B}.'},
  '15.1: E; 15.2: A; 15.3: B',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 16',
  new List<String>{'Každý obrazec tvaru obdélníku je složen z malých šedých čtverečků a větších bílých čtverečků. Šedé čtverečky jsou stejné a jsou poskládány do spodní řady a do levého sloupce; zbytek tvoří bílé čtverečky. Každý bílý čtvereček má dvakrát delší stranu než šedý. První obrazec má ve spodní řadě $5$ šedých čtverečků a v levém sloupci $3$ šedé čtverečky; skládá se celkem z $9$ čtverečků. Každý další obrazec má oproti předchozímu vždy o $2$ šedé čtverečky více jak ve spodní řadě, tak i v levém sloupci.','16.1 Obrazec má ve spodní řadě $41$ šedých čtverečků. Určete počet bílých čtverečků v obrazci.','16.2 V obrazci je $90$ bílých čtverečků. Určete počet šedých čtverečků v obrazci.','16.3 Počet všech čtverečků v posledním a v předposledním obrazci se liší o $106$. Určete počet šedých čtverečků v posledním obrazci.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 143"><path d="M4 4L5 4L5 20L4 20Z" style="fill:#000000"/><path d="M4 138L5 138L5 139L4 139Z" style="fill:#000000"/><path d="M4 138L5 138L5 139L4 139Z" style="fill:#000000"/><path d="M5 138L467 138L467 139L5 139Z" style="fill:#000000"/><path d="M4 20L5 20L5 138L4 138Z" style="fill:#000000"/><path d="M16 64L87 64L87 107L16 107Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M31 64L87 64L87 93L31 93Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M16 78L31 78M16 93L31 93M31 93L31 107M45 93L45 107M59 64L59 107M73 93L73 107M144 50L130 50M229 64L130 64M144 78L130 78M144 93L130 93M144 107L144 93M158 107L158 93M172 107L172 36M187 107L187 93M201 107L201 36M215 107L215 93" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M130 36L229 36L229 107L130 107Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M144 36L229 36L229 93L144 93Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><text x="280" y="85" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="53" y="125" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="181" y="125" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text></svg>',
  'obr.svg',
  'Posloupnost obrazců tvaru obdélníku z malých šedých a větších bílých čtverečků; 1. a 2. obrazec a tři tečky naznačující pokračování.',
  '',
  new List<String>{'Pro $n$-tý obrazec: spodní řada $=2n+3$ šedých, levý sloupec $=2n+1$ šedých. Bílá část má rozměr $(2n+2)\\times2n$ v malých čtverečcích, tj. bílých $\\frac{2n+2}{2}\\cdot\\frac{2n}{2}=n(n+1)$. Šedých je $(2n+3)+(2n+1)-1=4n+3$.','16.1: $2n+3=41\\Rightarrow n=19$; bílých $19\\cdot20=380$.','16.2: $n(n+1)=90\\Rightarrow n=9$; šedých $4\\cdot9+3=39$.','16.3: celkem $C(n)=n^2+5n+3$; $C(n)-C(n-1)=2n+4=106\\Rightarrow n=51$; šedých $4\\cdot51+3=207$.'},
  '16.1: $380$ bílých; 16.2: $39$ šedých; 16.3: $207$ šedých',
  4, 6, '4',
  new List<String>{'zs2','r9','posloupnosti','algebra','vypocet','slovni','bez-kalkulacky'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
