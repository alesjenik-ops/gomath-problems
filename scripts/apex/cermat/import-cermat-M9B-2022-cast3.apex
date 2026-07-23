String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M9B 2022 – úloha 7',
  new List<String>{'Soutěže se zúčastnilo 5 škol $A$, $B$, $C$, $D$, $E$. Každou školu reprezentovaly dva týmy – jeden dívčí a jeden chlapecký. Výsledky týmů jsou uvedeny v grafu; dva údaje chybí.','7.1 Výsledek dívčího týmu školy $C$ byl stejný jako aritmetický průměr výsledků dívčích týmů škol $A$ a $B$. Vypočtěte aritmetický průměr výsledků všech pěti dívčích týmů.','7.2 Aritmetický průměr výsledků všech pěti chlapeckých týmů je $8$ bodů. Určete, kolik bodů získal chlapecký tým školy $D$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif"><line x1="55" y1="40" x2="55" y2="280" stroke="#000" stroke-width="1.5"/><line x1="55" y1="280" x2="500" y2="280" stroke="#000" stroke-width="1.5"/><line x1="55" y1="280" x2="500" y2="280" stroke="#e2e2e2"/><line x1="51" y1="280" x2="55" y2="280" stroke="#000"/><text x="47" y="284" font-size="11" text-anchor="end">0</text><line x1="55" y1="250" x2="500" y2="250" stroke="#e2e2e2"/><line x1="51" y1="250" x2="55" y2="250" stroke="#000"/><text x="47" y="254" font-size="11" text-anchor="end">2</text><line x1="55" y1="220" x2="500" y2="220" stroke="#e2e2e2"/><line x1="51" y1="220" x2="55" y2="220" stroke="#000"/><text x="47" y="224" font-size="11" text-anchor="end">4</text><line x1="55" y1="190" x2="500" y2="190" stroke="#e2e2e2"/><line x1="51" y1="190" x2="55" y2="190" stroke="#000"/><text x="47" y="194" font-size="11" text-anchor="end">6</text><line x1="55" y1="160" x2="500" y2="160" stroke="#e2e2e2"/><line x1="51" y1="160" x2="55" y2="160" stroke="#000"/><text x="47" y="164" font-size="11" text-anchor="end">8</text><line x1="55" y1="130" x2="500" y2="130" stroke="#e2e2e2"/><line x1="51" y1="130" x2="55" y2="130" stroke="#000"/><text x="47" y="134" font-size="11" text-anchor="end">10</text><line x1="55" y1="100" x2="500" y2="100" stroke="#e2e2e2"/><line x1="51" y1="100" x2="55" y2="100" stroke="#000"/><text x="47" y="104" font-size="11" text-anchor="end">12</text><line x1="55" y1="70" x2="500" y2="70" stroke="#e2e2e2"/><line x1="51" y1="70" x2="55" y2="70" stroke="#000"/><text x="47" y="74" font-size="11" text-anchor="end">14</text><line x1="55" y1="40" x2="500" y2="40" stroke="#e2e2e2"/><line x1="51" y1="40" x2="55" y2="40" stroke="#000"/><text x="47" y="44" font-size="11" text-anchor="end">16</text><text x="18" y="155" font-size="12" text-anchor="middle" transform="rotate(-90 18 155)">počet bodů</text><rect x="80" y="100" width="17" height="180" fill="#555" stroke="#000"/><rect x="100" y="190" width="17" height="90" fill="#dcdcdc" stroke="#000"/><text x="98" y="296" font-size="12" text-anchor="middle">A</text><rect x="162" y="190" width="17" height="90" fill="#555" stroke="#000"/><rect x="182" y="70" width="17" height="210" fill="#dcdcdc" stroke="#000"/><text x="180" y="296" font-size="12" text-anchor="middle">B</text><rect x="244" y="250" width="17" height="30" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="252.5" y="242" font-size="14" text-anchor="middle">?</text><rect x="264" y="250" width="17" height="30" fill="#dcdcdc" stroke="#000"/><text x="262" y="296" font-size="12" text-anchor="middle">C</text><rect x="326" y="220" width="17" height="60" fill="#555" stroke="#000"/><rect x="346" y="250" width="17" height="30" fill="none" stroke="#888" stroke-dasharray="4 3"/><text x="354.5" y="242" font-size="14" text-anchor="middle">?</text><text x="344" y="296" font-size="12" text-anchor="middle">D</text><rect x="408" y="220" width="17" height="60" fill="#555" stroke="#000"/><rect x="428" y="190" width="17" height="90" fill="#dcdcdc" stroke="#000"/><text x="426" y="296" font-size="12" text-anchor="middle">E</text><rect x="372" y="55" width="13" height="13" fill="#555" stroke="#000"/><text x="391" y="66" font-size="12">dívčí tým</text><rect x="372" y="74" width="13" height="13" fill="#dcdcdc" stroke="#000"/><text x="391" y="85" font-size="12">chlapecký tým</text></svg>',
  'graf-tymy.svg',
  'Sloupcový graf výsledků dívčích (tmavé) a chlapeckých (světlé) týmů škol A až E; dívčí tým školy C a chlapecký tým školy D chybí.',
  'Výsledky týmů jednotlivých škol (počet bodů)',
  new List<String>{'7.1 Dívčí: $A=12$, $B=6$, $C=\\frac{12+6}{2}=9$, $D=4$, $E=4$; průměr $\\frac{12+6+9+4+4}{5}=\\frac{35}{5}=7$ bodů.','7.2 Chlapecký: $A=6$, $B=14$, $C=2$, $E=6$; součet všech pěti je $5\\cdot8=40$, tedy $D=40-(6+14+2+6)=12$ bodů.'},
  '7.1: $7$ bodů; 7.2: $12$ bodů',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
