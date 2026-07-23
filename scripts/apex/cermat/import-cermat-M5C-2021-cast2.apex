String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD21C0T03';
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
  'CERMAT M5C 2021 – úloha 5',
  new List<String>{'$5$ talířků a $2$ hrnky váží stejně jako $2$ mísy. $1$ mísa váží stejně jako $3$ hrnky.','5.1 Vypočtěte, kolik talířků váží stejně jako $4$ hrnky.','5.2 Vypočtěte, kolik talířků váží stejně jako $4$ mísy.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Z $1$ mísa $=3$ hrnky plyne $2$ mísy $=6$ hrnků. Pak $5$ talířků $+2$ hrnky $=6$ hrnků, tedy $5$ talířků $=4$ hrnky.','5.1 $4$ hrnky $=5$ talířků.','5.2 $4$ mísy $=12$ hrnků $=3\\cdot(4$ hrnky$)=3\\cdot 5=15$ talířků.'},
  '5.1: $5$ talířků; 5.2: $15$ talířků',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2021 – úloha 6',
  new List<String>{'Na vytvoření obrazce můžeme použít velké a malé čtverce a trojúhelníky. Malý čtverec má obsah $4$ cm². Velký čtverec lze složit z $9$ malých čtverců. Trojúhelníky získáme rozstřižením malého nebo velkého čtverce na dvě poloviny.','6.1 Vypočtěte v cm² obsah obrazce A.','6.2 Vypočtěte v cm² obsah obrazce B.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 250" font-family="sans-serif"> <text x="150" y="22" font-size="15" text-anchor="middle">Obrazec A</text> <polygon points="150,45 250,150 50,150" fill="none" stroke="#000" stroke-width="2"/> <rect x="215" y="70" width="28" height="80" fill="none" stroke="#000" stroke-width="2"/> <line x1="215" y1="97" x2="243" y2="97" stroke="#000"/> <line x1="215" y1="124" x2="243" y2="124" stroke="#000"/> <rect x="115" y="150" width="70" height="82" fill="none" stroke="#000" stroke-width="2"/> <text x="470" y="22" font-size="15" text-anchor="middle">Obrazec B</text> <polygon points="360,215 360,150 378,150 378,132 396,132 396,150 420,150 420,132 438,132 438,150 462,150 600,215" fill="none" stroke="#000" stroke-width="2"/> <rect x="470" y="120" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/> <line x1="470" y1="120" x2="496" y2="146" stroke="#000"/> <text x="483" y="112" font-size="11" text-anchor="middle">malý čtverec</text> </svg>',
  'obrazce-ab.svg',
  'Obrazec A ve tvaru domku s komínem a obrazec B ve tvaru svahu se zuby, sestavené z čtverců a trojúhelníků (schematicky).',
  'Obrazec A a obrazec B',
  new List<String>{'Malý čtverec má $4$ cm², velký $9\\cdot 4=36$ cm²; jejich poloviny (trojúhelníky) mají $2$ cm², resp. $18$ cm². Součtem obsahů použitých dílů:','6.1 Obrazec A má obsah $82$ cm².','6.2 Obrazec B má obsah $104$ cm².'},
  '6.1: $82$ cm²; 6.2: $104$ cm²',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2021 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).','Bod $A$ je vrchol trojúhelníku $ABC$, jehož strana $AC$ měří $4$ cm. Oba vrcholy $B$, $C$ tohoto trojúhelníku leží na přímce $p$. Bod $S$ je střed strany $BC$.','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"> <line x1="60" y1="200" x2="470" y2="80" stroke="#000" stroke-width="2"/> <text x="46" y="206" font-size="16" font-style="italic">p</text> <line x1="294" y1="126" x2="306" y2="134" stroke="#000" stroke-width="1"/> <text x="306" y="120" font-size="15" font-style="italic">S</text> <line x1="244" y1="244" x2="256" y2="256" stroke="#000" stroke-width="2"/> <line x1="256" y1="244" x2="244" y2="256" stroke="#000" stroke-width="2"/> <text x="247" y="272" font-size="15" font-style="italic">A</text> </svg>',
  'body-a-s-p.svg',
  'Bod A, bod S a přímka p procházející bodem S; A leží pod přímkou p.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Vrchol $C$ leží na přímce $p$ a zároveň na kružnici se středem $A$ a poloměrem $4$ cm — to dává dvě polohy $C_1$, $C_2$. Bod $B$ je obrazem $C$ ve středové souměrnosti se středem $S$ (protože $S$ je střed $BC$). Vzniknou dva trojúhelníky $ABC$.'},
  'Dvě řešení: $C$ je průsečík přímky $p$ s kružnicí se středem $A$ a poloměrem $4$ cm; bod $B$ je obrazem bodu $C$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
