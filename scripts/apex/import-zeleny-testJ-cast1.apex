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
  'Zelený J1 – přírůstek obsahu obdélníku',
  new List<String>{'Naznačte, o kolik cm² ($x$) zvětšíte obsah obdélníku, jestliže jeho strany o délkách $a$ cm a $b$ cm zvětšíte o $2$ cm.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Původní obsah je $a\\cdot b$. Nový obsah je $(a+2)(b+2)=ab+2a+2b+4$. Přírůstek $x=(a+2)(b+2)-ab=2a+2b+4$.'},
  'o $2a+2b+4$ cm²',
  2, 3, '2',
  new List<String>{'zs2','r9','vyrazy','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J2.1 – desetinné dělení',
  new List<String>{'Vypočtěte: $5{,}2:4+0{,}13:0{,}1-0{,}52:0{,}2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5{,}2:4=1{,}3$; $0{,}13:0{,}1=1{,}3$; $0{,}52:0{,}2=2{,}6$. Tedy $1{,}3+1{,}3-2{,}6=0$.'},
  '$0$',
  1, 2, '1',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J2.2 – odmocnina a mocnina',
  new List<String>{'Vypočtěte: $(\\sqrt{36}:0{,}2-5^2)\\cdot\\frac{1}{5}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{36}=6$; $6:0{,}2=30$; $5^2=25$. Tedy $(30-25)\\cdot\\frac{1}{5}=5\\cdot\\frac{1}{5}=1$.'},
  '$1$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J3.1 – zlomky se smíšeným číslem',
  new List<String>{'Vypočtěte a výsledek zapište jako smíšené číslo: $\\frac{4}{5}:1\\frac{1}{5}-\\frac{2}{3}:\\frac{5}{18}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{4}{5}:\\frac{6}{5}=\\frac{4}{6}=\\frac{2}{3}$; $\\frac{2}{3}:\\frac{5}{18}=\\frac{2}{3}\\cdot\\frac{18}{5}=\\frac{12}{5}$. Tedy $\\frac{2}{3}-\\frac{12}{5}=\\frac{10-36}{15}=-\\frac{26}{15}=-1\\frac{11}{15}$.'},
  '$-1\\frac{11}{15}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište jako smíšené číslo: $\\frac{\\frac{2}{3}-\\frac{4}{5}}{0{,}6+\\frac{6}{12}}-\\frac{10}{11}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{2}{3}-\\frac{4}{5}=-\\frac{2}{15}$. Jmenovatel: $0{,}6+\\frac{6}{12}=\\frac{11}{10}$. Podíl: $-\\frac{2}{15}:\\frac{11}{10}=-\\frac{2}{15}\\cdot\\frac{10}{11}=-\\frac{4}{33}$. Nakonec $-\\frac{4}{33}-\\frac{10}{11}=-\\frac{4}{33}-\\frac{30}{33}=-\\frac{34}{33}=-1\\frac{1}{33}$.'},
  '$-1\\frac{1}{33}$',
  1, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J4.1 – roznásobení výrazu',
  new List<String>{'Zjednodušte výraz: $2y\\cdot(3-4y)+(1-2y)^2\\cdot 2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2y(3-4y)=6y-8y^2$; $(1-2y)^2=1-4y+4y^2$, po vynásobení dvěma $2-8y+8y^2$. Součet: $6y-8y^2+2-8y+8y^2=2-2y$.'},
  '$2-2y$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J4.2 – krácení lomeného výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{2a^2-18}{27-18a+3a^2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $2a^2-18=2(a-3)(a+3)$. Jmenovatel $3a^2-18a+27=3(a-3)^2$. Zlomek $\\frac{2(a-3)(a+3)}{3(a-3)^2}=\\frac{2}{3}\\cdot\\frac{a+3}{a-3}$ (pro $a\\neq 3$).'},
  '$\\frac{2}{3}\\cdot\\frac{a+3}{a-3}$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J5.1 – lineární rovnice se zlomky',
  new List<String>{'Řešte rovnici: $\\frac{x-3}{4}-\\frac{x+1}{2}=\\frac{x}{2}-4$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $4$: $(x-3)-2(x+1)=2x-16$, tj. $-x-5=2x-16$, odtud $11=3x$, $x=\\frac{11}{3}$.'},
  '$x=\\frac{11}{3}$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J5.2 – rovnice s druhými mocninami',
  new List<String>{'Řešte rovnici: $(d+2)\\cdot(d-3)+1=(d+1)^2$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$d^2-d-6+1=d^2+2d+1$, tj. $-d-5=2d+1$, odtud $-6=3d$, $d=-2$.'},
  '$d=-2$',
  2, 3, '2',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
