String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M7A 2019 – úloha 10',
  new List<String>{'Tři obrazce byly složeny z $9$ shodných čtverců a $3$ shodných rovnoramenných trojúhelníků. Obvod 1. obrazce je $32$ cm. (V 1. a 2. obrazci mají sousední čtverce a trojúhelníky společné vrcholy a nikde nepřečnívají.)','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah 1. obrazce je $48$ cm².','10.2 Obvod 2. obrazce je větší než $48$ cm.','10.3 Obvod 3. obrazce je $44$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif" font-size="13"> <text x="95" y="20" text-anchor="middle">1. obrazec</text> <text x="285" y="20" text-anchor="middle">2. obrazec</text> <text x="470" y="20" text-anchor="middle">3. obrazec</text> <rect x="60" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="100" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="100" y="110" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="215" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="255" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="295" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="215,150 255,150 228,70" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="255,150 335,150 268,95" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="425" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="465" y="150" width="40" height="40" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="425" y1="110" x2="425" y2="150" stroke="#000" stroke-width="1.5"/> <line x1="465" y1="110" x2="465" y2="150" stroke="#000" stroke-width="1.5"/> <polygon points="418,86 425,110 525,110" fill="none" stroke="#000" stroke-width="1.5"/> </svg>',
  'tri-obrazce.svg',
  'Tři obrazce ze shodných čtverců a rovnoramenných trojúhelníků: 1. obrazec tři čtverce do L, 2. obrazec řada tří čtverců se dvěma trojúhelníky, 3. obrazec dva čtverce, dvě svislé spojky a trojúhelník.',
  '1., 2. a 3. obrazec',
  new List<String>{'1. obrazec tvoří tři čtverce a jeho obvod je $8$ stran čtverce: $8a=32$, tedy strana $a=4$ cm.','10.1 Obsah $=3\\cdot a^2=3\\cdot 16=48$ cm². Pravda (A).','10.2 Obvod 2. obrazce není větší než $48$ cm. Nepravda (N).','10.3 Obvod 3. obrazce je $44$ cm. Pravda (A).'},
  '10.1: Ano; 10.2: Ne; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 11',
  new List<String>{'Na obrázku jsou vyznačeny úhly $\\alpha$, $\\alpha+20^\\circ$, $2\\alpha$ a $\\beta$; dvojité značky vyznačují rovnoběžná ramena. Velikosti úhlů neměřte, ale vypočtěte.','Jaká je velikost úhlu $\\beta$?'},
  new List<String>{'A) menší než $75^\\circ$','B) $75^\\circ$','C) $80^\\circ$','D) $85^\\circ$','E) větší než $85^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 290" font-family="sans-serif" font-size="15"> <line x1="55" y1="175" x2="335" y2="70" stroke="#000" stroke-width="1.7"/> <line x1="55" y1="175" x2="360" y2="262" stroke="#000" stroke-width="1.7"/> <line x1="250" y1="92" x2="315" y2="285" stroke="#000" stroke-width="1.7"/> <line x1="300" y1="240" x2="430" y2="222" stroke="#000" stroke-width="1.7"/> <line x1="295" y1="80" x2="303" y2="62" stroke="#000" stroke-width="1.5"/> <line x1="303" y1="83" x2="311" y2="65" stroke="#000" stroke-width="1.5"/> <line x1="378" y1="228" x2="388" y2="212" stroke="#000" stroke-width="1.5"/> <line x1="386" y1="231" x2="396" y2="215" stroke="#000" stroke-width="1.5"/> <text x="255" y="128" font-style="italic">&#946;</text> <text x="205" y="212">&#945; + 20&#176;</text> <text x="322" y="215">2&#945;</text> <text x="262" y="262" font-style="italic">&#945;</text> </svg>',
  'uhly-beta.svg',
  'Trojúhelník se dvěma rovnoběžnými rameny (dvojité značky); u dolního vrcholu úhly alfa, alfa + 20 stupňů a 2 alfa, u horního vrcholu úhel beta.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Rameno s dvojitou značkou u dolního vrcholu je rovnoběžné s horní stranou. Úhel $2\\alpha$ je střídavý (resp. souhlasný) s úhlem $\\beta$, proto $\\beta=2\\alpha$. Vnitřní úhel trojúhelníku u levého vrcholu je souhlasný s $\\alpha$ a u dolního vrcholu je $\\alpha+20^\\circ$. Součet vnitřních úhlů: $\\alpha+2\\alpha+(\\alpha+20^\\circ)=180^\\circ$, tj. $4\\alpha=160^\\circ$, $\\alpha=40^\\circ$. Odtud $\\beta=2\\alpha=80^\\circ$.'},
  'C) $80^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
