String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)';
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
  'CERMAT 2021 M9B · úloha 12',
  new List<String>{'V rovině leží rovnoramenný lichoběžník ABCD se základnou AB, rovnostranný trojúhelník BEC a polopřímky AB, CD (viz obrázek). Vnitřní úhel lichoběžníku při základně AB má velikost $65^\\circ$ (v obrázku vyznačen u vrcholu D mezi polopřímkou CD a ramenem AD, s nímž je shodný, neboť AB $\\parallel$ CD).','Jaká je velikost úhlu $\\varphi$ (úhel při vrcholu B mezi polopřímkou AB za bodem B a ramenem BE rovnostranného trojúhelníku)? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $45^\\circ$','B) $45^\\circ$','C) $50^\\circ$','D) $55^\\circ$','E) větší než $55^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 204 96"><path d="M154 59L166 59L166 74L154 74Z" style="fill:#ffffff"/><path d="M19 15L39 15L39 30L19 30Z" style="fill:#ffffff"/><path d="M25 76L43 14L124 14L141 76L25 76M124 14L186 30L141 76L124 14M141 76L192 76M4 14L43 14" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M161 55C167 61 170 68 170 76M35 41C23 38 15 27 15 14" style="fill:none;stroke:#000000;stroke-width:1"/><text x="23" y="90" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="143" y="90" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="127" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="41" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="194" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="160" y="72" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text><text x="27" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">65</text><text x="35" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text></svg>',
  'obr.svg',
  'Rovnoramenný lichoběžník ABCD se základnou AB, s úhlem 65° u vrcholu D, a rovnostranný trojúhelník BEC vpravo; hledaný úhel φ je při vrcholu B mezi polopřímkou AB a ramenem BE.',
  '',
  new List<String>{'Rovnoramenný lichoběžník má při základně AB úhly $|\\angle DAB|=|\\angle ABC|=65^\\circ$.','Polopřímka AB pokračuje za bodem B; úhel mezi ní a ramenem BC je $180^\\circ-65^\\circ=115^\\circ$.','Rovnostranný trojúhelník BEC má $|\\angle EBC|=60^\\circ$ a vrchol E leží vně lichoběžníku, proto $\\varphi=115^\\circ-60^\\circ=55^\\circ$.'},
  'D) $55^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 13',
  new List<String>{'Válcovací stroj se pohyboval v přímém směru vpřed. Jeho přední rotační válec vykonal při tomto pohybu $200$ otáček (bez prokluzu). Přední rotační válec má průměr podstavy $0{,}5\\ \\mathrm{m}$ a zanechává za sebou uválcovaný pás široký $0{,}8\\ \\mathrm{m}$. (Jedna otáčka je otočení kolem osy válce o $360^\\circ$.)','Kolik m$^2$ uválcoval přední rotační válec? Výsledek je zaokrouhlen na celé m$^2$. Za $\\pi$ lze dosadit $3{,}14$.'},
  new List<String>{'A) méně než $250\\ \\mathrm{m}^2$','B) $251\\ \\mathrm{m}^2$','C) $314\\ \\mathrm{m}^2$','D) $331\\ \\mathrm{m}^2$','E) více než $332\\ \\mathrm{m}^2$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Za jednu otáčku válec ujede vzdálenost rovnou obvodu podstavy $\\pi d=3{,}14\\cdot0{,}5=1{,}57\\ \\mathrm{m}$; za $200$ otáček $200\\cdot1{,}57=314\\ \\mathrm{m}$.','Uválcovaná plocha $=314\\ \\mathrm{m}\\cdot0{,}8\\ \\mathrm{m}=251{,}2\\ \\mathrm{m}^2\\doteq251\\ \\mathrm{m}^2$.'},
  'B) $251\\ \\mathrm{m}^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','obvod','vypocet','vyber','bezny-zivot','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 14',
  new List<String>{'Ve třídě 9. A je počet dívek o $4$ větší než počet chlapců. Na exkurzi se z 9. A přihlásila čtvrtina dívek a polovina chlapců. Mezi žáky 9. A, kteří se přihlásili na exkurzi, bylo dívek o $2$ méně než chlapců.','Neznámou $d$ je označen počet dívek 9. A. Ze které rovnice lze v souladu se zadáním určit počet dívek třídy 9. A?'},
  new List<String>{'A) $\\dfrac{d}{2}-2=\\dfrac{d+4}{4}$','B) $\\dfrac{d}{2}+2=\\dfrac{d-4}{4}$','C) $\\dfrac{d}{4}-2=\\dfrac{d+4}{2}$','D) $\\dfrac{d}{4}+2=\\dfrac{d-4}{2}$','E) $\\dfrac{d}{4}+2=\\dfrac{d+4}{2}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet chlapců je $d-4$. Na exkurzi jde $\\frac{d}{4}$ dívek a $\\frac{d-4}{2}$ chlapců; dívek je o $2$ méně než chlapců: $\\frac{d}{4}=\\frac{d-4}{2}-2$, tj. $\\frac{d}{4}+2=\\frac{d-4}{2}$.','(Řešením je $d=16$: dívek $16$, chlapců $12$; na exkurzi $4$ dívky a $6$ chlapců.)'},
  'D) $\\dfrac{d}{4}+2=\\dfrac{d-4}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','algebra','slovni','vyber','uvazovani','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
