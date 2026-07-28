String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M9A 2015 – úloha 12',
  new List<String>{'V pravoúhlém trojúhelníku $ABC$ leží proti přeponě $c$ úhel $\\gamma$ a proti odvěsnám $a$, $b$ úhly $\\alpha$, $\\beta$. Platí: $a=6$ cm, $c=10$ cm.','Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (A), či nikoli (N).','12.1 $a+b=c$','12.2 $\\beta<\\gamma$','12.3 $\\alpha+\\beta=90^\\circ$'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Podle Pythagorovy věty $b=\\sqrt{10^2-6^2}=\\sqrt{64}=8$ cm; proti přeponě leží pravý úhel, tedy $\\gamma=90^\\circ$.','12.1 $6+8=14$, což se nerovná $10$ → Ne.','12.2 Úhel $\\beta$ je ostrý, tedy $\\beta<90^\\circ=\\gamma$ → Ano.','12.3 Součet ostrých úhlů pravoúhlého trojúhelníku je $180^\\circ-90^\\circ=90^\\circ$ → Ano.'},
  '12.1: Ne; 12.2: Ano; 12.3: Ano',
  3, 4, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 13',
  new List<String>{'V trojúhelníku je u levého vrcholu vyznačen vnitřní úhel $\\alpha$ a k němu vedlejší (vnější) úhel o velikosti $90^\\circ+\\alpha$, u pravého vrcholu úhel $35^\\circ$ a u horního vrcholu úhel $\\gamma$ (viz obrázek).','Jaká je velikost úhlu $\\gamma$?'},
  new List<String>{'A) $90^\\circ$','B) $95^\\circ$','C) $100^\\circ$','D) $105^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif" font-size="15"> <line x1="30" y1="160" x2="440" y2="160" stroke="#000" stroke-width="2"/> <line x1="100" y1="160" x2="223.6" y2="36.4" stroke="#000" stroke-width="2"/> <line x1="223.6" y1="36.4" x2="400" y2="160" stroke="#000" stroke-width="2"/> <path d="M 38 160 A 62 62 0 0 1 143.8 116.2" fill="none" stroke="#000"/> <path d="M 134 160 A 34 34 0 0 0 124 136" fill="none" stroke="#000"/> <path d="M 366 160 A 34 34 0 0 1 372.2 140.5" fill="none" stroke="#000"/> <path d="M 248.2 53.6 A 30 30 0 0 1 202.4 57.6" fill="none" stroke="#000"/> <text x="72" y="140" text-anchor="middle">90° + α</text> <text x="118" y="155" font-style="italic">α</text> <text x="360" y="152" text-anchor="end">35°</text> <text x="222" y="76" text-anchor="middle" font-style="italic">γ</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Trojúhelník s vnějším úhlem 90 stupňů plus alfa u levého vrcholu, vnitřním úhlem alfa, úhlem 35 stupňů u pravého vrcholu a úhlem gama u vrcholu nahoře.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Vnitřní a vnější úhel u levého vrcholu tvoří přímý úhel: $(90^\\circ+\\alpha)+\\alpha=180^\\circ$, tedy $2\\alpha=90^\\circ$ a $\\alpha=45^\\circ$.','Součet vnitřních úhlů trojúhelníku: $\\gamma=180^\\circ-45^\\circ-35^\\circ=100^\\circ$.'},
  'C) $100^\\circ$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 14',
  new List<String>{'Kružnice je vytvořena z drátu délky $30$ cm. Z tohoto drátu se vytvaruje obdélník, jehož sousední strany mají délky v poměru $3:2$.','Jaký je obsah obdélníku?'},
  new List<String>{'A) $24$ cm²','B) $54$ cm²','C) $96$ cm²','D) $108$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 180" font-family="sans-serif"> <circle cx="105" cy="90" r="65" fill="none" stroke="#000" stroke-width="2"/> <rect x="265" y="52" width="150" height="76" fill="none" stroke="#000" stroke-width="2"/> </svg>',
  'kruznice-obdelnik.svg',
  'Kružnice a vedle ní obdélník, oba vytvořené ze stejného drátu.',
  'Výchozí obrázek k úloze 14',
  new List<String>{'Obvod obdélníku je roven délce drátu, tedy $30$ cm; součet dvou sousedních stran je $30:2=15$ cm.','V poměru $3:2$ platí $3k+2k=15$, tedy $k=3$; strany jsou $9$ cm a $6$ cm.','Obsah je $9\\cdot 6=54$ cm².'},
  'B) $54$ cm²',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 15',
  new List<String>{'Karel s rodiči odlétal na dovolenou. Při odbavení na letišti měla jejich 3 zavazadla celkovou hmotnost $44$ kg. Otcovo zavazadlo mělo třikrát větší hmotnost než Karlovo zavazadlo a matčino zavazadlo mělo polovinu hmotnosti otcova zavazadla.','O kolik kilogramů je matčino zavazadlo těžší než Karlovo zavazadlo?'},
  new List<String>{'A) o $3{,}5$ kg','B) o $4$ kg','C) o $5$ kg','D) o $6$ kg','E) o $6{,}5$ kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Karlovo zavazadlo $k$, otcovo $3k$, matčino $\\frac{3k}{2}=1{,}5k$.','Celkem $k+3k+1{,}5k=5{,}5k=44$, tedy $k=8$ kg.','Matčino má $12$ kg, Karlovo $8$ kg, rozdíl je $12-8=4$ kg.'},
  'B) o $4$ kg',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
