String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2020 M9I · úloha 1',
  new List<String>{'Vypočtěte, kolikrát je úhel o velikosti $10^\\circ$ větší než úhel o velikosti $0^\\circ\\,20\'$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$10^\\circ=600\'$ a $0^\\circ\\,20\'=20\'$; $\\frac{600\'}{20\'}=30$.'},
  '$30$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','uhly','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $\\sqrt{14{,}4:0{,}001}=$','2.2 \\quad $0{,}5-(-0{,}3+0{,}5)\\cdot2{,}1=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $\\sqrt{14{,}4:0{,}001}=\\sqrt{14\\,400}=120$.','2.2: $0{,}5-(0{,}2)\\cdot2{,}1=0{,}5-0{,}42=0{,}08$.'},
  '2.1: $120$; 2.2: $0{,}08$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\frac{5}{2}-\\frac{2}{5}}{(-7)^2}=$','3.2 \\quad $\\dfrac{5}{3}\\cdot\\dfrac{9}{50}\\cdot\\left(1-\\dfrac{4}{9}\\right)-\\dfrac{2}{3}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $\\frac{5}{2}-\\frac{2}{5}=\\frac{25-4}{10}=\\frac{21}{10}$; jmenovatel $(-7)^2=49$; $\\frac{21}{10}:49=\\frac{21}{490}=\\frac{3}{70}$.','3.2: $\\frac{5}{3}\\cdot\\frac{9}{50}=\\frac{3}{10}$; $1-\\frac{4}{9}=\\frac{5}{9}$; $\\frac{3}{10}\\cdot\\frac{5}{9}=\\frac{1}{6}$; $\\frac{1}{6}-\\frac{2}{3}=\\frac{1-4}{6}=-\\frac{1}{2}$.'},
  '3.1: $\\frac{3}{70}$; 3.2: $-\\frac{1}{2}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $\\left(\\dfrac{x}{3}+\\dfrac{3}{2}\\right)^2=$','4.2 \\quad $5a\\cdot(0{,}4b-2a+3)=$','4.3 \\quad $(4+n)\\cdot(4-n)+(3n-2)\\cdot(-3)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $\\left(\\frac{x}{3}\\right)^2+2\\cdot\\frac{x}{3}\\cdot\\frac{3}{2}+\\left(\\frac{3}{2}\\right)^2=\\frac{1}{9}x^2+x+\\frac{9}{4}$.','4.2: $5a\\cdot0{,}4b-5a\\cdot2a+5a\\cdot3=2ab-10a^2+15a$.','4.3: $(16-n^2)+(-9n+6)=-n^2-9n+22$.'},
  '4.1: $\\frac{1}{9}x^2+x+\\frac{9}{4}$; 4.2: $2ab-10a^2+15a$; 4.3: $-n^2-9n+22$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $6x-2=4\\cdot\\left(x-\\dfrac{1}{2}\\right)+2x$','5.2 \\quad $3-y=\\dfrac{3}{4}\\cdot(2y-1)-2$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: pravá strana $4x-2+2x=6x-2$, tedy $6x-2=6x-2$ — rovnice platí pro každé $x$, má nekonečně mnoho řešení.','5.2: $3-y=\\frac{3}{2}y-\\frac{3}{4}-2=\\frac{3}{2}y-\\frac{11}{4}$; $3+\\frac{11}{4}=\\frac{3}{2}y+y$; $\\frac{23}{4}=\\frac{5}{2}y$; $y=\\frac{23}{4}\\cdot\\frac{2}{5}=\\frac{23}{10}=2{,}3$.'},
  '5.1: nekonečně mnoho řešení; 5.2: $y=2{,}3$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 6',
  new List<String>{'Soutěže se zúčastnily tři týmy. Jejich výkony hodnotilo $10$ rozhodčích. Každý rozhodčí přidělil každému týmu jedno ze tří možných míst (každému týmu jiné). Tým získal za každé 1. místo $4$ body, za každé 2. místo $2$ body a za každé 3. místo $1$ bod. Zvítězil tým s nejvyšším počtem získaných bodů.','Do tabulky se zapisují počty přidělených míst a celkové počty bodů. Tým A získal v soutěži jen o $3$ body méně než vítězný tým.','Tabulka (počet 1. míst / počet 2. míst / počet 3. míst): Tým A: $3$ / $4$ / $3$; Tým B: — / — / —; Tým C: — / — / $3$.','6.1 Vypočtěte, kolik bodů získal tým A.','6.2 Vypočtěte, kolik bodů získaly dohromady týmy B a C.','6.3 Vypočtěte, kolik druhých míst získal tým B.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: tým A $=3\\cdot4+4\\cdot2+3\\cdot1=12+8+3=23$ bodů.','Každý z $10$ rozhodčích rozdělí $4+2+1=7$ bodů, celkem tedy $70$ bodů.','6.2: týmy B a C dohromady $70-23=47$ bodů.','6.3: v každém sloupci tabulky je součet míst $10$, proto tým B má 3. míst $10-3-3=4$. Vítěz má $23+3=26$ bodů. Označíme počet 1. míst týmu B jako $b$; pak 2. míst má $6-b$ a jeho body jsou $4b+2(6-b)+4=2b+16$. Z $2b+16=26$ plyne $b=5$, takže 2. míst má tým B $6-5=1$.'},
  '6.1: $23$ bodů; 6.2: $47$ bodů; 6.3: $1$ druhé místo',
  4, 7, '3',
  new List<String>{'zs2','r9','aritmetika','slovni','uvazovani','grafy','bez-kalkulacky','bezny-zivot'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
