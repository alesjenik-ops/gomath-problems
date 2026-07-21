String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 16',
  new List<String>{'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního přidáním dvou menších čtverců. Každý další obrazec vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Delší strana $4.$ obrazce měří $125\\ \\mathrm{cm}$.','16.1 Vypočtěte, kolik cm měří strana $1.$ obrazce.','16.2 Vypočtěte, o kolik $\\mathrm{cm}^2$ se liší obsah $4.$ obrazce a obsah $5.$ obrazce.','16.3 Vypočtěte, kolik cm měří obvod $6.$ obrazce.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 694 146"><path d="M4 4L5 4L5 20L4 20Z" style="fill:#000000"/><path d="M467 4L468 4L468 20L467 20Z" style="fill:#000000"/><path d="M4 20L5 20L5 39L4 39Z" style="fill:#000000"/><path d="M467 20L468 20L468 39L467 39Z" style="fill:#000000"/><path d="M4 39L5 39L5 142L4 142Z" style="fill:#000000"/><path d="M467 39L468 39L468 142L467 142Z" style="fill:#000000"/><path d="M9 42L392 42L392 141L9 141Z" style="fill:#ffffff"/><path d="M16 69L81 69L81 134L16 134ZM102 69L167 69L167 134L102 134ZM167 69L199 69L199 102L167 102ZM167 102L199 102L199 134L167 134ZM221 69L285 69L285 134L221 134ZM285 69L317 69L317 102L285 102ZM285 102L317 102L317 134L285 134ZM317 69L339 69L339 91L317 91ZM317 91L339 91L339 112L317 112Z" style="fill:none;stroke:#000000;stroke-width:2"/><text x="210" y="17" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek).</text><text x="171" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců.</text><text x="374" y="108" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="50" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="152" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text><text x="281" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. obrazec</text></svg>',
  'obr.svg',
  'Posloupnost obrazců: čtverec a rostoucí obdélníky vznikající přidáváním menších čtverců (1. až 3. obrazec).',
  '',
  new List<String>{'Kratší strana je stále $S$ (strana $1.$ obrazce); do $n$-tého obrazce přidáme $n$ čtverců o straně $\\frac{S}{n}$, takže delší strana vzroste o $\\frac{S}{n}$.','16.1: delší strana $4.$ obrazce $=S\\left(1+\\frac{1}{2}+\\frac{1}{3}+\\frac{1}{4}\\right)=\\frac{25}{12}S=125$, tedy $S=60\\ \\mathrm{cm}$.','16.2: delší strana $5.$ obrazce $=125+\\frac{60}{5}=137\\ \\mathrm{cm}$; rozdíl obsahů $60\\cdot(137-125)=720\\ \\mathrm{cm}^2$.','16.3: delší strana $6.$ obrazce $=137+\\frac{60}{6}=147\\ \\mathrm{cm}$; obvod $2\\cdot(147+60)=414\\ \\mathrm{cm}$.'},
  '16.1: $60\\ \\mathrm{cm}$; 16.2: o $720\\ \\mathrm{cm}^2$; 16.3: $414\\ \\mathrm{cm}$',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
