String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 16',
  new List<String>{'Obrazce tvaru trojúhelníku se sestavují skládáním šedých trojúhelníků do pater. Šedé trojúhelníky mají ve vrcholech puntíky a na stranách stejně dlouhé úsečky. V prvním obrazci je jeden šedý trojúhelník a každý další obrazec má o jedno patro šedých trojúhelníků více než předchozí obrazec (viz obrázek).','Pro obrazce s 1, 2 a 3 patry platí: šedých trojúhelníků je $1$, $3$, $6$; puntíků $3$, $6$, $10$; úseček $3$, $9$, $18$.','16.1 Určete počet úseček v obrazci, který má 5 pater.','16.2 Počet úseček v posledním a v předposledním obrazci se liší o 96. Určete, o kolik se liší počet puntíků v posledním a předposledním obrazci.','16.3 V jednom obrazci je 300 puntíků. Určete počet úseček v následujícím obrazci.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 130" font-family="sans-serif"><g fill="#c9c9c9" stroke="#000" stroke-width="1"><polygon points="70,25 57,47 83,47"/></g><g fill="#000"><circle cx="70" cy="25" r="3"/><circle cx="57" cy="47" r="3"/><circle cx="83" cy="47" r="3"/></g><g fill="#c9c9c9" stroke="#000" stroke-width="1"><polygon points="175,25 162,47 188,47"/><polygon points="162,47 149,69 175,69"/><polygon points="188,47 175,69 201,69"/></g><g fill="#000"><circle cx="175" cy="25" r="3"/><circle cx="162" cy="47" r="3"/><circle cx="188" cy="47" r="3"/><circle cx="149" cy="69" r="3"/><circle cx="175" cy="69" r="3"/><circle cx="201" cy="69" r="3"/></g><g fill="#c9c9c9" stroke="#000" stroke-width="1"><polygon points="305,25 292,47 318,47"/><polygon points="292,47 279,69 305,69"/><polygon points="318,47 305,69 331,69"/><polygon points="279,69 266,91 292,91"/><polygon points="305,69 292,91 318,91"/><polygon points="331,69 318,91 344,91"/></g><g fill="#000"><circle cx="305" cy="25" r="3"/><circle cx="292" cy="47" r="3"/><circle cx="318" cy="47" r="3"/><circle cx="279" cy="69" r="3"/><circle cx="305" cy="69" r="3"/><circle cx="331" cy="69" r="3"/><circle cx="266" cy="91" r="3"/><circle cx="292" cy="91" r="3"/><circle cx="318" cy="91" r="3"/><circle cx="344" cy="91" r="3"/></g><text x="440" y="90" font-size="22">…</text></svg>',
  'obrazce-trojuhelniky.svg',
  '1., 2. a 3. obrazec: šedé trojúhelníky poskládané do pater, s puntíky ve vrcholech.',
  '1., 2. a 3. obrazec',
  new List<String>{'V obrazci s $n$ patry je šedých trojúhelníků $\\frac{n(n+1)}{2}$, úseček $3\\cdot\\frac{n(n+1)}{2}$ a puntíků $\\frac{(n+1)(n+2)}{2}$.','16.1 Pro $n=5$ je úseček $3\\cdot\\frac{5\\cdot 6}{2}=3\\cdot 15=45$.','16.2 Rozdíl počtu úseček dvou sousedních obrazců je $3\\cdot\\frac{n(n+1)}{2}-3\\cdot\\frac{(n-1)n}{2}=3n=96$, odkud $n=32$. Rozdíl počtu puntíků je $\\frac{(n+1)(n+2)}{2}-\\frac{n(n+1)}{2}=n+1=33$.','16.3 Z rovnice $\\frac{(n+1)(n+2)}{2}=300$ plyne $(n+1)(n+2)=600=24\\cdot 25$, tedy $n=23$. Následující obrazec má $24$ pater a úseček $3\\cdot\\frac{24\\cdot 25}{2}=3\\cdot 300=900$.'},
  '16.1: $45$ úseček; 16.2: o $33$ puntíků; 16.3: $900$ úseček',
  4, 6, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
