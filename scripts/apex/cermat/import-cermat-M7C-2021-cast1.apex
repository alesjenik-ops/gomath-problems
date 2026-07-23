String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
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
  'CERMAT M7C 2021 – úloha 1',
  new List<String>{'Zapište zlomkem v základním tvaru, jakou část litru tvoří $30\\,\\%$ ze čtvrtlitru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$30\\,\\%$ ze čtvrtlitru je $\\frac{30}{100}\\cdot\\frac{1}{4}=\\frac{3}{10}\\cdot\\frac{1}{4}=\\frac{3}{40}$ litru.'},
  '$\\frac{3}{40}$ litru',
  1, 2, '3',
  new List<String>{'zs2','r7','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 2.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost: $6{,}5-1{,}5:5=$ □'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$6{,}5-1{,}5:5=6{,}5-0{,}3=6{,}2$.'},
  '$6{,}2$',
  1, 1, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 2.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost: □ $\\cdot 2 = 30 + 24\\cdot 0{,}4$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pravá strana: $30+24\\cdot 0{,}4=30+9{,}6=39{,}6$. Hledané číslo je $39{,}6:2=19{,}8$.'},
  '$19{,}8$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{3}{4}+\\frac{13}{6}\\right)\\cdot\\left(\\frac{2}{5}-1\\right)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{4}+\\frac{13}{6}=\\frac{9}{12}+\\frac{26}{12}=\\frac{35}{12}$; $\\frac{2}{5}-1=-\\frac{3}{5}$. Součin $\\frac{35}{12}\\cdot\\left(-\\frac{3}{5}\\right)=-\\frac{105}{60}=-\\frac{7}{4}$.'},
  '$-\\frac{7}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{3}{5}\\cdot 2-4\\cdot\\frac{2}{7}}{2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{5}\\cdot 2=\\frac{6}{5}$; $4\\cdot\\frac{2}{7}=\\frac{8}{7}$; $\\frac{6}{5}-\\frac{8}{7}=\\frac{42-40}{35}=\\frac{2}{35}$. Po dělení dvěma: $\\frac{2}{35}:2=\\frac{1}{35}$.'},
  '$\\frac{1}{35}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 4.1',
  new List<String>{'Myslím si celé číslo, které je větší než $20$ a menší než $25$. Když k němu přičtu trojnásobek jiného celého čísla, dostanu $90$.','Určete, které číslo si mohu myslet. Uveďte všechna řešení.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hledané číslo $n$ splňuje $20<n<25$, tedy $n\\in\\{21,22,23,24\\}$. Z rovnice $n+3k=90$ plyne, že $90-n$ musí být dělitelné třemi; protože $90$ je dělitelné třemi, musí být dělitelné třemi i $n$. Vyhovují čísla $21$ a $24$.'},
  '$21$; $24$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 4.2',
  new List<String>{'Do prázdné mísy jsme dali máslo o hmotnosti $120$ g a přidali mouku a cukr. Suroviny v míse váží dohromady půl kilogramu. Cukru je v míse o $80$ g méně než mouky.','Vypočtěte, kolik gramů mouky je v míse.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Mouka a cukr váží $500-120=380$ g. Označíme hmotnost mouky $m$, pak cukru je $m-80$. Platí $m+(m-80)=380$, tedy $2m=460$ a $m=230$ g.'},
  '$230$ g',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2021 – úloha 5',
  new List<String>{'Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala $25$ bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem. Jana uplavala $5$ bazénů za $7$ minut. Květa uplavala $10$ bazénů za čtvrt hodiny.','5.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).','5.2 Určete, za jak dlouho uplavala $25$ bazénů pomalejší plavkyně. (Čas uveďte v minutách a sekundách, např. $5$ min $12$ s.)'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jana uplave $1$ bazén za $\\frac{7}{5}$ min $=84$ s. Květa uplave $1$ bazén za $\\frac{15}{10}=1{,}5$ min $=90$ s.','5.1 Rozdíl na první obrátce je $90-84=6$ s.','5.2 Pomalejší je Květa ($90$ s na bazén); $25$ bazénů uplave za $25\\cdot 90=2250$ s $=37$ min $30$ s.'},
  '5.1: o $6$ sekund; 5.2: $37$ min $30$ s',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
