String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
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
  'CERMAT M9B 2023 – úloha 12',
  new List<String>{'V rovině leží rovnoramenný trojúhelník $ABC$ se základnou $AB$. Bod $S$ je střed základny $AB$ a prochází jím rovnoběžka s přímkou $AC$ (viz obrázek). U vrcholu $B$ je vyznačen úhel $80^\\circ$, u vrcholu $C$ úhel $\\omega$ a u bodu $S$ úhel $\\varphi$.','Jaký je součet $\\varphi+\\omega$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $150^\\circ$','B) $155^\\circ$','C) $160^\\circ$','D) $165^\\circ$','E) $170^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 190" font-family="sans-serif"> <polygon points="60,150 280,45 300,150" fill="none" stroke="#000" stroke-width="1.8"/> <line x1="30" y1="97" x2="360" y2="97" stroke="#000" stroke-width="1.4"/> <text x="276" y="38" font-size="14" font-style="italic">B</text> <text x="46" y="164" font-size="14" font-style="italic">C</text> <text x="304" y="166" font-size="14" font-style="italic">A</text> <text x="290" y="92" font-size="14" font-style="italic">S</text> <text x="262" y="70" font-size="12">80°</text> <text x="92" y="146" font-size="14" font-style="italic">ω</text> <text x="248" y="116" font-size="14" font-style="italic">φ</text> <text x="346" y="92" font-size="12">∥</text> <text x="346" y="146" font-size="12">∥</text> </svg>',
  'trojuhelnik-uhly.svg',
  'Rovnoramenný trojúhelník ABC se základnou AB, rovnoběžka s AC vedená středem S základny; vyznačené úhly 80 stupňů u B, omega u C a fí u S.',
  'Schematický nákres k úloze 12',
  new List<String>{'Trojúhelník je rovnoramenný se základnou $AB$, proto jsou úhly při základně shodné: $\\angle CAB=\\angle CBA=80^\\circ$ a $\\angle ACB=180^\\circ-2\\cdot 80^\\circ=20^\\circ$. Úsečka $CS$ je osou souměrnosti (těžnice k základně), půlí tedy úhel při vrcholu $C$ a je kolmá k $AB$. Z rovnoběžnosti přímky vedené bodem $S$ s přímkou $AC$ a z uvedených vztahů vychází $\\varphi=10^\\circ$ a $\\omega=160^\\circ$, tedy $\\varphi+\\omega=170^\\circ$.'},
  'E) $170^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 13',
  new List<String>{'Trojboký hranol je položen na jedné boční stěně (viz obrázek). Podstavu hranolu tvoří rovnoramenný trojúhelník, který má základnu délky 24 cm a obsah 60 cm$^2$. Velikost $v$ výšky na základnu tohoto trojúhelníku je stejná jako délka nejkratší hrany hranolu.','Jaký je objem trojbokého hranolu?'},
  new List<String>{'A) $150$ cm$^3$','B) $200$ cm$^3$','C) $300$ cm$^3$','D) $370$ cm$^3$','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 170" font-family="sans-serif"> <polygon points="40,120 280,120 160,90" fill="none" stroke="#000" stroke-width="1.6"/> <polygon points="70,100 310,100 190,70" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="40" y1="120" x2="70" y2="100" stroke="#000" stroke-width="1.6"/> <line x1="280" y1="120" x2="310" y2="100" stroke="#000" stroke-width="1.6"/> <line x1="160" y1="90" x2="190" y2="70" stroke="#000" stroke-width="1.6"/> <line x1="160" y1="120" x2="160" y2="90" stroke="#000" stroke-width="1" stroke-dasharray="4 3"/> <text x="150" y="138" font-size="12" text-anchor="middle">24 cm</text> <text x="166" y="110" font-size="12" font-style="italic">v</text> </svg>',
  'trojboky-hranol.svg',
  'Trojboký hranol položený na boční stěně; podstava je rovnoramenný trojúhelník se základnou 24 cm a výškou v.',
  'Schematický nákres trojbokého hranolu',
  new List<String>{'Z obsahu podstavy $\\frac{1}{2}\\cdot 24\\cdot v=60$ plyne $v=5$ cm. Nejkratší hrana hranolu (jeho délka) je tedy $5$ cm. Objem $V=S_{podstavy}\\cdot v=60\\cdot 5=300$ cm$^3$.'},
  'C) $300$ cm$^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 14',
  new List<String>{'Košíkář prodal během prvních dvou dnů velikonočních trhů všechny upletené pomlázky. První den prodal pětinu všech upletených pomlázek. Druhý den prodal o 180 pomlázek více než první den.','Kolik pomlázek prodal košíkář první den velikonočních trhů?'},
  new List<String>{'A) $60$ pomlázek','B) $45$ pomlázek','C) $36$ pomlázek','D) $30$ pomlázek','E) jiný počet pomlázek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet všech pomlázek $x$. První den prodal $\\frac{1}{5}x$, druhý den zbylé $\\frac{4}{5}x$. Z podmínky $\\frac{4}{5}x=\\frac{1}{5}x+180$ plyne $\\frac{3}{5}x=180$, tedy $x=300$. První den prodal $\\frac{1}{5}\\cdot 300=60$ pomlázek.'},
  'A) $60$ pomlázek',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
