String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9 nanečisto 2025 – úloha 1',
  new List<String>{'Vypočtěte, o kolik cm² je plocha o obsahu $0{,}2$ m² větší než plocha o obsahu $20$ cm².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}2$ m² $=2000$ cm². Rozdíl: $2000-20=1980$ cm².'},
  'o $1980$ cm²',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 2.1',
  new List<String>{'Vypočtěte: $(1{,}5^2-0{,}3^2):6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}5^2-0{,}3^2=2{,}25-0{,}09=2{,}16$; $2{,}16:6=0{,}36$.'},
  '$0{,}36$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 2.2',
  new List<String>{'Vypočtěte: $\\sqrt{\\dfrac{2\\cdot 2^2}{3}}\\cdot \\sqrt{\\dfrac{3}{2}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{\\dfrac{2\\cdot 2^2}{3}\\cdot \\dfrac{3}{2}}=\\sqrt{\\dfrac{8}{3}\\cdot\\dfrac{3}{2}}=\\sqrt{4}=2$.'},
  '$2$',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $0{,}2-0{,}2\\cdot \\dfrac{5}{12}-\\left(-\\dfrac{7}{30}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}2-\\dfrac{1}{12}+\\dfrac{7}{30}=\\dfrac{12}{60}-\\dfrac{5}{60}+\\dfrac{14}{60}=\\dfrac{21}{60}=\\dfrac{7}{20}$.'},
  '$\\dfrac{7}{20}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{1}{4}+\\frac{1}{6}}{\\frac{4}{9}-\\frac{5}{6}\\cdot\\frac{2}{15}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{1}{4}+\\frac{1}{6}=\\frac{5}{12}$. Jmenovatel $\\frac{4}{9}-\\frac{5}{6}\\cdot\\frac{2}{15}=\\frac{4}{9}-\\frac{1}{9}=\\frac{1}{3}$. Podíl $\\frac{5}{12}:\\frac{1}{3}=\\frac{5}{12}\\cdot 3=\\frac{5}{4}$.'},
  '$\\dfrac{5}{4}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $x^2-(x-2y)\\cdot(x+2y)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$x^2-(x^2-4y^2)=4y^2$.'},
  '$4y^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5n-8)\\cdot(-3n)+(4n-3)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(5n-8)(-3n)=-15n^2+24n$; $(4n-3)^2=16n^2-24n+9$. Součet $=n^2+9$.'},
  '$n^2+9$',
  1, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 4.3',
  new List<String>{'Zjednodušte a výsledný výraz rozložte na součin podle vzorce: $7\\cdot 3+10\\cdot(a^2+10)-a\\cdot(a+66)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$21+10a^2+100-a^2-66a=9a^2-66a+121=(3a-11)^2$.'},
  '$(3a-11)^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 5.1',
  new List<String>{'Řešte rovnici: $\\dfrac{1}{5}y+\\dfrac{1}{2}=2\\cdot\\left(y+\\dfrac{1}{4}\\right)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{5}y+\\frac{1}{2}=2y+\\frac{1}{2}$, odtud $\\frac{1}{5}y=2y$, tj. $\\frac{1}{5}y-2y=0$, $-\\frac{9}{5}y=0$, $y=0$.'},
  '$y=0$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 5.2',
  new List<String>{'Řešte soustavu rovnic: $3x+\\dfrac{3}{4}y=1$; $3{,}5y+3x=6{,}5$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Odečtením první rovnice od druhé: $(3{,}5-0{,}75)y=6{,}5-1$, tj. $2{,}75y=5{,}5$, $y=2$. Dosazením: $3x+0{,}75\\cdot 2=1$, $3x=-0{,}5$, $x=-\\frac{1}{6}$.'},
  '$x=-\\dfrac{1}{6}$, $y=2$',
  2, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
