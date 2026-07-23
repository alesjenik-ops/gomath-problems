String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M5C 2024 – úloha 1.1',
  new List<String>{'Vypočítejte: $(12\\cdot 12):6+12\\cdot 6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(12\\cdot 12):6+12\\cdot 6=144:6+72=24+72=96$.'},
  '$96$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 1.2',
  new List<String>{'Vypočítejte: $(1970+8\\cdot 23)-(1971-21:7)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(1970+184)-(1971-3)=2154-1968=186$.'},
  '$186$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 2',
  new List<String>{'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby výpočet byl správný.','Písemné sčítání dvou čtyřciferných čísel: číslo tvaru *36* plus číslo tvaru 1**8 se rovná 5 812. Každá hvězdička (*) představuje tutéž číslici.','Do záznamového archu uveďte pouze chybějící číslici.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hledanou číslici $c$. Součet je $5\\,812$; po dosazení dostaneme $1\\,111\\cdot c+1\\,368=5\\,812$, tedy $1\\,111\\cdot c=4\\,444$ a $c=4$. Zkouška: $4\\,364+1\\,448=5\\,812$.'},
  '$4$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 3',
  new List<String>{'V součtovém trojúhelníku platí, že součet dvou čísel, která jsou v rámečcích v řádku vedle sebe, je vždy zapsán o řádek níže do rámečku, který s těmito oběma čísly sousedí. Například z čísel $1$, $2$, $3$ v horním řádku vznikne v dalším řádku $3$ a $5$ a v posledním řádku $8$.','V daném součtovém trojúhelníku jsou v horním řádku dvě šedá pole a číslo $8$, v posledním řádku je číslo $44$. Do obou šedých polí patří stejné číslo.','Jaké číslo musí být v obou šedých polích?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 170" font-family="sans-serif"> <rect x="100" y="30" width="70" height="40" fill="#c9c9c9" stroke="#000"/> <rect x="170" y="30" width="70" height="40" fill="#c9c9c9" stroke="#000"/> <rect x="240" y="30" width="70" height="40" fill="#fff" stroke="#000"/> <text x="275" y="56" font-size="18" text-anchor="middle">8</text> <rect x="135" y="70" width="70" height="40" fill="#fff" stroke="#000"/> <rect x="205" y="70" width="70" height="40" fill="#fff" stroke="#000"/> <rect x="170" y="110" width="70" height="40" fill="#fff" stroke="#000"/> <text x="205" y="136" font-size="18" text-anchor="middle">44</text> </svg>',
  'souctovy-trojuhelnik.svg',
  'Součtový trojúhelník: horní řádek dvě šedá pole a číslo 8, prostřední řádek dvě prázdná pole, dolní řádek číslo 44.',
  'Součtový trojúhelník',
  new List<String>{'Označme číslo v šedých polích $x$. Horní řádek: $x$, $x$, $8$. Prostřední řádek: $x+x=2x$ a $x+8$. Poslední řádek: $2x+(x+8)=3x+8$. Má platit $3x+8=44$, tedy $3x=36$ a $x=12$.'},
  '$12$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 4.1',
  new List<String>{'Jsou dána dvě čísla. Druhé číslo je polovinou čísla prvního. Součet těchto dvou čísel je $150$.','Určete první i druhé číslo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme první číslo $a$, druhé $\\frac{a}{2}$. Platí $a+\\frac{a}{2}=150$, tj. $\\frac{3}{2}a=150$, odtud $a=100$ a druhé číslo je $50$.'},
  'první číslo: $100$; druhé číslo: $50$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 4.2',
  new List<String>{'Olga si z ušetřených peněz koupila knížku za $170$ Kč a čokoládu za $26$ Kč. Maminka jí pak přidala $100$ Kč na dárek pro babičku, který stál $180$ Kč. Poté, co Olga koupila babičce tento dárek, zbylo Olze $130$ Kč.','Kolik měla Olga ušetřeno před nákupem knížky a čokolády?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme úspory $u$. Platí $u-170-26+100-180=130$, tj. $u-276=130$, odtud $u=406$ Kč.'},
  '$406$ Kč',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
