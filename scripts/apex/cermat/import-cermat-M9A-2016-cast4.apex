String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M9A 2016 – úloha 13',
  new List<String>{'V obrázku jsou dvě rovnoběžky (označené dvojitými čárkami), které jsou proťaty dvěma různoběžkami procházejícími týmž bodem na horní rovnoběžce. U tohoto bodu jsou vyznačeny úhly o velikostech $113^\\circ$, $\\gamma$ a $37^\\circ$, u dolní rovnoběžky úhly $\\alpha$ a $\\beta$.','Kolik je $\\alpha+\\beta$? Úhly neměřte.'},
  new List<String>{'A) $104^\\circ$','B) $113^\\circ$','C) $142^\\circ$','D) $143^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif"> <g stroke="#000" stroke-width="2" fill="none"> <line x1="150" y1="100" x2="480" y2="100"/> <line x1="60" y1="250" x2="480" y2="250"/> <line x1="165" y1="40" x2="103" y2="290"/> <line x1="86" y1="52" x2="392" y2="282"/> </g> <g stroke="#000" stroke-width="2"> <line x1="428" y1="92" x2="428" y2="108"/><line x1="438" y1="92" x2="438" y2="108"/> <line x1="428" y1="242" x2="428" y2="258"/><line x1="438" y1="242" x2="438" y2="258"/> </g> <g stroke="#000" stroke-width="1" fill="none"> <path d="M116,75 A42,42 0 0 0 140,141"/> <path d="M143,129 A30,30 0 0 0 174,118"/> <path d="M188,129 A48,48 0 0 0 198,100"/> <path d="M121,215 A36,36 0 0 1 149,250"/> <path d="M317,226 A40,40 0 0 0 309,250"/> </g> <g font-size="15" text-anchor="middle"> <text x="97" y="124">113°</text> <text x="212" y="118">37°</text> </g> <g font-size="16" font-style="italic" text-anchor="middle"> <text x="163" y="146">γ</text><text x="148" y="228">α</text><text x="302" y="240">β</text> </g> </svg>',
  'uhly-rovnobezky.svg',
  'Dvě rovnoběžné přímky proťaté dvěma různoběžkami se společným bodem na horní rovnoběžce; vyznačené úhly 113 stupňů, gama, 37 stupňů, alfa a beta.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Úhly $113^\\circ$ a $\\gamma$ jsou vedlejší (leží u jedné přímky), proto $\\gamma=180^\\circ-113^\\circ=67^\\circ$.','Úhel $\\beta$ je střídavý s úhlem $37^\\circ$ (u rovnoběžek), tedy $\\beta=37^\\circ$.','Úhel mezi strmější příčkou a horní rovnoběžkou je $\\gamma+37^\\circ=104^\\circ$; úhel $\\alpha$ je k němu přilehlý u druhé rovnoběžky, tedy $\\alpha=180^\\circ-104^\\circ=76^\\circ$.','$\\alpha+\\beta=76^\\circ+37^\\circ=113^\\circ$.'},
  'B) $113^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 14',
  new List<String>{'Kvádr $ABCDEFGH$ má čtvercovou podstavu o obsahu $25$ cm². Obsah boční stěny je o $5$ cm² větší než obsah podstavy.','Jaký je objem kvádru?'},
  new List<String>{'A) $125$ cm³','B) $150$ cm³','C) $170$ cm³','D) $175$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 340" font-family="sans-serif"> <g stroke="#000" stroke-width="2" fill="none"> <path d="M60,300 L240,300 L240,150 L60,150 Z"/> <path d="M240,300 L310,240 L310,90 L240,150"/> <path d="M60,150 L130,90 L310,90"/> </g> <g stroke="#000" stroke-width="1" fill="none" stroke-dasharray="6 4"> <path d="M60,300 L130,240 L310,240"/> <line x1="130" y1="240" x2="130" y2="90"/> </g> <g font-size="15" font-style="italic"> <text x="46" y="318">A</text><text x="244" y="318">B</text><text x="318" y="244">C</text><text x="108" y="236">D</text> <text x="42" y="148">E</text><text x="248" y="168">F</text><text x="318" y="86">G</text><text x="110" y="84">H</text> </g> </svg>',
  'kvadr.svg',
  'Kvádr s vrcholy A, B, C, D dole a E, F, G, H nahoře.',
  'Výchozí obrázek k úloze 14',
  new List<String>{'Podstava je čtverec o obsahu $25$ cm², proto hrana podstavy je $a=\\sqrt{25}=5$ cm.','Obsah boční stěny je $25+5=30$ cm², tedy $5\\cdot v=30$ a výška je $v=6$ cm.','$V=S_p\\cdot v=25\\cdot 6=150$ cm³.'},
  'B) $150$ cm³',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 15',
  new List<String>{'Čtyři nepřetržitě pracující stroje uklidí společně halu za $24$ hodin. Všechny stroje jsou stejně výkonné. Když se použije o jeden stroj méně, doba úklidu haly se prodlouží.','O kolik hodin se doba úklidu prodlouží?'},
  new List<String>{'A) o $8$ hodin','B) o $6$ hodin','C) o $4$ hodiny','D) o $3$ hodiny','E) o $2$ hodiny'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celková práce odpovídá $4\\cdot 24=96$ strojohodinám.','Tři stroje ji zvládnou za $96:3=32$ hodin (nepřímá úměrnost).','Doba úklidu se prodlouží o $32-24=8$ hodin.'},
  'A) o $8$ hodin',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
