String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
Integer YEAR = 2022;

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
  'CERMAT M7C 2022 – úloha 1',
  new List<String>{'Vypočtěte: $\\dfrac{10\\cdot 10\\cdot(10\\cdot 10-1)}{10\\cdot 10\\cdot 10+10\\cdot 10}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $100\\cdot 99=9\\,900$, jmenovatel $1\\,000+100=1\\,100$; podíl $9\\,900:1\\,100=9$.'},
  '$9$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 2.1',
  new List<String>{'Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na $12$ stejně dlouhých dílů. Určete, kolik centimetrů měří jeden díl.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Tři půlmetrové kusy měří $3\\cdot 0{,}5=1{,}5$ m. Zbytek $5{,}1-1{,}5=3{,}6$ m $=360$ cm. Jeden díl $360:12=30$ cm.'},
  '$30$ cm',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2022 – úloha 2.2',
  new List<String>{'Cesta na kole z Roztok do Neratovic trvá $1$ hodinu a $50$ minut. S využitím přívozu se doba cestování zkrátí o $40\\,\\%$. Vypočtěte, kolik minut trvá cesta z Roztok do Neratovic s využitím přívozu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ h $50$ min $=110$ min. Zkrácení o $40\\,\\%$ je $0{,}4\\cdot 110=44$ min. Cesta s přívozem trvá $110-44=66$ min.'},
  '$66$ min',
  2, 3, '2',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{1}{3}\\cdot\\left(5-\\dfrac{13}{5}\\right):20=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$5-\\dfrac{13}{5}=\\dfrac{12}{5}$; dále $\\dfrac{1}{3}\\cdot\\dfrac{12}{5}=\\dfrac{12}{15}=\\dfrac{4}{5}$; a nakonec $\\dfrac{4}{5}:20=\\dfrac{4}{100}=\\dfrac{1}{25}$.'},
  '$\\dfrac{1}{25}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{2}{3}-\\frac{3}{2}}{\\frac{2}{3}:\\frac{3}{2}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\dfrac{2}{3}-\\dfrac{3}{2}=\\dfrac{4-9}{6}=-\\dfrac{5}{6}$. Jmenovatel: $\\dfrac{2}{3}:\\dfrac{3}{2}=\\dfrac{2}{3}\\cdot\\dfrac{2}{3}=\\dfrac{4}{9}$. Podíl: $-\\dfrac{5}{6}:\\dfrac{4}{9}=-\\dfrac{5}{6}\\cdot\\dfrac{9}{4}=-\\dfrac{45}{24}=-\\dfrac{15}{8}$.'},
  '$-\\dfrac{15}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 4',
  new List<String>{'Po jarních prázdninách postupně onemocnělo mnoho žáků. V pondělí chyběla $\\frac{1}{6}$ všech žáků školy. V úterý byla nemocná již $\\frac{1}{4}$ všech žáků školy. V pátek byla ve škole už jen $\\frac{1}{3}$ všech žáků školy, tedy $80$ nejodolnějších žáků. Všichni ostatní žáci školy byli nemocní.','4.1 Vypočtěte, kolik žáků měla škola.','4.2 Vypočtěte, kolik žáků bylo v pondělí ve škole.','4.3 Vypočtěte, o kolik nemocných žáků bylo v pátek více než v úterý.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 V pátek byla ve škole $\\frac{1}{3}$ žáků $=80$, tedy celkem $80\\cdot 3=240$ žáků.','4.2 V pondělí chybělo $\\frac{1}{6}$ z $240$, tj. $40$ žáků; ve škole bylo $240-40=200$ žáků.','4.3 V úterý bylo nemocných $\\frac{1}{4}$ z $240=60$ žáků, v pátek $240-80=160$ žáků; rozdíl $160-60=100$ žáků.'},
  '4.1: $240$ žáků; 4.2: $200$ žáků; 4.3: o $100$ žáků',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2022 – úloha 5',
  new List<String>{'Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.','5.1 Určete počet kříd v jedné menší krabičce.','5.2 Určete počet všech větších krabiček s křídami.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Ve $3$ větších krabičkách je $3\\cdot 10=30$ kříd; tolik je i v $5$ menších, tedy v jedné menší $30:5=6$ kříd.','5.2 V menších krabičkách je celkem $30$ kříd, ve větších $300-30=270$ kříd; větších krabiček je $270:10=27$.'},
  '5.1: $6$ kříd; 5.2: $27$ větších krabiček',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
