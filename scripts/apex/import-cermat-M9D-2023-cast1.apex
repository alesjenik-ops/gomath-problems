String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 1',
  new List<String>{'Hmotnosti dvou závaží jsou v poměru $3:5$ a liší se o $600\\ \\mathrm{g}$.','Vypočtěte v gramech hmotnost lehčího závaží.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl je $5-3=2$ díly $=600\\ \\mathrm{g}$, tedy $1$ díl $=300\\ \\mathrm{g}$; lehčí závaží má $3$ díly $=900\\ \\mathrm{g}$.'},
  '$900\\ \\mathrm{g}$',
  1, 2, '2',
  new List<String>{'zs2','r9','pomer','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 2',
  new List<String>{'Na číselné ose je vyznačeno $13$ bodů, které oddělují $12$ stejných dílků. V jednom z těchto bodů je číslo $20$ a body A, B, C představují tři kladná čísla (viz obrázek). Číslo v bodě C je součtem čísla v bodě A a čísla v bodě B.','Určete číslo v bodě 2.1 C, 2.2 B.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 70"><path d="M4 65L5 65L5 66L4 66Z" style="fill:#000000"/><path d="M4 65L5 65L5 66L4 66Z" style="fill:#000000"/><path d="M5 65L467 65L467 66L5 66Z" style="fill:#000000"/><path d="M4 4L5 4L5 65L4 65Z" style="fill:#000000"/><path d="M16 33L261 33C261 33 262 34 262 34C262 34 261 35 261 35L16 35C16 35 16 34 16 34C16 34 16 33 16 33M260 31L266 34L260 37L260 31Z" style="fill:#000000"/><path d="M28 30L28 38M46 30L46 38M65 30L65 38M83 30L83 38M101 30L101 38M120 30L120 38M138 30L138 38M157 30L157 38M175 30L175 38M194 30L194 38M212 30L212 38M230 30L230 38M249 30L249 38" style="fill:none;stroke:#000000;stroke-width:2"/><text x="158" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20</text><text x="120" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="194" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="249" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'Číselná osa se 13 body oddělujícími 12 stejných dílků; v jednom bodě je číslo 20 a jsou vyznačeny body A, B, C.',
  '',
  new List<String>{'Označme délku dílku $d$. Z obrázku: A leží $2$ dílky vlevo od $20$ ($A=20-2d$), B leží $2$ dílky vpravo ($B=20+2d$), C leží $5$ dílků vpravo ($C=20+5d$).','Podmínka $C=A+B$: $20+5d=(20-2d)+(20+2d)=40\\Rightarrow5d=20\\Rightarrow d=4$.','Tedy $C=20+5\\cdot4=40$ a $B=20+2\\cdot4=28$ (a $A=12$).'},
  '2.1: C $=40$; 2.2: B $=28$',
  2, 3, '3',
  new List<String>{'zs2','r9','cisla','aritmetika','uvazovani','bez-kalkulacky'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\frac{2}{3}-1}{\\frac{8}{9}}=$','3.2 \\quad $2\\cdot\\dfrac{1}{6}-\\dfrac{3}{8}\\cdot4=$','3.3 \\quad $\\dfrac{\\frac{6}{7}-\\frac{9}{14}}{\\frac{8}{7}+\\frac{6}{7}:\\frac{3}{2}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{\\frac{2}{3}-1}{\\frac{8}{9}}=\\frac{-\\frac{1}{3}}{\\frac{8}{9}}=-\\frac{1}{3}\\cdot\\frac{9}{8}=-\\frac{3}{8}$.','3.2: $\\frac{1}{3}-\\frac{3}{2}=\\frac{2}{6}-\\frac{9}{6}=-\\frac{7}{6}$.','3.3: čitatel $\\frac{12}{14}-\\frac{9}{14}=\\frac{3}{14}$; jmenovatel $\\frac{8}{7}+\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{8}{7}+\\frac{4}{7}=\\frac{12}{7}$; $\\frac{3}{14}:\\frac{12}{7}=\\frac{3}{14}\\cdot\\frac{7}{12}=\\frac{1}{8}$.'},
  '3.1: $-\\frac{3}{8}$; 3.2: $-\\frac{7}{6}$; 3.3: $\\frac{1}{8}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 4',
  new List<String>{'4.1 Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(0{,}3x+0{,}5)^2=$','4.2 Rozložte na součin podle vzorce: $49-(-4a)^2=$','4.3 Zjednodušte (výsledný výraz nesmí obsahovat závorky): $n\\cdot(2n-1)-(-2n-n)\\cdot(3n+2)+(1-2n)\\cdot(1+2n)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $0{,}09x^2+0{,}3x+0{,}25$.','4.2: $49-16a^2=(7+4a)\\cdot(7-4a)$.','4.3: $2n^2-n-(-3n)(3n+2)+(1-4n^2)=2n^2-n+9n^2+6n+1-4n^2=7n^2+5n+1$.'},
  '4.1: $0{,}09x^2+0{,}3x+0{,}25$; 4.2: $(7+4a)(7-4a)$; 4.3: $7n^2+5n+1$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $\\dfrac{2-x}{2}+2x=2{,}5x-3$','5.2 \\quad $3\\cdot\\dfrac{y+1}{2}-\\dfrac{y}{3}=\\dfrac{3}{2}\\cdot\\dfrac{2y-3}{3}+\\dfrac{3}{2}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: vynásobíme $2$: $(2-x)+4x=5x-6\\Rightarrow2+3x=5x-6\\Rightarrow8=2x\\Rightarrow x=4$.','5.2: levá strana $\\frac{9(y+1)-2y}{6}=\\frac{7y+9}{6}$; pravá $\\frac{2y-3}{2}+\\frac{3}{2}=\\frac{2y}{2}=y$; $\\frac{7y+9}{6}=y\\Rightarrow7y+9=6y\\Rightarrow y=-9$.'},
  '5.1: $x=4$; 5.2: $y=-9$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
