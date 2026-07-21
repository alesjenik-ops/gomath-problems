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
  'CERMAT 2026 M9B · úloha 16',
  new List<String>{'První obrazec je bílý čtverec. Druhý obrazec vznikne z prvního vložením menšího šedého čtverce, jehož vrcholy leží ve středech stran bílého čtverce. Další obrazce vznikají střídavým vkládáním stále menších bílých a šedých čtverců (viz obrázek). Např. třetí obrazec obsahuje $9$ dílů — $1$ bílý čtverec, $4$ šedé trojúhelníky a $4$ bílé trojúhelníky.','16.1 Určete, kolik šedých dílů obsahuje $10.$ obrazec.','16.2 Určete, kolikátý obrazec obsahuje $89$ bílých dílů.','16.3 Vyjádřete zlomkem, jakou část obsahu $5.$ obrazce představuje obsah všech jeho šedých dílů dohromady.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 130"><path d="M4 125L5 125L5 126L4 126Z" style="fill:#000000"/><path d="M4 125L5 125L5 126L4 126Z" style="fill:#000000"/><path d="M5 125L467 125L467 126L5 126Z" style="fill:#000000"/><path d="M4 4L5 4L5 125L4 125Z" style="fill:#000000"/><path d="M16 34L96 34L96 113L16 113ZM107 34L187 34L187 113L107 113ZM198 34L277 34L277 113L198 113ZM289 34L368 34L368 113L289 113Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M107 74L147 34L187 74L147 113L107 74Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M198 74L238 34L277 74L238 113L198 74Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M218 54L257 54L257 93L218 93Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M289 74L328 34L368 74L328 113L289 74Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M308 54L348 54L348 93L308 93Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M308 74L328 54L348 74L328 93L308 74Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><text x="402" y="80" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="58" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="148" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text><text x="239" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. obrazec</text><text x="330" y="27" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4. obrazec</text></svg>',
  'obr.svg',
  'Posloupnost čtyř obrazců z vnořených bílých a šedých čtverců (1. až 4. obrazec).',
  '',
  new List<String>{'V $n$-tém obrazci ($n\\ge2$) je počet šedých dílů $2n-3$ a počet bílých dílů $2n-1$ (u prvního obrazce je $1$ bílý díl).','16.1: $2\\cdot10-3=17$ šedých dílů.','16.2: $2n-1=89\\Rightarrow n=45$, tedy $45.$ obrazec.','16.3: každým vložením se obsah nového čtverce zmenší na polovinu; šedé díly $5.$ obrazce mají dohromady obsah $\\frac{5}{16}$ obsahu celého čtverce.'},
  '16.1: $17$ šedých dílů; 16.2: $45.$ obrazec; 16.3: $\\frac{5}{16}$',
  4, 6, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
