String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
Integer YEAR = 2024;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M9C 2024 – úloha 7',
  new List<String>{'V parku jsou 3 okrasné záhony. První a třetí záhon o stejné velikosti mají tvar čtvrtkruhu, druhý záhon má tvar kruhu. Každý ze tří záhonů má obsah $314$ dm² (viz obrázek).','V podúlohách 7.1 a 7.2 pro výpočet použijte zaokrouhlenou hodnotu čísla $\\pi\\doteq 3{,}14$ z tabulky na začátku testového sešitu.','7.1 Vypočtěte obvod druhého (kruhového) záhonu. Výsledek uveďte v celých metrech.','7.2 Vypočtěte poloměr $r$ jednoho z čtvrtkruhových záhonů. Výsledek uveďte v celých metrech.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif"> <path d="M150 70 L92 70 A58 58 0 0 0 150 128 Z" fill="none" stroke="#000"/> <circle cx="210" cy="100" r="40" fill="#b9b9b9" stroke="#000"/> <path d="M270 70 L328 70 A58 58 0 0 1 270 128 Z" fill="none" stroke="#000"/> <text x="118" y="104" font-size="11" text-anchor="middle">1. záhon</text> <text x="210" y="104" font-size="11" text-anchor="middle">2. záhon</text> <text x="302" y="104" font-size="11" text-anchor="middle">3. záhon</text> <text x="116" y="84" font-size="12" font-style="italic">r</text> <text x="300" y="84" font-size="12" font-style="italic">r</text> </svg>',
  'zahony.svg',
  'Tři záhony vedle sebe: první a třetí ve tvaru čtvrtkruhu s poloměrem r, prostřední ve tvaru kruhu.',
  'Tři okrasné záhony (schematický nákres)',
  new List<String>{'7.1 Kruhový záhon: $\\pi r^2=314$ dm², s $\\pi\\doteq 3{,}14$ je $r^2=100$, tedy $r=10$ dm. Obvod $o=2\\pi r=2\\cdot 3{,}14\\cdot 10=62{,}8$ dm $=6{,}28$ m $\\doteq 6$ m.','7.2 Čtvrtkruhový záhon: $\\frac{1}{4}\\pi r^2=314$ dm², tj. $\\pi r^2=1256$, $r^2=400$, a proto $r=20$ dm $=2$ m.'},
  '7.1: $6$ m; 7.2: $2$ m',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2024 – úloha 8',
  new List<String>{'Trojúhelník $ABC$ je vymezen třemi různoběžkami $a$, $b$, $c$. Přímky $a$ a $c$ svírají úhel $130^\\circ$ a velikosti úhlů $\\alpha$ a $\\gamma$ jsou v poměru $2:3$ (viz obrázek).','8.1 Vypočtěte velikost vnitřního úhlu $\\gamma$ při vrcholu $C$.','8.2 Vypočtěte rozdíl $\\alpha-\\beta$ vnitřních úhlů $\\alpha$ a $\\beta$. Velikosti úhlů neměřte, ale vypočtěte (obrázek je ilustrační).'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 330" font-family="sans-serif"> <line x1="80" y1="157" x2="560" y2="253" stroke="#000"/> <line x1="281" y1="19" x2="533" y2="307" stroke="#000"/> <line x1="394" y1="35" x2="122" y2="205" stroke="#000"/> <text x="70" y="150" font-size="15" font-style="italic">c</text> <text x="540" y="320" font-size="15" font-style="italic">a</text> <text x="400" y="30" font-size="15" font-style="italic">b</text> <text x="166" y="164" font-size="14" font-style="italic" text-anchor="middle">A</text> <text x="332" y="68" font-size="14" font-style="italic" text-anchor="middle">C</text> <text x="478" y="238" font-size="14" font-style="italic">B</text> <text x="205" y="172" font-size="14">α</text> <text x="322" y="112" font-size="14">γ</text> <text x="430" y="212" font-size="14">β</text> <text x="498" y="274" font-size="13">130°</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Trojúhelník ABC vymezený třemi různoběžkami a, b, c s vnitřními úhly alfa u A, beta u B, gama u C a vnějším úhlem 130 stupňů u vrcholu B.',
  'Schematický nákres k úloze 8',
  new List<String>{'8.1 Úhel $130^\\circ$, který svírají přímky $a$ a $c$, je vnějším úhlem trojúhelníku při vrcholu $B$. Podle věty o vnějším úhlu je $\\alpha+\\gamma=130^\\circ$. Protože $\\alpha:\\gamma=2:3$, je $\\alpha=52^\\circ$ a $\\gamma=78^\\circ$.','8.2 Vnitřní úhel $\\beta=180^\\circ-130^\\circ=50^\\circ$. Rozdíl $\\alpha-\\beta=52^\\circ-50^\\circ=2^\\circ$.'},
  '8.1: $\\gamma=78^\\circ$; 8.2: $\\alpha-\\beta=2^\\circ$',
  4, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
