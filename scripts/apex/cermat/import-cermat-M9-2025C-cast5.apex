String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD25C0T03';
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
  'CERMAT M9C 2025 – úloha 11',
  new List<String>{'Rodný dům slavného spisovatele je otevřen pouze v letní sezoně od května do září. V pokladně zaznamenávají počet prodaných vstupenek dětským a dospělým návštěvníkům. V grafu je uvedena návštěvnost v jedné sezoně.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V prvních třech měsících sezony bylo mezi návštěvníky rodného domu třikrát více dospělých než dětí.','11.2 Za celou sezonu bylo dospělých návštěvníků rodného domu průměrně $80$ za měsíc.','11.3 Za celou sezonu tvořily děti $40\\,\\%$ všech návštěvníků rodného domu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif"><line x1="70" y1="50" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="525" y2="300" stroke="#000"/><line x1="66" y1="300.0" x2="70" y2="300.0" stroke="#000"/><text x="62" y="304.0" font-size="10" text-anchor="end">0</text><line x1="66" y1="278.0" x2="70" y2="278.0" stroke="#000"/><text x="62" y="282.0" font-size="10" text-anchor="end">10</text><line x1="66" y1="256.0" x2="70" y2="256.0" stroke="#000"/><text x="62" y="260.0" font-size="10" text-anchor="end">20</text><line x1="66" y1="234.0" x2="70" y2="234.0" stroke="#000"/><text x="62" y="238.0" font-size="10" text-anchor="end">30</text><line x1="66" y1="212.0" x2="70" y2="212.0" stroke="#000"/><text x="62" y="216.0" font-size="10" text-anchor="end">40</text><line x1="66" y1="190.0" x2="70" y2="190.0" stroke="#000"/><text x="62" y="194.0" font-size="10" text-anchor="end">50</text><line x1="66" y1="168.0" x2="70" y2="168.0" stroke="#000"/><text x="62" y="172.0" font-size="10" text-anchor="end">60</text><line x1="66" y1="146.0" x2="70" y2="146.0" stroke="#000"/><text x="62" y="150.0" font-size="10" text-anchor="end">70</text><line x1="66" y1="124.0" x2="70" y2="124.0" stroke="#000"/><text x="62" y="128.0" font-size="10" text-anchor="end">80</text><line x1="66" y1="102.0" x2="70" y2="102.0" stroke="#000"/><text x="62" y="106.0" font-size="10" text-anchor="end">90</text><line x1="66" y1="80.0" x2="70" y2="80.0" stroke="#000"/><text x="62" y="84.0" font-size="10" text-anchor="end">100</text><line x1="66" y1="58.0" x2="70" y2="58.0" stroke="#000"/><text x="62" y="62.0" font-size="10" text-anchor="end">110</text><rect x="90" y="234.0" width="26" height="66.0" fill="#555" stroke="#000"/><rect x="118" y="124.0" width="26" height="176.0" fill="#dcdcdc" stroke="#000"/><text x="117" y="316" font-size="11" text-anchor="middle">Kveten</text><rect x="172" y="278.0" width="26" height="22.0" fill="#555" stroke="#000"/><rect x="200" y="168.0" width="26" height="132.0" fill="#dcdcdc" stroke="#000"/><text x="199" y="316" font-size="11" text-anchor="middle">Cerven</text><rect x="254" y="234.0" width="26" height="66.0" fill="#555" stroke="#000"/><rect x="282" y="146.0" width="26" height="154.0" fill="#dcdcdc" stroke="#000"/><text x="281" y="316" font-size="11" text-anchor="middle">Cervenec</text><rect x="336" y="190.0" width="26" height="110.0" fill="#555" stroke="#000"/><rect x="364" y="102.0" width="26" height="198.0" fill="#dcdcdc" stroke="#000"/><text x="363" y="316" font-size="11" text-anchor="middle">Srpen</text><rect x="418" y="212.0" width="26" height="88.0" fill="#555" stroke="#000"/><rect x="446" y="80.0" width="26" height="220.0" fill="#dcdcdc" stroke="#000"/><text x="445" y="316" font-size="11" text-anchor="middle">Zari</text><rect x="490" y="70" width="14" height="14" fill="#555" stroke="#000"/><text x="509" y="82" font-size="12">Deti</text><rect x="490" y="92" width="14" height="14" fill="#dcdcdc" stroke="#000"/><text x="509" y="104" font-size="12">Dospeli</text><text x="20" y="175" font-size="11" text-anchor="middle" transform="rotate(-90 20 175)">Pocet prodanych vstupenek</text></svg>',
  'graf-navstevnost.svg',
  'Skupinový sloupcový graf prodaných vstupenek pro děti a dospělé za květen až září: děti 30, 10, 30, 50, 40; dospělí 80, 60, 70, 90, 100.',
  'Návštěvnost v jedné sezoně (počet vstupenek)',
  new List<String>{'11.1 První tři měsíce (květen, červen, červenec): dětí $30+10+30=70$, dospělých $80+60+70=210$; $210=3\\cdot 70$, tvrzení je pravdivé (A).','11.2 Dospělí za celou sezonu: $80+60+70+90+100=400$, průměr $400:5=80$ za měsíc; pravdivé (A).','11.3 Dětí celkem $30+10+30+50+40=160$, všech návštěvníků $160+400=560$; $\\frac{160}{560}\\doteq 28{,}6\\,\\%$, tedy ne $40\\,\\%$ — nepravdivé (N).'},
  '11.1: Ano; 11.2: Ano; 11.3: Ne',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
