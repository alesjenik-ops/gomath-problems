String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M5B 2025 - uloha 9',
  new List<String>{'Do prazdnych bilych poli tabulky patri cisla $27$, $50$, $62$ a jeste jedno nezname cislo. Kazde cislo v sedem poli tabulky je soucin cisel v prislusnem radku nebo sloupci (viz tabulka).','Jake je nezname cislo, ktere patri do tabulky?'},
  new List<String>{'A) $13$','B) $16$','C) $23$','D) $26$','E) jine cislo'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 160" font-family="sans-serif"><rect x="20" y="20" width="70" height="42" fill="#ffffff" stroke="#000"/><rect x="90" y="20" width="70" height="42" fill="#ffffff" stroke="#000"/><text x="125.0" y="46.0" font-size="14" text-anchor="middle">29</text><rect x="160" y="20" width="70" height="42" fill="#ffffff" stroke="#000"/><rect x="230" y="20" width="86" height="42" fill="#cccccc" stroke="#000"/><text x="273.0" y="46.0" font-size="14" text-anchor="middle">23 374</text><rect x="20" y="62" width="70" height="42" fill="#ffffff" stroke="#000"/><text x="55.0" y="88.0" font-size="14" text-anchor="middle">11</text><rect x="90" y="62" width="70" height="42" fill="#ffffff" stroke="#000"/><rect x="160" y="62" width="70" height="42" fill="#ffffff" stroke="#000"/><rect x="230" y="62" width="86" height="42" fill="#cccccc" stroke="#000"/><text x="273.0" y="88.0" font-size="14" text-anchor="middle">14 850</text><rect x="20" y="104" width="70" height="42" fill="#cccccc" stroke="#000"/><text x="55.0" y="130.0" font-size="14" text-anchor="middle">682</text><rect x="90" y="104" width="70" height="42" fill="#cccccc" stroke="#000"/><text x="125.0" y="130.0" font-size="14" text-anchor="middle">783</text><rect x="160" y="104" width="70" height="42" fill="#cccccc" stroke="#000"/><text x="195.0" y="130.0" font-size="14" text-anchor="middle">650</text><rect x="230" y="104" width="86" height="42" fill="#cccccc" stroke="#000"/></svg>',
  'tabulka-souciny.svg',
  'Tabulka 3 krat 4; seda pole obsahuji souciny cisel v radku nebo sloupci, bila pole obsahuji 29, 11 a doplnovana cisla.',
  'Tabulka soucinu',
  new List<String>{'Z prvniho sloupce: $682=11\\cdot ?$, tedy horni bile pole je $62$. Z druheho sloupce: $783=29\\cdot ?$, tedy $27$. Ve tretim sloupci je soucin dvou bilych poli $650$. Zbyvaji cisla $50$ a nezname; $650:50=13$, proto nezname cislo je $13$. Kontrola radku: $62\\cdot 29\\cdot 13=23\\,374$ a $11\\cdot 27\\cdot 50=14\\,850$.'},
  'A) $13$',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 10',
  new List<String>{'Zahon ma tvar rovnostranneho trojuhelniku. Cely zahon je osazen zlute a fialove kvetoucimi rostlinami, a to ve stejnych rozestupech. Po jedne rostline je i v kazdem vrcholu trojuhelniku. Ze vsech rostlin na zahone je $39$ rostlin rozmisteno po obvodu zahonu.','Zlute kvetouci rostliny vytvareji v zahonu $6$ stejnych zlutych rovnostrannych trojuhelniku. Fialove kvetouci rostliny tvori $3$ fialove rovnostranne trojuhelniky. Kazdy fialovy trojuhelnik ma o $1$ radu rostlin vice nez zluty trojuhelnik.','Kolik zlute kvetoucich rostlin vytvari jeden zluty trojuhelnik?'},
  new List<String>{'A) $6$ rostlin','B) $9$ rostlin','C) $10$ rostlin','D) $12$ rostlin','E) $15$ rostlin'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 240" font-family="sans-serif"><polygon points="160,40 126.7,96.7 193.3,96.7" fill="#e6e6e6" stroke="#000"/><polygon points="126.7,96.7 93.3,153.3 160.0,153.3" fill="#e6e6e6" stroke="#000"/><polygon points="193.3,96.7 160.0,153.3 226.7,153.3" fill="#e6e6e6" stroke="#000"/><polygon points="93.3,153.3 60,210 126.7,210.0" fill="#e6e6e6" stroke="#000"/><polygon points="160.0,153.3 126.7,210.0 193.3,210.0" fill="#e6e6e6" stroke="#000"/><polygon points="226.7,153.3 193.3,210.0 260,210" fill="#e6e6e6" stroke="#000"/><polygon points="126.7,96.7 193.3,96.7 160.0,153.3" fill="#8f8f8f" stroke="#000"/><polygon points="93.3,153.3 160.0,153.3 126.7,210.0" fill="#8f8f8f" stroke="#000"/><polygon points="160.0,153.3 226.7,153.3 193.3,210.0" fill="#8f8f8f" stroke="#000"/><text x="150" y="234" font-size="11" text-anchor="middle" fill="#555">6 zlutych (svetle) a 3 fialove (tmave) trojuhelniky - schematicky</text></svg>',
  'zahon-10.svg',
  'Rovnostranny trojuhelnikovy zahon rozdeleny na mensi zlute a fialove rovnostranne trojuhelniky.',
  'Rozmisteni trojuhelniku na zahone (schematicky nakres)',
  new List<String>{'Na obvodu je $39$ rostlin; kazda strana zahonu ma tedy $39:3+1=14$ rostlin a $13$ rozestupu. Celkem je na zahone $\\frac{14\\cdot 15}{2}=105$ rostlin.','Zluty trojuhelnik ma $4$ rostliny na strane (tj. $3$ rozestupy), a proto $\\frac{4\\cdot 5}{2}=10$ rostlin.'},
  'C) $10$ rostlin',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
