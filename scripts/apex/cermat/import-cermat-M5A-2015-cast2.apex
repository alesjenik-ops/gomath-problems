String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 4',
  new List<String>{'Nahraďte každou hvězdičku takovou číslicí, aby byl písemný výpočet bez chyby (viz obrázek).','Do záznamového archu přepište celý zápis výpočtu (menšenec, menšitel i rozdíl).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 150" font-family="serif"><text x="70" y="40" font-size="26" text-anchor="middle">7</text><text x="108" y="40" font-size="26" text-anchor="middle">0</text><text x="146" y="40" font-size="26" text-anchor="middle">8</text><text x="184" y="40" font-size="26" text-anchor="middle">&#8727;</text><text x="70" y="82" font-size="26" text-anchor="middle">&#8727;</text><text x="108" y="82" font-size="26" text-anchor="middle">2</text><text x="146" y="82" font-size="26" text-anchor="middle">&#8727;</text><text x="184" y="82" font-size="26" text-anchor="middle">8</text><text x="70" y="130" font-size="26" text-anchor="middle">1</text><text x="108" y="130" font-size="26" text-anchor="middle">&#8727;</text><text x="146" y="130" font-size="26" text-anchor="middle">1</text><text x="184" y="130" font-size="26" text-anchor="middle">6</text><text x="34" y="82" font-size="26" text-anchor="middle">&#8722;</text><line x1="26" y1="96" x2="200" y2="96" stroke="#000" stroke-width="2"/></svg>',
  'pisemne-odcitani.svg',
  'Písemné odčítání pod sebou: menšenec 7 0 8 hvězdička, menšitel hvězdička 2 hvězdička 8, rozdíl 1 hvězdička 1 6.',
  'Písemné odčítání s chybějícími číslicemi',
  new List<String>{'Jednotky: číslice v jednotkách menšence po výpůjčce dává $14-8=6$, tedy v jednotkách menšence je 4.','Desítky: $8-\\square-1=1$, tedy v desítkách menšitele je 6. Stovky: $0-2$ vyžaduje výpůjčku, $10-2=8$, v rozdílu jsou tedy stovky 8.','Tisíce: $7-\\square-1=1$, v tisících menšitele je 5. Celkem $7\\,084-5\\,268=1\\,816$.'},
  '$7\\,084-5\\,268=1\\,816$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 5',
  new List<String>{'Ve škole se musí denně uklidit 12 tříd. Pan školník zvládne uklidit první polovinu všech tříd za 1 hodinu a 45 minut.','Někdy mu s úklidem pomáhají ještě dva pomocníci. Úklid kterékoli třídy trvá školníkovi i každému pomocníkovi stejně dlouhou dobu.','5.1 Vypočtěte, jak dlouho trvá celý úklid, jestliže i druhou polovinu tříd uklízí pan školník sám.','5.2 Vypočtěte, jak dlouho trvá celý úklid, jestliže druhou polovinu tříd uklízí pan školník společně s oběma pomocníky.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Polovina tříd je 6 tříd a školníkovi trvá $1$ h $45$ min $=105$ minut, jedna třída mu tedy trvá $105:6=17{,}5$ minuty.','5.1 Druhá polovina trvá školníkovi stejně dlouho: $105+105=210$ minut, tj. $3$ hodiny $30$ minut.','5.2 Druhou polovinu uklízejí tři lidé stejným tempem, každý z nich tedy uklidí 2 třídy za $2\\cdot 17{,}5=35$ minut. Celkem $105+35=140$ minut, tj. $2$ hodiny $20$ minut.'},
  '5.1: $3$ h $30$ min; 5.2: $2$ h $20$ min',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2015 – úloha 6',
  new List<String>{'5 balíčků sušenek stojí 80 Kč. 2 čokolády stojí stejně jako 3 balíčky sušenek. Hana si koupila 1 čokoládu a 2 balíčky sušenek.','6.1 Vypočtěte, kolik korun stojí 2 čokolády.','6.2 Vypočtěte, kolik korun Hana zaplatila.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jeden balíček sušenek stojí $80:5=16$ Kč.','6.1 Dvě čokolády stojí stejně jako tři balíčky, tedy $3\\cdot 16=48$ Kč.','6.2 Jedna čokoláda stojí $48:2=24$ Kč, dva balíčky stojí $2\\cdot 16=32$ Kč. Hana zaplatila $24+32=56$ Kč.'},
  '6.1: $48$ Kč; 6.2: $56$ Kč',
  4, 5, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
