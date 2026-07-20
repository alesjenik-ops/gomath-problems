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
  'Zelený L1 – pětinásobek odmocniny',
  new List<String>{'Vypočtěte pětinásobek druhé odmocniny jedné čtvrtiny.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$5\\cdot\\sqrt{\\frac{1}{4}}=5\\cdot\\frac{1}{2}=2{,}5$.'},
  '$2{,}5$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L2.1 – dělení mocnin desetinných čísel',
  new List<String>{'Vypočtěte: $4:0{,}2^2-0{,}99:0{,}1^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4:0{,}04-0{,}99:0{,}01=100-99=1$.'},
  '$1$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L2.2 – výraz s odmocninou',
  new List<String>{'Vypočtěte: $\\frac{0{,}4^2}{0{,}01}-\\frac{\\sqrt{4}}{0{,}1}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{0{,}16}{0{,}01}-\\frac{2}{0{,}1}=16-20=-4$.'},
  '$-4$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L3.1 – zlomky a desetinné číslo',
  new List<String>{'Vypočtěte a výsledek zapište smíšeným číslem: $\\frac{63}{5}:0{,}6-\\frac{96}{8}:\\frac{132}{24}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{63}{5}:\\frac{3}{5}=21$; $\\frac{96}{8}:\\frac{132}{24}=12\\cdot\\frac{24}{132}=\\frac{24}{11}$; $21-\\frac{24}{11}=\\frac{207}{11}=18\\frac{9}{11}$.'},
  '$18\\frac{9}{11}$',
  1, 3, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište smíšeným číslem: $\\frac{\\frac{15}{4}-\\frac{71}{12}}{\\frac{21}{6}-\\frac{13}{3}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{15}{4}-\\frac{71}{12}=\\frac{45-71}{12}=-\\frac{13}{6}$. Jmenovatel: $\\frac{21}{6}-\\frac{13}{3}=\\frac{21-26}{6}=-\\frac{5}{6}$. Podíl: $\\frac{-\\frac{13}{6}}{-\\frac{5}{6}}=\\frac{13}{5}=2\\frac{3}{5}$.'},
  '$2\\frac{3}{5}$',
  1, 3, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L4.1 – zjednodušení výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{(a-2b)^2-(2a-b)^2}{3}+(a+b)\\cdot(a-b)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(a-2b)^2-(2a-b)^2=(a^2-4ab+4b^2)-(4a^2-4ab+b^2)=3b^2-3a^2$. Po dělení třemi: $b^2-a^2$. Přičteme $(a+b)(a-b)=a^2-b^2$: $b^2-a^2+a^2-b^2=0$.'},
  '$0$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L4.2 – krácení výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{(4-2x)\\cdot(3x-9)}{(x-2)\\cdot(3-x)}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$4-2x=-2(x-2)$, $3x-9=3(x-3)$, $(x-2)(3-x)=-(x-2)(x-3)$. Zlomek: $\\frac{-2(x-2)\\cdot 3(x-3)}{-(x-2)(x-3)}=6$.'},
  '$6$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $\\frac{12-3\\cdot(6x-1)}{2}+\\frac{5x}{4}-2=\\frac{2\\cdot(x-2)}{8}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme čtyřmi: $2(15-18x)+5x-8=x-2$, tj. $30-36x+5x-8=x-2$, $22-31x=x-2$, $32x=24$, $x=\\frac{3}{4}$.'},
  '$x=\\frac{3}{4}$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L5.2 – rovnice s druhou mocninou',
  new List<String>{'Řešte rovnici: $\\frac{a^2-2a+1}{9}=\\frac{1}{6}\\cdot\\left(12+\\frac{2}{3}a^2\\right)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Pravá strana: $2+\\frac{a^2}{9}$. Vynásobíme devíti: $a^2-2a+1=18+a^2$, tedy $-2a=17$, $a=-8{,}5$.'},
  '$a=-8{,}5$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
