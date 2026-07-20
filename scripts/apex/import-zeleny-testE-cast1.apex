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
  'Zelený E1 – pětinásobek a polovina',
  new List<String>{'Vypočtěte číslo, jehož pětinásobek je roven jeho jedné polovině.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hledané číslo $x$. Platí $5x=\\frac{1}{2}x$, tedy $5x-\\frac{1}{2}x=0$, odtud $\\frac{9}{2}x=0$, a proto $x=0$.'},
  '$0$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E2.1 – desetinná čísla',
  new List<String>{'Vypočtěte: $2{,}2:0{,}22-0{,}22:(0{,}1-0{,}078)+22=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2{,}2:0{,}22=10$; $0{,}1-0{,}078=0{,}022$; $0{,}22:0{,}022=10$. Celkem $10-10+22=22$.'},
  '$22$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E2.2 – odmocnina a dělení',
  new List<String>{'Vypočtěte: $\\sqrt{40:0{,}1}-0{,}5:0{,}1=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$40:0{,}1=400$; $\\sqrt{400}=20$; $0{,}5:0{,}1=5$. Celkem $20-5=15$.'},
  '$15$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E3.1 – zlomky se závorkou',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{1}{2}:\\frac{1}{3}-3\\frac{3}{4}\\cdot\\frac{2}{5}\\cdot\\left(\\frac{5}{6}-\\frac{4}{9}\\right)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}:\\frac{1}{3}=\\frac{3}{2}$; $\\frac{5}{6}-\\frac{4}{9}=\\frac{7}{18}$; $\\frac{15}{4}\\cdot\\frac{2}{5}\\cdot\\frac{7}{18}=\\frac{7}{12}$. Celkem $\\frac{3}{2}-\\frac{7}{12}=\\frac{11}{12}$.'},
  '$\\frac{11}{12}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{3}{2}:\\frac{4}{3}-\\frac{3}{8}}{2-\\frac{7}{16}-\\frac{3}{4}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{3}{2}:\\frac{4}{3}=\\frac{9}{8}$; $\\frac{9}{8}-\\frac{3}{8}=\\frac{3}{4}$. Jmenovatel: $2-\\frac{7}{16}-\\frac{3}{4}=\\frac{13}{16}$. Podíl: $\\frac{3}{4}:\\frac{13}{16}=\\frac{3}{4}\\cdot\\frac{16}{13}=\\frac{12}{13}$.'},
  '$\\frac{12}{13}$',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E4.1 – rozdíl druhých mocnin',
  new List<String>{'Zjednodušte výraz: $\\left(2+\\frac{a}{2}\\right)^2-\\left(\\frac{a}{2}-2\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Použijeme $X^2-Y^2=(X-Y)(X+Y)$ pro $X=2+\\frac{a}{2}$, $Y=\\frac{a}{2}-2$: $(X-Y)=4$, $(X+Y)=a$. Výsledek $4a$.'},
  '$4a$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E4.2 – úprava výrazu se zlomky',
  new List<String>{'Zjednodušte výraz: $\\frac{2\\cdot(x-2)^2}{3}-\\frac{(x+2)^2}{2}+5x-0{,}5=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Společný jmenovatel $6$: $\\frac{4x^2-16x+16}{6}-\\frac{3x^2+12x+12}{6}+\\frac{30x-3}{6}=\\frac{x^2+2x+1}{6}=\\frac{(x+1)^2}{6}$.'},
  '$\\frac{x^2+2x+1}{6}$ (tj. $\\frac{(x+1)^2}{6}$)',
  2, 5, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $3\\cdot\\left(x-\\frac{x}{2}-2\\right)-2x=1+\\frac{x}{2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $3x-\\frac{3x}{2}-6-2x=x-\\frac{3x}{2}-6$. Vynásobíme $2$: $2x-3x-12=2+x$, tj. $-x-12=2+x$, odtud $-2x=14$, $x=-7$.'},
  '$x=-7$',
  2, 3, '2',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený E5.2 – rovnice se zlomky',
  new List<String>{'Řešte rovnici: $\\frac{a-3}{2}+\\frac{a-2}{3}-\\frac{a-1}{4}=2a+4$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $12$: $6(a-3)+4(a-2)-3(a-1)=24a+48$, tj. $7a-23=24a+48$, odtud $-71=17a$, $a=-\\frac{71}{17}$.'},
  '$a=-\\frac{71}{17}$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice-se-zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
