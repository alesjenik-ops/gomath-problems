String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. náhradní termín (M9D)';
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
  'CERMAT 2024 M9D · úloha 1',
  new List<String>{'Adam a Naďa šli trasou dlouhou $2{,}7\\ \\mathrm{km}$. Adam má krok $75\\ \\mathrm{cm}$, Naďa $60\\ \\mathrm{cm}$. O kolik kroků udělala Naďa více?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$2{,}7\\ \\mathrm{km}=270\\,000\\ \\mathrm{cm}$. Adam $\\frac{270\\,000}{75}=3\\,600$ kroků, Naďa $\\frac{270\\,000}{60}=4\\,500$ kroků.','Rozdíl $4\\,500-3\\,600=900$ kroků.'},
  'o $900$ kroků',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 2',
  new List<String>{'Reproduktory byly zlevněny o $150$ korun, což bylo $15\\ \\%$ původní ceny. Po Vánocích je prodejce zlevnil ještě o $200$ korun z nové ceny. O kolik procent byla konečná cena nižší než původní?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Původní cena $\\frac{150}{0{,}15}=1\\,000$ Kč; nová cena $850$ Kč; konečná $850-200=650$ Kč.','$1\\,000-650=350$ Kč, tj. $\\frac{350}{1\\,000}=35\\ \\%$ původní ceny.'},
  'o $35\\ \\%$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 3',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\left(\\frac{1}{6}-\\frac{1}{3}\\right):\\left(-\\frac{5}{3}\\right)}{0{,}3}=$','3.2 \\quad $\\dfrac{1}{6}+\\dfrac{1}{3}\\cdot\\left(\\dfrac{2}{5}-1\\right)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $\\left(-\\frac{1}{6}\\right):\\left(-\\frac{5}{3}\\right)=\\frac{1}{10}$; $\\frac{1}{10}:0{,}3=\\frac{1}{3}$.','3.2: $\\frac{1}{6}+\\frac{1}{3}\\cdot\\left(-\\frac{3}{5}\\right)=\\frac{1}{6}-\\frac{1}{5}=\\frac{5-6}{30}=-\\frac{1}{30}$.'},
  '3.1: $\\frac{1}{3}$; 3.2: $-\\frac{1}{30}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 4',
  new List<String>{'4.1 Upravte a rozložte na součin vytknutím: $a\\cdot(-a)-2^2\\cdot3a+6a^2=$','4.2 Umocněte a zjednodušte: $\\left(\\dfrac{1}{3}-4b\\right)^2=$','4.3 Upravte bez závorek a zjednodušte: $(2x+3)^2-x\\cdot6-4\\cdot(x-1)^2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $-a^2-12a+6a^2=5a^2-12a=a\\cdot(5a-12)$.','4.2: $\\frac{1}{9}-2\\cdot\\frac{1}{3}\\cdot4b+16b^2=16b^2-\\frac{8}{3}b+\\frac{1}{9}$.','4.3: $(4x^2+12x+9)-6x-4(x^2-2x+1)=4x^2+12x+9-6x-4x^2+8x-4=14x+5$.'},
  '4.1: $a\\cdot(5a-12)$; 4.2: $16b^2-\\frac{8}{3}b+\\frac{1}{9}$; 4.3: $14x+5$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 5',
  new List<String>{'Řešte rovnice.','5.1 \\quad $x-\\dfrac{x-2}{2}=\\dfrac{2x}{3}-2$','5.2 \\quad $2\\cdot(3x-2{,}5)=-5+3\\cdot(3x-2)$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: vynásobením $6$: $6x-3(x-2)=4x-12\\Rightarrow 3x+6=4x-12\\Rightarrow x=18$.','5.2: $6x-5=-5+9x-6\\Rightarrow 6x-5=9x-11\\Rightarrow 6=3x\\Rightarrow x=2$.'},
  '5.1: $x=18$; 5.2: $x=2$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 6',
  new List<String>{'V rychlíku jsou vagóny 1. a 2. třídy; vagónů 2. třídy je dvakrát více než 1. třídy. V každém vagónu je $10$ kupé. V kupé 1. třídy je $6$ míst, v kupé 2. třídy $8$ míst. Celkem je $440$ míst k sezení.','6.1 Kolik vagónů 2. třídy je v rychlíku?','6.2 Kolik míst k sezení je dohromady ve vagónech 1. třídy?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vagónů 1. třídy $x$, 2. třídy $2x$: $x\\cdot10\\cdot6+2x\\cdot10\\cdot8=220x=440\\Rightarrow x=2$.','6.1: vagónů 2. třídy $2x=4$.','6.2: míst v 1. třídě $x\\cdot10\\cdot6=2\\cdot60=120$.'},
  '6.1: $4$ vagóny; 6.2: $120$ míst',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 7',
  new List<String>{'V restauraci nabízejí tři menu A, B, C. Tři skupiny po $20$ lidech objednaly: skupina 1 dvacet menu A za $4\\,000$ Kč; skupina 2 deset A a deset B za $4\\,800$ Kč; skupina 3 pět A, pět B a deset C za $5\\,400$ Kč.','7.1 Jaká byla cena oběda B?','7.2 Jaká byla cena oběda C?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Z první skupiny $A=\\frac{4\\,000}{20}=200$ Kč.','7.1: $10\\cdot200+10B=4\\,800\\Rightarrow B=280$ Kč.','7.2: $5\\cdot200+5\\cdot280+10C=5\\,400\\Rightarrow 10C=3\\,000\\Rightarrow C=300$ Kč.'},
  '7.1: $280$ Kč; 7.2: $300$ Kč',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','soustava','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
