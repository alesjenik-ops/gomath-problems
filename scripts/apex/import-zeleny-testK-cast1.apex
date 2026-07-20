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
  'Zelený K1 – dělení pro čtyřnásobek',
  new List<String>{'Vypočtěte, jakým číslem musíte vydělit číslo $6$, abyste dostali jeho čtyřnásobek.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'Hledané číslo $x$ splňuje $6:x=4\\cdot 6=24$, tedy $x=\\frac{6}{24}=\\frac{1}{4}=0{,}25$.'},
  '$\\frac{1}{4}$ (tj. $0{,}25$)',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K2.1 – desetinná čísla',
  new List<String>{'Vypočtěte: $(0{,}11:1{,}1)+1{,}1\\cdot(1{,}1:0{,}11)$.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}11:1{,}1=0{,}1$, $1{,}1:0{,}11=10$, $1{,}1\\cdot 10=11$, celkem $0{,}1+11=11{,}1$.'},
  '$11{,}1$',
  1, 3, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K2.2 – druhá mocnina a odmocnina',
  new List<String>{'Vypočtěte: $\\left(\\left(\\frac{1}{2}\\right)^2-0{,}05\\right)\\cdot\\sqrt{25}$.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\frac{1}{4}-0{,}05\\right)\\cdot 5=(0{,}25-0{,}05)\\cdot 5=0{,}2\\cdot 5=1$.'},
  '$1$',
  1, 3, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K3.1 – zlomek v základním tvaru',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{3}{8}-\\frac{5}{6}+\\frac{3}{4}+\\frac{7}{2}:6$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{2}:6=\\frac{7}{12}$. Společný jmenovatel $24$: $\\frac{9}{24}-\\frac{20}{24}+\\frac{18}{24}+\\frac{14}{24}=\\frac{21}{24}=\\frac{7}{8}$.'},
  '$\\frac{7}{8}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{1\\frac{5}{7}-\\frac{2}{3}}{\\frac{1}{2}+1\\frac{1}{14}}$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{12}{7}-\\frac{2}{3}=\\frac{36-14}{21}=\\frac{22}{21}$. Jmenovatel: $\\frac{1}{2}+\\frac{15}{14}=\\frac{7+15}{14}=\\frac{22}{14}=\\frac{11}{7}$. Podíl: $\\frac{22}{21}\\cdot\\frac{7}{11}=\\frac{2}{3}$.'},
  '$\\frac{2}{3}$',
  1, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K4.1 – zjednodušení výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{a}{2}-\\frac{(a+1)^2}{3}-\\frac{(a-3)^2-(a-1)}{6}$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Rozšíříme na jmenovatele $6$: $\\frac{3a-2(a+1)^2-((a-3)^2-(a-1))}{6}=\\frac{3a-(2a^2+4a+2)-(a^2-7a+10)}{6}=\\frac{-3a^2+6a-12}{6}=-\\frac{a^2}{2}+a-2$.'},
  '$-\\frac{a^2}{2}+a-2$',
  2, 5, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K4.2 – zjednodušení lomeného výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{12x}{x+1}-\\frac{24}{1-x^2}+\\frac{12x}{1-x}$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Společný jmenovatel $1-x^2=(1-x)(1+x)$. Čitatel: $12x(1-x)-24+12x(1+x)=24x-24=24(x-1)$. Zlomek $\\frac{24(x-1)}{(1-x)(1+x)}=-\\frac{24}{x+1}$.'},
  '$-\\frac{24}{x+1}$',
  2, 5, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $(4-x):3+(6-5x):4=2-3x$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $12$: $4(4-x)+3(6-5x)=12(2-3x)$, tj. $16-4x+18-15x=24-36x$, $34-19x=24-36x$, $17x=-10$, $x=-\\frac{10}{17}$.'},
  '$x=-\\frac{10}{17}$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K5.2 – rovnice s druhou mocninou',
  new List<String>{'Řešte rovnici: $(a+2)\\cdot(a-2)+6a=a^2+a+6$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$a^2-4+6a=a^2+a+6$, $6a-4=a+6$, $5a=10$, $a=2$.'},
  '$a=2$',
  2, 3, '2',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
