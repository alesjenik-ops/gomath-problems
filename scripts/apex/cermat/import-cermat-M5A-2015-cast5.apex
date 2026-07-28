String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 12',
  new List<String>{'V grafu je znázorněn počet dětí ze všech 5. tříd školy kromě počtu dívek třídy 5. C.','Ve třídách 5. A a 5. B je dohromady dvakrát více dětí než ve třídě 5. C.','Kolik dívek je ve třídě 5. C?'},
  new List<String>{'A) méně než 12','B) 12','C) 13','D) 14','E) více než 14'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif"><text x="250" y="20" font-size="14" font-weight="bold" text-anchor="middle">Počty chlapců a dívek v 5. třídách</text><text x="54" y="300.0" font-size="12" text-anchor="end">0</text><text x="54" y="276.8" font-size="12" text-anchor="end">2</text><text x="54" y="253.6" font-size="12" text-anchor="end">4</text><text x="54" y="230.4" font-size="12" text-anchor="end">6</text><text x="54" y="207.2" font-size="12" text-anchor="end">8</text><text x="54" y="184.0" font-size="12" text-anchor="end">10</text><text x="54" y="160.8" font-size="12" text-anchor="end">12</text><text x="54" y="137.6" font-size="12" text-anchor="end">14</text><text x="54" y="114.4" font-size="12" text-anchor="end">16</text><text x="54" y="91.2" font-size="12" text-anchor="end">18</text><text x="54" y="68.0" font-size="12" text-anchor="end">20</text><path d="M 62 296.0 H 430 M 62 272.8 H 430 M 62 249.6 H 430 M 62 226.4 H 430 M 62 203.2 H 430 M 62 180.0 H 430 M 62 156.8 H 430 M 62 133.6 H 430 M 62 110.4 H 430 M 62 87.2 H 430 M 62 64.0 H 430" fill="none" stroke="#bbb" stroke-width="1"/><path d="M 62 60 V 296 H 430" fill="none" stroke="#000" stroke-width="1.5"/><rect x="84" y="156.8" width="44" height="139.2" fill="#fff" stroke="#000" stroke-width="2"/><rect x="132" y="133.6" width="44" height="162.4" fill="#555" stroke="#000" stroke-width="1.5"/><text x="130" y="316" font-size="12" text-anchor="middle">třída 5. A</text><rect x="206" y="87.2" width="44" height="208.8" fill="#fff" stroke="#000" stroke-width="2"/><rect x="254" y="156.8" width="44" height="139.2" fill="#555" stroke="#000" stroke-width="1.5"/><text x="252" y="316" font-size="12" text-anchor="middle">třída 5. B</text><rect x="328" y="110.4" width="44" height="185.6" fill="#fff" stroke="#000" stroke-width="2"/><rect x="376" y="64.0" width="44" height="232.0" fill="#ececec" stroke="#999" stroke-width="1.5" stroke-dasharray="5 4"/><text x="398" y="168.4" font-size="24" text-anchor="middle" font-weight="bold">?</text><text x="374" y="316" font-size="12" text-anchor="middle">třída 5. C</text><rect x="440" y="150" width="15" height="15" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="461" y="163" font-size="12">chlapci</text><rect x="440" y="174" width="15" height="15" fill="#555" stroke="#000" stroke-width="1.5"/><text x="461" y="187" font-size="12">dívky</text></svg>',
  'graf-tridy.svg',
  'Sloupcový graf: 5. A chlapci 12 a dívky 14, 5. B chlapci 18 a dívky 12, 5. C chlapci 16 a dívky neznámé (otazník).',
  'Počty chlapců a dívek v 5. třídách',
  new List<String>{'Ve třídě 5. A je $12+14=26$ dětí, ve třídě 5. B je $18+12=30$ dětí, dohromady tedy $26+30=56$ dětí.','Ve třídě 5. C je proto $56:2=28$ dětí. Chlapců je 16, dívek je tedy $28-16=12$.'},
  'B) 12',
  2, 4, '3',
  new List<String>{'zs1','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
