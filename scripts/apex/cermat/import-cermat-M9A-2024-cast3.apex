String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD24C0T01';
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
  'CERMAT M9A 2024 – úloha 8',
  new List<String>{'Šedý obrazec je ohraničen úsečkou délky $20$ cm a dvěma shodnými čtvrtkružnicemi (viz obrázek). Pro výpočet použijte zaokrouhlenou hodnotu čísla $\\pi$ z tabulky ($\\pi \\approx 3{,}14$).','8.1 Vypočítejte obsah šedého obrazce. Výsledek uveďte v cm² a zaokrouhlete ho na celé cm².','8.2 Vypočítejte obvod šedého obrazce. Výsledek uveďte v cm a zaokrouhlete ho na celé cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 200" font-family="sans-serif"> <rect x="60" y="40" width="200" height="100" fill="none" stroke="#999" stroke-dasharray="4 4"/> <line x1="160" y1="140" x2="160" y2="175" stroke="#999" stroke-dasharray="3 3"/> <line x1="60" y1="40" x2="260" y2="40" stroke="#000" stroke-width="2"/> <path d="M60 40 L260 40 A100 100 0 0 0 160 140 A100 100 0 0 0 60 40 Z" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/> <text x="160" y="30" font-size="13" text-anchor="middle">20 cm</text> </svg>',
  'sedy-obrazec.svg',
  'Šedý obrazec s vodorovnou horní úsečkou délky 20 cm, jehož boky tvoří dvě shodné čtvrtkružnice sbíhající se do bodu dole.',
  'Schematický nákres šedého obrazce',
  new List<String>{'Poloměr obou čtvrtkružnic je polovina úsečky, tj. $r=10$ cm. Obsah získáme jako obdélník $20\\times 10=200$ cm² zmenšený o dvě čtvrtkružnice (dohromady půlkruh) $\\frac{1}{2}\\pi r^2=\\frac{1}{2}\\cdot 3{,}14\\cdot 100=157$ cm²; tedy $200-157=43$ cm².','8.2 Obvod tvoří úsečka $20$ cm a dva čtvrtkruhové oblouky, dohromady půlkružnice $\\pi r=3{,}14\\cdot 10=31{,}4$ cm; $20+31{,}4=51{,}4$ cm, po zaokrouhlení $51$ cm.'},
  '8.1: $43$ cm²; 8.2: $51$ cm',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $C$ a $S$ (viz obrázek). Bod $C$ je vrchol rovnostranného trojúhelníku $ABC$. Bod $S$ je středem strany $AB$.','Sestrojte vrcholy $A$, $B$ rovnostranného trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"> <rect x="6" y="6" width="388" height="288" fill="none" stroke="#ccc"/> <text x="150" y="98" font-size="15" text-anchor="middle">x</text> <text x="150" y="82" font-size="15" text-anchor="middle" font-style="italic">C</text> <text x="270" y="212" font-size="15" text-anchor="middle">x</text> <text x="270" y="230" font-size="15" text-anchor="middle" font-style="italic">S</text> </svg>',
  'body-CS.svg',
  'Dva body v rovině: bod C nahoře a bod S vpravo dole.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'V rovnostranném trojúhelníku je spojnice vrcholu $C$ se středem $S$ protější strany kolmá na tuto stranu, proto přímka $AB$ je kolmice k $CS$ vedená bodem $S$. Protože výška rovnostranného trojúhelníku svírá s ramenem úhel $30^\\circ$, sestrojíme z bodu $C$ polopřímku svírající s $CS$ úhel $30^\\circ$; její průsečík s kolmicí je vrchol $A$. Bod $B$ je souměrný s $A$ podle středu $S$ ($|SB|=|SA|$). Trojúhelník $ABC$ narýsujeme.'},
  'Přímka $AB$ je kolmice k $CS$ v bodě $S$; vrcholy $A$, $B$ leží na této kolmici tak, že $|\\angle SCA|=|\\angle SCB|=30^\\circ$ a $S$ je střed $AB$ (viz náčrt konstrukce v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
