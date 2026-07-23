String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
Integer YEAR = 2025;

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
  'CERMAT M7C 2025 – úloha 11',
  new List<String>{'Počet všech žáků učiliště je větší než 150 a menší než 290. Když jsme rozdělili všechny žáky učiliště do skupin po 24 žácích, zbylo 5 žáků. Při rozdělení všech žáků do skupin po 36 opět zbylo 5 žáků.','Kolik žáků je na učilišti?'},
  new List<String>{'A) méně než 170 žáků','B) alespoň 170, ale méně než 190 žáků','C) alespoň 190, ale méně než 220 žáků','D) alespoň 220, ale méně než 250 žáků','E) více než 250 žáků'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet zmenšený o $5$ je dělitelný $24$ i $36$, tedy dělitelný jejich nejmenším společným násobkem $72$. Počet má tvar $72k+5$; v rozmezí $150$ až $290$ vyhovuje jen $72\\cdot 3+5=221$. To je „alespoň 220, ale méně než 250".'},
  'D) alespoň 220, ale méně než 250 žáků',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2025 – úloha 12',
  new List<String>{'Ve městě bylo třeba vydláždit náměstí. Radní města chtěli původně najmout 6 dlaždičů, kteří by společně vydláždili celé náměstí za 30 dní. Náměstí však bylo třeba otevřít dříve, proto radní najali raději o 9 dlaždičů více. Celé náměstí pak vydláždili všichni najatí dlaždiči společně. Každý dlaždič vydláždí za den stejně velkou plochu.','Za kolik dní bylo náměstí vydlážděno?'},
  new List<String>{'A) za 2 dny','B) za 10 dní','C) za 12 dní','D) za 18 dní','E) za 20 dní'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Práce je $6\\cdot 30=180$ dlaždičodnů. Dlaždičů bylo $6+9=15$, náměstí tedy vydláždili za $180:15=12$ dní.'},
  'C) za 12 dní',
  2, 4, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2025 – úloha 13',
  new List<String>{'Na každé stěně krychle je vždy jedna úhlopříčka celá přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých nepolepených ploch na povrchu krychle je 480 cm².','Jakou délku má hrana krychle?'},
  new List<String>{'A) méně než 10 cm','B) 10 cm','C) 12 cm','D) 15 cm','E) 20 cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 320" font-family="sans-serif"><rect x="60" y="120" width="180" height="180" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="60,120 120,60 300,60 240,120" fill="#ffffff" stroke="#000" stroke-width="2"/><polygon points="240,120 300,60 300,240 240,300" fill="#ffffff" stroke="#000" stroke-width="2"/><rect x="60" y="264" width="36" height="36" fill="#b0b0b0" stroke="#000"/><rect x="96" y="228" width="36" height="36" fill="#b0b0b0" stroke="#000"/><rect x="132" y="192" width="36" height="36" fill="#b0b0b0" stroke="#000"/><rect x="168" y="156" width="36" height="36" fill="#b0b0b0" stroke="#000"/><rect x="204" y="120" width="36" height="36" fill="#b0b0b0" stroke="#000"/></svg>',
  'krychle.svg',
  'Krychle s pěti šedými čtverci nalepenými podél úhlopříčky každé stěny (schematicky, přední stěna).',
  'Schematický nákres (šedé čtverce na úhlopříčce stěny)',
  new List<String>{'Hrana $a$. Pět šedých čtverců podél úhlopříčky stěny má úhlopříčky $\\frac{a\\sqrt2}{5}$, tedy stranu $\\frac{a}{5}$ a obsah $\\frac{a^2}{25}$; na jedné stěně je jich pět, tj. šedá plocha $\\frac{a^2}{5}$. Bílá plocha jedné stěny je $a^2-\\frac{a^2}{5}=\\frac{4a^2}{5}$, na šesti stěnách $6\\cdot\\frac{4a^2}{5}=\\frac{24a^2}{5}=480$, odtud $a^2=100$, $a=10$ cm.'},
  'B) 10 cm',
  2, 5, '4',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
