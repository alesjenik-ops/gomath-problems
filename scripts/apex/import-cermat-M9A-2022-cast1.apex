String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 1. řádný termín (M9A)';
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
  'CERMAT 2022 M9A · úloha 1',
  new List<String>{'Vypočtěte:','$\\dfrac{7^2-\\sqrt{7^2}}{\\sqrt{49}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{7^2}=7$, $\\sqrt{49}=7$; čitatel $49-7=42$; $\\dfrac{42}{7}=6$.'},
  '$6$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 2',
  new List<String>{'2.1 \\quad Obdélník má šířku $8\\ \\mathrm{cm}$ a obsah $4\\ \\mathrm{dm}^2$. Vypočtěte, o kolik cm se liší délka a šířka obdélníku.','2.2 \\quad Vypočtěte, kolikrát větší je objem $1{,}2\\ \\mathrm{dm}^3$ než objem $300\\ \\mathrm{mm}^3$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $4\\ \\mathrm{dm}^2=400\\ \\mathrm{cm}^2$; délka $=400:8=50\\ \\mathrm{cm}$; rozdíl $50-8=42\\ \\mathrm{cm}$.','2.2: $1{,}2\\ \\mathrm{dm}^3=1\\,200\\,000\\ \\mathrm{mm}^3$; $1\\,200\\,000:300=4\\,000$.'},
  '2.1: o $42\\ \\mathrm{cm}$; 2.2: $4\\,000$krát',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{8}{5}\\cdot\\left(\\dfrac{5}{6}\\cdot\\dfrac{7}{10}-\\dfrac{5}{6}\\right)=$','3.2 \\quad $\\dfrac{\\left(\\frac{4}{5}-\\frac{2}{3}\\right)\\cdot\\frac{5}{8}}{\\frac{2}{3}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{5}{6}\\cdot\\frac{7}{10}=\\frac{7}{12}$; $\\frac{7}{12}-\\frac{5}{6}=\\frac{7}{12}-\\frac{10}{12}=-\\frac{3}{12}=-\\frac{1}{4}$; $\\frac{8}{5}\\cdot\\left(-\\frac{1}{4}\\right)=-\\frac{8}{20}=-\\frac{2}{5}$.','3.2: $\\frac{4}{5}-\\frac{2}{3}=\\frac{12-10}{15}=\\frac{2}{15}$; $\\frac{2}{15}\\cdot\\frac{5}{8}=\\frac{10}{120}=\\frac{1}{12}$; $\\frac{1}{12}:\\frac{2}{3}=\\frac{1}{12}\\cdot\\frac{3}{2}=\\frac{3}{24}=\\frac{1}{8}$.'},
  '3.1: $-\\frac{2}{5}$; 3.2: $\\frac{1}{8}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 4',
  new List<String>{'4.1 \\quad Z daného výrazu vytkněte $3y$: $\\ 3y^2-9y+6xy=$','4.2 \\quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\\ \\left(x+\\dfrac{3}{2}\\right)^2=$','4.3 \\quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $\\ (4+3n)\\cdot(3n-2n)-(n-1)\\cdot5n=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $3y\\cdot(y-3+2x)$.','4.2: $\\left(x+\\frac{3}{2}\\right)^2=x^2+2\\cdot x\\cdot\\frac{3}{2}+\\frac{9}{4}=x^2+3x+\\frac{9}{4}$.','4.3: $3n-2n=n$; $(4+3n)\\cdot n=4n+3n^2$; $(n-1)\\cdot5n=5n^2-5n$; $4n+3n^2-(5n^2-5n)=-2n^2+9n$.'},
  '4.1: $3y\\cdot(y-3+2x)$; 4.2: $x^2+3x+\\frac{9}{4}$; 4.3: $-2n^2+9n$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $5\\cdot0{,}4-3x:2=0{,}5x+7$','5.2 \\quad $\\dfrac{3-y}{3}+\\dfrac{3}{5}\\cdot(y+1)+\\dfrac{y}{3}=y$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $2-1{,}5x=0{,}5x+7\\Rightarrow2-7=0{,}5x+1{,}5x\\Rightarrow-5=2x\\Rightarrow x=-2{,}5$.','5.2: vynásobíme $15$: $5(3-y)+9(y+1)+5y=15y\\Rightarrow15-5y+9y+9+5y=15y\\Rightarrow24+9y=15y\\Rightarrow24=6y\\Rightarrow y=4$.'},
  '5.1: $x=-2{,}5$; 5.2: $y=4$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD22C0T01', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
