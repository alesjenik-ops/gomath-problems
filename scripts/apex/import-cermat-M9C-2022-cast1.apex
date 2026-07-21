String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)';
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
  'CERMAT 2022 M9C · úloha 1',
  new List<String>{'Vypočtěte:','$\\dfrac{10^2\\cdot(10^2-1)}{10\\cdot10^2+10^2}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{100\\cdot99}{1000+100}=\\dfrac{9900}{1100}=9$.'},
  '$9$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 2',
  new List<String>{'2.1 \\quad Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na $12$ stejně dlouhých dílů. Určete, kolik centimetrů měří jeden díl.','2.2 \\quad Vypočtěte, kolik minut jsou tři pětiny z $1$ hodiny $50$ minut.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: kabel má $510\\ \\mathrm{cm}$; po odříznutí tří půlmetrových kusů zbývá $510-3\\cdot50=360\\ \\mathrm{cm}$; jeden díl $360:12=30\\ \\mathrm{cm}$.','2.2: $1$ hodina $50$ minut $=110\\ \\mathrm{min}$; $\\frac{3}{5}\\cdot110=66\\ \\mathrm{min}$.'},
  '2.1: $30\\ \\mathrm{cm}$; 2.2: $66\\ \\mathrm{min}$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{1}{3}\\cdot\\left(5-\\dfrac{13}{5}\\right):20=$','3.2 \\quad $\\dfrac{\\frac{2}{3}-\\frac{3}{2}}{\\frac{2}{3}:\\frac{3}{2}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $5-\\frac{13}{5}=\\frac{25-13}{5}=\\frac{12}{5}$; $\\frac{1}{3}\\cdot\\frac{12}{5}=\\frac{4}{5}$; $\\frac{4}{5}:20=\\frac{4}{5}\\cdot\\frac{1}{20}=\\frac{4}{100}=\\frac{1}{25}$.','3.2: čitatel $\\frac{2}{3}-\\frac{3}{2}=\\frac{4-9}{6}=-\\frac{5}{6}$; jmenovatel $\\frac{2}{3}:\\frac{3}{2}=\\frac{2}{3}\\cdot\\frac{2}{3}=\\frac{4}{9}$; $-\\frac{5}{6}:\\frac{4}{9}=-\\frac{5}{6}\\cdot\\frac{9}{4}=-\\frac{45}{24}=-\\frac{15}{8}$.'},
  '3.1: $\\frac{1}{25}$; 3.2: $-\\frac{15}{8}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 4',
  new List<String>{'4.1 \\quad Upravte a rozložte na součin vytknutím: $(4+x)\\cdot x+2x^2=$','4.2 \\quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(y-3y)\\cdot(y+3y)=$','4.3 \\quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(-n-1)^2+(1+4n)\\cdot(1+4n)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(4+x)\\cdot x+2x^2=4x+x^2+2x^2=3x^2+4x=x\\cdot(4+3x)$.','4.2: $(y-3y)\\cdot(y+3y)=(-2y)\\cdot(4y)=-8y^2$.','4.3: $(-n-1)^2=n^2+2n+1$; $(1+4n)^2=16n^2+8n+1$; součet $=17n^2+10n+2$.'},
  '4.1: $x\\cdot(4+3x)$; 4.2: $-8y^2$; 4.3: $17n^2+10n+2$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $3\\cdot(2x-1)+\\dfrac{2}{3}=\\dfrac{2}{3}-(x+3)$','5.2 \\quad $\\dfrac{y+1}{6}-\\dfrac{3y}{2}=2+\\dfrac{0{,}5-y}{3}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $6x-3+\\frac{2}{3}=\\frac{2}{3}-x-3$; po odečtení $\\frac{2}{3}$: $6x-3=-x-3$; $7x=0$; $x=0$.','5.2: vynásobíme $6$: $(y+1)-9y=12+2\\cdot(0{,}5-y)$; $-8y+1=13-2y$; $-6y=12$; $y=-2$.'},
  '5.1: $x=0$; 5.2: $y=-2$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 6',
  new List<String>{'V hruškovém království získal každý princ tolik zlatých hrušek, kolik si zasloužil. Druhý princ získal o třetinu více hrušek než první princ a třetí princ o $12$ hrušek více než první princ. Počet zlatých hrušek, které získal první princ, označíme $x$.','6.1 \\quad Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal druhý princ.','6.2 \\quad Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal třetí princ.','6.3 \\quad První a třetí princ získali dohromady dvakrát více hrušek než druhý princ. Vypočtěte, kolik hrušek získal první princ.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: druhý princ $=x+\\frac{x}{3}=\\frac{4}{3}x$.','6.2: třetí princ $=x+12$.','6.3: $x+(x+12)=2\\cdot\\frac{4}{3}x$; $2x+12=\\frac{8}{3}x$; vynásobíme $3$: $6x+36=8x$; $2x=36$; $x=18$.'},
  '6.1: $\\frac{4}{3}x$; 6.2: $x+12$; 6.3: $18$ hrušek',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD22C0T03', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
