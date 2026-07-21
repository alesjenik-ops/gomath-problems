String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)';
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
  'CERMAT 2019 M9A · úloha 1',
  new List<String>{'Vypočtěte tři pětiny z dvojnásobku čísla $15$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Dvojnásobek čísla $15$ je $30$; tři pětiny z $30$ jsou $\\frac{3}{5}\\cdot30=18$.'},
  '$18$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','zlomky','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','2.1 \\quad $11$ hodin $17$ minut $-$ $9$ hodin $45$ minut $=\\square$ minut','2.2 \\quad $28\\ \\mathrm{m}^2-\\square\\ \\mathrm{dm}^2=2\\,300\\ \\mathrm{dm}^2+2\\,300\\ \\mathrm{cm}^2$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $11$ h $17$ min $-\\,9$ h $45$ min $=1$ h $32$ min $=92$ minut.','2.2: $28\\ \\mathrm{m}^2=2\\,800\\ \\mathrm{dm}^2$ a $2\\,300\\ \\mathrm{cm}^2=23\\ \\mathrm{dm}^2$; tedy $2\\,800-\\square=2\\,300+23=2\\,323$, odkud $\\square=477$.'},
  '2.1: $92$; 2.2: $477$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $(6-4)\\cdot\\dfrac{11}{8}+\\dfrac{9}{14}\\cdot\\dfrac{7}{6}=$','3.2 \\quad $\\dfrac{\\frac{2\\cdot3}{6}-\\frac{4}{2\\cdot3}}{\\frac{2+3}{6}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $2\\cdot\\frac{11}{8}+\\frac{9\\cdot7}{14\\cdot6}=\\frac{11}{4}+\\frac{63}{84}=\\frac{11}{4}+\\frac{3}{4}=\\frac{14}{4}=\\frac{7}{2}$.','3.2: čitatel $\\frac{6}{6}-\\frac{4}{6}=1-\\frac{2}{3}=\\frac{1}{3}$; jmenovatel $\\frac{5}{6}$; $\\frac{1}{3}:\\frac{5}{6}=\\frac{1}{3}\\cdot\\frac{6}{5}=\\frac{2}{5}$.'},
  '3.1: $\\frac{7}{2}$; 3.2: $\\frac{2}{5}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $(3a-2)\\cdot(-2a)=$','4.2 \\quad $(3x-4)^2=$','4.3 \\quad $(2+n)\\cdot(3n-3)+(3n-n)\\cdot2-n\\cdot(3-5)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(3a-2)\\cdot(-2a)=-6a^2+4a$.','4.2: $(3x-4)^2=9x^2-24x+16$.','4.3: $(2+n)(3n-3)=3n^2+3n-6$; $(3n-n)\\cdot2=4n$; $-n\\cdot(3-5)=2n$; součet $3n^2+3n-6+4n+2n=3n^2+9n-6$.'},
  '4.1: $-6a^2+4a$; 4.2: $9x^2-24x+16$; 4.3: $3n^2+9n-6$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $0{,}6x-\\dfrac{1}{2}=1{,}4x+1{,}5$','5.2 \\quad $\\dfrac{3-2y}{3}=\\dfrac{1-2y}{4}+\\dfrac{y+3}{6}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}6x-0{,}5=1{,}4x+1{,}5\\Rightarrow-0{,}8x=2\\Rightarrow x=-2{,}5$.','5.2: rovnici vynásobíme $12$: $4(3-2y)=3(1-2y)+2(y+3)\\Rightarrow12-8y=3-6y+2y+6\\Rightarrow12-8y=9-4y\\Rightarrow3=4y\\Rightarrow y=0{,}75$.'},
  '5.1: $x=-2{,}5$; 5.2: $y=0{,}75$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9A · úloha 6',
  new List<String>{'Všichni chlapci atletického oddílu se seřadili do zástupu podle velikosti. Před Petrem stála jedna osmina celkového počtu chlapců. Hned za Petrem stál jeho bratr Radek a za Radkem ještě pět šestin celkového počtu chlapců. Neznámý celkový počet chlapců atletického oddílu označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli před Petrem.','6.2 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli za Petrem.','6.3 Vypočtěte celkový počet chlapců atletického oddílu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: před Petrem stála osmina, tj. $\\frac{x}{8}$ chlapců.','6.2: za Petrem stál Radek ($1$) a pět šestin, tj. $\\frac{5x}{6}+1$ chlapců.','6.3: $x=\\frac{x}{8}+1+\\left(\\frac{5x}{6}+1\\right)\\Rightarrow x-\\frac{x}{8}-\\frac{5x}{6}=2\\Rightarrow\\frac{24x-3x-20x}{24}=2\\Rightarrow\\frac{x}{24}=2\\Rightarrow x=48$.'},
  '6.1: $\\frac{x}{8}$; 6.2: $\\frac{5x}{6}+1$; 6.3: $48$ chlapců',
  4, 6, '4',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
