String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
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
  'CERMAT M9B 2018 – úloha 1',
  new List<String>{'Vypočtěte tři sedminy ze součinu čísel $21$ a $14$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Součin: $21\\cdot 14=294$. Tři sedminy: $\\frac{3}{7}\\cdot 294=126$.'},
  '$126$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 2.1',
  new List<String>{'Vypočtěte: $100+1:\\sqrt{6\\,400+60^2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$60^2=3\\,600$, $6\\,400+3\\,600=10\\,000$, $\\sqrt{10\\,000}=100$. Tedy $100+1:100=100+0{,}01=100{,}01$.'},
  '$100{,}01$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 2.2',
  new List<String>{'Vypočtěte: $0{,}005\\cdot 10^2-1{,}2:0{,}02=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}005\\cdot 100=0{,}5$, $1{,}2:0{,}02=60$. Tedy $0{,}5-60=-59{,}5$.'},
  '$-59{,}5$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\left(0{,}5+\\frac{2}{5}\\right):\\left(2-\\frac{7}{8}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5+\\frac{2}{5}=\\frac{1}{2}+\\frac{2}{5}=\\frac{9}{10}$; $2-\\frac{7}{8}=\\frac{9}{8}$. Podíl: $\\frac{9}{10}:\\frac{9}{8}=\\frac{9}{10}\\cdot\\frac{8}{9}=\\frac{4}{5}$.'},
  '$\\frac{4}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{3\\cdot\\frac{2}{9}-\\frac{3}{5}:\\frac{6}{15}}{2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$3\\cdot\\frac{2}{9}=\\frac{2}{3}$; $\\frac{3}{5}:\\frac{6}{15}=\\frac{3}{5}\\cdot\\frac{15}{6}=\\frac{3}{2}$. Čitatel: $\\frac{2}{3}-\\frac{3}{2}=-\\frac{5}{6}$. Celý zlomek: $-\\frac{5}{6}:2=-\\frac{5}{12}$.'},
  '$-\\frac{5}{12}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(2+3a)^2-(2-3a)^2=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Podle vzorce $x^2-y^2=(x+y)(x-y)$: $\\big((2+3a)+(2-3a)\\big)\\cdot\\big((2+3a)-(2-3a)\\big)=4\\cdot 6a=24a$.'},
  '$24a$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$\\frac{1}{2}\\cdot n\\cdot(2-3n)+3\\cdot(n+2n)-n\\cdot(3-n)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}n(2-3n)=n-\\frac{3}{2}n^2$; $3\\cdot(n+2n)=9n$; $-n(3-n)=-3n+n^2$. Součet: $n-\\frac{3}{2}n^2+9n-3n+n^2=-\\frac{1}{2}n^2+7n$.'},
  '$-\\frac{1}{2}n^2+7n$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$x\\cdot(x+2)+0{,}6=x\\cdot x+\\frac{1}{5}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$x^2+2x+0{,}6=x^2+0{,}2$, odtud $2x=0{,}2-0{,}6=-0{,}4$, tedy $x=-0{,}2=-\\frac{1}{5}$.'},
  '$x=-\\frac{1}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2018 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\frac{2y-3}{4}-2\\cdot\\frac{y}{5}=\\frac{2-y}{2}-1$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme číslem $20$: $5(2y-3)-8y=10(2-y)-20$, tj. $10y-15-8y=20-10y-20$, $2y-15=-10y$, $12y=15$, $y=\\frac{5}{4}$.'},
  '$y=\\frac{5}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
