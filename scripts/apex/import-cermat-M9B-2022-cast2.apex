String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)';
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
  'CERMAT 2022 M9B · úloha 7',
  new List<String>{'Soutěže se zúčastnilo $5$ škol A, B, C, D, E. Každou školu reprezentovaly dva týmy – jeden dívčí a jeden chlapecký. Výsledky (počty bodů) jsou dány grafem, dva údaje chybí. Dívčí týmy: A $=12$, B $=6$, C chybí, D $=4$, E $=4$. Chlapecké týmy: A $=6$, B $=14$, C $=2$, D chybí, E $=6$.','7.1 Výsledek dívčího týmu školy C byl stejný jako aritmetický průměr výsledků dívčích týmů škol A a B. Vypočtěte aritmetický průměr výsledků všech pěti dívčích týmů.','7.2 Aritmetický průměr výsledků všech pěti chlapeckých týmů je $8$ bodů. Určete, kolik bodů získal chlapecký tým školy D.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: dívčí tým C $=\\frac{12+6}{2}=9$. Průměr všech pěti dívčích týmů $=\\frac{12+6+9+4+4}{5}=\\frac{35}{5}=7$ bodů.','7.2: součet bodů pěti chlapeckých týmů $=5\\cdot8=40$. Známé $6+14+2+6=28$; chlapecký tým D $=40-28=12$ bodů.'},
  '7.1: $7$ bodů; 7.2: $12$ bodů',
  4, 5, '3',
  new List<String>{'zs2','r9','grafy','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 8',
  new List<String>{'Bílý čtverec má obsah $9\\ \\mathrm{cm}^2$, černá plocha uvnitř čtverce $KLMN$ má obsah $16\\ \\mathrm{cm}^2$ a šedá plocha uvnitř čtverce $ABCD$ má obsah $56\\ \\mathrm{cm}^2$ (viz obrázek). Bílý čtverec leží uvnitř čtverce $KLMN$ a ten uvnitř čtverce $ABCD$.','8.1 Vypočtěte v cm délku strany $KL$.','8.2 Vypočtěte v cm obvod čtverce $ABCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 167 175"><path d="M11 14L151 14L151 154L11 154Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M46 31L128 50L110 131L28 113L46 31Z" style="fill:#000000"/><path d="M49 53L102 53L102 105L49 105Z" style="fill:#ffffff"/><text x="7" y="169" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="156" y="169" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="157" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="7" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="24" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">K</text><text x="114" y="145" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="135" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="43" y="30" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">N</text></svg>',
  'obr.svg',
  'Čtverec ABCD (šedý) obsahuje pootočený čtverec KLMN (černý), uvnitř něhož je menší bílý čtverec.',
  '',
  new List<String>{'Bílý čtverec má stranu $\\sqrt{9}=3\\ \\mathrm{cm}$.','8.1: obsah čtverce $KLMN=$ černá $+$ bílý $=16+9=25\\ \\mathrm{cm}^2$, tedy $|KL|=\\sqrt{25}=5\\ \\mathrm{cm}$.','8.2: obsah čtverce $ABCD=$ šedá $+$ $KLMN=56+25=81\\ \\mathrm{cm}^2$, strana $\\sqrt{81}=9\\ \\mathrm{cm}$; obvod $4\\cdot9=36\\ \\mathrm{cm}$.'},
  '8.1: $5\\ \\mathrm{cm}$; 8.2: $36\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obsah','obvod','vypocet','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);
c.add(
  'CERMAT 2022 M9B · úloha 9',
  new List<String>{'V rovině leží bod $C$ a přímka $q$ (viz obrázek).','Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Základna $AB$ leží na přímce $q$ a má délku $6\\ \\mathrm{cm}$.','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 283 183"><path d="M201 163L206 157M206 163L200 157M272 4L4 140" style="fill:none;stroke:#000000;stroke-width:2"/><text x="202" y="177" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="273" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text></svg>',
  'obr.svg',
  'V rovině leží přímka q (šikmá) a pod ní bod C.',
  '',
  new List<String>{'Protože trojúhelník je rovnoramenný se základnou $AB$, leží vrchol $C$ na ose základny $AB$. Sestrojíme patu $S$ kolmice z bodu $C$ na přímku $q$ — to je střed základny.','Na přímce $q$ naneseme na obě strany od $S$ vzdálenost $3\\ \\mathrm{cm}$ (polovina $|AB|=6\\ \\mathrm{cm}$) a získáme body $A$ a $B$. Trojúhelník $ABC$ narýsujeme.'},
  'Konstrukce rovnoramenného trojúhelníku $ABC$ se základnou $AB$ délky $6\\ \\mathrm{cm}$ na přímce $q$ a vrcholem $C$.',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost'},
  'M9PBD22C0T02', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
