String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)';
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
  'CERMAT 2022 M9B · úloha 1',
  new List<String>{'Vypočtěte:','$(-6)^2-3\\cdot(-3)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$(-6)^2=36$, $-3\\cdot(-3)=9$; celkem $36+9=45$.'},
  '$45$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 2',
  new List<String>{'Body $A$, $B$, $C$ a $D$ představují čtyři čísla na číselné ose. Bod $B$ dělí (zleva) úsečku $AC$ v poměru $7:3$. Na ose jsou vyznačeny hodnoty: bod $B$ odpovídá číslu $10$, bod $C$ číslu $22$ a bod $D$ číslu $52$.','2.1 Určete, v jakém poměru dělí bod $C$ (zleva) úsečku $BD$. Poměr zapište v základním tvaru.','2.2 Určete číslo, které na číselné ose představuje bod $A$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $|BC|=22-10=12$, $|CD|=52-22=30$; poměr $12:30=2:5$.','2.2: $B$ dělí $AC$ v poměru $|AB|:|BC|=7:3$, přičemž $|BC|=12$, tedy $|AB|=\\frac{7}{3}\\cdot12=28$. Bod $A=10-28=-18$.'},
  '2.1: $2:5$; 2.2: $-18$',
  2, 4, '3',
  new List<String>{'zs2','r9','pomer','aritmetika','vypocet','cisla','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{7}{5}\\cdot\\dfrac{3}{8}\\cdot\\dfrac{10}{21}+\\dfrac{3}{10}=$','3.2 \\quad $\\dfrac{\\frac{1}{4}-\\frac{5}{8}}{3\\cdot\\frac{5}{12}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{7}{5}\\cdot\\frac{3}{8}\\cdot\\frac{10}{21}=\\frac{7\\cdot3\\cdot10}{5\\cdot8\\cdot21}=\\frac{210}{840}=\\frac{1}{4}$; poté $\\frac{1}{4}+\\frac{3}{10}=\\frac{5}{20}+\\frac{6}{20}=\\frac{11}{20}$.','3.2: čitatel $\\frac{1}{4}-\\frac{5}{8}=\\frac{2}{8}-\\frac{5}{8}=-\\frac{3}{8}$; jmenovatel $3\\cdot\\frac{5}{12}=\\frac{15}{12}=\\frac{5}{4}$; $-\\frac{3}{8}:\\frac{5}{4}=-\\frac{3}{8}\\cdot\\frac{4}{5}=-\\frac{12}{40}=-\\frac{3}{10}$.'},
  '3.1: $\\frac{11}{20}$; 3.2: $-\\frac{3}{10}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 4',
  new List<String>{'4.1 Upravte a rozložte na součin vytknutím: $x\\cdot x-x+2x^2=$','4.2 Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5b-0{,}4a)^2=$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n-3)\\cdot(4n-2)+(n-3)\\cdot(n+3)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $x\\cdot x-x+2x^2=x^2+2x^2-x=3x^2-x=x\\cdot(3x-1)$.','4.2: $(5b-0{,}4a)^2=(5b)^2-2\\cdot5b\\cdot0{,}4a+(0{,}4a)^2=25b^2-4ab+0{,}16a^2$.','4.3: $(2n-3)(4n-2)=8n^2-16n+6$; $(n-3)(n+3)=n^2-9$; součet $9n^2-16n-3$.'},
  '4.1: $x\\cdot(3x-1)$; 4.2: $25b^2-4ab+0{,}16a^2$; 4.3: $9n^2-16n-3$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $5\\cdot(0{,}2x+1)=(8-6x):2$','5.2 \\quad $\\dfrac{y-5}{2}+\\dfrac{3-y}{6}=1-\\dfrac{2y}{3}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $x+5=4-3x\\Rightarrow4x=-1\\Rightarrow x=-\\frac{1}{4}$.','5.2: vynásobíme $6$: $3(y-5)+(3-y)=6-4y\\Rightarrow3y-15+3-y=6-4y\\Rightarrow2y-12=6-4y\\Rightarrow6y=18\\Rightarrow y=3$.'},
  '5.1: $x=-\\frac{1}{4}$; 5.2: $y=3$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 6',
  new List<String>{'V krabici jsou pouze jednobarevné kuličky, a to zelené, červené a modré. Čtvrtina všech kuliček je zelených, šestina všech kuliček je červených, modrých kuliček je o $20$ více než červených.','6.1 Vypočtěte, kolik kuliček je v krabici.','6.2 Vypočtěte, o kolik se liší počty zelených a červených kuliček v krabici.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet všech kuliček $n$. Zelených $\\frac{n}{4}$, červených $\\frac{n}{6}$, modrých $\\frac{n}{6}+20$. Součet: $\\frac{n}{4}+\\frac{n}{6}+\\frac{n}{6}+20=n$.','Vynásobíme $12$: $3n+2n+2n+240=12n\\Rightarrow7n+240=12n\\Rightarrow5n=240\\Rightarrow n=48$.','6.1: v krabici je $48$ kuliček.','6.2: zelených $\\frac{48}{4}=12$, červených $\\frac{48}{6}=8$; liší se o $12-8=4$.'},
  '6.1: $48$ kuliček; 6.2: o $4$ kuličky',
  3, 4, '3',
  new List<String>{'zs2','r9','zlomky','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD22C0T02', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
