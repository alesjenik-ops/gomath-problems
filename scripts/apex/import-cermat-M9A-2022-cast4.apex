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
  'CERMAT 2022 M9A · úloha 12',
  new List<String>{'V rovině leží čtyři vzájemně různoběžné přímky; tři z nich procházejí bodem A (viz situace níže). Přímka, která bodem A neprochází, protíná dvě z těchto přímek — v horním vrcholu svírá úhel $60^\\circ$ a v pravém vrcholu je vně trojúhelníku vyznačen úhel $132^\\circ$. U bodu A jsou mezi přímkami vyznačeny úhly $\\alpha$ a $3\\alpha$ (spolu s vnitřním úhlem trojúhelníku u vrcholu A tvoří přímý úhel).','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $24^\\circ$','B) $27^\\circ$','C) $32^\\circ$','D) $36^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vnitřní úhel trojúhelníku u pravého vrcholu je $180^\\circ-132^\\circ=48^\\circ$.','Vnitřní úhel trojúhelníku u vrcholu A $=180^\\circ-60^\\circ-48^\\circ=72^\\circ$.','U vrcholu A leží na přímce vedle sebe úhly $\\alpha$, $3\\alpha$ a vnitřní úhel $72^\\circ$, jejich součet je přímý úhel: $\\alpha+3\\alpha+72^\\circ=180^\\circ\\Rightarrow4\\alpha=108^\\circ\\Rightarrow\\alpha=27^\\circ$.'},
  'B) $27^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 13',
  new List<String>{'Papír tvaru kruhu se středem S a poloměrem $10\\ \\mathrm{cm}$ byl rozstříhán na $5$ shodných kruhových výsečí (středový úhel každé výseče je $\\frac{360^\\circ}{5}=72^\\circ$).','Jaký je obvod jedné výseče? Výsledek je zaokrouhlen na celé cm.'},
  new List<String>{'A) menší než $25\\ \\mathrm{cm}$','B) $25\\ \\mathrm{cm}$','C) $30\\ \\mathrm{cm}$','D) $33\\ \\mathrm{cm}$','E) větší než $33\\ \\mathrm{cm}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Obvod výseče tvoří dva poloměry a kruhový oblouk: $o=2r+\\frac{72}{360}\\cdot2\\pi r=2\\cdot10+\\frac{1}{5}\\cdot2\\pi\\cdot10=20+4\\pi$.','$20+4\\pi\\doteq20+12{,}57=32{,}57\\doteq33\\ \\mathrm{cm}$.'},
  'D) $33\\ \\mathrm{cm}$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','vyber','bez-kalkulacky'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 14',
  new List<String>{'V soutěži mohli jednotliví soutěžící dosáhnout výsledků: $0$ bodů, $1$ bod, nebo $2$ body. Graf (kruhový diagram) znázorňuje rozdělení soutěžících podle výsledků. Po $1$ bodu získalo $30$ soutěžících, po $2$ bodech $10\\ \\%$ všech soutěžících. Soutěžících, kteří získali po $1$ bodu, bylo dvakrát více než soutěžících bez bodu.','Jaký je aritmetický průměr výsledků všech soutěžících?'},
  new List<String>{'A) $0{,}8$ bodu','B) $0{,}75$ bodu','C) $0{,}\\overline{6}$ bodu','D) $0{,}6$ bodu','E) jiný průměr'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je celkem $N$ soutěžících. Bez bodu jich je polovina z těch, kdo mají $1$ bod, tedy $15$; s $2$ body je $0{,}1N$. Platí $15+30+0{,}1N=N\\Rightarrow0{,}9N=45\\Rightarrow N=50$.','S $2$ body je $0{,}1\\cdot50=5$ soutěžících. Součet bodů $=0\\cdot15+1\\cdot30+2\\cdot5=40$; průměr $=\\frac{40}{50}=0{,}8$ bodu.'},
  'A) $0{,}8$ bodu',
  2, 4, '4',
  new List<String>{'zs2','r9','grafy','aritmetika','procenta','vypocet','vyber','bezny-zivot'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 15',
  new List<String>{'Ve škole, která má v každém ročníku dvě třídy (A, B), proběhla soutěž ve sběru papíru. V prvním ročníku nasbírala třída 1. A $600\\ \\mathrm{kg}$ a třída 1. B $600\\ \\mathrm{kg}$, celkem tedy $1\\,200\\ \\mathrm{kg}$.','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 \\quad Třída 2. A nasbírala o $25\\ \\%$ méně papíru než třída 1. A. Kolik kg papíru nasbírala třída 2. A?','15.2 \\quad Třída 1. B nasbírala o $20\\ \\%$ více papíru než třída 2. B. Kolik kg papíru nasbírala třída 2. B?','15.3 \\quad Ze všech žáků prvního ročníku nasbíraly dívky o $50\\ \\%$ více papíru než chlapci. Kolik kg papíru nasbírali dohromady chlapci z prvního ročníku?','Nabídka: A) $800\\ \\mathrm{kg}$; B) $720\\ \\mathrm{kg}$; C) $500\\ \\mathrm{kg}$; D) $480\\ \\mathrm{kg}$; E) $450\\ \\mathrm{kg}$; F) jiný počet kg.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $600\\cdot(1-0{,}25)=600\\cdot0{,}75=450\\ \\mathrm{kg}$ — \\textbf{E}.','15.2: $1{,}2\\cdot(\\text{2. B})=600\\Rightarrow\\text{2. B}=500\\ \\mathrm{kg}$ — \\textbf{C}.','15.3: chlapci $+$ dívky $=1\\,200$, dívky $=1{,}5\\cdot$chlapci; $2{,}5\\cdot$chlapci $=1\\,200\\Rightarrow$ chlapci $=480\\ \\mathrm{kg}$ — \\textbf{D}.'},
  '15.1: E; 15.2: C; 15.3: D',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','prirazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
