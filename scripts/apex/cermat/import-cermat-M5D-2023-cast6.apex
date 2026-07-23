String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
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
  'CERMAT M5D 2023 – úloha 9',
  new List<String>{'Květinářka vázala pouze dva druhy kytic – jednak se 3 růžemi, jednak s 5 růžemi. Kytic se 3 růžemi uvázala o 8 méně než kytic s 5 růžemi. Na všechny kytice dohromady použila 128 růží.','Kolik kytic květinářka celkem uvázala?'},
  new List<String>{'A) 36 kytic','B) 34 kytic','C) 32 kytic','D) 30 kytic','E) 28 kytic'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Kytic s 5 růžemi je $x$, se 3 růžemi $x-8$. Růže: $5x+3(x-8)=128$, tj. $8x-24=128$, $x=19$. Celkem $19+(19-8)=30$ kytic.'},
  'D) 30 kytic',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2023 – úloha 10',
  new List<String>{'Anežka je o pětinu nižší než já, ale tatínek je o pětinu vyšší než já. Anežka měří o 60 cm méně než tatínek.','Kolik cm měří Anežka?'},
  new List<String>{'A) méně než 100 cm','B) 100 cm','C) 120 cm','D) 150 cm','E) více než 150 cm'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Moje výška $j$: Anežka $\\frac{4}{5}j$, tatínek $\\frac{6}{5}j$. Rozdíl $\\frac{6}{5}j-\\frac{4}{5}j=\\frac{2}{5}j=60$, tedy $j=150$ cm. Anežka $\\frac{4}{5}\\cdot 150=120$ cm.'},
  'C) 120 cm',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2023 – úloha 11',
  new List<String>{'Na parkovišti je přesně 105 parkovacích míst pro osobní auta. Zaparkuje-li na parkovišti autobus, obsadí vždy 4 parkovací místa pro osobní auta. (Parkoviště tedy zcela zaplní např. 101 osobních aut a jeden autobus.) Nyní je parkoviště zcela zaplněno, přitom osobních aut je na něm třikrát více než autobusů.','O kolik se liší počet osobních aut a počet autobusů na parkovišti?'},
  new List<String>{'A) o méně než 30','B) o 30','C) o 32','D) o 36','E) o více než 36'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Autobusů je $b$, osobních aut $3b$. Autobus zabere 4 místa, auto 1 místo: $4b+3b=7b=105$, tedy $b=15$ a aut je 45. Rozdíl $45-15=30$.'},
  'B) o 30',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2023 – úloha 12',
  new List<String>{'Velký obdélník lze rozdělit na dva stejné menší obdélníky nebo na dva čtverce (viz obrázek). Obvod jednoho z menších obdélníků je 30 cm.','Jaký je obvod velkého obdélníku?'},
  new List<String>{'A) menší než 36 cm','B) 36 cm','C) 40 cm','D) 60 cm','E) větší než 60 cm'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdělení na dva čtverce znamená, že delší strana velkého obdélníku je dvojnásobek kratší: $W=2H$. Menší obdélník (polovina velkého) má rozměry $W\\times\\frac{H}{2}=2H\\times\\frac{H}{2}$ a obvod $2\\left(2H+\\frac{H}{2}\\right)=5H=30$, tedy $H=6$ cm a $W=12$ cm. Obvod velkého obdélníku je $2(12+6)=36$ cm.'},
  'B) 36 cm',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2023 – úloha 13',
  new List<String>{'Těleso na obrázku je slepeno ze 6 stejných válců. V zadání jsou dány pohledy na těleso shora a zprava.','Ke každé situaci (13.1–13.3) přiřaďte odpovídající obrazec (A–F z testového sešitu).','13.1 Pohled na těleso zezadu.','13.2 Pohled na těleso zleva.','13.3 Pohled na těleso zespodu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif"> <text x="280" y="48" font-size="13" text-anchor="middle">Teleso slepene ze 6 stejnych valcu; prirazuji se pohledy zezadu, zleva a zespodu k obrazcum A-F.</text> <text x="280" y="74" font-size="11" text-anchor="middle" fill="#666">Prostorove teleso a varianty A-F nelze verne prenest do SVG; posuzuje se podle testoveho sesitu.</text> </svg>',
  'teleso-valce.svg',
  'Těleso slepené ze šesti stejných válců a schematická poznámka k variantám A–F.',
  'Prostorové těleso ze 6 válců – varianty A–F viz testový sešit',
  new List<String>{'Podle rozmístění 6 válců odpovídá pohled zezadu obrazci A, pohled zleva obrazci C a pohled zespodu obrazci E.'},
  '13.1: A; 13.2: C; 13.3: E',
  5, 6, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
