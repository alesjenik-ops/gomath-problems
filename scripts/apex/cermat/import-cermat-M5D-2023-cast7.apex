String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M5D 2023 – úloha 14',
  new List<String>{'Obrazce tvaru trojúhelníku se sestavují skládáním šedých trojúhelníků do pater (viz obrázek). Šedé trojúhelníky mají ve vrcholech puntíky a na stranách stejně dlouhé úsečky. V prvním obrazci je pouze jeden šedý trojúhelník a každý další obrazec má o jedno patro šedých trojúhelníků více než předchozí obrazec. Pro počet pater 1, 2, 3 platí: šedé trojúhelníky 1, 3, 6; puntíky 3, 6, 10; úsečky 3, 9, 18.','14.1 Určete počet úseček v obrazci, který má 5 pater.','14.2 Počet úseček v posledním a v předposledním obrazci se liší o 96. Určete, o kolik se liší počet puntíků v posledním a v předposledním obrazci.','14.3 V jednom obrazci je 300 puntíků. Určete počet úseček v následujícím obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 200" font-family="sans-serif"><polygon points="90.0,40.0 77.0,62.5 103.0,62.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><circle cx="90.0" cy="40.0" r="3" fill="#000"/><circle cx="77.0" cy="62.5" r="3" fill="#000"/><circle cx="103.0" cy="62.5" r="3" fill="#000"/><text x="90" y="87" font-size="12" text-anchor="middle">1. obrazec</text><polygon points="230.0,40.0 217.0,62.5 243.0,62.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="217.0,62.5 204.0,85.0 230.0,85.0" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="243.0,62.5 230.0,85.0 256.0,85.0" fill="#c9c9c9" stroke="#000" stroke-width="1"/><circle cx="230.0" cy="40.0" r="3" fill="#000"/><circle cx="217.0" cy="62.5" r="3" fill="#000"/><circle cx="243.0" cy="62.5" r="3" fill="#000"/><circle cx="204.0" cy="85.0" r="3" fill="#000"/><circle cx="230.0" cy="85.0" r="3" fill="#000"/><circle cx="256.0" cy="85.0" r="3" fill="#000"/><text x="230" y="109" font-size="12" text-anchor="middle">2. obrazec</text><polygon points="410.0,40.0 397.0,62.5 423.0,62.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="397.0,62.5 384.0,85.0 410.0,85.0" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="423.0,62.5 410.0,85.0 436.0,85.0" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="384.0,85.0 371.0,107.5 397.0,107.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="410.0,85.0 397.0,107.5 423.0,107.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><polygon points="436.0,85.0 423.0,107.5 449.0,107.5" fill="#c9c9c9" stroke="#000" stroke-width="1"/><circle cx="410.0" cy="40.0" r="3" fill="#000"/><circle cx="397.0" cy="62.5" r="3" fill="#000"/><circle cx="423.0" cy="62.5" r="3" fill="#000"/><circle cx="384.0" cy="85.0" r="3" fill="#000"/><circle cx="410.0" cy="85.0" r="3" fill="#000"/><circle cx="436.0" cy="85.0" r="3" fill="#000"/><circle cx="371.0" cy="107.5" r="3" fill="#000"/><circle cx="397.0" cy="107.5" r="3" fill="#000"/><circle cx="423.0" cy="107.5" r="3" fill="#000"/><circle cx="449.0" cy="107.5" r="3" fill="#000"/><text x="410" y="132" font-size="12" text-anchor="middle">3. obrazec</text><text x="530" y="105" font-size="20">...</text></svg>',
  'obrazce-trojuhelniky.svg',
  '1., 2. a 3. obrazec: šedé trojúhelníky skládané do pater s puntíky ve vrcholech.',
  '1., 2. a 3. obrazec',
  new List<String>{'Obrazec s $n$ patry má úseček $U(n)=3\\cdot\\frac{n(n+1)}{2}$ a puntíků $P(n)=\\frac{(n+1)(n+2)}{2}$.','14.1 $U(5)=3\\cdot\\frac{5\\cdot 6}{2}=45$ úseček.','14.2 Rozdíl úseček sousedních obrazců je $U(n)-U(n-1)=3n=96$, tedy $n=32$. Rozdíl puntíků $P(n)-P(n-1)=n+1=33$.','14.3 Z $P(n)=\\frac{(n+1)(n+2)}{2}=300$ plyne $(n+1)(n+2)=600$, tj. $n=23$. V následujícím obrazci ($n=24$) je $U(24)=3\\cdot\\frac{24\\cdot 25}{2}=900$ úseček.'},
  '14.1: $45$ úseček; 14.2: o $33$ puntíků; 14.3: $900$ úseček',
  4, 7, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
