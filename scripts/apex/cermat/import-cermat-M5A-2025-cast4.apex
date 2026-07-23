String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
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
  'CERMAT M5A 2025 – úloha 8',
  new List<String>{'Graf udává počet všech členů (mužů a žen) turistického oddílu sledovaný v letech 2015–2018.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Počet mužů v turistickém oddílu byl v roce 2015 o jednu třetinu menší než v roce 2016.','8.2 Počet členů turistického oddílu byl v roce 2017 o jednu devítinu větší než v roce 2016.','8.3 Ve sledovaném období se počet žen v turistickém oddílu poprvé snížil oproti předchozímu roku až v roce 2018.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif"><line x1="70" y1="30" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="480" y2="300" stroke="#000"/><line x1="66" y1="300.0" x2="70" y2="300.0" stroke="#000"/><text x="62" y="304.0" font-size="10" text-anchor="end">0</text><line x1="66" y1="276.0" x2="70" y2="276.0" stroke="#000"/><text x="62" y="280.0" font-size="10" text-anchor="end">10</text><line x1="66" y1="252.0" x2="70" y2="252.0" stroke="#000"/><text x="62" y="256.0" font-size="10" text-anchor="end">20</text><line x1="66" y1="228.0" x2="70" y2="228.0" stroke="#000"/><text x="62" y="232.0" font-size="10" text-anchor="end">30</text><line x1="66" y1="204.0" x2="70" y2="204.0" stroke="#000"/><text x="62" y="208.0" font-size="10" text-anchor="end">40</text><line x1="66" y1="180.0" x2="70" y2="180.0" stroke="#000"/><text x="62" y="184.0" font-size="10" text-anchor="end">50</text><line x1="66" y1="156.0" x2="70" y2="156.0" stroke="#000"/><text x="62" y="160.0" font-size="10" text-anchor="end">60</text><line x1="66" y1="132.0" x2="70" y2="132.0" stroke="#000"/><text x="62" y="136.0" font-size="10" text-anchor="end">70</text><line x1="66" y1="108.0" x2="70" y2="108.0" stroke="#000"/><text x="62" y="112.0" font-size="10" text-anchor="end">80</text><line x1="66" y1="84.0" x2="70" y2="84.0" stroke="#000"/><text x="62" y="88.0" font-size="10" text-anchor="end">90</text><line x1="66" y1="60.0" x2="70" y2="60.0" stroke="#000"/><text x="62" y="64.0" font-size="10" text-anchor="end">100</text><line x1="66" y1="36.0" x2="70" y2="36.0" stroke="#000"/><text x="62" y="40.0" font-size="10" text-anchor="end">110</text><text x="22" y="165" font-size="12" text-anchor="middle" transform="rotate(-90 22 165)">Počet členů</text><rect x="105" y="228.0" width="50" height="72.0" fill="#555" stroke="#000"/><rect x="105" y="144.0" width="50" height="84.0" fill="#dcdcdc" stroke="#000"/><text x="130.0" y="316" font-size="11" text-anchor="middle">2015</text><rect x="190" y="192.0" width="50" height="108.0" fill="#555" stroke="#000"/><rect x="190" y="84.0" width="50" height="108.0" fill="#dcdcdc" stroke="#000"/><text x="215.0" y="316" font-size="11" text-anchor="middle">2016</text><rect x="275" y="180.0" width="50" height="120.0" fill="#555" stroke="#000"/><rect x="275" y="60.0" width="50" height="120.0" fill="#dcdcdc" stroke="#000"/><text x="300.0" y="316" font-size="11" text-anchor="middle">2017</text><rect x="360" y="192.0" width="50" height="108.0" fill="#555" stroke="#000"/><rect x="360" y="72.0" width="50" height="120.0" fill="#dcdcdc" stroke="#000"/><text x="385.0" y="316" font-size="11" text-anchor="middle">2018</text><rect x="410" y="70" width="14" height="14" fill="#dcdcdc" stroke="#000"/><text x="430" y="82" font-size="12">Ženy</text><rect x="410" y="92" width="14" height="14" fill="#555" stroke="#000"/><text x="430" y="104" font-size="12">Muži</text></svg>',
  'graf-oddil.svg',
  'Skládaný sloupcový graf počtu členů (muži, ženy) turistického oddílu v letech 2015 až 2018.',
  'Počet členů oddílu v letech 2015–2018',
  new List<String>{'Z grafu: muži $30, 45, 50, 45$; celkem členů $65, 90, 100, 95$; ženy $35, 45, 50, 50$ (roky 2015 až 2018).','8.1 Třetina z $45$ je $15$; $45 - 15 = 30 =$ počet mužů v roce 2015. Tvrzení platí (A).','8.2 Devítina z $90$ je $10$; $90 + 10 = 100 =$ počet členů v roce 2017. Tvrzení platí (A).','8.3 Ženy: $35, 45, 50, 50$ – meziročně nikdy neklesly (v roce 2018 zůstal počet stejný). Tvrzení neplatí (N).'},
  '8.1: A (Ano); 8.2: A (Ano); 8.3: N (Ne)',
  4, 5, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
