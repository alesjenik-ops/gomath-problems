String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)';
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
  'CERMAT 2022 M9D · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Do prosince roku $2020$ prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku $2020$?','15.2 Počet novorozenců tvořil v dubnu $\\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?','15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?','Nabídka: A) $4\\ \\%$; B) $5\\ \\%$; C) $6\\ \\%$; D) $7\\ \\%$; E) $8\\ \\%$; F) jiný počet procent.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: každý dvacátý $=\\frac{1}{20}=5\\ \\%$ — B.','15.2: $\\frac{26}{25}=1{,}04$, tedy o $4\\ \\%$ více — A.','15.3: vychladlá kapalina má objem $\\frac{25}{27}$ teplé; teplá je o $\\frac{2/27}{25/27}=\\frac{2}{25}=8\\ \\%$ větší — E.'},
  '15.1: B; 15.2: A; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','zlomky','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 16',
  new List<String>{'Řada je vytvořena z celých čísel. První trojice čísel je $0$, $1$, $2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$. Na 1. až 18. místě řady je následujících 18 čísel:','$0,\\ 1,\\ 2,\\quad 1,\\ 2,\\ 3,\\quad 2,\\ 3,\\ 4,\\quad 3,\\ 4,\\ 5,\\quad 4,\\ 5,\\ 6,\\quad 5,\\ 6,\\ 7,\\quad \\ldots$','16.1 Určete, na kolikátém místě řady je poprvé číslo $12$.','16.2 Určete, na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo.','16.3 Určete, které číslo je na 152. místě řady.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$k$-tá trojice je $(k-1,\\ k,\\ k+1)$ a zabírá místa $3k-2$, $3k-1$, $3k$.','16.1: číslo $12$ se poprvé objeví jako největší člen trojice $k=11$ (trojice $10,11,12$), tedy na místě $3\\cdot11=33$.','16.2: $125=3\\cdot41+2$. Pro liché $k$ je v trojici jedno liché číslo, pro sudé $k$ dvě lichá. Mezi trojicemi $1$ až $41$ je $21$ lichých a $20$ sudých $k$: $21\\cdot1+20\\cdot2=61$. Místa $124$ a $125$ jsou čísla $41$ (liché) a $42$ (sudé), přidají $1$ — celkem $62$.','16.3: $152=3\\cdot50+2$, jde o 2. člen trojice $k=51$ $(50,51,52)$, tedy číslo $51$.'},
  '16.1: na 33. místě; 16.2: na 62 místech; 16.3: $51$',
  4, 6, '4',
  new List<String>{'zs2','r9','posloupnosti','aritmetika','uvazovani','vypocet','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
