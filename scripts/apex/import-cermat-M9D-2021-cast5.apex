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
  'CERMAT 2021 M9D · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?','15.2 Obdélník i tmavý obrazec zakreslený v obdélníku mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?','15.3 Věra měla naspořeno $1\\,000$ korun. Nejprve si za $20\\ \\%$ úspor koupila tričko a potom $20\\ \\%$ ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?','Nabídka: A) o $0\\ \\%$; B) o $20\\ \\%$; C) o $25\\ \\%$; D) o $30\\ \\%$; E) o $35\\ \\%$; F) o jiný počet procent.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 65 53"><path d="M4 15L61 15M4 27L61 27M4 38L61 38M15 4L15 49M27 4L27 49M38 4L38 49M49 4L49 49" style="fill:none;stroke:#a6a6a6;stroke-width:1"/><path d="M27 4L4 38L15 49L27 38L61 49L61 15L27 4Z" style="fill:#7f7f7f;stroke:#000000;stroke-width:1"/><path d="M4 4L61 4L61 49L4 49Z" style="fill:none;stroke:#000000;stroke-width:1"/></svg>',
  'obr.svg',
  'Obdélník rozdělený čtvercovou sítí 5 krát 4; v něm je tmavě vyplněný šestiúhelník s vrcholy v mřížových bodech o obsahu 13 čtverečků.',
  '',
  new List<String>{'15.1: $\\frac{420-350}{350}=\\frac{70}{350}=0{,}2=20\\ \\%$ — \\textbf{B}.','15.2: obdélník má $5\\times4=20$ čtverečků, obsah tmavého obrazce je $13$ čtverečků; je menší o $20-13=7$, tj. o $\\frac{7}{20}=35\\ \\%$ — \\textbf{E}.','15.3: tričko $=20\\ \\%$ z $1\\,000=200$ Kč; zbývá $800$ Kč, knížka $=20\\ \\%$ z $800=160$ Kč; tričko je dražší o $\\frac{200-160}{160}=\\frac{40}{160}=25\\ \\%$ — \\textbf{C}.'},
  '15.1: B; 15.2: E; 15.3: C',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','planimetrie','aritmetika','prirazovani','vypocet','bezny-zivot'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 16',
  new List<String>{'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. Na $1.$ až $17.$ místě je: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\dots$','Určete,','16.1 na kolikátém místě nové řady je číslo $100$,','16.2 které číslo je na $100.$ místě nové řady,','16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Číslo $v$ končí na místě $v+\\left\\lfloor\\frac{v}{3}\\right\\rfloor$ (za každý násobek $3$ menší nebo rovný $v$ přibude jedno místo).','16.1: $100$ není dělitelné $3$, je na místě $100+\\left\\lfloor\\frac{100}{3}\\right\\rfloor=100+33=133$.','16.2: hledáme $v$ s $v+\\lfloor v/3\\rfloor=100$; pro $v=75$ je $75+25=100$. Číslo $75$ je dělitelné $3$, vyskytuje se dvakrát (na $99.$ a $100.$ místě), takže na $100.$ místě je $75$.','16.3: sudých čísel od $1$ do $101$ je $50$ (čísla $2,4,\\dots,100$). Z nich jsou násobky $6$ (sudé a zároveň dělitelné $3$) uvedeny dvakrát: $6,12,\\dots,96$, tj. $16$ čísel. Počet míst $=(50-16)\\cdot1+16\\cdot2=34+32=66$.'},
  '16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','cisla','aritmetika','uvazovani','bez-kalkulacky'},
  'M9PDD21C0T04', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
