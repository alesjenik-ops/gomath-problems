String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený D6 – omluvení z písemky (rovnice, poměr)',
  new List<String>{'V naší třídě připadá na $4$ dívky $5$ chlapců. Ze včerejší písemky z matematiky se omluvila pětina chlapců a čtvrtina děvčat. Takže nás písemku psalo jen $21$.','6.1 Neznámý celkový počet žáků ve třídě označte $y$ a sestavte rovnici pro výpočet celkového počtu žáků. Celkový počet omluvených vypočtěte.','6.2 Vypočtěte poměr chlapců a dívek, kteří písemku z matematiky psali.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Dívek je $\\frac{4}{9}y$, chlapců $\\frac{5}{9}y$. Písemku psalo $\\frac{4}{5}$ chlapců a $\\frac{3}{4}$ dívek: $\\frac{5}{9}y\\cdot\\frac{4}{5}+\\frac{4}{9}y\\cdot\\frac{3}{4}=21$, tj. $\\frac{7}{9}y=21$, $y=27$. Omluvených je $27-21=6$.','6.2 Psalo $\\frac{4}{5}\\cdot 15=12$ chlapců a $\\frac{3}{4}\\cdot 12=9$ dívek, poměr $12:9=4:3$.'},
  '6.1: $21=\\frac{5}{9}y\\cdot\\frac{4}{5}+\\frac{4}{9}y\\cdot\\frac{3}{4}$, $y=27$, omluvených $6$; 6.2: $4:3$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený D7.1 – měřítko mapy, výměra louky',
  new List<String>{'Jaká je výměra louky pana Trávníčka, jestliže na mapě s měřítkem $1:10\\,000$ je louka zobrazena jako čtyřúhelník o obsahu $8$ cm²? Skutečnou výměru louky uveďte v hektarech.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah na mapě $8$ cm², měřítko $1:10\\,000$. Skutečný obsah $=8\\cdot(10\\,000)^2$ cm² $=8\\cdot 10^8$ cm² $=80\\,000$ m² $=8$ ha.'},
  '$8$ hektarů',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený D7.2 – čas startu závodu',
  new List<String>{'Jaký byl čas hromadného startu cyklistického závodu, jestliže jeho vítěz dosáhl času 2.55:20 hod. a cílovou páskou projel v 16.02:10 hod.?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Start = cíl − čas jízdy = 16:02:10 − 2:55:20 = 13:06:50.'},
  '13.06:50 h',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený D7.3 – průměrná rychlost sprintera',
  new List<String>{'Jakou průměrnou rychlostí běží sprinter, který v běhu na $100$ m dosáhne času $10{,}0$ s? Rychlost uveďte v km/h.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$v=100:10=10$ m/s. Protože $1$ m/s $=3{,}6$ km/h, je $v=36$ km/h.'},
  '$36$ km/h',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený D8 – zahrada tvaru kosočtverce',
  new List<String>{'Pan Sádlo se rozhodl oplotit zahradu tvaru kosočtverce, jejíž protilehlé rohy jsou od sebe vzdáleny $12$ a $16$ metrů.','8.1 Vypočtěte délku plotu.','8.2 Vypočtěte výměru zahrady a výsledek uveďte v hektarech.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif"><polygon points="230,78 380,190 230,303 80,190" fill="#e9efe6" stroke="#000" stroke-width="2.5"/><line x1="80" y1="190" x2="380" y2="190" stroke="#444" stroke-width="1.5" stroke-dasharray="5 5"/><line x1="230" y1="78" x2="230" y2="303" stroke="#444" stroke-width="1.5" stroke-dasharray="5 5"/><text x="320" y="182" font-size="17" text-anchor="middle">16 m</text><text x="263" y="150" font-size="17" text-anchor="middle">12 m</text></svg>',
  'kosoctverec.svg',
  'Kosočtverec s úhlopříčkami dlouhými 16 m a 12 m.',
  'Zahrada tvaru kosočtverce s úhlopříčkami 12 m a 16 m',
  new List<String>{'8.1 Úhlopříčky kosočtverce jsou $12$ m a $16$ m, jejich poloviny $6$ m a $8$ m. Strana $=\\sqrt{6^2+8^2}=10$ m. Obvod (délka plotu) $=4\\cdot 10=40$ m.','8.2 Obsah $=\\frac{12\\cdot 16}{2}=96$ m² $=0{,}0096$ ha.'},
  '8.1: $40$ m; 8.2: $0{,}0096$ ha',
  4, 7, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
