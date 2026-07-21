String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 1',
  new List<String>{'Filip se učil házet oštěpem. Délka jeho prvního hodu byla $7\\ \\mathrm{m}$. Každý další hod byl o desetinu delší než předchozí hod.','Vypočtěte, o kolik cm byl Filipův třetí hod delší než první.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Druhý hod: $7\\cdot1{,}1=7{,}7\\ \\mathrm{m}$; třetí hod: $7{,}7\\cdot1{,}1=8{,}47\\ \\mathrm{m}$.','Rozdíl: $8{,}47-7=1{,}47\\ \\mathrm{m}=147\\ \\mathrm{cm}$.'},
  'o $147\\ \\mathrm{cm}$',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','desetinna-cisla','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $0{,}5\\cdot(-0{,}04)-100\\cdot0{,}02=$','2.2 \\quad $\\left(\\dfrac{18}{14}\\cdot\\dfrac{7}{6}-1\\right):6=$ (výsledek zlomkem v základním tvaru)','2.3 \\quad $\\left(\\dfrac{7}{2}-\\dfrac{1}{6}\\right):\\left(12-6\\cdot\\dfrac{3}{4}\\right)=$ (výsledek zlomkem v základním tvaru)'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $-0{,}02-2=-2{,}02$.','2.2: $\\frac{18}{14}\\cdot\\frac{7}{6}=\\frac{3}{2}$; $\\left(\\frac{3}{2}-1\\right):6=\\frac{1}{2}:6=\\frac{1}{12}$.','2.3: $\\frac{7}{2}-\\frac{1}{6}=\\frac{10}{3}$; $12-\\frac{18}{4}=\\frac{15}{2}$; $\\frac{10}{3}:\\frac{15}{2}=\\frac{4}{9}$.'},
  '2.1: $-2{,}02$; 2.2: $\\frac{1}{12}$; 2.3: $\\frac{4}{9}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','desetinna-cisla','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 3',
  new List<String>{'3.1 Vytkněte $(-x)$: $-4x^2-x+8xy=$','3.2 Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $\\dfrac{1}{2}\\cdot(2a+4)^2=$','3.3 Upravte na co nejjednodušší tvar bez závorek: $(2+2n)\\cdot(2-2n)-2\\cdot(n+1)+(4n-n)\\cdot3n=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $-4x^2-x+8xy=(-x)\\cdot(4x-8y+1)$.','3.2: $\\frac{1}{2}(4a^2+16a+16)=2a^2+8a+8$.','3.3: $(4-4n^2)-(2n+2)+9n^2=5n^2-2n+2$.'},
  '3.1: $(-x)(4x-8y+1)$; 3.2: $2a^2+8a+8$; 3.3: $5n^2-2n+2$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 4',
  new List<String>{'Řešte rovnici:','4.1 \\quad $0{,}5\\cdot(3-5x)=0{,}25\\cdot(3x+6)$','4.2 \\quad $\\dfrac{5}{3}\\cdot\\left(y-\\dfrac{3}{2}\\right)+\\dfrac{1}{2}\\cdot y=\\dfrac{5}{9}\\cdot(3y-9)$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $1{,}5-2{,}5x=0{,}75x+1{,}5\\Rightarrow -2{,}5x=0{,}75x\\Rightarrow -3{,}25x=0\\Rightarrow x=0$.','4.2: $\\frac{5}{3}y-\\frac{5}{2}+\\frac{1}{2}y=\\frac{5}{3}y-5\\Rightarrow -\\frac{5}{2}+\\frac{1}{2}y=-5\\Rightarrow \\frac{1}{2}y=-\\frac{5}{2}\\Rightarrow y=-5$.'},
  '4.1: $x=0$; 4.2: $y=-5$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);
c.add(
  'CERMAT 2026 M9D · úloha 5',
  new List<String>{'Na výstavbě kanalizace se podílejí tři firmy: Roura, Trubka a Potrubí. Úsek firmy Roura je dvakrát delší než úsek firmy Trubka. Úsek firmy Potrubí má čtyřikrát menší délku, než mají dohromady úseky obou zbývajících firem. Délku úseku firmy Roura označíme $r$.','5.1 Vyjádřete výrazem s proměnnou $r$ délku úseku firmy Trubka.','5.2 Vyjádřete výrazem s proměnnou $r$ délku úseku firmy Potrubí.','5.3 Firma Potrubí staví úsek o $12\\ \\mathrm{km}$ kratší než firma Trubka. Vypočtěte v km délku úseku firmy Roura.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: Trubka $=\\frac{r}{2}$.','5.2: Potrubí $=\\frac{1}{4}\\left(r+\\frac{r}{2}\\right)=\\frac{3}{8}r$.','5.3: $\\frac{r}{2}-\\frac{3}{8}r=\\frac{r}{8}=12\\Rightarrow r=96\\ \\mathrm{km}$.'},
  '5.1: $\\frac{r}{2}$; 5.2: $\\frac{3}{8}r$; 5.3: $96\\ \\mathrm{km}$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','algebra','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
