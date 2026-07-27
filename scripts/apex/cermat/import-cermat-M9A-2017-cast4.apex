String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M9A 2017 – úloha 11',
  new List<String>{'Maminka, tatínek, Ema a Ota váží dohromady $210$ kg. Maminka s tatínkem dohromady váží dvakrát více než Ema s Otou dohromady. Ota váží $45$ kg a maminka váží o pětinu více než Ota.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (Ano), či nikoli (Ne).','11.1 Ema s Otou váží dohromady $70$ kg.','11.2 Maminka váží o $20$ kg více než Ema.','11.3 Tatínek váží $86$ kg.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hmotnost dětí $d$; pak rodiče váží $2d$ a $d+2d=210$, tedy $d=70$ kg a rodiče $140$ kg.','11.1 Ema s Otou váží $70$ kg → Ano.','Ema váží $70-45=25$ kg. Maminka váží $45+\\frac{45}{5}=45+9=54$ kg.','11.2 $54-25=29$ kg, ne $20$ kg → Ne.','11.3 Tatínek váží $140-54=86$ kg → Ano.'},
  '11.1: Ano; 11.2: Ne; 11.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2017 – úloha 12',
  new List<String>{'V obrázku je rovnoramenný trojúhelník s vrcholovým úhlem o velikosti $112^\\circ$ a s úhly $\\alpha$ při základně. Vrcholem trojúhelníku prochází polopřímka rovnoběžná se základnou; úhel $\\delta$ je vyznačen v obrázku.','Jaká je velikost úhlu $\\delta$? Úhly neměřte, ale vypočtěte.'},
  new List<String>{'A) $192^\\circ$','B) $214^\\circ$','C) $236^\\circ$','D) $248^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 270" font-family="sans-serif"> <g stroke="#000" stroke-width="2" fill="none"> <line x1="105" y1="230" x2="450" y2="230"/><line x1="250" y1="142" x2="450" y2="142"/> <line x1="120" y1="230" x2="250" y2="142"/><line x1="380" y1="230" x2="250" y2="142"/> <line x1="410" y1="222" x2="410" y2="238"/><line x1="418" y1="222" x2="418" y2="238"/> <line x1="410" y1="134" x2="410" y2="150"/><line x1="418" y1="134" x2="418" y2="150"/> </g> <g stroke="#000" stroke-width="1" fill="none"> <path d="M215,166 A42,42 0 1 1 292,142"/> <path d="M228,164 A26,26 0 0 1 272,164"/> <path d="M148,230 A28,28 0 0 0 141,214"/><path d="M352,230 A28,28 0 0 1 359,214"/> </g> <g font-size="16" font-style="italic"> <text x="244" y="92">δ</text><text x="146" y="224">α</text><text x="342" y="224">α</text> </g> <text x="250" y="182" font-size="14" text-anchor="middle">112°</text> </svg>',
  'uhel-delta.svg',
  'Rovnoramenný trojúhelník s úhlem 112 stupňů u vrcholu, s úhly alfa při základně a s vyznačeným úhlem delta u vrcholu.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Úhly při základně: $\\alpha=\\frac{180^\\circ-112^\\circ}{2}=34^\\circ$.','Polopřímka vrcholem je rovnoběžná se základnou, proto úhel mezi ní a ramenem je střídavý úhel k $\\alpha$, tedy $34^\\circ$.','$\\delta=360^\\circ-112^\\circ-34^\\circ=214^\\circ$.'},
  'B) $214^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 13',
  new List<String>{'Nádrž s vodou má tvar kvádru o rozměrech $1$ m, $2$ m a $1$ m (viz obrázek). Zahrádkář naplnil vodou z nádrže 15 prázdných dvanáctilitrových konví, a hladina vody v nádrži tak klesla.','O kolik cm klesla hladina vody v nádrži?'},
  new List<String>{'A) o méně než $9$ cm','B) o $9$ cm','C) o $10$ cm','D) o $11$ cm','E) o více než $11$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 270" font-family="sans-serif"> <polygon points="140,152 250,152 345,94 235,94" fill="#dcdcdc" stroke="none"/> <g stroke="#000" stroke-width="1" fill="none" stroke-dasharray="5 4"> <line x1="235" y1="172" x2="235" y2="82"/><line x1="235" y1="172" x2="345" y2="172"/><line x1="235" y1="172" x2="140" y2="230"/> </g> <g stroke="#000" stroke-width="2" fill="none"> <rect x="140" y="140" width="110" height="90"/> <path d="M140,140 L235,82 L345,82 L345,172 L250,230"/> <line x1="250" y1="140" x2="345" y2="82"/> </g> <g stroke="#000" stroke-width="1" fill="none"> <line x1="368" y1="82" x2="368" y2="172"/> <path d="M364,88 L368,80 L372,88" fill="#000"/><path d="M364,166 L368,174 L372,166" fill="#000"/> </g> <g font-size="14"> <text x="378" y="132">1 m</text><text x="300" y="212">2 m</text><text x="180" y="252">1 m</text> </g> </svg>',
  'nadrz-kvadr.svg',
  'Nádrž tvaru kvádru s rozměry 1 m, 2 m a 1 m a se znázorněnou hladinou vody.',
  'Výchozí obrázek k úloze 13',
  new List<String>{'Odebraný objem: $15\\cdot 12=180$ litrů $=180$ dm³ $=0{,}18$ m³.','Obsah dna nádrže: $1\\cdot 2=2$ m².','Pokles hladiny: $0{,}18:2=0{,}09$ m $=9$ cm.'},
  'B) o $9$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
