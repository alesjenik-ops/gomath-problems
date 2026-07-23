String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD25C0T03';
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
  'CERMAT M5C 2025 – úloha 14',
  new List<String>{'Vytváříme obrazce tvaru šestiúhelníku složené ze stejně velkých bílých a šedých rovnostranných trojúhelníků. První obrazec se skládá ze 3 bílých a 3 šedých trojúhelníků a každý další obrazec vznikne přidáním jednoho pásu trojúhelníků okolo předchozího obrazce (viz obrázek).','14.1 Vypočtěte, kolik trojúhelníků (bílých i šedých dohromady) obsahuje poslední přidaný pás 4. obrazce.','14.2 Vypočtěte, kolik šedých trojúhelníků obsahuje celý 6. obrazec.','14.3 Určete, kolikátý obrazec má v posledním přidaném pásu 225 šedých trojúhelníků.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250" font-family="sans-serif"><path fill="#fff" stroke="#777" stroke-width="0.7" d="M70,130L93,117L93,143ZM70,130L70,156L47,143ZM70,130L47,117L70,104ZM210,104L233,117L233,91ZM210,130L233,117L233,143ZM233,143L255,130L255,156ZM233,117L255,104L255,130ZM233,143L210,156L233,169ZM210,130L210,156L187,143ZM187,143L187,169L165,156ZM210,156L210,182L187,169ZM187,143L187,117L165,130ZM210,130L187,117L210,104ZM210,104L187,91L210,78ZM187,117L165,104L187,91ZM420,104L443,117L443,91ZM443,91L465,104L465,78ZM420,78L443,91L443,65ZM420,130L443,117L443,143ZM443,143L465,130L465,156ZM465,156L488,143L488,169ZM443,117L465,104L465,130ZM465,130L488,117L488,143ZM465,104L488,91L488,117ZM443,143L420,156L443,169ZM443,169L420,182L443,195ZM465,156L443,169L465,182ZM420,130L420,156L397,143ZM397,143L397,169L375,156ZM375,156L375,182L352,169ZM420,156L420,182L397,169ZM397,169L397,195L375,182ZM420,182L420,208L397,195ZM397,143L397,117L375,130ZM375,130L375,104L352,117ZM375,156L375,130L352,143ZM420,130L397,117L420,104ZM420,104L397,91L420,78ZM420,78L397,65L420,52ZM397,117L375,104L397,91ZM397,91L375,78L397,65ZM375,104L352,91L375,78Z"/><path fill="#9a9a9a" stroke="#777" stroke-width="0.7" d="M70,130L70,104L93,117ZM70,130L93,143L70,156ZM70,130L47,143L47,117ZM210,130L210,104L233,117ZM233,117L233,91L255,104ZM210,104L210,78L233,91ZM233,117L233,143L255,130ZM210,130L233,143L210,156ZM210,156L233,169L210,182ZM233,143L255,156L233,169ZM210,156L187,143L187,169ZM210,130L187,143L187,117ZM187,117L165,130L165,104ZM187,143L165,156L165,130ZM187,117L210,104L187,91ZM420,130L420,104L443,117ZM443,117L443,91L465,104ZM465,104L465,78L488,91ZM420,104L420,78L443,91ZM443,91L443,65L465,78ZM420,78L420,52L443,65ZM443,117L443,143L465,130ZM465,130L465,156L488,143ZM465,104L465,130L488,117ZM420,130L443,143L420,156ZM420,156L443,169L420,182ZM420,182L443,195L420,208ZM443,143L465,156L443,169ZM443,169L465,182L443,195ZM465,156L488,169L465,182ZM420,156L397,143L397,169ZM397,169L375,156L375,182ZM420,182L397,169L397,195ZM420,130L397,143L397,117ZM397,117L375,130L375,104ZM375,104L352,117L352,91ZM397,143L375,156L375,130ZM375,130L352,143L352,117ZM375,156L352,169L352,143ZM397,117L420,104L397,91ZM397,91L420,78L397,65ZM375,104L397,91L375,78Z"/><text x="70" y="26" font-size="13" text-anchor="middle">1. obrazec</text><text x="210" y="26" font-size="13" text-anchor="middle">2. obrazec</text><text x="420" y="26" font-size="13" text-anchor="middle">3. obrazec</text><text x="545" y="138" font-size="22">…</text></svg>',
  'obrazce-trojuhelniky.svg',
  'Tři obrazce tvaru šestiúhelníku z bílých a šedých rovnostranných trojúhelníků (1., 2. a 3. obrazec), dále pokračuje.',
  '1., 2. a 3. obrazec (schematický nákres)',
  new List<String>{'$n$-tý obrazec obsahuje celkem $6n^2$ trojúhelníků, z toho $3n^2$ šedých. Poslední přidaný pás obsahuje $6n^2-6(n-1)^2=6(2n-1)$ trojúhelníků, z toho $3(2n-1)$ šedých.','14.1 Pás 4. obrazce: $6(2\\cdot 4-1)=6\\cdot 7=42$ trojúhelníků.','14.2 Šedých v celém 6. obrazci: $3\\cdot 6^2=108$.','14.3 Ze $3(2n-1)=225$ plyne $2n-1=75$, $n=38$. Jde o 38. obrazec.'},
  '14.1: $42$ trojúhelníků; 14.2: $108$ šedých trojúhelníků; 14.3: ve 38. obrazci',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
