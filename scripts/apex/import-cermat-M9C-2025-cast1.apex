String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
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
  'CERMAT 2025 M9C · úloha 1',
  new List<String>{'Určete, kolikrát více je $5$ kilogramů než $0{,}25$ gramů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$5\\ \\mathrm{kg}=5\\,000\\ \\mathrm{g}$; $5\\,000:0{,}25=20\\,000$.'},
  '$20\\,000$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','desetinna-cisla','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 2',
  new List<String>{'Druhá mocnina neznámého prvočísla je o $3$ menší než jiné prvočíslo. Určete větší z obou prvočísel.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Hledáme prvočíslo $p$ tak, aby $p^2+3$ bylo také prvočíslo. Pro $p=2$: $2^2+3=7$ je prvočíslo.','Větší z prvočísel je $7$.'},
  '$7$',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\sqrt{10^2-19}}{\\sqrt{10^2}}=$','3.2 \\quad $\\dfrac{\\left(\\dfrac{3}{5}\\right)^2}{\\dfrac{27}{34}\\cdot\\left(\\dfrac{2}{3}-\\dfrac{3^2}{5}\\right)}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{\\sqrt{81}}{\\sqrt{100}}=\\frac{9}{10}$.','3.2: čitatel $\\frac{9}{25}$; jmenovatel $\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{9}{5}\\right)=\\frac{27}{34}\\cdot\\left(-\\frac{17}{15}\\right)=-\\frac{9}{10}$; $\\frac{9}{25}:\\left(-\\frac{9}{10}\\right)=-\\frac{2}{5}$.'},
  '3.1: $\\frac{9}{10}$; 3.2: $-\\frac{2}{5}$',
  3, 5, '3',
  new List<String>{'zs2','r9','zlomky','mocniny-odmocniny','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 4',
  new List<String>{'4.1 Upravte a umocněte (výsledný výraz nesmí obsahovat závorky): $(4+8a-8)^2=$','4.2 Upravte na co nejjednodušší tvar bez závorek: $(2-3x)\\cdot2+(2x)^2-x\\cdot(-6)=$','4.3 Upravte na co nejjednodušší tvar bez závorek: $(1-2n)\\cdot(1-2n+4n)-2n\\cdot(1-3n)+(3n-1)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(8a-4)^2=64a^2-64a+16$.','4.2: $4-6x+4x^2+6x=4x^2+4$.','4.3: $(1-2n)(1+2n)-2n+6n^2+3n-1=(1-4n^2)+6n^2+n-1=2n^2+n$.'},
  '4.1: $64a^2-64a+16$; 4.2: $4x^2+4$; 4.3: $2n^2+n$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $5x+\\dfrac{2}{15}+\\dfrac{1}{15}x=\\dfrac{2}{3}x-\\dfrac{3}{5}$','5.2 \\quad $4-\\dfrac{7-3y}{5}=3+\\dfrac{7y-4}{10}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: vynásobením $15$: $75x+2+x=10x-9\\Rightarrow 76x+2=10x-9\\Rightarrow 66x=-11\\Rightarrow x=-\\frac{1}{6}$.','5.2: vynásobením $10$: $40-2(7-3y)=30+(7y-4)\\Rightarrow 26+6y=26+7y\\Rightarrow y=0$.'},
  '5.1: $x=-\\frac{1}{6}$; 5.2: $y=0$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 6',
  new List<String>{'Do ložnice jsme přikoupili postel, noční stolek a skříň. Noční stolek byl o polovinu levnější než skříň, ale o třetinu dražší než postel. Cenu nočního stolku označíme $n$.','6.1 Vyjádřete výrazem s proměnnou $n$ cenu skříně.','6.2 Vyjádřete výrazem s proměnnou $n$ cenu postele.','6.3 Za všechny tři kusy nábytku jsme zaplatili $9\\,000$ korun. Vypočtěte, kolik korun stál noční stolek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: stolek je o polovinu levnější než skříň, tedy skříň $=2n$.','6.2: stolek je o třetinu dražší než postel, tedy $n=\\frac{4}{3}\\cdot$postel, postel $=\\frac{3}{4}n$.','6.3: $n+2n+\\frac{3}{4}n=\\frac{15}{4}n=9\\,000\\Rightarrow n=2\\,400$ korun.'},
  '6.1: $2n$; 6.2: $\\frac{3}{4}n$; 6.3: $2\\,400$ korun',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 7',
  new List<String>{'Cyklista jel část trasy po rovině, část klesal a zbytek stoupal. Po rovině ujel třetinu délky trasy rychlostí $30\\ \\mathrm{km/h}$. Klesání bylo pětkrát kratší než celá trasa, rychlost při něm o $40\\ \\%$ vyšší než po rovině. Stoupání bylo na $14\\ \\mathrm{km}$ trasy, rychlost o polovinu nižší než při klesání.','7.1 Vypočtěte v $\\mathrm{km/h}$ průměrnou rychlost při klesání.','7.2 Vypočtěte v km délku celé trasy.','7.3 Vypočtěte v minutách, jak dlouho cyklista stoupal.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: $30\\cdot1{,}4=42\\ \\mathrm{km/h}$.','7.2: délka $L$: $\\frac{L}{3}+\\frac{L}{5}+14=L\\Rightarrow \\frac{7}{15}L=14\\Rightarrow L=30\\ \\mathrm{km}$.','7.3: rychlost při stoupání $\\frac{42}{2}=21\\ \\mathrm{km/h}$; čas $\\frac{14}{21}\\ \\mathrm{h}=\\frac{2}{3}\\ \\mathrm{h}=40$ minut.'},
  '7.1: $42\\ \\mathrm{km/h}$; 7.2: $30\\ \\mathrm{km}$; 7.3: $40$ minut',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
