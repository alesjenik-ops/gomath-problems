String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
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
  'CERMAT 2024 M9C · úloha 1',
  new List<String>{'Města Jihlava a Třebíč mají dohromady $86\\,200$ obyvatel. Jihlava má o $16\\,000$ obyvatel více. Kolik obyvatel má Třebíč?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$(86\\,200-16\\,000):2=70\\,200:2=35\\,100$ obyvatel.'},
  '$35\\,100$ obyvatel',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 2',
  new List<String>{'Dvě válcové nádoby A a B mají stejnou výšku $v=20\\ \\mathrm{cm}$. Nádoba A má průměr podstavy $d_1=10\\ \\mathrm{cm}$, nádoba B $d_2=20\\ \\mathrm{cm}$. Nádoba A je plná vody, B prázdná.','Do jaké výšky bude sahat voda v nádobě B, přelijeme-li do ní všechnu vodu z A?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Objem vody $V=\\pi\\cdot5^2\\cdot20=500\\pi\\ \\mathrm{cm}^3$.','V nádobě B: $\\pi\\cdot10^2\\cdot h=500\\pi\\Rightarrow h=5\\ \\mathrm{cm}$.'},
  '$5\\ \\mathrm{cm}$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 3',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\frac{7}{5}+3{,}3-\\frac{1}{2}}{\\frac{1}{15}+\\frac{1}{3}}=$','3.2 \\quad $\\left(\\dfrac{1}{2}+\\dfrac{1}{3}:\\dfrac{5}{6}\\right)-\\dfrac{7}{2}+\\dfrac{3}{5}:\\dfrac{3}{2}-1=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $\\frac{7}{5}+3{,}3-\\frac{1}{2}=1{,}4+3{,}3-0{,}5=4{,}2=\\frac{21}{5}$; jmenovatel $\\frac{1}{15}+\\frac{1}{3}=\\frac{2}{5}$; $\\frac{21}{5}:\\frac{2}{5}=\\frac{21}{2}$.','3.2: $\\frac{1}{3}:\\frac{5}{6}=\\frac{2}{5}$, $\\frac{3}{5}:\\frac{3}{2}=\\frac{2}{5}$; $\\left(\\frac{1}{2}+\\frac{2}{5}\\right)-\\frac{7}{2}+\\frac{2}{5}-1=\\frac{9}{10}-\\frac{35}{10}+\\frac{4}{10}-\\frac{10}{10}=-\\frac{16}{5}$.'},
  '3.1: $\\frac{21}{2}$; 3.2: $-\\frac{16}{5}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 4',
  new List<String>{'4.1 Umocněte a zjednodušte (výsledek zlomkem v základním tvaru): $\\left(\\dfrac{b}{3}-3b\\right)^2=$','4.2 Upravte a rozložte na součin pomocí vzorců: $5-(1-x^2)-x\\cdot2x=$','4.3 Zjednodušte (bez závorek): $(c-7)\\cdot(c-7)-(c-5)\\cdot3c+c\\cdot(c+c)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $\\left(\\frac{b}{3}-\\frac{9b}{3}\\right)^2=\\left(-\\frac{8b}{3}\\right)^2=\\frac{64b^2}{9}$.','4.2: $5-1+x^2-2x^2=4-x^2=(2-x)(2+x)$.','4.3: $(c^2-14c+49)-(3c^2-15c)+2c^2=c+49$.'},
  '4.1: $\\frac{64b^2}{9}$; 4.2: $(2-x)(2+x)$; 4.3: $c+49$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 5',
  new List<String>{'Řešte rovnice.','5.1 \\quad $\\left(x+\\dfrac{1}{2}x\\right)\\cdot2=\\left(x+\\dfrac{1}{6}x\\right)\\cdot2+6$','5.2 \\quad $\\dfrac{1}{2}\\cdot(x+2)-(x-2)^2=6-x^2$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $3x=\\frac{7}{3}x+6\\Rightarrow 9x=7x+18\\Rightarrow x=9$.','5.2: $\\frac{x}{2}+1-(x^2-4x+4)=6-x^2\\Rightarrow \\frac{x}{2}+4x-3=6\\Rightarrow \\frac{9x}{2}=9\\Rightarrow x=2$.'},
  '5.1: $x=9$; 5.2: $x=2$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
