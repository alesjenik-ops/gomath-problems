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
  'Zelený D1 – rozdíl trojnásobků',
  new List<String>{'Vypočtěte rozdíl trojnásobku čísla $1{,}5$ a trojnásobku čísla $-1{,}5$.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$3\\cdot 1{,}5 - 3\\cdot(-1{,}5) = 4{,}5 + 4{,}5 = 9$.'},
  '$9$',
  1, 2, '1',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D2.1 – desetinná čísla, pořadí operací',
  new List<String>{'Vypočtěte: $1{,}2:0{,}6\\cdot(0{,}5-0{,}4)+0{,}3\\cdot 0{,}2:0{,}1$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}2:0{,}6=2$, $2\\cdot 0{,}1=0{,}2$; $0{,}3\\cdot 0{,}2=0{,}06$, $0{,}06:0{,}1=0{,}6$; celkem $0{,}2+0{,}6=0{,}8$.'},
  '$0{,}8$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D2.2 – mocnina a dělení desetinných čísel',
  new List<String>{'Vypočtěte: $(0{,}25:0{,}5)^2:0{,}01$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}25:0{,}5=0{,}5$; $0{,}5^2=0{,}25$; $0{,}25:0{,}01=25$.'},
  '$25$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D3.1 – zlomky, smíšené číslo',
  new List<String>{'Vypočtěte a výsledek zapište jako smíšené číslo:','$\\left(\\frac{5}{12}+2\\frac{1}{3}\\right):\\left(\\frac{1}{5}+\\frac{1}{6}\\right)$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{12}+\\frac{28}{12}=\\frac{33}{12}=\\frac{11}{4}$; $\\frac{1}{5}+\\frac{1}{6}=\\frac{11}{30}$; $\\frac{11}{4}:\\frac{11}{30}=\\frac{30}{4}=\\frac{15}{2}=7\\frac{1}{2}$.'},
  '$7\\frac{1}{2}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D3.2 – složený zlomek, smíšené číslo',
  new List<String>{'Vypočtěte a výsledek zapište jako smíšené číslo:','$1-\\frac{\\frac{3}{8}-\\frac{4}{3}}{\\frac{5}{4}}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{8}-\\frac{4}{3}=\\frac{9-32}{24}=-\\frac{23}{24}$; $-\\frac{23}{24}:\\frac{5}{4}=-\\frac{23}{30}$; $1-\\left(-\\frac{23}{30}\\right)=1\\frac{23}{30}$.'},
  '$1\\frac{23}{30}$',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D4.1 – zjednodušení výrazu (druhá mocnina)',
  new List<String>{'Zjednodušte výraz: $\\left(\\frac{3x}{2}-1\\right)^2\\cdot\\frac{2}{3}+2x$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\frac{3x}{2}-1\\right)^2=\\frac{9x^2}{4}-3x+1$; po vynásobení $\\frac{2}{3}$: $\\frac{3x^2}{2}-2x+\\frac{2}{3}$; a $+2x$ dává $\\frac{3}{2}x^2+\\frac{2}{3}$.'},
  '$\\frac{3}{2}x^2+\\frac{2}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D4.2 – zjednodušení lomeného výrazu',
  new List<String>{'Zjednodušte výraz: $\\frac{(2x+1)\\cdot(2-x)+(x-2)\\cdot 5}{x-2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $(2x+1)(2-x)+5(x-2)=-2x^2+3x+2+5x-10=-2x^2+8x-8=-2(x-2)^2$; po vydělení $(x-2)$: $-2(x-2)=4-2x$.'},
  '$4-2x$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D5.1 – lineární rovnice se zlomky',
  new List<String>{'Řešte rovnici: $\\frac{x+3}{2}-\\frac{2x+5}{3}=8$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $6$: $3(x+3)-2(2x+5)=48$; $3x+9-4x-10=48$; $-x-1=48$; $x=-49$.'},
  '$x=-49$',
  2, 3, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D5.2 – lineární rovnice se zlomky',
  new List<String>{'Řešte rovnici: $0{,}5y+\\frac{3}{2}\\left(\\frac{y-2}{3}\\right)=\\frac{y-4}{2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5y+\\frac{y-2}{2}=\\frac{y-4}{2}$; vynásobíme $2$: $y+(y-2)=y-4$; $2y-2=y-4$; $y=-2$.'},
  '$y=-2$',
  2, 3, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
