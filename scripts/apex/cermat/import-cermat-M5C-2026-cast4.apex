String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
Integer YEAR = 2026;

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
  'CERMAT M5C 2026 – úloha 6',
  new List<String>{'První šestiúhelník se skládá ze dvou stejných bílých rovnostranných trojúhelníků a dvou šedých trojúhelníků. Oba šedé trojúhelníky jsou stejné. Trojúhelníky přeskládáme do druhého šestiúhelníku (viz obrázek). Nejdelší strana šedého trojúhelníku měří 10 cm. Obvod prvního šestiúhelníku je 40 cm a obvod druhého šestiúhelníku je 46 cm.','6.1 Určete v cm délku jedné strany bílého rovnostranného trojúhelníku.','6.2 Určete v cm délku nejkratší strany šedého trojúhelníku.','6.3 Určete v cm rozdíl obvodů jednoho šedého a jednoho bílého trojúhelníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 190" font-family="sans-serif"> <text x="120" y="24" font-size="12" text-anchor="middle">1. šestiúhelník</text> <polygon points="30,100 120,45 210,100 120,155" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="120,45 120,155 70,100" fill="#bdbdbd" stroke="#000"/> <polygon points="120,45 120,155 170,100" fill="#bdbdbd" stroke="#000"/> <line x1="120" y1="45" x2="120" y2="155" stroke="#000"/> <text x="126" y="104" font-size="12">10 cm</text> <text x="370" y="24" font-size="12" text-anchor="middle">2. šestiúhelník</text> <polygon points="290,150 370,60 450,150" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="290,150 370,60 370,150" fill="#bdbdbd" stroke="#000"/> <polygon points="450,150 370,60 370,150" fill="#bdbdbd" stroke="#000"/> <line x1="370" y1="60" x2="370" y2="150" stroke="#000"/> <text x="316" y="166" font-size="11">10 cm</text> <text x="398" y="166" font-size="11">10 cm</text> </svg>',
  'sestiuhelniky.svg',
  'První a druhý šestiúhelník složené ze dvou bílých rovnostranných a dvou šedých trojúhelníků.',
  'Schematický nákres dvou šestiúhelníků',
  new List<String>{'Bílý trojúhelník je rovnostranný se stranou $a$. Šedý trojúhelník má nejdelší stranu $10$ cm.','Z obvodů obou šestiúhelníků (prvního $40$ cm a druhého $46$ cm) vychází strana bílého trojúhelníku $a = 7$ cm; strany šedého trojúhelníku jsou pak $6$ cm, $7$ cm a $10$ cm.','6.1 Strana bílého trojúhelníku měří $7$ cm.','6.2 Nejkratší strana šedého trojúhelníku měří $6$ cm.','6.3 Obvod šedého trojúhelníku je $6+7+10 = 23$ cm, obvod bílého $3\\cdot 7 = 21$ cm; liší se o $2$ cm.'},
  '6.1: $7$ cm; 6.2: $6$ cm; 6.3: o $2$ cm',
  5, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol trojúhelníku $ABC$. Bod $S$ je střed strany $AC$ tohoto trojúhelníku. Na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$. Body $P$ a $S$ mají od vrcholu $C$ stejnou vzdálenost.','Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 250" font-family="sans-serif"> <line x1="30" y1="215" x2="410" y2="85" stroke="#000" stroke-width="2"/> <text x="416" y="82" font-size="16" font-style="italic">p</text> <text x="86" y="197" font-size="15">×</text> <text x="90" y="213" font-size="15" font-style="italic">A</text> <text x="212" y="122" font-size="15">×</text> <text x="216" y="114" font-size="15" font-style="italic">S</text> </svg>',
  'body-AS-p.svg',
  'Body A a S a přímka p procházející bodem A.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'$S$ je střed strany $AC$, proto vrchol $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$ (bod $C$ leží na polopřímce $AS$ za bodem $S$, $|SC| = |AS|$).','Body $P$ a $S$ mají od $C$ stejnou vzdálenost, tedy $|CP| = |CS|$. Střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $|CS|$; ta protne přímku $p$ ve dvou bodech $P_1$, $P_2$.','$P$ je střed strany $BC$, proto vrchol $B$ je obraz bodu $C$ ve středové souměrnosti se středem $P$ ($|PB| = |PC|$). Dostaneme dvě řešení s vrcholy $B_1$, $B_2$.'},
  'Dvě řešení. $C$ je obraz $A$ podle středu $S$; střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $|CS|$ (body $P_1$, $P_2$); vrchol $B$ je obraz $C$ podle středu $P$ – viz náčrt v klíči.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
