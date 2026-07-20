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
  'Zelený F1 – kolikrát větší',
  new List<String>{'Vypočtěte, kolikrát větší je číslo $235$ než polovina jeho osminy.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'Osmina čísla je $\\frac{235}{8}$, její polovina $\\frac{235}{16}$. Podíl $235 : \\frac{235}{16} = 16$.'},
  '16krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F2.1 – závorka a zlomek',
  new List<String>{'Vypočtěte: $\\left(64 : \\frac{1}{2} - 16 : 0{,}16\\right)\\cdot \\frac{1}{14} =$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$64 : \\frac{1}{2} = 128$, $16 : 0{,}16 = 100$. Pak $(128-100)\\cdot \\frac{1}{14} = 28\\cdot \\frac{1}{14} = 2$.'},
  '$2$',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F2.2 – pořadí operací',
  new List<String>{'Vypočtěte: $(-7)\\cdot 0{,}3 - 0{,}7\\cdot (6-3) : (-1) =$'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'$(-7)\\cdot 0{,}3 = -2{,}1$; $0{,}7\\cdot (6-3):(-1) = 2{,}1:(-1) = -2{,}1$. Celkem $-2{,}1-(-2{,}1) = 0$.'},
  '$0$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F3.1 – zlomek se jmenovatelem 72',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem se jmenovatelem $72$:','$-\\frac{7}{12} + 2{,}5 - \\frac{5}{8} : 0{,}6 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{8} : 0{,}6 = \\frac{5}{8}\\cdot \\frac{5}{3} = \\frac{25}{24}$. Pak $-\\frac{7}{12} + \\frac{5}{2} - \\frac{25}{24} = \\frac{-14+60-25}{24} = \\frac{21}{24} = \\frac{63}{72}$.'},
  '$\\frac{63}{72}$',
  1, 3, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F3.2 – složený zlomek se jmenovatelem 72',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem se jmenovatelem $72$:','$\\frac{1\\frac{1}{5} - \\frac{7}{9}}{1\\frac{1}{10} - \\frac{7}{15}} =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{6}{5} - \\frac{7}{9} = \\frac{19}{45}$, jmenovatel $\\frac{11}{10} - \\frac{7}{15} = \\frac{19}{30}$. Podíl $\\frac{19}{45} : \\frac{19}{30} = \\frac{30}{45} = \\frac{2}{3} = \\frac{48}{72}$.'},
  '$\\frac{48}{72}$',
  1, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F4.1 – zjednodušení výrazu (zlomky)',
  new List<String>{'Zjednodušte výraz: $\\left(\\frac{3-x}{3x} - \\frac{5-3x}{5x}\\right)\\cdot 7{,}5x =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Roznásobíme $7{,}5x$: $\\frac{3-x}{3x}\\cdot 7{,}5x = 2{,}5(3-x)$ a $\\frac{5-3x}{5x}\\cdot 7{,}5x = 1{,}5(5-3x)$. Rozdíl $(7{,}5-2{,}5x)-(7{,}5-4{,}5x) = 2x$.'},
  '$2x$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F4.2 – zjednodušení výrazu (mocnina)',
  new List<String>{'Zjednodušte výraz: $3 + (1+2a)^2 - (1+a)\\cdot 4a =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(1+2a)^2 = 1+4a+4a^2$, $(1+a)\\cdot 4a = 4a+4a^2$. Dosazením $3+1+4a+4a^2-4a-4a^2 = 4$.'},
  '$4$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $\\frac{4b+4}{5} - \\frac{5b}{2} + 1 = -(2b-3) : 10$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $10$: $2(4b+4)-25b+10 = -(2b-3)$, tj. $-17b+18 = -2b+3$. Odtud $-15b = -15$, $b = 1$.'},
  '$b=1$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený F5.2 – rovnice s odmocninou',
  new List<String>{'Řešte rovnici: $\\frac{2x-2}{\\sqrt{3}} + \\sqrt{3}\\cdot (x+2) = \\frac{1}{\\sqrt{3}}\\cdot (5-3x)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $\\sqrt{3}$: $(2x-2)+3(x+2) = 5-3x$, tj. $5x+4 = 5-3x$. Odtud $8x = 1$, $x = \\frac{1}{8}$.'},
  '$x=\\frac{1}{8}$',
  2, 5, '4',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
