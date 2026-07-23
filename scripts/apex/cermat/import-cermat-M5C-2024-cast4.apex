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
  'CERMAT M5C 2024 – úloha 9',
  new List<String>{'Kilogram broskví stojí $32$ Kč a kilogram jablek $28$ Kč. Petra koupila stejný počet kilogramů jablek jako broskví a utratila $720$ Kč.','Kolik kilogramů broskví Petra koupila?'},
  new List<String>{'A) $6$','B) $8$','C) $10$','D) $12$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Za $1$ kg broskví a $1$ kg jablek zaplatí $32+28=60$ Kč. Petra utratila $720$ Kč, tj. $720:60=12$ kg broskví (a $12$ kg jablek).'},
  'D) $12$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2024 – úloha 10',
  new List<String>{'Zuzana měla pytlík s bonbóny, kterých bylo méně než $60$. Bonbóny se rozhodla rozdělit rovným dílem mezi své kamarády. Beze zbytku je mohla rozdělit mezi $2$, $3$ nebo $4$ kamarády. Pokud by však měla kamarádů $7$ a chtěla bonbóny rozdělit mezi ně, zbyly by jí právě $3$ bonbóny.','Kolik bonbónů měla Zuzana v pytlíku?'},
  new List<String>{'A) $24$','B) $36$','C) $42$','D) $48$','E) $56$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet je dělitelný $2$, $3$ i $4$, tedy dělitelný $12$, a menší než $60$: možnosti $12$, $24$, $36$, $48$. Po dělení číslem $7$ dává zbytek $3$ jen $24$ ($24=3\\cdot 7+3$).'},
  'A) $24$',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2024 – úloha 11',
  new List<String>{'Do čtvercové sítě je zakreslen šedý čtyřúhelník, jehož vrcholy leží v mřížových bodech. Na otázku, jakou část z plochy čtvercové sítě zabírá plocha šedého čtyřúhelníku, odpověděla Alena, že je to více než polovina. Blanka odpověděla, že čtyřúhelník zabírá jednu polovinu čtvercové sítě. Cecílie odpověděla, že jde o tři šestiny čtvercové sítě, a Darina uvedla jako odpověď tři pětiny čtvercové sítě (viz obrázek).','Kdo odpověděl správně?'},
  new List<String>{'A) Alena a Darina','B) Blanka a Cecílie','C) jenom Alena','D) jenom Darina','E) ani jedna z dívek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 160 160" font-family="sans-serif"><polygon points="60,20 140,60 100,140 20,60" fill="#b9b9b9" stroke="#000" stroke-width="1.5"/><line x1="20" y1="20" x2="20" y2="140" stroke="#000"/><line x1="60" y1="20" x2="60" y2="140" stroke="#000"/><line x1="100" y1="20" x2="100" y2="140" stroke="#000"/><line x1="140" y1="20" x2="140" y2="140" stroke="#000"/><line x1="20" y1="20" x2="140" y2="20" stroke="#000"/><line x1="20" y1="60" x2="140" y2="60" stroke="#000"/><line x1="20" y1="100" x2="140" y2="100" stroke="#000"/><line x1="20" y1="140" x2="140" y2="140" stroke="#000"/></svg>',
  'ctyruhelnik-sit.svg',
  'Čtvercová síť tři krát tři se šedým čtyřúhelníkem, jehož vrcholy leží v mřížových bodech.',
  'Šedý čtyřúhelník ve čtvercové síti',
  new List<String>{'Čtvercová síť má $3\\times 3=9$ čtverečků. Obsah šedého čtyřúhelníku je $4{,}5$ čtverečku, tj. $\\frac{4{,}5}{9}=\\frac{1}{2}$ sítě. Polovinu uvedla Blanka; tři šestiny $\\frac{3}{6}=\\frac{1}{2}$ uvedla Cecílie – obě odpověděly správně.'},
  'B) Blanka a Cecílie',
  2, 3, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
