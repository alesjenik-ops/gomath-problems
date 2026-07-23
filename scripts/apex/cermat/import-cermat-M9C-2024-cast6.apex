String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
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
  'CERMAT M9C 2024 – úloha 15',
  new List<String>{'Všichni žáci 9. A a 9. B odpověděli v průzkumu, jakou střední školu chtějí studovat. Žáci chtějí na gymnázia (GYM), střední odborné školy (SOŠ) nebo střední odborná učiliště (SOU). Ti, kteří chtějí na SOŠ, uvedli také obor zaměření — humanitní, technický, či umělecký. Na gymnázia chce jít studovat $12$ žáků. Nejmenší zájem je o odborná učiliště, kam chce jít $16\\,\\%$ žáků. Největší zájem je o střední odborné školy, na kterých chtějí studovat všichni, kteří nechtějí jít na gymnázia ani na odborná učiliště. Na uměleckou střední školu chtějí $3$ žáci, $15$ žáků na technicky zaměřenou střední školu, ostatní, kteří chtějí na SOŠ, by si vybrali humanitní obor. Výsledky průzkumu jsou v grafech (viz obrázek).','Rozhodněte o každém z následujících tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).','15.1 Na uměleckou střední školu chce jít $6\\,\\%$ všech žáků.','15.2 V 9. A a 9. B je celkem více než $50$ žáků.','15.3 Na gymnázia a na humanitní střední školy se chce hlásit stejný počet žáků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"> <text x="140" y="24" font-size="12" text-anchor="middle">Zájem o gymnázia, SOŠ a SOU</text> <path d="M140 150 L140 70 A80 80 0 0 1 219.8 145.0 Z" fill="#e8e8e8" stroke="#000"/> <path d="M140 150 L219.8 145.0 A80 80 0 0 1 186.0 214.7 Z" fill="#ffffff" stroke="#000"/> <path d="M140 150 L186.0 214.7 A80 80 0 1 1 140 70 Z" fill="#d0d0d0" stroke="#000"/> <text x="196" y="112" font-size="11" text-anchor="middle">12 žáků</text> <text x="196" y="124" font-size="11" text-anchor="middle">GYM</text> <text x="200" y="192" font-size="11" text-anchor="middle">16 % SOU</text> <text x="92" y="160" font-size="11" text-anchor="middle">60 % SOŠ</text> <text x="380" y="24" font-size="12" text-anchor="middle">SOŠ podle zaměření</text> <path d="M380 150 L380 70 A80 80 0 0 1 427.0 214.7 Z" fill="#e8e8e8" stroke="#000"/> <path d="M380 150 L427.0 214.7 A80 80 0 0 1 380 230 Z" fill="#ffffff" stroke="#000"/> <path d="M380 150 L380 230 A80 80 0 1 1 380 70 Z" fill="#9a9a9a" stroke="#000"/> <text x="345" y="145" font-size="11" text-anchor="middle">technické</text> <text x="345" y="157" font-size="11" text-anchor="middle">15 žáků</text> <text x="432" y="140" font-size="11" text-anchor="middle">humanitní</text> <text x="432" y="248" font-size="11" text-anchor="middle">3 žáci</text> <text x="432" y="260" font-size="11" text-anchor="middle">umělecké</text> </svg>',
  'grafy-skoly.svg',
  'Dva kruhové grafy: vlevo zájem o gymnázia (12 žáků), SOŠ (60 %) a SOU (16 %); vpravo rozdělení SOŠ na technické (15 žáků), humanitní a umělecké (3 žáci).',
  'Výsledky průzkumu zájmu o střední školy',
  new List<String>{'Gymnázium volí $12$ žáků, což je $100\\,\\%-60\\,\\%-16\\,\\%=24\\,\\%$ všech žáků. Celkem je tedy $12:0{,}24=50$ žáků. Střední odborné školy volí $60\\,\\%$ z $50$, tj. $30$ žáků; z nich humanitní obor $30-15-3=12$ žáků.','15.1 Umělecký obor volí $3$ žáci, tj. $\\frac{3}{50}=6\\,\\%$ všech žáků — pravdivé (A).','15.2 Celkem je $50$ žáků, není jich tedy více než $50$ — nepravdivé (N).','15.3 Na gymnázia míří $12$ žáků a na humanitní SOŠ také $12$ žáků — pravdivé (A).'},
  '15.1: Ano; 15.2: Ne; 15.3: Ano',
  3, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2024 – úloha 16',
  new List<String>{'Deset zedníků dokončí stavbu budovy za $20$ dní. Všichni zedníci jsou stejně výkonní a pracují rovnoměrným tempem.','Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Za kolik dní dokončí stavbu budovy $4$ zedníci?','16.2 Kolik zedníků dokončí stavbu budovy za $5$ dní?','16.3 Kolik dní bude trvat dokončení stavby budovy, jestliže na první polovině stavby pracuje $8$ zedníků a současně na druhé polovině stavby pracuje $10$ zedníků?'},
  new List<String>{'A) $10$','B) $12{,}5$','C) $22{,}5$','D) $40$','E) $50$','F) $52{,}5$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celková práce je $10\\cdot 20=200$ zednických dní.','16.1 $200:4=50$ dní — možnost E.','16.2 $200:5=40$ zedníků — možnost D.','16.3 Každá polovina stavby představuje $100$ zednických dní. První polovina s $8$ zedníky trvá $100:8=12{,}5$ dne, druhá polovina s $10$ zedníky trvá $100:10=10$ dní. Obě poloviny se staví současně, celá stavba je hotová po $12{,}5$ dne — možnost B.'},
  '16.1: E ($50$ dní); 16.2: D ($40$ zedníků); 16.3: B ($12{,}5$ dne)',
  6, 6, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
