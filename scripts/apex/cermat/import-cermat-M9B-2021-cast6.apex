String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M9B 2021 – úloha 12',
  new List<String>{'V rovině leží rovnoramenný lichoběžník $ABCD$ se základnou $AB$, rovnostranný trojúhelník $BEC$ a polopřímky $AB$, $CD$. Úhel vyznačený na obrázku při vrcholu $D$ (mezi polopřímkou $CD$ a ramenem $DA$) měří $65^\\circ$.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $45^\\circ$','B) $45^\\circ$','C) $50^\\circ$','D) $55^\\circ$','E) větší než $55^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 390" font-family="sans-serif"> <polygon points="120,340 360,340 299,210 181,210" fill="none" stroke="#000" stroke-width="2"/> <line x1="360" y1="340" x2="470" y2="340" stroke="#000" stroke-width="2"/> <line x1="181" y1="210" x2="105" y2="210" stroke="#000" stroke-width="2"/> <line x1="360" y1="340" x2="442" y2="222" stroke="#000" stroke-width="2"/> <line x1="299" y1="210" x2="442" y2="222" stroke="#000" stroke-width="2"/> <text x="106" y="356" font-size="15" font-style="italic">A</text> <text x="356" y="360" font-size="15" font-style="italic">B</text> <text x="300" y="202" font-size="15" font-style="italic">C</text> <text x="174" y="202" font-size="15" font-style="italic">D</text> <text x="450" y="222" font-size="15" font-style="italic">E</text> <text x="150" y="236" font-size="13">65°</text> <text x="376" y="328" font-size="15">φ</text> </svg>',
  'lichobeznik-BEC.svg',
  'Rovnoramenný lichoběžník ABCD se základnou AB, na straně BC rovnostranný trojúhelník BEC; u D úhel 65°, u B úhel fí.',
  'Lichoběžník ABCD s rovnostranným trojúhelníkem BEC',
  new List<String>{'Vyznačený úhel $65^\\circ$ je vedlejší k vnitřnímu úhlu lichoběžníku při vrcholu $D$, proto úhel při základně (u vrcholů $A$ a $B$) je $65^\\circ$. Polopřímka $AB$ svírá s ramenem $BC$ úhel $180^\\circ-65^\\circ=115^\\circ$. Trojúhelník $BEC$ je rovnostranný, takže úhel $CBE=60^\\circ$. Odtud $\\varphi=115^\\circ-60^\\circ=55^\\circ$.'},
  'D) $55^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2021 – úloha 13',
  new List<String>{'Válcovací stroj se pohyboval přímo vpřed. Jeho přední rotační válec vykonal při tomto pohybu $200$ otáček (bez prokluzu). Válec má průměr podstavy $0{,}5$ m a zanechává za sebou uválcovaný pás široký $0{,}8$ m. (Jedna otáčka je otočení o $360^\\circ$.)','Kolik m² uválcoval přední rotační válec? Výsledek je zaokrouhlen na celé m². Za $\\pi$ lze dosadit $3{,}14$.'},
  new List<String>{'A) méně než $250$ m²','B) $251$ m²','C) $314$ m²','D) $331$ m²','E) více než $332$ m²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 270" font-family="sans-serif"> <polygon points="90,250 340,250 440,205 190,205" fill="#e8e8e8" stroke="#999"/> <text x="265" y="245" font-size="12" text-anchor="middle" fill="#555">uválcovaný pás</text> <rect x="170" y="60" width="180" height="90" fill="#cfcfcf" stroke="#000"/> <ellipse cx="170" cy="105" rx="22" ry="45" fill="#bcbcbc" stroke="#000"/> <ellipse cx="350" cy="105" rx="22" ry="45" fill="#d8d8d8" stroke="#000"/> <line x1="392" y1="60" x2="392" y2="150" stroke="#000" stroke-width="1"/> <polygon points="392,60 388,70 396,70" fill="#000"/> <polygon points="392,150 388,140 396,140" fill="#000"/> <text x="400" y="110" font-size="14">0,5 m</text> <line x1="170" y1="172" x2="350" y2="172" stroke="#000" stroke-width="1"/> <polygon points="170,172 180,168 180,176" fill="#000"/> <polygon points="350,172 340,168 340,176" fill="#000"/> <text x="260" y="190" font-size="14" text-anchor="middle">0,8 m</text> </svg>',
  'valec.svg',
  'Schematický rotační válec s vyznačeným průměrem podstavy 0,5 m a šířkou uválcovaného pásu 0,8 m.',
  'Rotační válec (schematicky)',
  new List<String>{'Za jednu otáčku válec ujede délku svého obvodu $\\pi\\cdot 0{,}5=3{,}14\\cdot 0{,}5=1{,}57$ m a uválcuje pás šířky $0{,}8$ m, tj. plochu $1{,}57\\cdot 0{,}8=1{,}256$ m². Za $200$ otáček je to $200\\cdot 1{,}256=251{,}2$ m², po zaokrouhlení $251$ m².'},
  'B) $251$ m²',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
