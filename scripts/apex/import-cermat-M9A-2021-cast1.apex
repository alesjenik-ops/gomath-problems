String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 1',
  new List<String>{'Určete, na kolik $16$minutových intervalů lze rozdělit $1{,}6$ hodiny.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}6$ hodiny $=1{,}6\\cdot60=96$ minut; $96:16=6$.'},
  'na $6$ intervalů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','2.1 \\quad $0{,}3\\ \\mathrm{m}^2-52\\ \\mathrm{cm}^2=\\square\\ \\mathrm{cm}^2$','2.2 \\quad $\\square\\ \\mathrm{dm}^3-0{,}04\\ \\mathrm{m}^3=250\\ \\mathrm{cm}^3$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $0{,}3\\ \\mathrm{m}^2=3000\\ \\mathrm{cm}^2$; $3000-52=2948\\ \\mathrm{cm}^2$.','2.2: $0{,}04\\ \\mathrm{m}^3=40\\ \\mathrm{dm}^3$ a $250\\ \\mathrm{cm}^3=0{,}25\\ \\mathrm{dm}^3$; hledané číslo $=40+0{,}25=40{,}25$.'},
  '2.1: $2948$; 2.2: $40{,}25$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{5}{8}\\cdot\\dfrac{10}{9}-\\dfrac{4}{9}\\right):\\left(8\\cdot\\dfrac{1}{6}\\right)=$','3.2 \\quad $\\dfrac{2-\\frac{13}{10}}{\\frac{5}{3}-\\frac{1}{2}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{5}{8}\\cdot\\frac{10}{9}=\\frac{50}{72}=\\frac{25}{36}$; $\\frac{25}{36}-\\frac{4}{9}=\\frac{25}{36}-\\frac{16}{36}=\\frac{9}{36}=\\frac{1}{4}$; $8\\cdot\\frac{1}{6}=\\frac{4}{3}$; $\\frac{1}{4}:\\frac{4}{3}=\\frac{1}{4}\\cdot\\frac{3}{4}=\\frac{3}{16}$.','3.2: čitatel $2-\\frac{13}{10}=\\frac{20-13}{10}=\\frac{7}{10}$; jmenovatel $\\frac{5}{3}-\\frac{1}{2}=\\frac{10-3}{6}=\\frac{7}{6}$; $\\frac{7}{10}:\\frac{7}{6}=\\frac{7}{10}\\cdot\\frac{6}{7}=\\frac{6}{10}=\\frac{3}{5}$.'},
  '3.1: $\\frac{3}{16}$; 3.2: $\\frac{3}{5}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 4',
  new List<String>{'4.1 Rozložte na součin podle vzorce: $9a^2-30a+25=$','4.2 Vynásobte (výsledný výraz nesmí obsahovat závorky): $(3x+y)\\cdot(3x-2)=$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-1)\\cdot(4n+1)-8n\\cdot(n-1)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $9a^2-30a+25=(3a)^2-2\\cdot3a\\cdot5+5^2=(3a-5)^2$.','4.2: $(3x+y)(3x-2)=9x^2-6x+3xy-2y=9x^2+3xy-6x-2y$.','4.3: $(4n-1)(4n+1)=16n^2-1$; $8n(n-1)=8n^2-8n$; $16n^2-1-(8n^2-8n)=8n^2+8n-1$.'},
  '4.1: $(3a-5)^2$; 4.2: $9x^2+3xy-6x-2y$; 4.3: $8n^2+8n-1$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $0{,}3\\cdot2-0{,}5x\\cdot2+0{,}4x=x+3{,}8$','5.2 \\quad $\\dfrac{3}{4}\\cdot(4-y)+\\dfrac{3}{2}\\cdot(y+2)=6+\\dfrac{3y}{2}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}6-x+0{,}4x=x+3{,}8\\Rightarrow0{,}6-0{,}6x=x+3{,}8\\Rightarrow-3{,}2=1{,}6x\\Rightarrow x=-2$.','5.2: levá strana $3-\\frac{3y}{4}+\\frac{3y}{2}+3=6+\\frac{3y}{4}$; rovnice $6+\\frac{3y}{4}=6+\\frac{3y}{2}\\Rightarrow\\frac{3y}{4}=\\frac{3y}{2}\\Rightarrow3y=6y\\Rightarrow y=0$.'},
  '5.1: $x=-2$; 5.2: $y=0$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 6',
  new List<String>{'Firma zaměstnává $200$ osob. Během epidemie museli někteří pracovat z domova. Včera byla na pracovišti jedna třetina žen zaměstnaných ve firmě a dvě pětiny mužů zaměstnaných ve firmě, všichni ostatní pracovali z domova. Počet všech žen zaměstnaných ve firmě označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete počet žen, které byly včera na pracovišti.','6.2 V závislosti na veličině $x$ vyjádřete počet mužů, kteří byli včera na pracovišti.','6.3 Včera bylo na pracovišti celkem $70$ osob zaměstnaných ve firmě. Vypočtěte, kolik žen firma zaměstnává.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: počet žen na pracovišti $=\\frac{x}{3}$.','6.2: mužů je ve firmě $200-x$, na pracovišti byly dvě pětiny, tedy $\\frac{2}{5}\\cdot(200-x)$.','6.3: $\\frac{x}{3}+\\frac{2}{5}\\cdot(200-x)=70$; vynásobením $15$: $5x+6(200-x)=1050\\Rightarrow5x+1200-6x=1050\\Rightarrow-x=-150\\Rightarrow x=150$.'},
  '6.1: $\\frac{x}{3}$; 6.2: $\\frac{2}{5}\\cdot(200-x)$; 6.3: $150$ žen',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
