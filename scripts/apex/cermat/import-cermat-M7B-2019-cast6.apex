String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 14',
  new List<String>{'V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem 30 žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má 3 sourozence. Skupina žáků se 2 sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence, je dvakrát více než těch, kteří žádného sourozence nemají.','Kolik sourozenců mají dohromady všichni žáci třídy?'},
  new List<String>{'A) 27','B) 28','C) 29','D) 30','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif"><path d="M205,165 L205.0,73.0 A92,92 0 0 1 224.1,75.0 Z" fill="#585858" stroke="#000" stroke-width="1.2"/><path d="M205,165 L224.1,75.0 A92,92 0 0 1 273.4,226.6 Z" fill="#c9c9c9" stroke="#000" stroke-width="1.2"/><path d="M205,165 L273.4,226.6 A92,92 0 0 1 125.3,119.0 Z" fill="#efefef" stroke="#000" stroke-width="1.2"/><path d="M205,165 L125.3,119.0 A92,92 0 0 1 205.0,73.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.2"/><text x="205" y="22" font-size="13" text-anchor="middle">žáci se 3 sourozenci</text><text x="322" y="120" font-size="13">žáci bez sourozenců</text><text x="205" y="312" font-size="13" text-anchor="middle">žáci s 1 sourozencem</text><text x="8" y="95" font-size="13">žáci se 2 sourozenci</text></svg>',
  'graf-sourozenci.svg',
  'Kruhový graf rozdělení 30 žáků podle počtu sourozenců na čtyři výseče (bez, 1, 2, 3 sourozenci).',
  'Rozdělení žáků podle počtu sourozenců',
  new List<String>{'Bez sourozence $10$, se 2 sourozenci $\\frac{30}{6}=5$, se 3 sourozenci $1$, tedy s 1 sourozencem $30-10-5-1=14$. Sourozenců dohromady $14\\cdot 1+5\\cdot 2+1\\cdot 3=27$.'},
  'A) 27',
  2, 3, '2',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2019 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Z přednášky na dvě a půl hodiny zbývá ještě 60 minut do konce. Kolik procent přednášky již uběhlo?','15.2 Z času na test uběhlo teprve 27 minut a zbývá ještě 63 minut. Kolik procent času na test ještě zbývá?','15.3 Všichni tři členové družstva se bez prodlev vystřídali při plnění soutěžního úkolu. První člen vyčerpal 30 % celkového soutěžního času, druhý potřeboval ještě o 10 minut více než první a na třetího zbylo už jen 10 minut. Kolik procent celkového soutěžního času potřeboval druhý člen?'},
  new List<String>{'A) $50\\,\\%$','B) $55\\,\\%$','C) $60\\,\\%$','D) $65\\,\\%$','E) $70\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Přednáška trvá $150$ min, uběhlo $150-60=90$ min, tj. $\\frac{90}{150}=60\\,\\%$ → C.','15.2 Celkem $27+63=90$ min, zbývá $\\frac{63}{90}=70\\,\\%$ → E.','15.3 Celkový čas $T$: $0{,}3T+(0{,}3T+10)+10=T\\Rightarrow 0{,}4T=20\\Rightarrow T=50$ min. Druhý $0{,}3\\cdot 50+10=25$ min, tj. $\\frac{25}{50}=50\\,\\%$ → A.'},
  '15.1: C ($60\\,\\%$); 15.2: E ($70\\,\\%$); 15.3: A ($50\\,\\%$)',
  6, 9, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
