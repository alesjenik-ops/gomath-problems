String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
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
  'CERMAT M7C 2026 – úloha 16',
  new List<String>{'První obrazec je čtverec. Druhý obrazec má tvar obdélníku a vznikl z prvního obrazce přidáním dvou menších čtverců. Každý další obrazec má opět tvar obdélníku a vznikne tak, že u kratší strany předchozího obrazce přidáme tolik menších čtverců, kolikátý obrazec vytváříme (viz obrázek). Např. 3. obrazec vznikl z 2. obrazce přidáním tří menších čtverců. Delší strana 4. obrazce měří 125 cm.','16.1 Vypočtěte, kolik cm měří strana 1. obrazce.','16.2 Vypočtěte, o kolik cm² se liší obsah 4. obrazce a obsah 5. obrazce.','16.3 Vypočtěte, kolik cm měří obvod 6. obrazce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif" font-size="14"> <text x="85" y="45" text-anchor="middle">1. obrazec</text> <rect x="40" y="60" width="90" height="90" fill="none" stroke="#000"/> <text x="237" y="45" text-anchor="middle">2. obrazec</text> <rect x="170" y="60" width="135" height="90" fill="none" stroke="#000"/> <line x1="260" y1="60" x2="260" y2="150" stroke="#000"/> <line x1="260" y1="105" x2="305" y2="105" stroke="#000"/> <text x="432" y="45" text-anchor="middle">3. obrazec</text> <rect x="350" y="60" width="165" height="90" fill="none" stroke="#000"/> <line x1="440" y1="60" x2="440" y2="150" stroke="#000"/> <line x1="440" y1="105" x2="485" y2="105" stroke="#000"/> <line x1="485" y1="60" x2="485" y2="150" stroke="#000"/> <line x1="485" y1="90" x2="515" y2="90" stroke="#000"/> <line x1="485" y1="120" x2="515" y2="120" stroke="#000"/> <text x="555" y="110" font-size="22">…</text> </svg>',
  'obrazce-ctverce.svg',
  'Posloupnost obrazců: čtverec, obdélník s dvěma menšími čtverci a obdélník s dalšími menšími čtverci.',
  'Schematický nákres 1. až 3. obrazce',
  new List<String>{'Kratší strana všech obrazců je stále strana $a$ prvního čtverce. Při tvorbě $n$-tého obrazce se delší strana prodlouží o $\\frac{a}{n}$ (šířka $n$ menších čtverců se stranou $\\frac{a}{n}$).','16.1 Delší strana 4. obrazce je $a+\\frac{a}{2}+\\frac{a}{3}+\\frac{a}{4}=\\frac{25}{12}a=125$, tedy $a=60$ cm.','16.2 Při tvorbě 5. obrazce se delší strana prodlouží o $\\frac{60}{5}=12$ cm; přibude pruh $60\\times 12$, obsahy se tedy liší o $60\\cdot 12=720$ cm².','16.3 Delší strana 6. obrazce je $125+\\frac{60}{5}+\\frac{60}{6}=125+12+10=147$ cm; obvod je $2\\cdot(147+60)=414$ cm.'},
  '16.1: $60$ cm; 16.2: o $720$ cm²; 16.3: $414$ cm',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
