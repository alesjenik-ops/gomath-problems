String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2020 M9I · úloha 11',
  new List<String>{'Šest obrazců A–F ve čtvercové síti se skládá ze čtverců a trojúhelníků. Všechny vrcholy obrazců jsou v mřížových bodech (viz obrázek).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Právě $4$ osy souměrnosti má pouze jeden obrazec.','11.2 Právě $1$ osu souměrnosti mají pouze $2$ obrazce, a to B a F.','11.3 Právě $2$ osy souměrnosti mají pouze $2$ obrazce.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 485 248"><path d="M4 243L481 243L481 244L4 244Z" style="fill:#000000"/><path d="M451 106L451 4M434 106L434 4M417 106L417 4M399 106L399 4M383 106L383 4M366 106L366 4M349 106L349 4M349 106L451 106M349 89L451 89M349 72L451 72M349 55L451 55M349 38L451 38M349 21L451 21M349 4L451 4M295 106L295 4M278 106L278 4M261 106L261 4M244 106L244 4M227 106L227 4M210 106L210 4M193 106L193 4M193 106L295 106M193 89L295 89M193 72L295 72M193 55L295 55M193 38L295 38M193 21L295 21M193 4L295 4M139 106L139 4M122 106L122 4M105 106L105 4M88 106L88 4M71 106L71 4M54 106L54 4M37 106L37 4M37 106L139 106M37 89L139 89M37 72L139 72M37 55L139 55M37 38L139 38M37 21L139 21M37 4L139 4M295 233L295 132M278 233L278 132M261 233L261 132M244 234L244 132M227 233L227 132M210 233L210 132M193 233L193 132M193 233L295 233M193 216L295 216M193 200L295 200M193 183L295 183M193 166L295 166M193 148L295 148M193 132L295 132M139 233L139 132M122 233L122 132M105 233L105 132M88 234L88 132M71 233L71 132M54 233L54 132M37 233L37 132M37 233L139 233M37 216L139 216M37 200L139 200M37 183L139 183M37 166L139 166M37 149L139 149M37 132L139 132M451 233L451 132M434 233L434 132M417 233L417 132M399 234L399 132M383 233L383 132M366 233L366 132M349 233L349 132M349 233L451 233M349 216L451 216M349 200L451 200M349 183L451 183M349 166L451 166M349 149L451 149M349 132L451 132" style="fill:none;stroke:#7f7f7f;stroke-width:1"/><path d="M400 72L383 55L400 38L400 72Z" style="fill:#7f7f7f"/><path d="M400 72L417 55L400 38L400 72Z" style="fill:#7f7f7f"/><path d="M383 72L366 55L383 38L383 72Z" style="fill:#7f7f7f"/><path d="M417 72L434 55L417 38L417 72Z" style="fill:#7f7f7f"/><path d="M417 38L400 21L383 38L417 38Z" style="fill:#7f7f7f"/><path d="M417 72L400 89L383 72L417 72Z" style="fill:#7f7f7f"/><path d="M244 72L227 55L244 38L244 72Z" style="fill:#7f7f7f"/><path d="M244 72L261 55L244 38L244 72Z" style="fill:#7f7f7f"/><path d="M227 72L210 55L227 38L227 72Z" style="fill:#7f7f7f"/><path d="M261 72L278 55L261 38L261 72Z" style="fill:#7f7f7f"/><path d="M261 38L244 21L227 38L261 38Z" style="fill:#7f7f7f"/><path d="M261 89L244 72L227 89L261 89Z" style="fill:#7f7f7f"/><path d="M54 55L71 55L71 72L54 72Z" style="fill:#7f7f7f"/><path d="M88 72L71 55L88 38L88 72Z" style="fill:#7f7f7f"/><path d="M88 72L105 55L88 38L88 72Z" style="fill:#7f7f7f"/><path d="M71 72L88 72L88 89L71 89Z" style="fill:#7f7f7f"/><path d="M88 21L105 21L105 38L88 38Z" style="fill:#7f7f7f"/><path d="M105 38L122 38L122 55L105 55Z" style="fill:#7f7f7f"/><path d="M244 200L227 183L244 166L244 200Z" style="fill:#7f7f7f"/><path d="M244 199L261 182L244 165L244 199Z" style="fill:#7f7f7f"/><path d="M227 199L210 182L227 165L227 199Z" style="fill:#7f7f7f"/><path d="M278 200L261 183L278 166L278 200Z" style="fill:#7f7f7f"/><path d="M261 166L244 149L227 166L261 166Z" style="fill:#7f7f7f"/><path d="M261 217L244 200L227 217L261 217Z" style="fill:#7f7f7f"/><path d="M54 200L71 200L71 217L54 217Z" style="fill:#7f7f7f"/><path d="M105 149L122 149L122 166L105 166Z" style="fill:#7f7f7f"/><path d="M71 166L105 166L105 200L71 200Z" style="fill:#7f7f7f"/><path d="M122 217L105 183L88 200L122 217Z" style="fill:#7f7f7f"/><path d="M54 149L71 183L88 166L54 149Z" style="fill:#7f7f7f"/><path d="M417 200L434 183L434 200L417 200Z" style="fill:#7f7f7f"/><path d="M400 200L383 183L400 166L400 200Z" style="fill:#7f7f7f"/><path d="M400 199L417 182L400 165L400 199Z" style="fill:#7f7f7f"/><path d="M400 149L417 149L417 166L400 149Z" style="fill:#7f7f7f"/><path d="M417 166L434 166L434 183L417 166Z" style="fill:#7f7f7f"/><path d="M400 217L417 200L417 217L400 217Z" style="fill:#7f7f7f"/><text x="27" y="145" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="339" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="182" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="28" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="182" y="145" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="338" y="146" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">F</text></svg>',
  'obr.svg',
  'Šest obrazců A–F ve čtvercové síti, každý složený ze šedých čtverců a trojúhelníků; posuzuje se počet os souměrnosti.',
  '',
  new List<String>{'U každého z obrazců A–F určíme počet os souměrnosti.','11.1: čtyři osy souměrnosti má jediný z obrazců (čtverec s vepsaným čtvercem), žádný jiný ne — tvrzení je pravdivé (A).','11.2: dvojice obrazců, které mají právě jednu osu souměrnosti, není tvořena pouze obrazci B a F — tvrzení je nepravdivé (N).','11.3: právě dvě osy souměrnosti mají právě dva z obrazců — tvrzení je pravdivé (A).'},
  '11.1: A; 11.2: N; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','soumernost','planimetrie','geometrie','uvazovani'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
