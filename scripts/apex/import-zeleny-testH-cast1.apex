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
  'Zelený H1 – rozdíl součtů prvočísel',
  new List<String>{'Vypočtěte rozdíl mezi součtem všech prvočísel větších než $10$ a součtem všech prvočísel větších než $20$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl tvoří právě prvočísla, která jsou větší než $10$ a nejsou větší než $20$, tj. $11+13+17+19=60$.'},
  '$60$',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H2.1 – dělení desetinných čísel a zlomků',
  new List<String>{'Vypočtěte: $\\frac{0{,}2}{4}:0{,}05-\\frac{1}{5}:0{,}2$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{0{,}2}{4}=0{,}05$, tedy $0{,}05:0{,}05=1$; dále $\\frac{1}{5}:0{,}2=0{,}2:0{,}2=1$. Výsledek $1-1=0$.'},
  '$0$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H2.2 – mocnina, odmocnina a dělení',
  new List<String>{'Vypočtěte: $(-3)^2+0{,}16:0{,}01-\\sqrt{81}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9+16-9=16$.'},
  '$16$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H3.1 – složený zlomek se smíšeným číslem',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{14}{3}:1\\frac{1}{6}-0{,}4:\\frac{3}{5}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1\\frac{1}{6}=\\frac{7}{6}$; $\\frac{14}{3}:\\frac{7}{6}=\\frac{14}{3}\\cdot\\frac{6}{7}=4$; $0{,}4:\\frac{3}{5}=\\frac{2}{5}\\cdot\\frac{5}{3}=\\frac{2}{3}$; $4-\\frac{2}{3}=\\frac{10}{3}$.'},
  '$\\frac{10}{3}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H3.2 – zlomek s odmocninami',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\sqrt{\\frac{1}{4}}+\\sqrt{\\frac{1}{25}}}{\\sqrt{\\frac{1}{9}}+\\sqrt{\\frac{1}{16}}}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{1}{2}+\\frac{1}{5}=\\frac{7}{10}$, jmenovatel $\\frac{1}{3}+\\frac{1}{4}=\\frac{7}{12}$; podíl $\\frac{7}{10}:\\frac{7}{12}=\\frac{12}{10}=\\frac{6}{5}$.'},
  '$\\frac{6}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H4.1 – zjednodušení mnohočlenu',
  new List<String>{'Zjednodušte výraz: $2x\\cdot(2x-3)-3x\\cdot(x-6)-(x+4)^2$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4x^2-6x-3x^2+18x-(x^2+8x+16)=4x-16$.'},
  '$4x-16$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H4.2 – zjednodušení lomeného výrazu',
  new List<String>{'Zjednodušte výraz: $\\left(\\frac{a^2-a+4}{3}-a\\right)\\cdot\\frac{3a+6}{a-2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{a^2-a+4-3a}{3}=\\frac{(a-2)^2}{3}$; po vynásobení $\\frac{(a-2)^2}{3}\\cdot\\frac{3(a+2)}{a-2}=(a-2)(a+2)=a^2-4$.'},
  '$a^2-4$',
  2, 4, '4',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H5.1 – lineární rovnice se zlomky',
  new List<String>{'Řešte rovnici: $\\frac{4a}{3}-1+\\frac{12-a}{4}=(2a-5)\\cdot\\frac{1}{2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobením $12$: $16a-12+3(12-a)=6(2a-5)$, tj. $13a+24=12a-30$, odtud $a=-54$.'},
  '$a=-54$',
  2, 3, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený H5.2 – rovnice s druhými mocninami',
  new List<String>{'Řešte rovnici: $4x^2-4+(x-2)\\cdot3=\\frac{x}{2}\\cdot(8x+5)$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Roznásobením $4x^2+3x-10=4x^2+2{,}5x$, tj. $0{,}5x=10$, odtud $x=20$.'},
  '$x=20$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
