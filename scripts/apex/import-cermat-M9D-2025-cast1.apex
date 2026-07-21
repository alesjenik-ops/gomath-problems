String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
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
  'CERMAT 2025 M9D · úloha 1',
  new List<String>{'Třímetrovou stuhu jsme dvěma střihy rozdělili na tři díly. Nejprve jsme odstřihli čtvrtinu stuhy, potom dvě pětiny zbytku a poslední díl jsme použili na třetí dárek.','Vypočtěte, kolik cm stuhy jsme použili na třetí dárek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Stuha $300\\ \\mathrm{cm}$; první díl $\\frac{1}{4}\\cdot300=75\\ \\mathrm{cm}$, zbytek $225\\ \\mathrm{cm}$.','Druhý díl $\\frac{2}{5}\\cdot225=90\\ \\mathrm{cm}$; třetí díl $225-90=135\\ \\mathrm{cm}$.'},
  '$135\\ \\mathrm{cm}$',
  1, 2, '2',
  new List<String>{'zs2','r9','zlomky','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 2',
  new List<String>{'Poměr dvou neznámých přirozených čísel je $4:5$ a dvojnásobky těchto čísel se liší o $6$. Určete menší z obou čísel.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Čísla jsou $4k$ a $5k$; $2\\cdot5k-2\\cdot4k=2k=6\\Rightarrow k=3$.','Menší číslo je $4\\cdot3=12$.'},
  '$12$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','rovnice','slovni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{7}{5}-\\dfrac{7}{4}\\right):\\dfrac{2}{5}=$','3.2 \\quad $\\dfrac{\\left(1+\\dfrac{1}{7}\\right)^2\\cdot\\dfrac{7}{4}}{\\sqrt{25}-\\dfrac{3^2}{5}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{7}{5}-\\frac{7}{4}=\\frac{28-35}{20}=-\\frac{7}{20}$; $-\\frac{7}{20}:\\frac{2}{5}=-\\frac{7}{8}$.','3.2: čitatel $\\left(\\frac{8}{7}\\right)^2\\cdot\\frac{7}{4}=\\frac{64}{49}\\cdot\\frac{7}{4}=\\frac{16}{7}$; jmenovatel $5-\\frac{9}{5}=\\frac{16}{5}$; $\\frac{16}{7}:\\frac{16}{5}=\\frac{5}{7}$.'},
  '3.1: $-\\frac{7}{8}$; 3.2: $\\frac{5}{7}$',
  3, 5, '3',
  new List<String>{'zs2','r9','zlomky','mocniny-odmocniny','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 4',
  new List<String>{'4.1 Upravte na co nejjednodušší tvar bez závorek: $(y+1)^2+(y-1)\\cdot2y=$','4.2 Upravte a výsledný výraz rozložte na součin pomocí vzorce: $k\\cdot(k-9)+9\\cdot(k-16)=$','4.3 Upravte na co nejjednodušší tvar bez závorek: $(x-15)\\cdot(2x-x)-(5x-8)\\cdot(-3+1)-1=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $y^2+2y+1+2y^2-2y=3y^2+1$.','4.2: $k^2-9k+9k-144=k^2-144=(k+12)(k-12)$.','4.3: $(x-15)\\cdot x-(5x-8)\\cdot(-2)-1=x^2-15x+10x-16-1=x^2-5x-17$.'},
  '4.1: $3y^2+1$; 4.2: $(k+12)(k-12)$; 4.3: $x^2-5x-17$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 5',
  new List<String>{'5.1 Řešte rovnici: $0{,}1x+5\\cdot(0{,}04x-3{,}2)=4-0{,}7x$','5.2 Řešte soustavu rovnic: $\\begin{aligned}3x-(y+1)&=10\\\\ 2x-9&=y\\end{aligned}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}1x+0{,}2x-16=4-0{,}7x\\Rightarrow 0{,}3x-16=4-0{,}7x\\Rightarrow x=20$.','5.2: dosazením $y=2x-9$: $3x-(2x-9+1)=10\\Rightarrow x+8=10\\Rightarrow x=2$, $y=-5$.'},
  '5.1: $x=20$; 5.2: $x=2$, $y=-5$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','soustava','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD25C0T04', 2025
);
c.add(
  'CERMAT 2025 M9D · úloha 6',
  new List<String>{'Ve skladu bylo $95$ beden. Robot A vozil bedny po $5$ kusech a odvezl za $2$ hodiny $50$ beden. Robot B vozil bedny po $3$ kusech a odvezl za $1{,}5$ hodiny zbývajících $45$ beden.','6.1 Vyjádřete v základním tvaru poměr počtu beden odvezených za $1$ hodinu robotem A ku počtu odvezených robotem B.','6.2 Vyjádřete v základním tvaru poměr počtu jízd robota A za hodinu ku počtu jízd robota B za hodinu.','6.3 Vypočtěte, kolik beden odvezou oba roboti dohromady za $36$ minut při společném provozu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'A: $\\frac{50}{2}=25$ beden/h; B: $\\frac{45}{1{,}5}=30$ beden/h.','6.1: $25:30=5:6$.','6.2: jízd A $\\frac{25}{5}=5$/h, B $\\frac{30}{3}=10$/h; $5:10=1:2$.','6.3: $36$ min $=0{,}6$ h; $(25+30)\\cdot0{,}6=33$ beden.'},
  '6.1: $5:6$; 6.2: $1:2$; 6.3: $33$ beden',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
