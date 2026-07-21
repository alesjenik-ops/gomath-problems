String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)';
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
  'CERMAT 2023 M9A · úloha 16',
  new List<String>{'Prvním obrazcem je bílý rovnostranný trojúhelník. Každý další obrazec vznikne tak, že každý bílý trojúhelník rozdělíme na $4$ shodné rovnostranné trojúhelníky a vnitřní z nich obarvíme na šedo (viz obrázek).','16.1 Určete, kolik bílých trojúhelníků obsahuje pátý obrazec.','16.2 Šestý obrazec obsahuje $121$ šedých trojúhelníků. Určete, kolik šedých trojúhelníků obsahuje sedmý obrazec.','16.3 Počet šedých trojúhelníků v posledním a předposledním obrazci se liší o $6\\,561$. Určete, kolik bílých trojúhelníků obsahuje poslední obrazec.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 816 148"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 144L4 144Z" style="fill:#000000"/><path d="M16 113L54 47L92 113L16 113Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M115 99L153 33L191 99L115 99Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M134 66L153 99L172 66L134 66Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M198 113L236 47L274 113L198 113Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M217 80L236 113L255 80L217 80Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M297 99L335 33L373 99L297 99Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M325 50L335 66L344 50L325 50Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M306 82L316 99L325 82L306 82Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M344 82L354 99L363 82L344 82Z" style="fill:#ffffff;stroke:#7f7f7f;stroke-width:2"/><path d="M316 66L335 99L354 66L316 66Z" style="fill:#bfbfbf;stroke:#7f7f7f;stroke-width:2"/><path d="M380 113L418 47L456 113L380 113Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M408 64L418 80L427 64L408 64Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M389 96L399 113L408 96L389 96Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M427 96L437 113L446 96L427 96Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M399 80L418 113L437 80L399 80Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><text x="236" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. Poté v každé takto vzniklé čtveřici bílých trojúhelníků obarvíme vnitřní trojúhelník na šedo.</text><text x="56" y="131" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="237" y="131" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text><text x="419" y="131" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. obrazec</text></svg>',
  'obr.svg',
  'Posloupnost obrazců Sierpińského trojúhelníku (1., 2. a 3. obrazec) z bílých a šedých rovnostranných trojúhelníků.',
  '',
  new List<String>{'Počet bílých trojúhelníků v $n$-tém obrazci je $3^{n-1}$; každým krokem přibude tolik šedých, kolik bylo bílých v předchozím obrazci ($3^{n-2}$).','16.1: $3^4=81$ bílých trojúhelníků.','16.2: přibude $3^5=243$ šedých, tedy $121+243=364$ šedých trojúhelníků.','16.3: rozdíl je $3^{n-2}=6\\,561=3^8\\Rightarrow n=10$; bílých je $3^9=19\\,683$.'},
  '16.1: $81$ bílých trojúhelníků; 16.2: $364$ šedých trojúhelníků; 16.3: $19\\,683$ bílých trojúhelníků',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
