String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 1',
  new List<String>{'Vypočtěte:','$0{,}01\\cdot 1000+10\\cdot\\frac{1}{0{,}1}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}01\\cdot 1000=10$ a $\\frac{1}{0{,}1}=10$.','Celkem $10+10\\cdot 10=10+100=110$.'},
  '$110$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 2',
  new List<String>{'Vypočtěte, kolikrát je třeba k číslu $820$ přičíst číslo $10$, abychom získali číslo $8\\,200$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Přičíst je třeba celkem $8\\,200-820=7\\,380$.','Počet přičtení: $7\\,380:10=738$.'},
  '$738$krát',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.','$0{,}2\\cdot\\left(\\frac{1}{9}+\\frac{7}{12}\\right)-\\frac{1}{4}=$'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce: $\\frac{1}{9}+\\frac{7}{12}=\\frac{4}{36}+\\frac{21}{36}=\\frac{25}{36}$.','Součin: $0{,}2\\cdot\\frac{25}{36}=\\frac{1}{5}\\cdot\\frac{25}{36}=\\frac{5}{36}$.','Rozdíl: $\\frac{5}{36}-\\frac{1}{4}=\\frac{5}{36}-\\frac{9}{36}=-\\frac{4}{36}=-\\frac{1}{9}$.'},
  '$-\\frac{1}{9}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.','$\\frac{\\frac{1}{2}-\\left(\\frac{2}{3}-\\frac{5}{6}\\right)}{\\frac{1}{2}}=$'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce: $\\frac{2}{3}-\\frac{5}{6}=\\frac{4}{6}-\\frac{5}{6}=-\\frac{1}{6}$.','Čitatel: $\\frac{1}{2}-\\left(-\\frac{1}{6}\\right)=\\frac{3}{6}+\\frac{1}{6}=\\frac{4}{6}=\\frac{2}{3}$.','Podíl: $\\frac{2}{3}:\\frac{1}{2}=\\frac{2}{3}\\cdot 2=\\frac{4}{3}$.'},
  '$\\frac{4}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 4.1',
  new List<String>{'Zapište převrácené číslo k číslu $2\\frac{1}{3}$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Smíšené číslo převedeme na zlomek: $2\\frac{1}{3}=\\frac{7}{3}$.','Převrácené číslo vznikne záměnou čitatele a jmenovatele: $\\frac{3}{7}$.'},
  '$\\frac{3}{7}$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 4.2',
  new List<String>{'Vypočtěte číslo, které musíme odečíst od čísla $2\\frac{1}{3}$, abychom dostali číslo opačné k číslu $2\\frac{1}{3}$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\frac{1}{3}=\\frac{7}{3}$, číslo opačné je $-\\frac{7}{3}$.','Hledáme $x$ tak, aby $\\frac{7}{3}-x=-\\frac{7}{3}$, tedy $x=\\frac{7}{3}+\\frac{7}{3}=\\frac{14}{3}$.'},
  '$\\frac{14}{3}$',
  1, 3, '3',
  new List<String>{'zs2','r7','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
