String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
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
  'CERMAT M5B 2025 - uloha 5',
  new List<String>{'Na papir lepime stejne samolepici ctverecky, ktere maji stranu delky $1$ cm a obsah $1$ cm2. Vytvarime tak ruzne obdelniky, z nichz kazdy ma obvod $18$ cm. Jeden z takovych obdelniku je na obrazku. Sousedni ctverecky v obdelniku maji vzdy jednu stranu spolecnou.','5.1 Vypoctete, kolik cm meri nejdelsi mozna strana takoveho obdelniku.','5.2 Urcete, kolik navzajem ruznych obsahu maji vsechny takove obdelniky.','5.3 Vypoctete v cm2, jaky je nejvetsi mozny obsah takoveho obdelniku.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif"><text x="55" y="30" font-size="13" text-anchor="middle">Ctverecek</text><rect x="42" y="55" width="26" height="26" fill="#d9d9d9" stroke="#000"/><text x="340" y="30" font-size="13" text-anchor="middle">Obdelnik vytvoreny ze ctverecku</text><rect x="250" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="250" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="276" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="276" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="302" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="302" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="328" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="328" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="354" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="354" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="380" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="380" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="406" y="45" width="26" height="26" fill="#d9d9d9" stroke="#000"/><rect x="406" y="71" width="26" height="26" fill="#d9d9d9" stroke="#000"/></svg>',
  'obdelnik-ctverecky.svg',
  'Jeden samolepici ctverecek a priklad obdelniku slozeneho ze ctverecku o obvodu 18 cm.',
  'Ctverecek a obdelnik ze ctverecku',
  new List<String>{'Obvod $18$ cm znamena, ze soucet delek dvou sousednich stran je $9$ cm. Strany jsou cela cisla: $1+8$, $2+7$, $3+6$, $4+5$.','5.1 Nejdelsi mozna strana je $8$ cm (obdelnik $1\\times 8$).','5.2 Obsahy jsou $1\\cdot 8=8$, $2\\cdot 7=14$, $3\\cdot 6=18$ a $4\\cdot 5=20$; tedy $4$ ruzne obsahy.','5.3 Nejvetsi obsah ma obdelnik $4\\times 5$, tj. $20$ cm2.'},
  '5.1: $8$ cm; 5.2: $4$ ruzne obsahy; 5.3: $20$ cm2',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 6',
  new List<String>{'Karel a Mirka zapsali na tabuli dve ruzna dvojciferna cisla. Karel ve svem cisle zapsal na miste desitek cislici o 3 vetsi nez Mirka, ale na miste jednotek cislici o 2 mensi nez Mirka.','6.1 Vypoctete, o kolik se lisi Karlovo a Mircino cislo.','6.2 Zapsana cisla se lisi o tretinu Karlova cisla. Urcete, jake cislo zapsala na tabuli Mirka.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Mircino cislo ma na miste desitek $d$ a na miste jednotek $j$, tedy $10d+j$. Karlovo cislo je $10(d+3)+(j-2)=10d+j+28$.','6.1 Cisla se lisi o $28$.','6.2 Rozdil $28$ je tretinou Karlova cisla, proto Karlovo cislo je $3\\cdot 28=84$ a Mircino je $84-28=56$.'},
  '6.1: o $28$; 6.2: $56$',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
