String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M9D 2021 – úloha 1',
  new List<String>{'Vypočtěte: $\\dfrac{0{,}25}{0{,}025} : 0{,}2 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{0{,}25}{0{,}025}=10$, potom $10 : 0{,}2 = 50$.'},
  '$50$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 2.1',
  new List<String>{'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.','Vypočtěte délku toku Labe v Německu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Délku v ČR označme $x$ km. Pak $x+(x+352)=1\\,094$, tedy $2x=742$ a $x=371$. V Německu je $371+352=723$ km.'},
  '$723$ km',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2021 – úloha 2.2',
  new List<String>{'Zahrada měla výměru $1\\,799$ m². Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250$ dm².','Vypočtěte v m² novou výměru zahrady.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$250$ dm² $=2{,}5$ m². Nová výměra je $1\\,799+2{,}5=1\\,801{,}5$ m².'},
  '$1\\,801{,}5$ m²',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2021 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\left(\\dfrac{5}{8}-\\dfrac{5}{12}\\right)\\cdot 4 - 2\\cdot\\left(\\dfrac{3}{4}-\\dfrac{2}{3}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{5}{8}-\\dfrac{5}{12}=\\dfrac{15-10}{24}=\\dfrac{5}{24}$, po vynásobení čtyřmi $\\dfrac{5}{6}$. Dále $2\\cdot\\left(\\dfrac{3}{4}-\\dfrac{2}{3}\\right)=2\\cdot\\dfrac{1}{12}=\\dfrac{1}{6}$. Výsledek $\\dfrac{5}{6}-\\dfrac{1}{6}=\\dfrac{4}{6}=\\dfrac{2}{3}$.'},
  '$\\dfrac{2}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{\\left(\\dfrac{27}{10}\\cdot\\dfrac{5}{9}-4\\right):3}{5}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{27}{10}\\cdot\\dfrac{5}{9}=\\dfrac{3}{2}$; $\\dfrac{3}{2}-4=-\\dfrac{5}{2}$; $\\left(-\\dfrac{5}{2}\\right):3=-\\dfrac{5}{6}$; a nakonec $\\left(-\\dfrac{5}{6}\\right):5=-\\dfrac{1}{6}$.'},
  '$-\\dfrac{1}{6}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 4.1',
  new List<String>{'Z daného výrazu vytkněte $(-3x)$:','$-6x^2-3x+9xy=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-6x^2-3x+9xy=(-3x)\\cdot(2x+1-3y)$.'},
  '$(-3x)\\cdot(2x+1-3y)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 4.2',
  new List<String>{'Doplňte do rámečků chybějící čísla tak, aby platila rovnost:','$(\\square\\cdot a-\\square\\cdot b)^2=\\square\\cdot a^2-56ab+(4\\cdot b)^2$','Uveďte všechna tři čísla doplněná do rámečků.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Z $(4\\cdot b)^2$ plyne druhé číslo $4$. Prostřední člen $-2\\cdot p\\cdot 4\\cdot ab=-56ab$ dává $p=7$; první člen je pak $p^2 a^2=49a^2$. Platí $(7a-4b)^2=49a^2-56ab+16b^2$, čísla jsou $7$, $4$, $49$.'},
  '$7$; $4$; $49$',
  1, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(5-y)(5+y)+3\\cdot(y^2-10)-(2y-3)\\cdot y=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(5-y)(5+y)=25-y^2$; $3\\cdot(y^2-10)=3y^2-30$; $(2y-3)\\cdot y=2y^2-3y$. Celkem $25-y^2+3y^2-30-2y^2+3y=3y-5$.'},
  '$3y-5$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2021 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$2{,}5\\cdot(2-3x)=\\dfrac{5x+10}{2}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$5-7{,}5x=\\dfrac{5x+10}{2}$; po vynásobení dvěma $10-15x=5x+10$; odtud $-20x=0$, tedy $x=0$.'},
  '$x=0$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
