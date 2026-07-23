String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M7D 2023 - uloha 11',
  new List<String>{'Velky obdelnik lze rozdelit na dva shodne mensi obdelniky nebo na dva ctverce. Obvod jednoho z mensich obdelniku je $30$ cm.','Jaky je obvod velkeho obdelniku?'},
  new List<String>{'A) mensi nez $36$ cm','B) $36$ cm','C) $40$ cm','D) $60$ cm','E) vetsi nez $60$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 150" font-family="sans-serif"> <g fill="none" stroke="#000" stroke-width="2"><rect x="40" y="45" width="150" height="72"/><rect x="230" y="45" width="150" height="72"/></g> <g stroke="#000"><line x1="40" y1="81" x2="190" y2="81"/><line x1="305" y1="45" x2="305" y2="117"/></g> </svg>',
  'obdelnik-deleni.svg',
  'Velky obdelnik rozdeleny jednou na dva mensi obdelniky, podruhe na dva ctverce.',
  'Vychozi obrazek k uloze 11',
  new List<String>{'Rozdeleni na dva ctverce znamena, ze delsi strana je dvojnasobek kratsi: $a=2b$. Mensi obdelnik (s polovicni vyskou) ma rozmery $a\\times\\frac{b}{2}=2b\\times\\frac{b}{2}$ a obvod $2\\left(2b+\\frac{b}{2}\\right)=5b=30$, tedy $b=6$ cm, $a=12$ cm. Obvod velkeho obdelniku $2(a+b)=2\\cdot 18=36$ cm.'},
  'B) $36$ cm',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 12',
  new List<String>{'Primka $p$ prochazi vrcholy $A$, $B$ trojuhelniku $ABC$, jehoz vnitrni uhly maji velikosti $\\alpha$, $\\beta$, $\\gamma$. Bodem $B$ prochazi rovnobezka se stranou $AC$. U vrcholu $B$ jsou vyznaceny uhly $2\\beta+\\gamma$ a $30^\\circ$ (viz obrazek).','Jaka je velikost uhlu $\\gamma$? Velikosti uhlu nemerte, ale vypoctete.'},
  new List<String>{'A) $115^\\circ$','B) $120^\\circ$','C) $135^\\circ$','D) $140^\\circ$','E) $150^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 210" font-family="sans-serif"> <g stroke="#000" stroke-width="1.6" fill="none"> <line x1="185" y1="10" x2="360" y2="180"/> <line x1="120" y1="180" x2="360" y2="180"/> <line x1="230" y1="52" x2="120" y2="180"/> <line x1="230" y1="52" x2="410" y2="52"/> </g> <g font-size="15" font-style="italic"><text x="230" y="44" text-anchor="middle">B</text><text x="366" y="192">A</text><text x="108" y="192">C</text></g> <g font-size="13"><text x="333" y="174">&#945;</text><text x="138" y="174">&#946;</text><text x="228" y="76">&#946;</text><text x="150" y="172">&#947;</text> <text x="188" y="46">2&#946;+&#947;</text><text x="252" y="70">30&#176;</text></g> <g font-size="12"><text x="238" y="176">//</text><text x="316" y="49">//</text></g> </svg>',
  'trojuhelnik-uhly.svg',
  'Trojuhelnik ABC s primkou p vrcholy A, B a rovnobezkou se stranou AC bodem B; vyznacene uhly 2beta+gama, 30 stupnu, alfa, beta, gama.',
  'Vychozi obrazek k uloze 12',
  new List<String>{'Rovnobezka se stranou $AC$ vedena bodem $B$ vytvari stridave uhly: vyznaceny uhel $30^\\circ$ odpovida uhlu $\\alpha$, tedy $\\alpha=30^\\circ$. Z polohy uhlu u vrcholu $B$ na primce $p$ plyne $3\\beta+\\gamma=180^\\circ$. Se souctem $\\alpha+\\beta+\\gamma=180^\\circ$ dostaneme $\\beta+\\gamma=150^\\circ$; odectenim $\\beta=15^\\circ$ a $\\gamma=135^\\circ$.'},
  'C) $135^\\circ$',
  2, 5, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 13',
  new List<String>{'Teleso na obrazku je slepeno ze $6$ stejnych valcu. V ucebnici je toto teleso zakresleno pri pohledu zprava, zleva, zezadu a shora.','Ktery z obrazku (A-E) nemuze predstavovat zadny ze ctyr pohledu zakreslenych v ucebnici?'},
  new List<String>{'A) obrazek A','B) obrazek B','C) obrazek C','D) obrazek D','E) obrazek E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif"> <text x="260" y="55" font-size="13" text-anchor="middle">Teleso ze 6 stejnych valcu a jeho pohledy A-E (viz testovy sesit).</text> <text x="260" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorove teleso nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'valce.svg',
  'Teleso slepene ze sesti stejnych valcu (schematicka poznamka).',
  'Prostorove teleso - viz testovy sesit',
  new List<String>{'Porovnanim moznych pohledu (zprava, zleva, zezadu, shora) na teleso ze sesti valcu zjistime, ze jim neodpovida obrazek $D$.'},
  'D) obrazek D',
  2, 4, '3',
  new List<String>{'zs2','r7','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
