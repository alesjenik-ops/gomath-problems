String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený D15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Páté kolo závodu projel Nico Rosberg o $5\\,\\%$ rychleji než první kolo. V každém dalším kole pak přidával ještě další $2$ km/h. V osmém kole jsme tak jeho „williamsu“ naměřili průměrných $216$ km/h. O kolik $\\%$ byla průměrná rychlost Rosberga v osmém kole vyšší ve srovnání s prvním kolem závodu?','15.2 V letošním roce se nám podařilo proti loňsku snížit náklady o $20\\,\\%$. O kolik $\\%$ byly vloni náklady vyšší ve srovnání s letoškem?','15.3 V posledních třech letech se cena elektřiny každým rokem (meziročně) zvýšila o $5\\,\\%$. O kolik $\\%$ je stávající cena elektřiny vyšší než před čtyřmi lety?'},
  new List<String>{'A) o $8\\,\\%$','B) o $10\\,\\%$','C) o $15\\,\\%$','D) o $16\\,\\%$','E) o $25\\,\\%$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 V osmém kole $216=1{,}05v_1+6$ (tři přírůstky po $2$ km/h mezi $5.$ a $8.$ kolem), tedy $1{,}05v_1=210$, $v_1=200$ km/h. Nárůst $\\frac{216}{200}=1{,}08$, tj. o $8\\,\\%$ → A.','15.2 Letos jsou náklady $0{,}8$ loňských. Loni byly vyšší o $\\frac{0{,}2}{0{,}8}=0{,}25$, tj. o $25\\,\\%$ → E.','15.3 $1{,}05^3=1{,}157625$, tj. nárůst o $15{,}7625\\,\\%$; to není v nabídce → F.'},
  '15.1: A (o $8\\,\\%$); 15.2: E (o $25\\,\\%$); 15.3: F (o $15{,}7625\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
