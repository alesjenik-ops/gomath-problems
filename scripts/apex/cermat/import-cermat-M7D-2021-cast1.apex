String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD21C0T04';
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
  'CERMAT M7D 2021 – úloha 1.1',
  new List<String>{'Vypočtěte: $-0{,}5\\cdot 0{,}2 - 0{,}1\\cdot(3-8)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-0{,}5\\cdot 0{,}2=-0{,}1$; $-0{,}1\\cdot(3-8)=-0{,}1\\cdot(-5)=0{,}5$. Výsledek $-0{,}1+0{,}5=0{,}4$.'},
  '$0{,}4$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 1.2',
  new List<String>{'Vypočtěte: $\\dfrac{0{,}25}{0{,}025}:0{,}2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{0{,}25}{0{,}025}=10$; $10:0{,}2=50$.'},
  '$50$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 2',
  new List<String>{'Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094$ km. V Německu je tok Labe o $352$ km delší než v České republice.','2.1 Vypočtěte délku toku Labe v Německu.','Zahrada měla výměru $1\\,799$ m². Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250$ dm².','2.2 Vypočtěte v m² novou výměru zahrady.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 Délka v ČR $=c$, v Německu $=c+352$. Pak $c+(c+352)=1\\,094$, tj. $2c=742$, $c=371$ km. V Německu $371+352=723$ km.','2.2 $250$ dm² $=2{,}5$ m². Nová výměra $1\\,799+2{,}5=1\\,801{,}5$ m².'},
  '2.1: $723$ km; 2.2: $1\\,801{,}5$ m²',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2021 – úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. V obou částech úlohy uveďte postup řešení.','3.1 $\\left(\\frac{5}{8}-\\frac{5}{12}\\right)\\cdot 4 - 2\\cdot\\left(\\frac{3}{4}-\\frac{2}{3}\\right)=$','3.2 $\\dfrac{\\left(\\frac{27}{10}\\cdot\\frac{5}{9}-4\\right):3}{5}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 $\\frac{5}{8}-\\frac{5}{12}=\\frac{15-10}{24}=\\frac{5}{24}$, $\\frac{5}{24}\\cdot 4=\\frac{5}{6}$. Dále $\\frac{3}{4}-\\frac{2}{3}=\\frac{1}{12}$, $2\\cdot\\frac{1}{12}=\\frac{1}{6}$. Výsledek $\\frac{5}{6}-\\frac{1}{6}=\\frac{4}{6}=\\frac{2}{3}$.','3.2 $\\frac{27}{10}\\cdot\\frac{5}{9}=\\frac{3}{2}$; $\\frac{3}{2}-4=-\\frac{5}{2}$; $\\left(-\\frac{5}{2}\\right):3=-\\frac{5}{6}$; $\\frac{-5/6}{5}=-\\frac{1}{6}$.'},
  '3.1: $\\frac{2}{3}$; 3.2: $-\\frac{1}{6}$',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 4',
  new List<String>{'Na trati závodila $3$ autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.','Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod','4.1 druhé autíčko,','4.2 třetí autíčko.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'První autíčko: $1$ min $42$ s $=102$ s.','4.1 Druhé je o třetinu kratší: $\\frac{2}{3}\\cdot 102=68$ s $=1$ min $8$ s.','4.2 První je o třetinu kratší než třetí, tj. $102=\\frac{2}{3}\\cdot t_3$, odtud $t_3=153$ s $=2$ min $33$ s.'},
  '4.1 druhé: $1$ min $8$ s; 4.2 třetí: $2$ min $33$ s',
  3, 4, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2021 – úloha 5',
  new List<String>{'V dětské hře se smí provádět pouze následující nákupy: za $5$ mincí lze koupit $3$ autíčka; za $3$ mince lze koupit $4$ figurky.','5.1 Amélie si chce koupit několik autíček a dvakrát tolik figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.','5.2 Franta si chce koupit přesně o $10$ autíček více než figurek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Autíčka se kupují po $3$ (za $5$ mincí), figurky po $4$ (za $3$ mince).','5.1 Ať je autíček $3a$ a figurek $4b$; má platit $4b=2\\cdot 3a$, tj. $2b=3a$. Nejmenší řešení $a=2$, $b=3$ — $6$ autíček a $12$ figurek; mince $5\\cdot 2+3\\cdot 3=19$.','5.2 $3a-4b=10$. Nejmenší nezáporné řešení $a=6$, $b=2$ ($18$ autíček, $8$ figurek); mince $5\\cdot 6+3\\cdot 2=36$.'},
  '5.1: $19$ mincí; 5.2: $36$ mincí',
  4, 6, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
