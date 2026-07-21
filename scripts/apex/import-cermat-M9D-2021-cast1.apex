String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, druhý náhradní termín (M9D)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2021 M9D · úloha 1',
  new List<String>{'Vypočtěte: $\\dfrac{0{,}25}{0{,}025}:0{,}2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{0{,}25}{0{,}025}=10$, potom $10:0{,}2=50$.'},
  '$50$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','cisla','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 2',
  new List<String>{'2.1 Řeka Labe protéká pouze dvěma státy a délka celého jejího toku je $1\\,094\\ \\mathrm{km}$. V Německu je tok Labe o $352\\ \\mathrm{km}$ delší než v České republice. Vypočtěte délku toku Labe v Německu.','2.2 Zahrada měla výměru $1\\,799\\ \\mathrm{m}^2$. Při stavbě nového plotu se posunutím sloupků výměra zahrady zvětšila o $250\\ \\mathrm{dm}^2$. Vypočtěte v $\\mathrm{m}^2$ novou výměru zahrady.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: Délku v ČR označme $c$. Pak $c+(c+352)=1\\,094$, tedy $2c=742$, $c=371\\ \\mathrm{km}$; v Německu $371+352=723\\ \\mathrm{km}$.','2.2: $250\\ \\mathrm{dm}^2=2{,}5\\ \\mathrm{m}^2$; nová výměra $1\\,799+2{,}5=1\\,801{,}5\\ \\mathrm{m}^2$.'},
  '2.1: $723\\ \\mathrm{km}$; 2.2: $1\\,801{,}5\\ \\mathrm{m}^2$',
  2, 4, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bezny-zivot'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{5}{8}-\\dfrac{5}{12}\\right)\\cdot4-2\\cdot\\left(\\dfrac{3}{4}-\\dfrac{2}{3}\\right)=$','3.2 \\quad $\\dfrac{\\left(\\dfrac{27}{10}\\cdot\\dfrac{5}{9}-4\\right):3}{5}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{5}{8}-\\frac{5}{12}=\\frac{15-10}{24}=\\frac{5}{24}$; $\\frac{5}{24}\\cdot4=\\frac{5}{6}$; $\\frac{3}{4}-\\frac{2}{3}=\\frac{1}{12}$; $2\\cdot\\frac{1}{12}=\\frac{1}{6}$; $\\frac{5}{6}-\\frac{1}{6}=\\frac{4}{6}=\\frac{2}{3}$.','3.2: $\\frac{27}{10}\\cdot\\frac{5}{9}=\\frac{135}{90}=\\frac{3}{2}$; $\\frac{3}{2}-4=-\\frac{5}{2}$; $-\\frac{5}{2}:3=-\\frac{5}{6}$; $-\\frac{5}{6}:5=-\\frac{1}{6}$.'},
  '3.1: $\\frac{2}{3}$; 3.2: $-\\frac{1}{6}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 4',
  new List<String>{'4.1 Z daného výrazu vytkněte $(-3x)$: $\\quad -6x^2-3x+9xy=$','4.2 Doplňte do rámečků chybějící čísla tak, aby platila rovnost (uveďte všechna tři čísla): $\\left(\\square\\cdot a-\\square\\cdot b\\right)^2=\\square\\cdot a^2-56ab+(4\\cdot b)^2$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5-y)(5+y)+3\\cdot(y^2-10)-(2y-3)\\cdot y=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $-6x^2-3x+9xy=(-3x)\\cdot(2x+1-3y)$.','4.2: $(p\\cdot a-q\\cdot b)^2=p^2a^2-2pq\\,ab+q^2b^2$. Z $(4b)^2=16b^2$ je $q=4$; z $-2pq=-56$ je $p=7$; koeficient u $a^2$ je $p^2=49$. Čísla: $7$; $4$; $49$.','4.3: $25-y^2+3y^2-30-(2y^2-3y)=25-y^2+3y^2-30-2y^2+3y=3y-5$.'},
  '4.1: $(-3x)(2x+1-3y)$; 4.2: $7$; $4$; $49$; 4.3: $3y-5$',
  4, 7, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $2{,}5\\cdot(2-3x)=\\dfrac{5x+10}{2}$','5.2 \\quad $\\dfrac{5}{3}\\cdot(y-1)+\\dfrac{5}{6}\\cdot(11-2y)-\\dfrac{3}{4}\\cdot y=0$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $5-7{,}5x=\\frac{5x+10}{2}$; vynásobením dvěma $10-15x=5x+10$, tedy $-20x=0$, $x=0$.','5.2: vynásobíme $12$: $20(y-1)+10(11-2y)-9y=0$; $20y-20+110-20y-9y=0$; $-9y+90=0$, $y=10$.'},
  '5.1: $x=0$; 5.2: $y=10$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 6',
  new List<String>{'Na trati závodila 3 autíčka. První autíčko ujelo závod za $1$ minutu a $42$ sekund. Druhé autíčko ujelo závod za dobu o třetinu kratší než první autíčko. První autíčko ujelo závod za dobu o třetinu kratší než třetí autíčko.','Vypočtěte v minutách a sekundách, za jakou dobu ujelo závod','6.1 druhé autíčko,','6.2 třetí autíčko.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'První autíčko: $1\\ \\mathrm{min}\\ 42\\ \\mathrm{s}=102\\ \\mathrm{s}$.','6.1: druhé $=102\\cdot\\frac{2}{3}=68\\ \\mathrm{s}=1\\ \\mathrm{min}\\ 8\\ \\mathrm{s}$.','6.2: první je o třetinu kratší než třetí, tedy první $=\\frac{2}{3}\\cdot$třetí, třetí $=102\\cdot\\frac{3}{2}=153\\ \\mathrm{s}=2\\ \\mathrm{min}\\ 33\\ \\mathrm{s}$.'},
  '6.1: $1$ minuta $8$ sekund; 6.2: $2$ minuty $33$ sekund',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bezny-zivot'},
  'M9PDD21C0T04', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
