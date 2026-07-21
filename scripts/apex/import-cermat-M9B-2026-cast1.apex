String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
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
  'CERMAT 2026 M9B · úloha 1',
  new List<String>{'Vypočtěte, o kolik $\\mathrm{cm}^2$ je plocha o obsahu $0{,}1\\ \\mathrm{m}^2$ větší než plocha o obsahu $20\\ \\mathrm{cm}^2$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}1\\ \\mathrm{m}^2 = 1000\\ \\mathrm{cm}^2$.','$1000 - 20 = 980\\ \\mathrm{cm}^2$.'},
  'o $980\\ \\mathrm{cm}^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem:','2.1 \\quad $3\\cdot\\left(\\dfrac{2}{3}-\\dfrac{7}{9}\\right)+\\dfrac{2}{3}=$','2.2 \\quad $1:\\dfrac{6}{5}-\\dfrac{1}{6}:5=$','2.3 \\quad $\\dfrac{1-\\frac{1}{4}}{2\\cdot\\frac{5}{8}-2}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $3\\cdot\\left(\\frac{6}{9}-\\frac{7}{9}\\right)+\\frac{2}{3}=3\\cdot\\left(-\\frac{1}{9}\\right)+\\frac{2}{3}=-\\frac{1}{3}+\\frac{2}{3}=\\frac{1}{3}$.','2.2: $1:\\frac{6}{5}-\\frac{1}{6}:5=\\frac{5}{6}-\\frac{1}{30}=\\frac{25}{30}-\\frac{1}{30}=\\frac{24}{30}=\\frac{4}{5}$.','2.3: čitatel $1-\\frac{1}{4}=\\frac{3}{4}$, jmenovatel $2\\cdot\\frac{5}{8}-2=\\frac{5}{4}-2=-\\frac{3}{4}$; $\\frac{3}{4}:\\left(-\\frac{3}{4}\\right)=-1$.'},
  '2.1: $\\frac{1}{3}$; 2.2: $\\frac{4}{5}$; 2.3: $-1$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 3',
  new List<String>{'3.1 Upravte na co nejjednodušší tvar bez závorek: $5x-3x\\cdot3-3\\cdot(-2x)=$','3.2 Upravte a rozložte na součin vytknutím: $(a-2b)\\cdot b-b+2b^2=$','3.3 Upravte na co nejjednodušší tvar bez závorek: $(3y+y)\\cdot(y-1)+(1-2y)\\cdot(2y+1)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $5x-9x+6x=2x$.','3.2: $(a-2b)b-b+2b^2=ab-2b^2-b+2b^2=ab-b=b\\cdot(a-1)$.','3.3: $(4y)(y-1)+(1-2y)(2y+1)=4y^2-4y+(1-4y^2)=1-4y$.'},
  '3.1: $2x$; 3.2: $b\\cdot(a-1)$; 3.3: $1-4y$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 4',
  new List<String>{'Řešte rovnici:','4.1 \\quad $\\dfrac{1}{2}\\cdot(3x+4)+5=\\dfrac{1}{2}\\cdot(2-x)$','4.2 \\quad $\\dfrac{6+y}{5}=7-\\dfrac{8+5y}{20}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: vynásobíme $2$: $3x+4+10=2-x\\Rightarrow 3x+14=2-x\\Rightarrow 4x=-12\\Rightarrow x=-3$.','4.2: vynásobíme $20$: $4(6+y)=140-(8+5y)\\Rightarrow 24+4y=132-5y\\Rightarrow 9y=108\\Rightarrow y=12$.'},
  '4.1: $x=-3$; 4.2: $y=12$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 5',
  new List<String>{'František dal do svého salátu obsahujícího $850\\ \\mathrm{g}$ rajčat celkem $255\\ \\mathrm{g}$ cukru. Podle receptu však do salátu patří na každých $250\\ \\mathrm{g}$ rajčat pouze $25\\ \\mathrm{g}$ cukru.','5.1 Vypočtěte, kolik gramů cukru měl dát František podle receptu do svého salátu.','5.2 Vypočtěte, o kolik procent více cukru dal František do svého salátu, než měl dát podle receptu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: na $850\\ \\mathrm{g}$ rajčat je $\\frac{850}{250}\\cdot25=3{,}4\\cdot25=85\\ \\mathrm{g}$ cukru.','5.2: $255:85=3$, tedy dal $300\\ \\%$ doporučeného množství, což je o $200\\ \\%$ více.'},
  '5.1: $85\\ \\mathrm{g}$; 5.2: o $200\\ \\%$ více',
  3, 4, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 6',
  new List<String>{'Na vánočním jarmarku prodávali ve stánku pouze čaj a punč. Čaj prodávali za $40$ korun a cena punče byla o $75\\ \\%$ vyšší než cena čaje.','6.1 Vypočtěte v korunách cenu jednoho punče.','6.2 Počet čajů, které dnes ve stánku prodali, označíme $x$. Vyjádřete výrazem s proměnnou $x$, kolik korun dnes ve stánku utržili za všechny prodané čaje.','6.3 Ve stánku dnes prodali celkem $510$ nápojů a utržili za ně dohromady $29\\,700$ korun. Vypočtěte, kolik čajů prodali dnes ve stánku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: $40\\cdot1{,}75=70$ korun.','6.2: $40x$ korun.','6.3: čajů $x$, punčů $510-x$: $40x+70(510-x)=29\\,700\\Rightarrow -30x=-6000\\Rightarrow x=200$.'},
  '6.1: $70$ korun; 6.2: $40x$; 6.3: $200$ čajů',
  4, 6, '3',
  new List<String>{'zs2','r9','procenta','rovnice','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
