String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
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
  'CERMAT 2026 M9B · úloha 12',
  new List<String>{'V trojúhelníkovém diagramu se do prázdných kroužků doplní taková kladná celá čísla, aby byl součin tří čísel na každé straně trojúhelníku stejný (viz obrázek).','Jaký je součet obou čísel doplněných do prázdných kroužků diagramu?'},
  new List<String>{'A) $11$','B) $14$','C) $19$','D) $22$','E) jiný součet'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 157"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 93L466 93Z" style="fill:#000000"/><path d="M466 93L467 93L467 112L466 112Z" style="fill:#000000"/><path d="M466 112L467 112L467 131L466 131Z" style="fill:#000000"/><path d="M466 131L467 131L467 153L466 153Z" style="fill:#000000"/><path d="M333 34L385 124L438 34L333 34" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M316 34C316 24 324 17 333 17C342 17 350 24 350 34C350 43 342 51 333 51C324 51 316 43 316 34Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M368 34C368 24 376 17 385 17C395 17 402 24 402 34C402 43 395 51 385 51C376 51 368 43 368 34Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M421 34C421 24 428 17 438 17C447 17 455 24 455 34C455 43 447 51 438 51C428 51 421 43 421 34Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M342 79C342 70 350 62 359 62C369 62 376 70 376 79C376 88 369 96 359 96C350 96 342 88 342 79Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M394 79C394 70 402 62 411 62C421 62 428 70 428 79C428 88 421 96 411 96C402 96 394 88 394 79Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M368 124C368 115 376 107 385 107C395 107 402 115 402 124C402 134 395 141 385 141C376 141 368 134 368 124Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><text x="387" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6</text><text x="439" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="360" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="413" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">5</text></svg>',
  'obr.svg',
  'Trojúhelníkový diagram se šesti kroužky; vyplněná čísla 6, 8, 4, 5 a dva prázdné kroužky.',
  '',
  new List<String>{'Označme horní levý kroužek $t$ a dolní kroužek $b$. Součin na horní straně je $t\\cdot6\\cdot8=48t$, na pravé $8\\cdot5\\cdot b=40b$, na levé $t\\cdot4\\cdot b$.','Z $48t=4tb$ plyne $b=12$; z $48t=40b=480$ plyne $t=10$.','Součet doplněných čísel je $t+b=10+12=22$.'},
  'D) $22$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','algebra','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
