String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
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
  'CERMAT 2025 M9C · úloha 8',
  new List<String>{'Podlaha chodby je vydlážděna čtvercovými dlaždicemi se stranou $20\\ \\mathrm{cm}$; každá je ozdobena čtvrtkruhem a malým kruhem (viz obrázek vlevo). Dlaždice se pokládaly ve čtveřicích (obrázek vpravo). Poloměr malého kruhu je $10\\ \\mathrm{cm}$... resp. dle obrázku.','8.1 Vypočtěte v $\\mathrm{cm}^2$ obsah jednoho malého kruhu (zaokrouhlete na celé $\\mathrm{cm}^2$).','8.2 Podlaha má tvar obdélníku $2\\ \\mathrm{m}\\times3{,}2\\ \\mathrm{m}$. Určete, o kolik se liší počet malých a velkých kruhů na podlaze.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 305 121"><path d="M244 61L301 61L301 117L244 117ZM244 4L301 4L301 61L244 61ZM188 4L244 4L244 61L188 61ZM188 61L244 61L244 117L188 117ZM32 4L88 4L88 61L32 61Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M273 61C273 76 260 89 244 89C244 80 244 70 244 61L273 61Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M273 103C273 95 279 89 287 89C295 89 301 95 301 103C301 111 295 117 287 117C279 117 273 111 273 103Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M273 61C273 45 260 32 244 32C244 42 244 51 244 61L273 61Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M273 18C273 26 279 32 287 32C295 32 301 26 301 18C301 10 295 4 287 4C279 4 273 10 273 18Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M216 61C216 45 229 32 244 32C244 42 244 51 244 61L216 61Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M216 18C216 26 210 32 202 32C194 32 188 26 188 18C188 10 194 4 202 4C210 4 216 10 216 18Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M216 61C216 76 229 89 244 89C244 80 244 70 244 61L216 61Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M216 103C216 95 210 89 202 89C194 89 188 95 188 103C188 111 194 117 202 117C210 117 216 111 216 103Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M60 4L60 61M32 32L88 32" style="fill:none;stroke:#7f7f7f;stroke-width:1"/><path d="M60 4C60 20 47 32 32 32C32 23 32 14 32 4L60 4Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M60 47C60 39 66 32 74 32C82 32 88 39 88 47C88 54 82 61 74 61C66 61 60 54 60 47Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M88 66L32 66C32 66 32 66 32 66C32 67 32 67 32 67L88 67C88 67 88 67 88 66C88 66 88 66 88 66M82 69L88 66L82 64C82 64 82 64 81 64C81 64 81 64 82 64L88 67L88 66L82 69C81 69 81 69 81 69C82 69 82 69 82 69M38 64L32 66L38 69C38 69 38 69 39 69C39 69 39 69 38 69L32 66L32 67L38 64C39 64 39 64 39 64C38 64 38 64 38 64Z" style="fill:#000000"/><path d="M26 60L26 33C26 33 26 33 26 33C26 33 26 33 26 33L26 60C26 60 26 60 26 60C26 60 26 60 26 60M23 54L26 61L29 54C29 54 29 54 29 54C28 54 28 54 28 54L26 60L26 60L24 54C24 54 24 54 23 54C23 54 23 54 23 54M29 39L26 32L23 39C23 39 23 39 23 39C24 39 24 39 24 39L26 33L26 33L28 39C28 39 28 39 29 39C29 39 29 39 29 39Z" style="fill:#000000"/><path d="M94 32L94 5C94 5 94 4 94 4C94 4 94 5 94 5L94 32C94 32 94 32 94 32C94 32 94 32 94 32M91 26L94 32L97 26C97 26 97 26 97 25C96 25 96 25 96 26L94 32L94 32L92 26C92 25 92 25 91 25C91 26 91 26 91 26M97 11L94 4L91 11C91 11 91 11 91 11C92 11 92 11 92 11L94 5L94 5L96 11C96 11 96 11 97 11C97 11 97 11 97 11Z" style="fill:#000000"/><text x="7" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text><text x="113" y="24" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text><text x="61" y="80" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20 cm</text></svg>',
  'obr.svg',
  'Čtvercová dlaždice se čtvrtkruhem a malým kruhem a čtveřice dlaždic tvořící uprostřed velký kruh.',
  '',
  new List<String>{'8.1: malý kruh má poloměr $5\\ \\mathrm{cm}$; $S=\\pi\\cdot5^2\\doteq79\\ \\mathrm{cm}^2$.','8.2: dlaždic je $\\frac{200}{20}\\cdot\\frac{320}{20}=10\\cdot16=160$. Malých kruhů $160$ (po jednom na dlaždici), velké kruhy vzniknou vždy ze čtyř čtvrtkruhů čtveřice, tj. $\\frac{160}{4}=40$. Rozdíl $160-40=120$.'},
  '8.1: $79\\ \\mathrm{cm}^2$; 8.2: o $120$',
  3, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
