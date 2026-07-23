String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD25C0T03';
Integer YEAR = 2025;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M9C 2025 – úloha 16',
  new List<String>{'Vytváříme obrazce tvaru pravidelného šestiúhelníku složené z bílých a šedých shodných rovnostranných trojúhelníků. První obrazec se skládá ze $3$ bílých a $3$ šedých trojúhelníků a každý další obrazec vznikne přidáním jednoho pásu trojúhelníků okolo předchozího obrazce (viz obrázek).','16.1 Vypočtěte, kolik trojúhelníků (bílých i šedých dohromady) obsahuje poslední přidaný pás 4. obrazce.','16.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý 6. obrazec.','16.3 Určete, kolikátý obrazec má v posledním přidaném pásu $225$ šedých trojúhelníků.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 230" font-family="sans-serif"><polygon points="90.0,120.0 90.0,80.0 124.6,100.0" fill="#b9b9b9" stroke="#000"/><polygon points="90.0,120.0 124.6,100.0 124.6,140.0" fill="#ffffff" stroke="#000"/><polygon points="90.0,120.0 124.6,140.0 90.0,160.0" fill="#b9b9b9" stroke="#000"/><polygon points="90.0,120.0 90.0,160.0 55.4,140.0" fill="#ffffff" stroke="#000"/><polygon points="90.0,120.0 55.4,140.0 55.4,100.0" fill="#b9b9b9" stroke="#000"/><polygon points="90.0,120.0 55.4,100.0 90.0,80.0" fill="#ffffff" stroke="#000"/><text x="90" y="72" font-size="12" text-anchor="middle">1. obrazec</text><polygon points="240.0,120.0 240.0,58.0 293.7,89.0" fill="#b9b9b9" stroke="#000"/><polygon points="240.0,120.0 293.7,89.0 293.7,151.0" fill="#ffffff" stroke="#000"/><polygon points="240.0,120.0 293.7,151.0 240.0,182.0" fill="#b9b9b9" stroke="#000"/><polygon points="240.0,120.0 240.0,182.0 186.3,151.0" fill="#ffffff" stroke="#000"/><polygon points="240.0,120.0 186.3,151.0 186.3,89.0" fill="#b9b9b9" stroke="#000"/><polygon points="240.0,120.0 186.3,89.0 240.0,58.0" fill="#ffffff" stroke="#000"/><polygon points="240.0,89.0 266.8,104.5 266.8,135.5 240.0,151.0 213.2,135.5 213.2,104.5" fill="none" stroke="#000"/><text x="240" y="50" font-size="12" text-anchor="middle">2. obrazec</text><polygon points="410.0,120.0 410.0,36.0 482.7,78.0" fill="#b9b9b9" stroke="#000"/><polygon points="410.0,120.0 482.7,78.0 482.7,162.0" fill="#ffffff" stroke="#000"/><polygon points="410.0,120.0 482.7,162.0 410.0,204.0" fill="#b9b9b9" stroke="#000"/><polygon points="410.0,120.0 410.0,204.0 337.3,162.0" fill="#ffffff" stroke="#000"/><polygon points="410.0,120.0 337.3,162.0 337.3,78.0" fill="#b9b9b9" stroke="#000"/><polygon points="410.0,120.0 337.3,78.0 410.0,36.0" fill="#ffffff" stroke="#000"/><polygon points="410.0,92.0 434.2,106.0 434.2,134.0 410.0,148.0 385.8,134.0 385.8,106.0" fill="none" stroke="#000"/><polygon points="410.0,64.0 458.5,92.0 458.5,148.0 410.0,176.0 361.5,148.0 361.5,92.0" fill="none" stroke="#000"/><text x="410" y="28" font-size="12" text-anchor="middle">3. obrazec</text><text x="520" y="128" font-size="22">…</text></svg>',
  'sestiuhelniky.svg',
  'První, druhý a třetí obrazec tvaru pravidelného šestiúhelníku složeného ze šedých a bílých trojúhelníků, každý další s jedním pásem navíc.',
  'Schematický nákres 1., 2. a 3. obrazce',
  new List<String>{'$n$-tý obrazec obsahuje celkem $6n^2$ trojúhelníků (pro $n=1$ je to $6$), z toho polovina, tedy $3n^2$, je šedých. Poslední přidaný pás $n$-tého obrazce má $6n^2-6(n-1)^2=6(2n-1)$ trojúhelníků, z toho $3(2n-1)$ šedých.','16.1 Pás 4. obrazce: $6\\cdot(2\\cdot 4-1)=6\\cdot 7=42$ trojúhelníků.','16.2 Celý 6. obrazec: šedých $3\\cdot 6^2=108$.','16.3 $3(2n-1)=225\\Rightarrow 2n-1=75\\Rightarrow n=38$; jde o 38. obrazec.'},
  '16.1: $42$ trojúhelníků; 16.2: $108$ šedých trojúhelníků; 16.3: ve 38. obrazci',
  4, 7, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
