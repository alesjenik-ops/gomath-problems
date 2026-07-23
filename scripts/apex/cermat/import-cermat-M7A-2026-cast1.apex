String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M7A 2026 - uloha 1',
  new List<String>{'Veslarka trenuje na trenazeru a udrzuje stale stejne tempo. Na displeji vidi, ze za 1 minutu a 30 sekund ujela na trenazeru 350 m.','Vypoctete v metrech vzdalenost, kterou veslarka pri danem tempu ujede na trenazeru za 6 minut.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Za 1 minutu a 30 sekund (tj. 90 s) ujede 350 m. 6 minut je 4-krat vice nez 90 s, proto ujede $4\\cdot 350=1400$ m.'},
  '$1400$ metru',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2026 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru.','$3{,}6\\cdot\\left(\\frac{7}{12}-\\frac{5}{9}\\right)-1=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{12}-\\frac{5}{9}=\\frac{21}{36}-\\frac{20}{36}=\\frac{1}{36}$; $3{,}6\\cdot\\frac{1}{36}=\\frac{1}{10}$; $\\frac{1}{10}-1=-\\frac{9}{10}$.'},
  '$-\\frac{9}{10}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2026 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru.','$\\frac{2-\\frac{10}{7}}{2:\\frac{5}{7}-\\frac{2}{5}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $2-\\frac{10}{7}=\\frac{14}{7}-\\frac{10}{7}=\\frac{4}{7}$. Jmenovatel: $2:\\frac{5}{7}-\\frac{2}{5}=\\frac{14}{5}-\\frac{2}{5}=\\frac{12}{5}$. Podil: $\\frac{4}{7}:\\frac{12}{5}=\\frac{4}{7}\\cdot\\frac{5}{12}=\\frac{5}{21}$.'},
  '$\\frac{5}{21}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2026 - uloha 3',
  new List<String>{'Zapiste vsechny dvojice ruznych prvocisel, jejichz soucet je 24.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Rozklady cisla 24 na soucet dvou ruznych prvocisel: $5+19$, $7+17$, $11+13$. (Dvojice $1$ a $23$ se nepovazuje za reseni, protoze $1$ neni prvocislo.)'},
  '$5$ a $19$; $7$ a $17$; $11$ a $13$',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2026 - uloha 4',
  new List<String>{'V aquaparku ziskavaji deti v plaveckych soutezich zetony, za ktere mohou koupit volne jizdy na tobogánu nebo na clunu po divoke rece, avsak pouze podle nasledujicich dvou pravidel: za 4 zetony se kupuji 3 jizdy na tobogánu, za 15 zetonu se kupuji 2 jizdy na clunu.','4.1 Petr ziskal 70 zetonu. Za vsechny tyto zetony koupil 4 jizdy na clunu a urcity pocet jizd na tobogánu. Urcete, kolik jizd na tobogánu Petr koupil.','4.2 Nela za vsechny sve ziskane zetony koupila nekolik jizd na clunu a dvakrat tolik jizd na tobogánu. Urcete nejmensi mozny pocet zetonu, ktere musela Nela ziskat.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Za 4 jizdy na clunu zaplati Petr $2\\cdot 15=30$ zetonu. Zbyva $70-30=40$ zetonu na tobogán, tj. $\\frac{40}{4}\\cdot 3=30$ jizd na tobogánu.','4.2 Jizdy na clunu jsou po 2 (za 15 zetonu), jizdy na tobogánu po 3 (za 4 zetony). Nela koupila $c$ jizd na clunu a $2c$ na tobogánu; $c$ musi byt sude a soucasne $2c$ delitelne 3, tedy $c$ delitelne 6. Nejmensi $c=6$: clun $6$ jizd $=3\\cdot 15=45$ zetonu, tobogán $12$ jizd $=4\\cdot 4=16$ zetonu, celkem $45+16=61$ zetonu.'},
  '4.1: $30$ jizd na tobogánu; 4.2: $61$ zetonu',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
