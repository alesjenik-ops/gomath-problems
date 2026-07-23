String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
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
  'CERMAT M9C 2021 – úloha 1',
  new List<String>{'Zapište zlomkem v základním tvaru, jakou část litru tvoří $30\\,\\%$ ze čtvrtlitru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$30\\,\\%$ ze čtvrtlitru je $0{,}3\\cdot\\dfrac{1}{4}=\\dfrac{3}{10}\\cdot\\dfrac{1}{4}=\\dfrac{3}{40}$ litru.'},
  '$\\dfrac{3}{40}$ litru',
  1, 2, '2',
  new List<String>{'zs2','r9','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 2',
  new List<String>{'Dvě rekreační plavkyně Jana s Květou byly společně plavat. Každá uplavala 25 bazénů. Obě začaly plavat současně a každá plavala svým stále stejným tempem. Jana uplavala 5 bazénů za 7 minut. Květa uplavala 10 bazénů za čtvrt hodiny.','2.1 Vypočtěte, o kolik sekund se lišily časy obou plavkyň na první obrátce (tj. po uplavání prvního bazénu).','2.2 Určete, za jak dlouho uplavala 25 bazénů Květa. (Čas uveďte v minutách a sekundách, např. 5 min 12 s.)'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 Jana uplave 1 bazén za $\\dfrac{7}{5}=1{,}4$ min $=84$ s, Květa za $\\dfrac{15}{10}=1{,}5$ min $=90$ s. Časy se liší o $90-84=6$ s.','2.2 Květa uplave 1 bazén za $90$ s, tedy 25 bazénů za $25\\cdot 90=2\\,250$ s $=37$ min $30$ s.'},
  '2.1: o $6$ s; 2.2: $37$ min $30$ s',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2021 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\left(\\dfrac{3}{4}+\\dfrac{13}{6}\\right)\\cdot\\left(\\dfrac{2}{5}-1\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{3}{4}+\\dfrac{13}{6}=\\dfrac{9}{12}+\\dfrac{26}{12}=\\dfrac{35}{12}$, $\\dfrac{2}{5}-1=-\\dfrac{3}{5}$. Součin $\\dfrac{35}{12}\\cdot\\left(-\\dfrac{3}{5}\\right)=-\\dfrac{105}{60}=-\\dfrac{7}{4}$.'},
  '$-\\dfrac{7}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\frac{3}{5}\\cdot 2-4\\cdot\\frac{2}{7}}{2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\dfrac{3}{5}\\cdot 2-4\\cdot\\dfrac{2}{7}=\\dfrac{6}{5}-\\dfrac{8}{7}=\\dfrac{42-40}{35}=\\dfrac{2}{35}$. Dělením dvěma: $\\dfrac{2}{35}:2=\\dfrac{1}{35}$.'},
  '$\\dfrac{1}{35}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 4.1',
  new List<String>{'Rozložte podle vzorce (výsledný výraz uveďte ve tvaru součinu).','$(4\\cdot a)^{2}-81=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(4a)^{2}-81=(4a)^{2}-9^{2}=(4a-9)(4a+9)$.'},
  '$(4a-9)(4a+9)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky).','$2\\cdot(3y-x)\\cdot(5-y)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(3y-x)(5-y)=15y-3y^{2}-5x+xy$. Po vynásobení dvěma: $2xy-6y^{2}-10x+30y$.'},
  '$2xy-6y^{2}-10x+30y$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky).','$(4n+1)^{2}+3\\cdot(n-1)-(3n+n)\\cdot 2n=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(4n+1)^{2}=16n^{2}+8n+1$, $3(n-1)=3n-3$, $(3n+n)\\cdot 2n=4n\\cdot 2n=8n^{2}$. Celkem $16n^{2}+8n+1+3n-3-8n^{2}=8n^{2}+11n-2$.'},
  '$8n^{2}+11n-2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$0{,}4\\cdot 0{,}1x+0{,}32:0{,}1=0{,}2x$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}04x+3{,}2=0{,}2x$. Odtud $3{,}2=0{,}16x$ a $x=20$.'},
  '$x=20$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\dfrac{y-4}{5}-\\dfrac{y}{10}=\\dfrac{3+y}{2}-2$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme 10: $2(y-4)-y=5(3+y)-20$, tj. $2y-8-y=15+5y-20$. Po úpravě $y-8=5y-5$, $-3=4y$ a $y=-0{,}75$.'},
  '$y=-0{,}75$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
