String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M9B 2019 – úloha 1',
  new List<String>{'Vypočtěte, kolik procent z $20$ tun tvoří $500$ kilogramů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$20$ tun $=20\\,000$ kg. Podíl $\\frac{500}{20\\,000}=0{,}025=2{,}5\\,\\%$.'},
  '$2{,}5\\,\\%$',
  1, 2, '2',
  new List<String>{'zs2','r9','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 2.1',
  new List<String>{'Vypočtěte: $\\sqrt{10^2\\cdot 0{,}0025}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{100\\cdot 0{,}0025}=\\sqrt{0{,}25}=0{,}5$.'},
  '$0{,}5$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 2.2',
  new List<String>{'Vypočtěte: $5:0{,}2-(-0{,}3+0{,}5)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5:0{,}2-(-0{,}3+0{,}5)=25-0{,}2=24{,}8$.'},
  '$24{,}8$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{1-\\frac{1}{3}}{-6^2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $1-\\frac{1}{3}=\\frac{2}{3}$, jmenovatel $-6^2=-36$. Podíl $\\frac{2}{3}:(-36)=-\\frac{2}{108}=-\\frac{1}{54}$.'},
  '$-\\frac{1}{54}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $12\\cdot\\left(\\frac{2}{3}-\\frac{1}{2}\\right)-\\frac{5}{2}+\\frac{2}{3}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{3}-\\frac{1}{2}=\\frac{1}{6}$, takže $12\\cdot\\frac{1}{6}=2$. Dále $2-\\frac{5}{2}+\\frac{2}{3}=\\frac{12-15+4}{6}=\\frac{1}{6}$.'},
  '$\\frac{1}{6}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2a+3b)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2a+3b)^2=(2a)^2+2\\cdot 2a\\cdot 3b+(3b)^2=4a^2+12ab+9b^2$.'},
  '$4a^2+12ab+9b^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $3e\\cdot(2-f)-2f\\cdot(e-3f)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3e\\cdot(2-f)-2f\\cdot(e-3f)=6e-3ef-2ef+6f^2=6e-5ef+6f^2$.'},
  '$6e-5ef+6f^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(1+3n)\\cdot(1+3n)+(1+3n)\\cdot(1-3n)-2=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(1+3n)^2=1+6n+9n^2$; $(1+3n)(1-3n)=1-9n^2$. Součet $1+6n+9n^2+1-9n^2-2=6n$.'},
  '$6n$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 5.1',
  new List<String>{'Řešte rovnici: $2\\cdot(3-0{,}75x)+x=7-\\dfrac{x}{2}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$6-1{,}5x+x=7-0{,}5x$, tj. $6-0{,}5x=7-0{,}5x$. Po odečtení $-0{,}5x$ zbyde $6=7$, což neplatí. Rovnice nemá řešení.'},
  'Rovnice nemá řešení.',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 5.2',
  new List<String>{'Řešte rovnici: $\\dfrac{5}{6}\\cdot(y-2)-\\dfrac{2}{3}\\cdot y=\\dfrac{y}{2}-\\dfrac{5}{4}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $\\frac{5}{6}y-\\frac{5}{3}-\\frac{2}{3}y=\\frac{1}{6}y-\\frac{5}{3}$. Rovnice $\\frac{1}{6}y-\\frac{5}{3}=\\frac{1}{2}y-\\frac{5}{4}$; vynásobením $12$: $2y-20=6y-15$, odtud $-5=4y$, tedy $y=-1{,}25$.'},
  '$y=-1{,}25$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
