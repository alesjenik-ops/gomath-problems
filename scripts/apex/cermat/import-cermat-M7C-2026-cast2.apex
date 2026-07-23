String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
Integer YEAR = 2026;

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
  'CERMAT M7C 2026 – úloha 4',
  new List<String>{'Sadu tvoří 27 závaží. Celková hmotnost všech závaží v sadě je 1 kg. Sada obsahuje pouze malá, střední a velká závaží. Hmotnost 1 kusu je: malé $15$ g, střední $25$ g, velké $50$ g; malých závaží je v sadě $5$ kusů (viz tabulka).','4.1 Určete počet velkých závaží v sadě.','4.2 Určete v gramech celkovou hmotnost všech středních závaží v sadě.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 130" font-family="sans-serif" font-size="14"> <rect x="10" y="10" width="420" height="110" fill="none" stroke="#000"/> <line x1="150" y1="10" x2="150" y2="120" stroke="#000"/> <line x1="245" y1="10" x2="245" y2="120" stroke="#000"/> <line x1="340" y1="10" x2="340" y2="120" stroke="#000"/> <line x1="10" y1="47" x2="430" y2="47" stroke="#000"/> <line x1="10" y1="84" x2="430" y2="84" stroke="#000"/> <text x="20" y="33">Závaží</text> <text x="197" y="33" text-anchor="middle">Malé</text> <text x="292" y="33" text-anchor="middle">Střední</text> <text x="385" y="33" text-anchor="middle">Velké</text> <text x="20" y="70">Hmotnost 1 kusu</text> <text x="197" y="70" text-anchor="middle">15 g</text> <text x="292" y="70" text-anchor="middle">25 g</text> <text x="385" y="70" text-anchor="middle">50 g</text> <text x="20" y="107">Počet kusů v sadě</text> <text x="197" y="107" text-anchor="middle">5</text> </svg>',
  'zavazi-tabulka.svg',
  'Tabulka závaží: malé 15 g, střední 25 g, velké 50 g; malých je 5 kusů.',
  'Výchozí tabulka k úloze 4',
  new List<String>{'Malá závaží mají $5\\cdot 15=75$ g. Na střední a velká zbývá $1000-75=925$ g a $27-5=22$ kusů.','4.1 Pro počet středních $s$ a velkých $v$ platí $s+v=22$ a $25s+50v=925$. Odtud $v=15$ velkých závaží.','4.2 Středních je pak $s=7$; jejich hmotnost je $7\\cdot 25=175$ g.'},
  '4.1: $15$ velkých závaží; 4.2: $175$ gramů',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2026 – úloha 5',
  new List<String>{'Slepením šedé krychle s povrchem $54$ cm² a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.','5.1 Vypočtěte v cm délku hrany šedé krychle.','5.2 Vypočtěte v cm³ objem velkého hranolu $ABCDEFGH$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif" font-size="15"> <polygon points="290,150 360,150 360,240 290,240" fill="#c9c9c9"/> <polygon points="290,150 360,150 400,110 330,110" fill="#dcdcdc"/> <polygon points="360,150 400,110 400,200 360,240" fill="#b8b8b8"/> <polyline points="110,200 110,110 400,110 400,200" fill="none" stroke="#000" stroke-dasharray="5 4"/> <line x1="110" y1="200" x2="400" y2="200" stroke="#000" stroke-dasharray="5 4"/> <line x1="70" y1="240" x2="110" y2="200" stroke="#000" stroke-dasharray="5 4"/> <line x1="70" y1="150" x2="360" y2="150" stroke="#000"/> <line x1="360" y1="150" x2="360" y2="240" stroke="#000"/> <line x1="360" y1="240" x2="70" y2="240" stroke="#000"/> <line x1="70" y1="240" x2="70" y2="150" stroke="#000"/> <line x1="70" y1="150" x2="110" y2="110" stroke="#000"/> <line x1="360" y1="150" x2="400" y2="110" stroke="#000"/> <line x1="360" y1="240" x2="400" y2="200" stroke="#000"/> <line x1="290" y1="150" x2="290" y2="240" stroke="#000"/> <line x1="290" y1="150" x2="330" y2="110" stroke="#000"/> <text x="60" y="255" font-style="italic">A</text> <text x="362" y="258" font-style="italic">B</text> <text x="405" y="205" font-style="italic">C</text> <text x="92" y="215" font-style="italic">D</text> <text x="55" y="148" font-style="italic">E</text> <text x="345" y="145" font-style="italic">F</text> <text x="405" y="108" font-style="italic">G</text> <text x="96" y="108" font-style="italic">H</text> </svg>',
  'hranol-krychle.svg',
  'Kvádr ABCDEFGH složený z bílého hranolu vlevo a šedé krychle vpravo.',
  'Schematický nákres velkého hranolu',
  new List<String>{'5.1 Povrch krychle $6a^2=54$, tedy $a^2=9$ a $a=3$ cm.','5.2 Nejdelší hrana bílého hranolu je $3+\\frac{3}{2}=4{,}5$ cm; příčný řez zůstává $3\\times 3$ cm. Velký hranol má rozměry $3\\times 3\\times(3+4{,}5)=3\\times 3\\times 7{,}5$, objem $3\\cdot 3\\cdot 7{,}5=67{,}5$ cm³.'},
  '5.1: $3$ cm; 5.2: $67{,}5$ cm³',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
