String SRC   = 'CERMAT – Jednotná přijímací zkouška 2020, řádný termín (M9A)';
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
  'CERMAT 2020 M9A · úloha 1',
  new List<String>{'Vypočtěte:','$(-0{,}4)^2+0{,}3^2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$(-0{,}4)^2=0{,}16$ a $0{,}3^2=0{,}09$; součet $0{,}16+0{,}09=0{,}25$.'},
  '$0{,}25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 2',
  new List<String>{'2.1 \\quad Z dvouhodinové přednášky již tři pětiny uplynuly. Vypočtěte, kolik minut zbývá do konce přednášky.','2.2 \\quad Objemy dvou laboratorních nádob jsou $V_1=9\\,500\\ \\mathrm{mm}^3$, $V_2=0{,}001\\ \\mathrm{m}^3$. Vypočtěte, o kolik $\\mathrm{cm}^3$ se liší objemy $V_1$, $V_2$ těchto laboratorních nádob.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: dvě hodiny $=120$ minut; zbývají dvě pětiny, tedy $\\frac{2}{5}\\cdot120=48$ minut.','2.2: $V_1=9\\,500\\ \\mathrm{mm}^3=9{,}5\\ \\mathrm{cm}^3$; $V_2=0{,}001\\ \\mathrm{m}^3=1\\,000\\ \\mathrm{cm}^3$; rozdíl $1\\,000-9{,}5=990{,}5\\ \\mathrm{cm}^3$.'},
  '2.1: $48$ minut; 2.2: o $990{,}5\\ \\mathrm{cm}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','slovni','bez-kalkulacky'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{1}{4}+\\dfrac{5}{6}\\right)\\cdot\\left(\\dfrac{5}{13}-\\dfrac{1}{2}\\right)=$','3.2 \\quad $\\dfrac{\\frac{6}{5}}{\\frac{7}{6}\\cdot4-4\\cdot\\frac{5}{12}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{1}{4}+\\frac{5}{6}=\\frac{3+10}{12}=\\frac{13}{12}$; $\\frac{5}{13}-\\frac{1}{2}=\\frac{10-13}{26}=-\\frac{3}{26}$; součin $\\frac{13}{12}\\cdot\\left(-\\frac{3}{26}\\right)=-\\frac{39}{312}=-\\frac{1}{8}$.','3.2: jmenovatel $\\frac{7}{6}\\cdot4-4\\cdot\\frac{5}{12}=\\frac{28}{6}-\\frac{20}{12}=\\frac{14}{3}-\\frac{5}{3}=3$; tedy $\\frac{6}{5}:3=\\frac{6}{15}=\\frac{2}{5}$.'},
  '3.1: $-\\frac{1}{8}$; 3.2: $\\frac{2}{5}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 4',
  new List<String>{'4.1 \\quad Rozložte na součin: $p^2-16=$','4.2 \\quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x+5)^2=$','4.3 \\quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n+6)\\cdot(4n-5)+(3-5)\\cdot2n-5n\\cdot(n-2n)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $p^2-16=(p-4)(p+4)$.','4.2: $(2x+5)^2=4x^2+20x+25$.','4.3: $(2n+6)(4n-5)=8n^2+14n-30$; $(3-5)\\cdot2n=-4n$; $-5n\\cdot(n-2n)=-5n\\cdot(-n)=5n^2$; součet $8n^2+5n^2+14n-4n-30=13n^2+10n-30$.'},
  '4.1: $(p-4)(p+4)$; 4.2: $4x^2+20x+25$; 4.3: $13n^2+10n-30$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $3{,}2-0{,}5x-1=0{,}6-1{,}3x$','5.2 \\quad $\\dfrac{5y+3}{8}-\\dfrac{y}{2}=\\dfrac{4-y}{5}+\\dfrac{2y-1}{10}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $2{,}2-0{,}5x=0{,}6-1{,}3x\\Rightarrow0{,}8x=-1{,}6\\Rightarrow x=-2$.','5.2: levá strana $\\frac{5y+3-4y}{8}=\\frac{y+3}{8}$; pravá strana $\\frac{2(4-y)+(2y-1)}{10}=\\frac{8-2y+2y-1}{10}=\\frac{7}{10}$; tedy $\\frac{y+3}{8}=\\frac{7}{10}\\Rightarrow10(y+3)=56\\Rightarrow10y=26\\Rightarrow y=\\frac{13}{5}$.'},
  '5.1: $x=-2$; 5.2: $y=\\frac{13}{5}$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9A · úloha 6',
  new List<String>{'Tři vázy mají různé velikosti. Objem velké vázy je o polovinu větší než objem střední vázy. Objem střední vázy je čtyřikrát větší než objem malé vázy. Neznámý objem střední vázy označte $x$.','6.1 \\quad V závislosti na veličině $x$ vyjádřete objem velké vázy.','6.2 \\quad V závislosti na veličině $x$ vyjádřete objem malé vázy.','6.3 \\quad Všechny tři vázy dohromady mají objem $5{,}5$ litru. Vypočtěte v litrech objem střední vázy.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: velká $=x+\\frac{1}{2}x=\\frac{3x}{2}$.','6.2: malá $=\\frac{x}{4}$.','6.3: $\\frac{3x}{2}+x+\\frac{x}{4}=\\frac{6x+4x+x}{4}=\\frac{11x}{4}=5{,}5\\Rightarrow x=2$, tedy střední váza má objem $2$ litry.'},
  '6.1: $\\frac{3x}{2}$; 6.2: $\\frac{x}{4}$; 6.3: $2$ litry',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
