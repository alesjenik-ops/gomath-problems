String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M5B 2024 – úloha 8',
  new List<String>{'Graf znázorňuje, kolik hodin denně se Petr věnuje třem vybraným aktivitám – sportu, počítači a učení (viz obrázek).','Rozhodněte o každém z tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Petr tráví týdně na počítači o polovinu více času, než kolik času týdně věnuje sportu.','8.2 Petr týdně věnuje více času učení než sportu.','8.3 Aby Petr týdně trávil učením stejnou dobu jako na počítači, musel by se týdně učit o pět hodin déle.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 360" font-family="sans-serif"><line x1="60" y1="300" x2="660" y2="300" stroke="#ddd"/><text x="52" y="304" font-size="11" text-anchor="end">0</text><line x1="60" y1="265" x2="660" y2="265" stroke="#ddd"/><text x="52" y="269" font-size="11" text-anchor="end">0,5</text><line x1="60" y1="230" x2="660" y2="230" stroke="#ddd"/><text x="52" y="234" font-size="11" text-anchor="end">1</text><line x1="60" y1="195" x2="660" y2="195" stroke="#ddd"/><text x="52" y="199" font-size="11" text-anchor="end">1,5</text><line x1="60" y1="160" x2="660" y2="160" stroke="#ddd"/><text x="52" y="164" font-size="11" text-anchor="end">2</text><line x1="60" y1="125" x2="660" y2="125" stroke="#ddd"/><text x="52" y="129" font-size="11" text-anchor="end">2,5</text><line x1="60" y1="90" x2="660" y2="90" stroke="#ddd"/><text x="52" y="94" font-size="11" text-anchor="end">3</text><line x1="60" y1="55" x2="660" y2="55" stroke="#ddd"/><text x="52" y="59" font-size="11" text-anchor="end">3,5</text><line x1="60" y1="20" x2="60" y2="300" stroke="#000"/><line x1="60" y1="300" x2="660" y2="300" stroke="#000"/><text x="18" y="170" font-size="11" text-anchor="middle" transform="rotate(-90 18 170)">počet hodin za den</text><rect x="76" y="230" width="15" height="70" fill="#9a9a9a" stroke="#000"/><rect x="97" y="195" width="15" height="105" fill="#dcdcdc" stroke="#000"/><rect x="118" y="230" width="15" height="70" fill="#555" stroke="#000"/><text x="104" y="316" font-size="10" text-anchor="middle">pondělí</text><rect x="165" y="230" width="15" height="70" fill="#9a9a9a" stroke="#000"/><rect x="186" y="195" width="15" height="105" fill="#dcdcdc" stroke="#000"/><rect x="207" y="230" width="15" height="70" fill="#555" stroke="#000"/><text x="194" y="316" font-size="10" text-anchor="middle">úterý</text><rect x="254" y="160" width="15" height="140" fill="#9a9a9a" stroke="#000"/><rect x="275" y="160" width="15" height="140" fill="#dcdcdc" stroke="#000"/><rect x="296" y="160" width="15" height="140" fill="#555" stroke="#000"/><text x="282" y="316" font-size="10" text-anchor="middle">středa</text><rect x="343" y="230" width="15" height="70" fill="#9a9a9a" stroke="#000"/><rect x="364" y="90" width="15" height="210" fill="#dcdcdc" stroke="#000"/><rect x="385" y="160" width="15" height="140" fill="#555" stroke="#000"/><text x="372" y="316" font-size="10" text-anchor="middle">čtvrtek</text><rect x="432" y="230" width="15" height="70" fill="#9a9a9a" stroke="#000"/><rect x="453" y="90" width="15" height="210" fill="#dcdcdc" stroke="#000"/><rect x="474" y="160" width="15" height="140" fill="#555" stroke="#000"/><text x="460" y="316" font-size="10" text-anchor="middle">pátek</text><rect x="521" y="160" width="15" height="140" fill="#9a9a9a" stroke="#000"/><rect x="542" y="160" width="15" height="140" fill="#dcdcdc" stroke="#000"/><rect x="563" y="230" width="15" height="70" fill="#555" stroke="#000"/><text x="550" y="316" font-size="10" text-anchor="middle">sobota</text><rect x="610" y="160" width="15" height="140" fill="#9a9a9a" stroke="#000"/><rect x="631" y="160" width="15" height="140" fill="#dcdcdc" stroke="#000"/><rect x="652" y="230" width="15" height="70" fill="#555" stroke="#000"/><text x="638" y="316" font-size="10" text-anchor="middle">neděle</text><rect x="560" y="38" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="578" y="48" font-size="12">sport</text><rect x="560" y="56" width="12" height="12" fill="#dcdcdc" stroke="#000"/><text x="578" y="66" font-size="12">počítač</text><rect x="560" y="74" width="12" height="12" fill="#555" stroke="#000"/><text x="578" y="84" font-size="12">učení</text></svg>',
  'graf-aktivity.svg',
  'Skupinový sloupcový graf hodin denně (sport, počítač, učení) pro pondělí až neděli.',
  'Schematický nákres grafu (týdenní součty: sport 10 h, počítač 15 h, učení 10 h)',
  new List<String>{'Týdenní součty: sport $10$ h, počítač $15$ h, učení $10$ h.','8.1 $15=10+\\frac{10}{2}$, tj. o polovinu více → Ano (A).','8.2 Učení $10$ h není více než sport $10$ h → Ne (N).','8.3 $15-10=5$, učení by muselo být o $5$ h delší → Ano (A).'},
  '8.1: Ano (A); 8.2: Ne (N); 8.3: Ano (A)',
  3, 5, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
