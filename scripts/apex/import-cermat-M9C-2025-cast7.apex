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
  'CERMAT 2025 M9C · úloha 16',
  new List<String>{'Vytváříme obrazce tvaru pravidelného šestiúhelníku složené z bílých a šedých shodných rovnostranných trojúhelníků. První obrazec má $3$ bílé a $3$ šedé trojúhelníky; každý další vznikne přidáním jednoho pásu trojúhelníků okolo předchozího (viz obrázek).','16.1 Vypočtěte, kolik trojúhelníků (bílých i šedých) obsahuje poslední přidaný pás $4.$ obrazce.','16.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý $6.$ obrazec.','16.3 Určete, kolikátý obrazec má v posledním přidaném pásu $225$ šedých trojúhelníků.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 333 113"><path d="M4 65L13 50L21 65L4 65Z" style="fill:#a6a6a6"/><path d="M21 65L30 50L38 65L21 65Z" style="fill:#a6a6a6"/><path d="M13 80L21 65L30 80L13 80Z" style="fill:#a6a6a6"/><path d="M4 65L12 50L30 50L38 65L30 80L12 80L4 65M89 65L97 50L114 50L123 65L114 80L97 80L89 65M72 65L89 35L123 35L140 65L123 94L89 94L72 65M208 65L216 50L234 50L242 65L234 80L216 80L208 65M191 65L208 35L242 35L259 65L242 94L208 94L191 65M174 65L199 21L251 21L276 65L251 109L199 109L174 65" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M89 65L97 50L106 65L89 65Z" style="fill:#a6a6a6"/><path d="M106 65L114 50L123 65L106 65Z" style="fill:#a6a6a6"/><path d="M97 80L106 65L114 80L97 80Z" style="fill:#a6a6a6"/><path d="M80 50L89 35L97 50L80 50Z" style="fill:#a6a6a6"/><path d="M97 50L106 35L114 50L97 50Z" style="fill:#a6a6a6"/><path d="M114 50L123 35L131 50L114 50Z" style="fill:#a6a6a6"/><path d="M123 65L131 50L140 65L123 65Z" style="fill:#a6a6a6"/><path d="M114 80L123 65L131 80L114 80Z" style="fill:#a6a6a6"/><path d="M106 94L114 80L123 94L106 94Z" style="fill:#a6a6a6"/><path d="M89 94L97 80L106 94L89 94Z" style="fill:#a6a6a6"/><path d="M80 80L89 65L97 80L80 80Z" style="fill:#a6a6a6"/><path d="M72 65L81 50L89 65L72 65Z" style="fill:#a6a6a6"/><path d="M208 65L217 50L225 65L208 65Z" style="fill:#a6a6a6"/><path d="M225 65L234 50L242 65L225 65Z" style="fill:#a6a6a6"/><path d="M217 80L225 65L234 80L217 80Z" style="fill:#a6a6a6"/><path d="M199 50L208 35L217 50L199 50Z" style="fill:#a6a6a6"/><path d="M217 50L225 35L234 50L217 50Z" style="fill:#a6a6a6"/><path d="M234 50L242 35L251 50L234 50Z" style="fill:#a6a6a6"/><path d="M242 65L251 50L259 65L242 65Z" style="fill:#a6a6a6"/><path d="M234 80L242 65L251 80L234 80Z" style="fill:#a6a6a6"/><path d="M225 94L234 80L242 94L225 94Z" style="fill:#a6a6a6"/><path d="M208 94L217 80L225 94L208 94Z" style="fill:#a6a6a6"/><path d="M199 80L208 65L217 80L199 80Z" style="fill:#a6a6a6"/><path d="M191 65L199 50L208 65L191 65Z" style="fill:#a6a6a6"/><path d="M191 35L199 21L208 35L191 35Z" style="fill:#a6a6a6"/><path d="M208 35L217 21L225 35L208 35Z" style="fill:#a6a6a6"/><path d="M225 35L234 21L242 35L225 35Z" style="fill:#a6a6a6"/><path d="M242 35L251 21L259 35L242 35Z" style="fill:#a6a6a6"/><path d="M251 50L259 35L268 50L251 50Z" style="fill:#a6a6a6"/><path d="M259 65L268 50L276 65L259 65Z" style="fill:#a6a6a6"/><path d="M251 80L259 65L268 80L251 80Z" style="fill:#a6a6a6"/><path d="M242 94L251 80L259 94L242 94Z" style="fill:#a6a6a6"/><path d="M234 109L242 94L251 109L234 109Z" style="fill:#a6a6a6"/><path d="M217 109L225 94L234 109L217 109Z" style="fill:#a6a6a6"/><path d="M199 109L208 94L217 109L199 109Z" style="fill:#a6a6a6"/><path d="M191 94L199 80L208 94L191 94Z" style="fill:#a6a6a6"/><path d="M182 80L191 65L199 80L182 80Z" style="fill:#a6a6a6"/><path d="M174 65L182 50L191 65L174 65Z" style="fill:#a6a6a6"/><path d="M182 50L191 35L199 50L182 50Z" style="fill:#a6a6a6"/><text x="22" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="107" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text><text x="226" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. obrazec</text><text x="323" y="71" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text></svg>',
  'obr.svg',
  'Posloupnost obrazců tvaru pravidelného šestiúhelníku z bílých a šedých rovnostranných trojúhelníků (1. až 3. obrazec).',
  '',
  new List<String>{'$n$-tý obrazec má celkem $6n^2$ trojúhelníků, z toho $3n^2$ šedých. Poslední pás má $6n^2-6(n-1)^2=12n-6$ trojúhelníků, z toho $6n-3$ šedých.','16.1: $12\\cdot4-6=42$ trojúhelníků.','16.2: $3\\cdot6^2=108$ šedých trojúhelníků.','16.3: $6n-3=225\\Rightarrow n=38$, tedy $38.$ obrazec.'},
  '16.1: $42$ trojúhelníků; 16.2: $108$ šedých trojúhelníků; 16.3: $38.$ obrazec',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
