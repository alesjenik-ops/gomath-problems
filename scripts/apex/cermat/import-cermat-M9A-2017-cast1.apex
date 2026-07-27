String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M9A 2017 – úloha 1',
  new List<String>{'Vypočtěte, kolikrát větší jsou 4 setiny než 8 tisícin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4 setiny $=0{,}04$, 8 tisícin $=0{,}008$.','$0{,}04:0{,}008=40:8=5$.'},
  '$5$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 2.1',
  new List<String>{'Vypočtěte: $\\sqrt{4\\cdot 0{,}25}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4\\cdot 0{,}25=1$, tedy $\\sqrt{1}=1$.'},
  '$1$',
  1, 1, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 2.2',
  new List<String>{'Vypočtěte: $1:0{,}2^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}2^2=0{,}04$; $1:0{,}04=100:4=25$.'},
  '$25$',
  1, 1, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$0{,}2:\\frac{27}{25}-\\frac{2}{3}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}2:\\frac{27}{25}=\\frac{1}{5}\\cdot\\frac{25}{27}=\\frac{5}{27}$.','$\\frac{5}{27}-\\frac{2}{3}=\\frac{5}{27}-\\frac{18}{27}=-\\frac{13}{27}$.'},
  '$-\\frac{13}{27}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\frac{\\frac{1}{5}-\\frac{3}{10}+\\frac{1}{4}\\cdot 2}{4}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'V čitateli: $\\frac{1}{4}\\cdot 2=\\frac{1}{2}$, tedy $\\frac{2}{10}-\\frac{3}{10}+\\frac{5}{10}=\\frac{4}{10}=\\frac{2}{5}$.','$\\frac{2}{5}:4=\\frac{2}{20}=\\frac{1}{10}$.'},
  '$\\frac{1}{10}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 4.1',
  new List<String>{'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.','$(a+a)\\cdot(1-a)-a\\cdot a=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$(a+a)=2a$, tedy $2a\\cdot(1-a)-a^2$.','$2a-2a^2-a^2=2a-3a^2$.'},
  '$2a-3a^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 4.2',
  new List<String>{'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.','$\\frac{n-1}{2}-\\frac{2n-3}{4}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Společný jmenovatel je 4: $\\frac{2(n-1)}{4}-\\frac{2n-3}{4}$.','$\\frac{2n-2-2n+3}{4}=\\frac{1}{4}$.'},
  '$\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 5.1',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).','$-\\frac{2}{3}\\cdot\\frac{x}{2}=\\frac{5}{12}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vlevo zkrátíme: $-\\frac{2x}{6}=-\\frac{x}{3}$, tedy $-\\frac{x}{3}=\\frac{5}{12}$.','$x=-\\frac{15}{12}=-\\frac{5}{4}$.'},
  '$x=-\\frac{5}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 5.2',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).','$\\frac{x-2}{2}-x=2-\\frac{2x}{3}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme šesti: $3(x-2)-6x=12-4x$.','$3x-6-6x=12-4x$, tedy $-3x-6=12-4x$.','$-3x+4x=12+6$, tedy $x=18$.'},
  '$x=18$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
