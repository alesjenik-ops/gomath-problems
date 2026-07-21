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
  'CERMAT 2020 M9A · úloha 7',
  new List<String>{'Škrabací sloupek pro kočky má tvar rotačního válce. Válec má výšku $50\\ \\mathrm{cm}$ a jeho podstava má průměr $14\\ \\mathrm{cm}$. Obě podstavy jsou bílé, plášť válce je šedý. (Za $\\pi$ dosazujte $\\frac{22}{7}$.)','Vypočtěte v $\\mathrm{cm}^2$:','7.1 \\quad obsah jedné podstavy válce,','7.2 \\quad obsah pláště válce.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 57 144"><path d="M16 13L15 6L15 6L13 7L13 6L15 5L16 5L17 13L16 13M24 12L23 12L22 10L19 10L19 10L22 4L23 4L23 9L24 9L24 10L23 10L24 12M20 9L22 9L22 7C22 6 22 6 22 5L22 5C22 6 21 6 21 7L20 9Z" style="fill:#231f20"/><path d="M32 10L32 11C32 11 32 11 32 11C31 11 31 11 31 11C30 11 29 11 29 11C28 10 28 9 28 9C27 8 28 7 28 6C29 6 29 5 30 5C31 5 31 5 32 5L32 6C31 6 31 6 30 6C30 6 29 6 29 7C29 7 29 8 29 8C29 9 29 10 29 10C30 10 30 10 31 10C31 10 32 10 32 10M34 11L33 6C33 6 33 5 33 5L34 5L34 6L34 6C34 5 35 5 36 4C36 4 36 4 37 5C37 5 37 5 37 5L38 5C38 5 38 5 38 5C38 4 39 4 39 4C39 4 40 4 40 4C40 4 40 4 40 4C41 4 41 4 41 5C41 5 41 5 41 5C41 6 41 6 41 6L42 10L41 10L40 7C40 6 40 6 40 5C40 5 39 5 39 5C39 5 38 5 38 5C38 6 38 6 38 6C38 6 38 6 38 7L38 10L37 10L37 7C37 6 37 6 36 6C36 5 36 5 35 5C35 5 35 6 35 6C34 6 34 6 34 7C34 7 34 7 34 7L35 11Z" style="fill:#231f20"/><path d="M53 26L53 9M5 32L5 15" style="fill:none;stroke:#929597;stroke-width:1"/><path d="M5 134C4 130 14 125 28 124C41 122 52 124 53 128C53 132 43 137 29 139C16 140 5 138 5 134Z" style="fill:#dcddde;stroke:#231f20;stroke-width:2"/><path d="M5 134L52 128L52 26L5 32Z" style="fill:#dcddde"/><path d="M5 32C4 28 14 23 28 22C41 20 52 22 53 26C53 30 43 35 29 37C16 38 5 36 5 32Z" style="fill:#ffffff;stroke:#231f20;stroke-width:2"/><path d="M4 32L4 134M53 26L53 128" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M5 18L52 12C52 12 52 12 52 12C52 12 52 12 52 12L5 17C5 17 5 18 5 18C5 18 5 18 5 18M11 14L4 18L12 20C12 20 12 20 12 20C12 19 12 19 12 19L5 17L6 18L11 15C11 15 11 14 11 14C11 14 11 14 11 14M46 16L53 12L45 10C45 10 45 10 45 10C45 10 45 11 45 11L52 12L51 12L46 15C46 15 46 15 46 15C46 16 46 16 46 16Z" style="fill:#231f20"/><path d="M5 32L53 26" style="fill:none;stroke:#231f20;stroke-width:1"/></svg>',
  'obr.svg',
  'Rotační válec (škrabací sloupek) o výšce 50 cm a s podstavou o průměru 14 cm; plášť je šedý.',
  '',
  new List<String>{'7.1: poloměr $r=7\\ \\mathrm{cm}$; obsah podstavy $=\\pi r^2=\\frac{22}{7}\\cdot49=154\\ \\mathrm{cm}^2$.','7.2: obsah pláště $=\\pi d\\cdot h=\\frac{22}{7}\\cdot14\\cdot50=2\\,200\\ \\mathrm{cm}^2$.'},
  '7.1: $154\\ \\mathrm{cm}^2$; 7.2: $2\\,200\\ \\mathrm{cm}^2$',
  3, 5, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','slovni','bez-kalkulacky'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 8',
  new List<String>{'Obdélníkový záhon má rozměry $210\\ \\mathrm{cm}$ a $140\\ \\mathrm{cm}$.','8.1 \\quad Záhon bude po obvodu osázen tulipány ve stejných rozestupech. Rozestupy mezi sousedními tulipány musí být co největší, přitom tulipán musí být v každém rohu záhonu a také uprostřed delší strany. Vypočtěte v cm rozestup mezi sousedními tulipány.','8.2 \\quad Uvnitř záhonu je vyznačen menší obdélník. V jeho rozích a po jeho obvodu budou v $10$centimetrových rozestupech vysázeny narcisy. Každý narcis bude vzdálen $25\\ \\mathrm{cm}$ od nejbližšího okraje záhonu. Vypočtěte, kolik narcisů bude vysázeno.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: rozestup musí beze zbytku dělit kratší stranu $140\\ \\mathrm{cm}$ i polovinu delší strany $105\\ \\mathrm{cm}$ (tulipán je i uprostřed delší strany). Největší takové číslo je největší společný dělitel čísel $105$ a $140$, tedy $35\\ \\mathrm{cm}$.','8.2: vnitřní obdélník je od každého okraje vzdálen $25\\ \\mathrm{cm}$, jeho rozměry jsou $(210-2\\cdot25)\\times(140-2\\cdot25)=160\\times90\\ \\mathrm{cm}$; jeho obvod je $2\\cdot(160+90)=500\\ \\mathrm{cm}$. Narcisy jsou po $10\\ \\mathrm{cm}$: $500:10=50$ narcisů.'},
  '8.1: $35\\ \\mathrm{cm}$; 8.2: $50$ narcisů',
  4, 7, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
