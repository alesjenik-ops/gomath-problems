String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M9A 2018 – úloha 1',
  new List<String>{'Vypočtěte, kolikrát je trojnásobek čísla $9$ menší než číslo $324$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Trojnásobek čísla $9$ je $27$. Podíl $324:27=12$. Trojnásobek je tedy $12$krát menší než $324$.'},
  '$12$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 2.1',
  new List<String>{'Vypočtěte: $\\sqrt{1^2-0{,}6^2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1^2-0{,}6^2=1-0{,}36=0{,}64$, tedy $\\sqrt{0{,}64}=0{,}8$.'},
  '$0{,}8$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 2.2',
  new List<String>{'Vypočtěte: $100-\\frac{1}{0{,}01\\cdot 0{,}1}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}01\\cdot 0{,}1=0{,}001$; $\\frac{1}{0{,}001}=1000$; $100-1000=-900$.'},
  '$-900$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{4}{1+2}-1}{1+2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{4}{1+2}-1=\\frac{4}{3}-1=\\frac{1}{3}$. Jmenovatel je $1+2=3$. Celkem $\\frac{1}{3}:3=\\frac{1}{9}$.'},
  '$\\frac{1}{9}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(2-\\frac{7}{8}\\right)\\cdot\\frac{8}{9}:\\left(\\frac{5}{8}+\\frac{5}{6}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2-\\frac{7}{8}=\\frac{9}{8}$; $\\frac{9}{8}\\cdot\\frac{8}{9}=1$; $\\frac{5}{8}+\\frac{5}{6}=\\frac{15+20}{24}=\\frac{35}{24}$; $1:\\frac{35}{24}=\\frac{24}{35}$.'},
  '$\\frac{24}{35}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(3+a)^2-(3\\cdot a)^2-3^2=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(3+a)^2=9+6a+a^2$; $(3a)^2=9a^2$; $3^2=9$. Po dosazení $9+6a+a^2-9a^2-9=6a-8a^2$.'},
  '$6a-8a^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $2n\\cdot(3-n)+2\\cdot(3n\\cdot n)-n\\cdot(3\\cdot n)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2n(3-n)=6n-2n^2$; $2\\cdot(3n\\cdot n)=6n^2$; $n\\cdot(3n)=3n^2$. Součet $6n-2n^2+6n^2-3n^2=n^2+6n$.'},
  '$n^2+6n$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 5.1',
  new List<String>{'Řešte rovnici: $2\\cdot\\frac{5x}{6}-\\frac{1}{3}=x-\\frac{1}{2}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\cdot\\frac{5x}{6}=\\frac{5x}{3}$. Rovnici $\\frac{5x}{3}-\\frac{1}{3}=x-\\frac{1}{2}$ vynásobíme $6$: $10x-2=6x-3$, tj. $4x=-1$, tedy $x=-\\frac{1}{4}$.'},
  '$x=-\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2018 – úloha 5.2',
  new List<String>{'Řešte rovnici: $y-\\frac{1-3y}{2}=\\frac{7}{4}+\\frac{5y}{3}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme $12$: $12y-6(1-3y)=21+20y$, tj. $12y-6+18y=21+20y$, $30y-6=21+20y$, $10y=27$, tedy $y=2{,}7$.'},
  '$y=2{,}7$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
