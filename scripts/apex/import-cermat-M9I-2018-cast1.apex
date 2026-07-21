String SRC   = 'CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2018 M9I · úloha 1',
  new List<String>{'Myslím si číslo. Číslo k němu opačné je o $6$ menší.','Určete číslo, které si myslím.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Hledané číslo označíme $x$, opačné číslo je $-x$. Platí $-x=x-6$, odtud $-2x=-6$, tedy $x=3$.'},
  '$3$',
  1, 2, '2',
  new List<String>{'zs2','r9','cisla','rovnice','uvazovani','bez-kalkulacky','bez-kontextu'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 2',
  new List<String>{'Trojúhelník má obvod $21\\ \\mathrm{cm}$ a délky jeho stran jsou v poměru $6:5:3$.','2.1 Určete v cm délku nejdelší strany trojúhelníku.','2.2 Určete, o kolik cm se liší délky dvou kratších stran trojúhelníku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Součet dílů poměru je $6+5+3=14$; jeden díl $=\\frac{21}{14}=1{,}5\\ \\mathrm{cm}$.','2.1: nejdelší strana $=6\\cdot1{,}5=9\\ \\mathrm{cm}$.','2.2: kratší strany jsou $5\\cdot1{,}5=7{,}5\\ \\mathrm{cm}$ a $3\\cdot1{,}5=4{,}5\\ \\mathrm{cm}$; liší se o $7{,}5-4{,}5=3\\ \\mathrm{cm}$.'},
  '2.1: $9\\ \\mathrm{cm}$; 2.2: o $3\\ \\mathrm{cm}$',
  2, 3, '2',
  new List<String>{'zs2','r9','pomer','planimetrie','vypocet','bez-kalkulacky'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $2-2\\cdot\\dfrac{2\\cdot\\frac{9}{10}}{3}=$','3.2 \\quad $\\dfrac{3^2}{5}-\\dfrac{3}{5^2}+\\left(-\\dfrac{3}{5}\\right)^2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $2\\cdot\\frac{9}{10}=\\frac{9}{5}$; $\\frac{9/5}{3}=\\frac{9}{15}=\\frac{3}{5}$; $2-2\\cdot\\frac{3}{5}=2-\\frac{6}{5}=\\frac{4}{5}$.','3.2: $\\frac{9}{5}-\\frac{3}{25}+\\frac{9}{25}=\\frac{45}{25}-\\frac{3}{25}+\\frac{9}{25}=\\frac{51}{25}$.'},
  '3.1: $\\frac{4}{5}$; 3.2: $\\frac{51}{25}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $\\left[(a-4a)^2-3a\\cdot(3a+2)\\right]^2=$','4.2 \\quad $(2b+1)\\cdot(2b-1)-b\\cdot(-b+b)+1=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(a-4a)^2=(-3a)^2=9a^2$; $3a\\cdot(3a+2)=9a^2+6a$; hranatá závorka $=9a^2-(9a^2+6a)=-6a$; $(-6a)^2=36a^2$.','4.2: $(2b+1)(2b-1)=4b^2-1$; $-b\\cdot(-b+b)=-b\\cdot0=0$; celkem $4b^2-1+1=4b^2$.'},
  '4.1: $36a^2$; 4.2: $4b^2$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $\\dfrac{5x-2}{4}=1{,}25x-\\dfrac{1}{2}$','5.2 \\quad $\\dfrac{2}{3}\\cdot(x+1)=-\\dfrac{1}{3}\\cdot(2x-1)-1$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $1{,}25=\\frac{5}{4}$, pravá strana $=\\frac{5x}{4}-\\frac{1}{2}=\\frac{5x-2}{4}$. Obě strany jsou totožné, rovnice platí pro každé $x$ — nekonečně mnoho řešení.','5.2: vynásobíme $3$: $2(x+1)=-(2x-1)-3$; $2x+2=-2x+1-3=-2x-2$; $4x=-4$; $x=-1$.'},
  '5.1: nekonečně mnoho řešení; 5.2: $x=-1$',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 6',
  new List<String>{'V každé krabici je stejný počet mýdel. Čtvrtina všech krabic obsahuje jen bílá mýdla a v každé ze zbývajících $120$ krabic je vždy polovina mýdel bílých a polovina zelených. Bílých mýdel je celkem $1\\,200$.','6.1 Určete počet všech krabic s mýdly.','6.2 Určete nejmenší počet krabic, do nichž by se vešla všechna bílá mýdla.','6.3 Určete počet všech mýdel.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Zbývajících $120$ krabic tvoří tři čtvrtiny všech krabic, tedy všech krabic je $120:\\frac{3}{4}=160$.','6.1: všech krabic je $160$.','6.2: čistě bílých krabic je $\\frac{1}{4}\\cdot160=40$. V každé krabici je stejný počet mýdel $m$; bílá mýdla: $40m+120\\cdot\\frac{m}{2}=40m+60m=100m=1\\,200$, tedy $m=12$. Všech $1\\,200$ bílých mýdel se vejde do $1\\,200:12=100$ krabic.','6.3: všech mýdel je $160\\cdot12=1\\,920$.'},
  '6.1: $160$ krabic; 6.2: $100$ krabic; 6.3: $1\\,920$ mýdel',
  4, 6, '4',
  new List<String>{'zs2','r9','slovni','aritmetika','zlomky','uvazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID18C0T01', 2018
);

System.debug('Vytvořeno úloh: '+c.created);
