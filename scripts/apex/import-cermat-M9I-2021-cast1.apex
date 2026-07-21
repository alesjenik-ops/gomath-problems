String SRC   = 'CERMAT – Ilustrační test 2021, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2021 M9I · úloha 1',
  new List<String>{'Vypočtěte, o kolik se liší druhá mocnina čísla $16$ a druhá odmocnina z čísla $16$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$16^2=256$; $\\sqrt{16}=4$; rozdíl $256-4=252$.'},
  'o $252$',
  1, 2, '1',
  new List<String>{'zs2','r9','aritmetika','cisla','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 2',
  new List<String>{'2.1 \\quad Cesta tam trvala $1$ hodinu a $14$ minut. Zpáteční cesta byla o $46$ minut kratší. Vypočtěte v hodinách a minutách, jak dlouho trvala celá cesta (tam i zpět).','2.2 \\quad Když jsme z nádoby zcela naplněné vodou vylili $0{,}12\\ \\mathrm{m}^3$ vody, v nádobě zbylo ještě $4\\,500\\ \\mathrm{cm}^3$ vody. Vypočtěte v litrech objem nádoby.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: cesta tam $=74$ min; zpět $=74-46=28$ min; celkem $74+28=102$ min $=1$ hodina $42$ minut.','2.2: $0{,}12\\ \\mathrm{m}^3=120\\ \\mathrm{l}$; $4\\,500\\ \\mathrm{cm}^3=4{,}5\\ \\mathrm{l}$; objem $=120+4{,}5=124{,}5\\ \\mathrm{l}$.'},
  '2.1: $1$ hodina $42$ minut; 2.2: $124{,}5$ litru',
  2, 4, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{1}{2}+\\dfrac{8}{5}\\cdot\\left(\\dfrac{3}{8}-\\dfrac{1}{6}\\right)=$','3.2 \\quad $\\dfrac{\\frac{7}{4}-4}{\\,7-\\frac{4}{7}\\,}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{3}{8}-\\frac{1}{6}=\\frac{9-4}{24}=\\frac{5}{24}$; $\\frac{8}{5}\\cdot\\frac{5}{24}=\\frac{1}{3}$; $\\frac{1}{2}+\\frac{1}{3}=\\frac{5}{6}$.','3.2: čitatel $\\frac{7}{4}-4=-\\frac{9}{4}$; jmenovatel $7-\\frac{4}{7}=\\frac{45}{7}$; $-\\frac{9}{4}:\\frac{45}{7}=-\\frac{9}{4}\\cdot\\frac{7}{45}=-\\frac{7}{20}$.'},
  '3.1: $\\frac{5}{6}$; 3.2: $-\\frac{7}{20}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 4',
  new List<String>{'4.1 \\quad Rozložte na součin: $(4a)^2-9\\cdot9=$','4.2 \\quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\\left(\\dfrac{3y}{2}+2\\right)^2=$','4.3 \\quad Zjednodušte a rozložte na součin: $(3n+7)\\cdot(-4n+3n)+n\\cdot(4n+9)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(4a)^2-9\\cdot9=16a^2-81=(4a-9)(4a+9)$.','4.2: $\\left(\\frac{3y}{2}\\right)^2+2\\cdot\\frac{3y}{2}\\cdot2+2^2=\\frac{9y^2}{4}+6y+4$.','4.3: $(3n+7)\\cdot(-n)+n(4n+9)=-3n^2-7n+4n^2+9n=n^2+2n=n(n+2)$.'},
  '4.1: $(4a-9)(4a+9)$; 4.2: $\\frac{9y^2}{4}+6y+4$; 4.3: $n(n+2)$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $2{,}5\\cdot(2x-0{,}4)+x=2{,}5x+0{,}4$','5.2 \\quad $y-\\dfrac{2-5y}{10}=\\dfrac{5y-8}{15}-2$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $5x-1+x=2{,}5x+0{,}4\\Rightarrow6x-1=2{,}5x+0{,}4\\Rightarrow3{,}5x=1{,}4\\Rightarrow x=0{,}4$.','5.2: vynásobíme $30$: $30y-3(2-5y)=2(5y-8)-60\\Rightarrow30y-6+15y=10y-16-60\\Rightarrow45y-6=10y-76\\Rightarrow35y=-70\\Rightarrow y=-2$.'},
  '5.1: $x=0{,}4$; 5.2: $y=-2$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 6',
  new List<String>{'Na záhonu je v každém z $10$ řádků stejný počet květin. První květina ve druhém a každém dalším řádku je vždy na úrovni druhé květiny předchozího řádku (každý řádek je oproti předchozímu posunut o jeden rozestup doprava). Rozestupy mezi sousedními květinami v řádcích i ve sloupcích jsou stejné. Květiny v $1.$ a $10.$ řádku, které jsou ve stejném sloupci, mají vzdálenost $270\\ \\mathrm{cm}$. Předposlední květina v $1.$ řádku je ve stejném sloupci jako druhá květina v $10.$ řádku. (Při výpočtech rozměry květin zanedbáváme.)','6.1 \\quad Vypočtěte v cm rozestup mezi sousedními květinami.','6.2 \\quad Vypočtěte počet květin vysázených v jednom řádku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: mezi $1.$ a $10.$ řádkem je $9$ rozestupů, tedy rozestup $=270:9=30\\ \\mathrm{cm}$.','6.2: $10.$ řádek je posunut o $9$ rozestupů; jeho druhá květina je ve sloupci $9+2=11$. Předposlední (tj. $(n-1).$) květina $1.$ řádku je ve sloupci $n-1$, proto $n-1=11\\Rightarrow n=12$ květin.'},
  '6.1: $30\\ \\mathrm{cm}$; 6.2: $12$ květin',
  2, 5, '3',
  new List<String>{'zs2','r9','posloupnosti','aritmetika','slovni','uvazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
