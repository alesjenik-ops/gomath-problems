String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
Integer YEAR = 2026;

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
  'CERMAT M5C 2026 – úloha 14',
  new List<String>{'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního obrazce přidáním dvou menších čtverců. Každý další obrazec má opět tvar obdélníku a vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců. Obvod 2. obrazce měří 300 cm.','14.1 Vypočtěte, kolik cm měří strana 1. obrazce.','14.2 Vypočtěte, o kolik cm se liší obvod 4. obrazce a obvod 5. obrazce.','14.3 Vypočtěte, kolik cm měří obvod 6. obrazce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 130" font-family="sans-serif"> <text x="50" y="22" font-size="12" text-anchor="middle">1. obrazec</text> <rect x="20" y="32" width="60" height="60" fill="none" stroke="#000"/> <text x="175" y="22" font-size="12" text-anchor="middle">2. obrazec</text> <rect x="130" y="32" width="60" height="60" fill="none" stroke="#000"/> <rect x="190" y="32" width="30" height="60" fill="none" stroke="#000"/> <line x1="190" y1="62" x2="220" y2="62" stroke="#000"/> <text x="325" y="22" font-size="12" text-anchor="middle">3. obrazec</text> <rect x="270" y="32" width="60" height="60" fill="none" stroke="#000"/> <rect x="330" y="32" width="30" height="60" fill="none" stroke="#000"/> <line x1="330" y1="62" x2="360" y2="62" stroke="#000"/> <rect x="360" y="32" width="20" height="60" fill="none" stroke="#000"/> <line x1="360" y1="52" x2="380" y2="52" stroke="#000"/> <line x1="360" y1="72" x2="380" y2="72" stroke="#000"/> <text x="405" y="68" font-size="20">…</text> </svg>',
  'obrazce.svg',
  'První obrazec čtverec, druhý a třetí obrazec obdélníky vzniklé přidáním menších čtverců.',
  '1., 2. a 3. obrazec',
  new List<String>{'Kratší strana každého obrazce má stále délku strany 1. obrazce $a$. K vytvoření $k$-tého obrazce přidáme $k$ menších čtverců o straně $a/k$, čímž se delší strana prodlouží o $a/k$.','14.1 Obvod 2. obrazce: čtverec o straně $a$ se prodlouží o $a/2$, obvod je $2\\cdot(a+\\frac{3a}{2}) = 5a = 300$, tedy $a = 60$ cm.','14.2 Delší strana: 4. obrazec $60+30+20+15 = 125$ cm, 5. obrazec $125+12 = 137$ cm. Obvody jsou $2\\cdot(60+125) = 370$ cm a $2\\cdot(60+137) = 394$ cm; liší se o $24$ cm.','14.3 6. obrazec: delší strana $137+10 = 147$ cm, obvod $2\\cdot(60+147) = 414$ cm.'},
  '14.1: $60$ cm; 14.2: o $24$ cm; 14.3: $414$ cm',
  4, 7, '4',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
