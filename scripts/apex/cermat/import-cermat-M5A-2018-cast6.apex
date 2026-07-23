String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M5A 2018 – úloha 12',
  new List<String>{'Třída 5. A s $20$ žáky spořila půl roku na podporu adoptovaného hrocha. Všichni žáci přispívali rovným dílem, ale každý měsíc vyšší částkou o stejnou částku. Graf udává, jak v průběhu pěti měsíců narůstala naspořená částka celé třídy 5. A (za 1. až 5. měsíc postupně $100$, $300$, $600$, $1\\,000$ a $1\\,500$ korun).','Kolik korun třída 5. A uspořila za půl roku (celkem za 6 měsíců)?'},
  new List<String>{'A) méně než 2 100 korun','B) 2 100 korun','C) 2 200 korun','D) 2 300 korun','E) více než 2 300 korun'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif"><text x="290" y="18" font-size="13" text-anchor="middle" font-weight="bold">Naspořená částka třídy 5. A</text><line x1="64" y1="30" x2="64" y2="300" stroke="#000"/><line x1="64" y1="300" x2="530" y2="300" stroke="#000"/><line x1="60" y1="300.0" x2="64" y2="300.0" stroke="#000"/><text x="56" y="304.0" font-size="9" text-anchor="end">0</text><line x1="60" y1="278.3333333333333" x2="64" y2="278.3333333333333" stroke="#000"/><text x="56" y="282.3333333333333" font-size="9" text-anchor="end">200</text><line x1="60" y1="256.6666666666667" x2="64" y2="256.6666666666667" stroke="#000"/><text x="56" y="260.6666666666667" font-size="9" text-anchor="end">400</text><line x1="60" y1="235.0" x2="64" y2="235.0" stroke="#000"/><text x="56" y="239.0" font-size="9" text-anchor="end">600</text><line x1="60" y1="213.33333333333331" x2="64" y2="213.33333333333331" stroke="#000"/><text x="56" y="217.33333333333331" font-size="9" text-anchor="end">800</text><line x1="60" y1="191.66666666666666" x2="64" y2="191.66666666666666" stroke="#000"/><text x="56" y="195.66666666666666" font-size="9" text-anchor="end">1000</text><line x1="60" y1="170.0" x2="64" y2="170.0" stroke="#000"/><text x="56" y="174.0" font-size="9" text-anchor="end">1200</text><line x1="60" y1="148.33333333333331" x2="64" y2="148.33333333333331" stroke="#000"/><text x="56" y="152.33333333333331" font-size="9" text-anchor="end">1400</text><line x1="60" y1="126.66666666666666" x2="64" y2="126.66666666666666" stroke="#000"/><text x="56" y="130.66666666666666" font-size="9" text-anchor="end">1600</text><line x1="60" y1="105.0" x2="64" y2="105.0" stroke="#000"/><text x="56" y="109.0" font-size="9" text-anchor="end">1800</text><line x1="60" y1="83.33333333333331" x2="64" y2="83.33333333333331" stroke="#000"/><text x="56" y="87.33333333333331" font-size="9" text-anchor="end">2000</text><line x1="60" y1="61.66666666666666" x2="64" y2="61.66666666666666" stroke="#000"/><text x="56" y="65.66666666666666" font-size="9" text-anchor="end">2200</text><line x1="60" y1="40.0" x2="64" y2="40.0" stroke="#000"/><text x="56" y="44.0" font-size="9" text-anchor="end">2400</text><text x="18" y="170" font-size="11" text-anchor="middle" transform="rotate(-90 18 170)">Počet korun</text><rect x="88" y="289.1666666666667" width="44" height="10.833333333333334" fill="#a9a9a9" stroke="#000"/><text x="110.0" y="316" font-size="9" text-anchor="middle">za 1 měsíc</text><rect x="164" y="267.5" width="44" height="32.5" fill="#a9a9a9" stroke="#000"/><text x="186.0" y="316" font-size="9" text-anchor="middle">za 2 měsíce</text><rect x="240" y="235.0" width="44" height="65.0" fill="#a9a9a9" stroke="#000"/><text x="262.0" y="316" font-size="9" text-anchor="middle">za 3 měsíce</text><rect x="316" y="191.66666666666666" width="44" height="108.33333333333334" fill="#a9a9a9" stroke="#000"/><text x="338.0" y="316" font-size="9" text-anchor="middle">za 4 měsíce</text><rect x="392" y="137.5" width="44" height="162.5" fill="#a9a9a9" stroke="#000"/><text x="414.0" y="316" font-size="9" text-anchor="middle">za 5 měsíců</text><text x="490.0" y="180" font-size="26" text-anchor="middle" font-weight="bold">?</text><text x="490.0" y="316" font-size="9" text-anchor="middle">za 6 měsíců</text></svg>',
  'graf-sporeni.svg',
  'Sloupcový graf naspořené částky třídy: za 1 až 5 měsíců 100, 300, 600, 1000 a 1500 korun; za 6 měsíců otazník.',
  'Naspořená částka třídy 5. A (v korunách)',
  new List<String>{'Měsíční příspěvky celé třídy jsou $100$, $200$, $300$, $400$, $500$ a $600$ korun. Za šestý měsíc přibude $600$ korun, celkem za půl roku $1\\,500+600=2\\,100$ korun.'},
  'B) 2 100 korun',
  2, 3, '2',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
