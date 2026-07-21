String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)';
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
  'CERMAT 2022 M9D · úloha 1',
  new List<String>{'Vypište všechny dělitele čísla $95$, které jsou větší než $1$ a menší než $95$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$95=5\\cdot19$. Dělitelé čísla $95$ jsou $1$, $5$, $19$, $95$; v požadovaném rozmezí leží $5$ a $19$.'},
  '$5$ a $19$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','cisla','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $(-3)^2-5^2-4\\cdot(-4)=$','2.2 \\quad $(0{,}08-1):0{,}2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $9-25-(-16)=9-25+16=0$.','2.2: $(-0{,}92):0{,}2=-4{,}6$.'},
  '2.1: $0$; 2.2: $-4{,}6$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{12}{5}\\cdot\\dfrac{3}{20}-\\dfrac{3}{20}\\right):\\dfrac{7}{25}=$','3.2 \\quad $\\dfrac{12}{\\,2+\\frac{2}{3}\\,}\\cdot\\dfrac{2\\cdot\\frac{2}{3}}{18}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{12}{5}\\cdot\\frac{3}{20}=\\frac{36}{100}=\\frac{9}{25}$; $\\frac{9}{25}-\\frac{3}{20}=\\frac{36-15}{100}=\\frac{21}{100}$; $\\frac{21}{100}:\\frac{7}{25}=\\frac{21}{100}\\cdot\\frac{25}{7}=\\frac{3}{4}$.','3.2: jmenovatel $2+\\frac{2}{3}=\\frac{8}{3}$, tedy $\\frac{12}{8/3}=\\frac{12\\cdot3}{8}=\\frac{9}{2}$; dále $2\\cdot\\frac{2}{3}=\\frac{4}{3}$, tedy $\\frac{4/3}{18}=\\frac{4}{54}=\\frac{2}{27}$; $\\frac{9}{2}\\cdot\\frac{2}{27}=\\frac{18}{54}=\\frac{1}{3}$.'},
  '3.1: $\\frac{3}{4}$; 3.2: $\\frac{1}{3}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 4',
  new List<String>{'4.1 Zjednodušte (výsledný výraz nesmí obsahovat závorky ani znak pro odmocninu): $(10x-8)-x\\cdot\\sqrt{100-64}=$','4.2 Do rámečků doplňte chybějící čísla $a$, $b$ tak, aby platila rovnost: $(y+a)^2=y^2+10y+b$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(6n+1)\\cdot(1-2n-4n)+(1-2n)\\cdot(-4n)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $\\sqrt{100-64}=\\sqrt{36}=6$; $(10x-8)-6x=4x-8$.','4.2: $(y+5)^2=y^2+10y+25$, tedy $a=5$ a $b=25$.','4.3: $(6n+1)(1-6n)=1-36n^2$; $(1-2n)(-4n)=-4n+8n^2$; součet $-28n^2-4n+1$.'},
  '4.1: $4x-8$; 4.2: $5$ a $25$; 4.3: $-28n^2-4n+1$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $x+0{,}2\\cdot(5x+0{,}9)=x:5$','5.2 \\quad $7\\cdot\\dfrac{y-3}{6}-\\dfrac{6y+6}{9}=\\dfrac{1}{3}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $x+x+0{,}18=0{,}2x\\Rightarrow2x+0{,}18=0{,}2x\\Rightarrow1{,}8x=-0{,}18\\Rightarrow x=-0{,}1$.','5.2: vynásobíme $18$: $21(y-3)-2(6y+6)=6\\Rightarrow21y-63-12y-12=6\\Rightarrow9y=81\\Rightarrow y=9$.'},
  '5.1: $x=-0{,}1$; 5.2: $y=9$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 6',
  new List<String>{'Stejné činky jsou baleny po $6$ kusech do stejných krabic. V obchodě se sportovními potřebami mají čtyři krabice s činkami, dvě z těchto krabic jsou plné, dvě poloprázdné a vše dohromady váží $47\\ \\mathrm{kg}$. V každé poloprázdné krabici zůstaly jen $3$ činky. Obě poloprázdné krabice s činkami váží celkem $16\\ \\mathrm{kg}$.','Vypočtěte, kolik kilogramů váží','6.1 jedna plná krabice s činkami,','6.2 jedna činka,','6.3 jedna prázdná krabice.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hmotnost prázdné krabice $b$ a jedné činky $c$. Plná krabice váží $b+6c$, poloprázdná $b+3c$.','Obě poloprázdné: $2(b+3c)=16\\Rightarrow b+3c=8$. Vše dohromady: $2(b+6c)+2(b+3c)=47\\Rightarrow4b+18c=47$.','Z $b=8-3c$: $4(8-3c)+18c=47\\Rightarrow32+6c=47\\Rightarrow c=2{,}5$; $b=8-7{,}5=0{,}5$. Plná: $b+6c=0{,}5+15=15{,}5$.'},
  '6.1: $15{,}5\\ \\mathrm{kg}$; 6.2: $2{,}5\\ \\mathrm{kg}$; 6.3: $0{,}5\\ \\mathrm{kg}$',
  3, 6, '3',
  new List<String>{'zs2','r9','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD22C0T04', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
