String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD21C0T03';
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
  'CERMAT M5C 2021 – úloha 9',
  new List<String>{'Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf, i když skutečná cena v korunách není uvedena.','Vedoucí skautského oddílu nasbírala $2$ kg byliny A a $1$ kg byliny B. Za nasbírané byliny A dostala o $60$ korun více než za byliny B.','Kolik korun celkem dostala vedoucí za nasbírané byliny?'},
  new List<String>{'A) $130$ korun','B) $195$ korun','C) $260$ korun','D) $390$ korun','E) více než $390$ korun'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif"><text x="70" y="28" font-size="14">Ceny bylin za 1 kg</text><line x1="70" y1="250" x2="380" y2="250" stroke="#bbb" stroke-width="1"/><line x1="70" y1="210" x2="380" y2="210" stroke="#bbb" stroke-width="1"/><line x1="70" y1="170" x2="380" y2="170" stroke="#bbb" stroke-width="1"/><line x1="70" y1="130" x2="380" y2="130" stroke="#bbb" stroke-width="1"/><line x1="70" y1="90" x2="380" y2="90" stroke="#bbb" stroke-width="1"/><line x1="70" y1="50" x2="380" y2="50" stroke="#bbb" stroke-width="1"/><line x1="70" y1="40" x2="70" y2="290" stroke="#000" stroke-width="2"/><line x1="70" y1="290" x2="380" y2="290" stroke="#000" stroke-width="2"/><text x="58" y="296" font-size="14">0</text><rect x="118" y="210" width="44" height="80" fill="#4d4d4d" stroke="#000"/><text x="140" y="310" font-size="14" text-anchor="middle">A</text><rect x="198" y="190" width="44" height="100" fill="#4d4d4d" stroke="#000"/><text x="220" y="310" font-size="14" text-anchor="middle">B</text><rect x="278" y="150" width="44" height="140" fill="#4d4d4d" stroke="#000"/><text x="300" y="310" font-size="14" text-anchor="middle">C</text><text x="200" y="332" font-size="13" text-anchor="middle">Druh bylin</text></svg>',
  'graf-byliny.svg',
  'Sloupcový graf výkupních cen bylin A, B, C za 1 kg; sloupce v poměru výšek 4 : 5 : 7.',
  'Ceny bylin za 1 kg',
  new List<String>{'Z grafu jsou ceny v poměru A : B : C $=4:5:7$. Označme jednotku $j$: $2\\cdot 4j-1\\cdot 5j=3j=60$ Kč, tedy $j=20$ Kč. Celkem $2\\cdot 4j+5j=13j=13\\cdot 20=260$ Kč.'},
  'C) $260$ korun',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2021 – úloha 10',
  new List<String>{'Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf, i když skutečná cena v korunách není uvedena.','Chlapci ze skautského oddílu nasbírali $14$ kg byliny B, dívky sbíraly bylinu C. Dívky dostaly za nasbírané byliny stejnou částku jako chlapci.','Kolik kg byliny C nasbíraly dívky?'},
  new List<String>{'A) $5$ kg','B) $7$ kg','C) $8$ kg','D) $9$ kg','E) $10$ kg'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif"><text x="70" y="28" font-size="14">Ceny bylin za 1 kg</text><line x1="70" y1="250" x2="380" y2="250" stroke="#bbb" stroke-width="1"/><line x1="70" y1="210" x2="380" y2="210" stroke="#bbb" stroke-width="1"/><line x1="70" y1="170" x2="380" y2="170" stroke="#bbb" stroke-width="1"/><line x1="70" y1="130" x2="380" y2="130" stroke="#bbb" stroke-width="1"/><line x1="70" y1="90" x2="380" y2="90" stroke="#bbb" stroke-width="1"/><line x1="70" y1="50" x2="380" y2="50" stroke="#bbb" stroke-width="1"/><line x1="70" y1="40" x2="70" y2="290" stroke="#000" stroke-width="2"/><line x1="70" y1="290" x2="380" y2="290" stroke="#000" stroke-width="2"/><text x="58" y="296" font-size="14">0</text><rect x="118" y="210" width="44" height="80" fill="#4d4d4d" stroke="#000"/><text x="140" y="310" font-size="14" text-anchor="middle">A</text><rect x="198" y="190" width="44" height="100" fill="#4d4d4d" stroke="#000"/><text x="220" y="310" font-size="14" text-anchor="middle">B</text><rect x="278" y="150" width="44" height="140" fill="#4d4d4d" stroke="#000"/><text x="300" y="310" font-size="14" text-anchor="middle">C</text><text x="200" y="332" font-size="13" text-anchor="middle">Druh bylin</text></svg>',
  'graf-byliny.svg',
  'Sloupcový graf výkupních cen bylin A, B, C za 1 kg; sloupce v poměru výšek 4 : 5 : 7.',
  'Ceny bylin za 1 kg',
  new List<String>{'Z grafu je poměr výkupních cen B : C $=5:7$. Za stejnou částku platí $14\\cdot 5=x\\cdot 7$ (množství je nepřímo úměrné ceně), tedy $x=\\frac{14\\cdot 5}{7}=10$ kg.'},
  'E) $10$ kg',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
