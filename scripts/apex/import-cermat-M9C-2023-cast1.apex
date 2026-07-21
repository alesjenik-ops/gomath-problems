String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 1',
  new List<String>{'Vypočtěte, kolikrát je součet čísel $0{,}2$ a $0{,}5$ větší než jejich součin.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Součet $0{,}2+0{,}5=0{,}7$; součin $0{,}2\\cdot0{,}5=0{,}1$; $\\frac{0{,}7}{0{,}1}=7$.'},
  '$7$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $4+6:2-5\\cdot(-3+5)=$','2.2 \\quad $\\sqrt{1{,}3^2-1{,}2^2}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $4+3-5\\cdot2=4+3-10=-3$.','2.2: $\\sqrt{1{,}69-1{,}44}=\\sqrt{0{,}25}=0{,}5$.'},
  '2.1: $-3$; 2.2: $0{,}5$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $3\\cdot\\dfrac{2}{7}-\\dfrac{2}{7}=$','3.2 \\quad $1-\\dfrac{14}{5}:2=$','3.3 \\quad $\\dfrac{\\frac{3}{4}+\\frac{4}{3}}{\\frac{5}{7}\\cdot\\frac{14}{3}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{6}{7}-\\frac{2}{7}=\\frac{4}{7}$.','3.2: $1-\\frac{14}{10}=1-\\frac{7}{5}=-\\frac{2}{5}$.','3.3: čitatel $\\frac{3}{4}+\\frac{4}{3}=\\frac{9+16}{12}=\\frac{25}{12}$; jmenovatel $\\frac{5}{7}\\cdot\\frac{14}{3}=\\frac{10}{3}$; $\\frac{25}{12}:\\frac{10}{3}=\\frac{25}{12}\\cdot\\frac{3}{10}=\\frac{5}{8}$.'},
  '3.1: $\\frac{4}{7}$; 3.2: $-\\frac{2}{5}$; 3.3: $\\frac{5}{8}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 4',
  new List<String>{'4.1 Rozložte na součin podle vzorce: $4a^2-9=$','4.2 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x-1)\\cdot\\dfrac{1}{2}-x=$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-3)^2-4n\\cdot(4n-3)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(2a+3)\\cdot(2a-3)$.','4.2: $x-\\frac{1}{2}-x=-\\frac{1}{2}$.','4.3: vytkneme $(4n-3)$: $(4n-3)\\cdot[(4n-3)-4n]=(4n-3)\\cdot(-3)=-12n+9$.'},
  '4.1: $(2a+3)(2a-3)$; 4.2: $-\\frac{1}{2}$; 4.3: $-12n+9$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $0{,}3\\cdot(2x+1)=0{,}2x-0{,}7$','5.2 \\quad $y+\\dfrac{5y}{6}=\\dfrac{2y-1}{4}+\\dfrac{y+1}{2}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}6x+0{,}3=0{,}2x-0{,}7\\Rightarrow0{,}4x=-1\\Rightarrow x=-2{,}5$.','5.2: levá strana $\\frac{6y+5y}{6}=\\frac{11y}{6}$; pravá $\\frac{2y-1}{4}+\\frac{2y+2}{4}=\\frac{4y+1}{4}$; $\\frac{11y}{6}=\\frac{4y+1}{4}\\Rightarrow44y=6(4y+1)\\Rightarrow20y=6\\Rightarrow y=0{,}3$.'},
  '5.1: $x=-2{,}5$; 5.2: $y=0{,}3$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 6',
  new List<String>{'Vítek, Rudolf a Ondra jeli společně autem k moři. Každý z nich odřídil část trasy. Vítek odřídil třetinu celé trasy, Rudolf odřídil o $60\\ \\mathrm{km}$ méně než Vítek a Ondra odřídil zbývající dvě pětiny celé trasy. Celá trasa měřila $x\\ \\mathrm{km}$.','6.1 Vyjádřete výrazem s proměnnou $x$, kolik km trasy odřídil Rudolf.','6.2 Vypočtěte, kolik km měřila celá trasa.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: Rudolf $=\\frac{x}{3}-60$ (ekvivalentně $\\frac{4}{15}x$, neboť $x-\\frac{x}{3}-\\frac{2x}{5}=\\frac{4}{15}x$).','6.2: $\\frac{x}{3}-60=\\frac{4}{15}x\\Rightarrow\\frac{5x}{15}-\\frac{4x}{15}=60\\Rightarrow\\frac{x}{15}=60\\Rightarrow x=900$.'},
  '6.1: $\\frac{x}{3}-60$ (resp. $\\frac{4}{15}x$); 6.2: $900\\ \\mathrm{km}$',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
