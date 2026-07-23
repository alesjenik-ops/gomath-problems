String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
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
  'CERMAT M5D 2024 – úloha 13',
  new List<String>{'Pepa byl týden na brigádě. Graf znázorňuje, kolik nasbíral denně kilogramů jablek, hrušek a hroznového vína.','Rozhodněte o každém z tvrzení 13.1–13.3, zda je pravdivé (Ano), či nikoli (Ne).','13.1 Kdyby Pepa nasbíral za celý týden o $25$ kg více jablek, nasbíral by za tento týden stejně jablek jako hrušek.','13.2 Z daných druhů ovoce Pepa za uvedený týden nasbíral nejvíce hroznového vína.','13.3 Jedna devítina hroznového vína, které za daný týden Pepa nasbíral, je rovna jedné šestině hrušek, které za daný týden Pepa nasbíral.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 335" font-family="sans-serif"><line x1="55" y1="30" x2="55" y2="300" stroke="#000"/><line x1="55" y1="300" x2="600" y2="300" stroke="#000"/><line x1="51" y1="300.0" x2="55" y2="300.0" stroke="#000"/><text x="47" y="304.0" font-size="10" text-anchor="end">0</text><line x1="51" y1="261.4" x2="55" y2="261.4" stroke="#000"/><text x="47" y="265.4" font-size="10" text-anchor="end">50</text><line x1="51" y1="222.9" x2="55" y2="222.9" stroke="#000"/><text x="47" y="226.9" font-size="10" text-anchor="end">100</text><line x1="51" y1="184.3" x2="55" y2="184.3" stroke="#000"/><text x="47" y="188.3" font-size="10" text-anchor="end">150</text><line x1="51" y1="145.7" x2="55" y2="145.7" stroke="#000"/><text x="47" y="149.7" font-size="10" text-anchor="end">200</text><line x1="51" y1="107.1" x2="55" y2="107.1" stroke="#000"/><text x="47" y="111.1" font-size="10" text-anchor="end">250</text><line x1="51" y1="68.6" x2="55" y2="68.6" stroke="#000"/><text x="47" y="72.6" font-size="10" text-anchor="end">300</text><line x1="51" y1="30.0" x2="55" y2="30.0" stroke="#000"/><text x="47" y="34.0" font-size="10" text-anchor="end">350</text><rect x="71" y="222.9" width="13" height="77.1" fill="#cccccc" stroke="#000"/><rect x="84" y="184.3" width="13" height="115.7" fill="#888888" stroke="#000"/><rect x="97" y="261.4" width="13" height="38.6" fill="#333333" stroke="#000"/><text x="90.5" y="314" font-size="10" text-anchor="middle">pondeli</text><rect x="120" y="222.9" width="13" height="77.1" fill="#cccccc" stroke="#000"/><rect x="133" y="222.9" width="13" height="77.1" fill="#888888" stroke="#000"/><rect x="146" y="222.9" width="13" height="77.1" fill="#333333" stroke="#000"/><text x="139.5" y="314" font-size="10" text-anchor="middle">utery</text><rect x="169" y="242.1" width="13" height="57.9" fill="#cccccc" stroke="#000"/><rect x="182" y="165.0" width="13" height="135.0" fill="#888888" stroke="#000"/><rect x="195" y="222.9" width="13" height="77.1" fill="#333333" stroke="#000"/><text x="188.5" y="314" font-size="10" text-anchor="middle">streda</text><rect x="218" y="222.9" width="13" height="77.1" fill="#cccccc" stroke="#000"/><rect x="231" y="203.6" width="13" height="96.4" fill="#888888" stroke="#000"/><rect x="244" y="222.9" width="13" height="77.1" fill="#333333" stroke="#000"/><text x="237.5" y="314" font-size="10" text-anchor="middle">ctvrtek</text><rect x="267" y="261.4" width="13" height="38.6" fill="#cccccc" stroke="#000"/><rect x="280" y="145.7" width="13" height="154.3" fill="#888888" stroke="#000"/><rect x="293" y="184.3" width="13" height="115.7" fill="#333333" stroke="#000"/><text x="286.5" y="314" font-size="10" text-anchor="middle">patek</text><rect x="342" y="68.6" width="13" height="231.4" fill="#333333" stroke="#000"/><text x="335.5" y="314" font-size="10" text-anchor="middle">sobota</text><rect x="391" y="49.3" width="13" height="250.7" fill="#333333" stroke="#000"/><text x="384.5" y="314" font-size="10" text-anchor="middle">nedele</text><rect x="470" y="40" width="14" height="14" fill="#cccccc" stroke="#000"/><text x="489" y="52" font-size="11">jablka</text><rect x="470" y="60" width="14" height="14" fill="#888888" stroke="#000"/><text x="489" y="72" font-size="11">hrusky</text><rect x="470" y="80" width="14" height="14" fill="#333333" stroke="#000"/><text x="489" y="92" font-size="11">hroznove vino</text></svg>',
  'graf-brigada.svg',
  'Sloupcový graf denního sběru jablek, hrušek a hroznového vína od pondělí do neděle.',
  'Denní sběr ovoce (kg) – schematická reprodukce grafu',
  new List<String>{'Týdenní součty: jablka $425$ kg, hrušky $750$ kg, hroznové víno $1\\,125$ kg.','13.1 Jablek by muselo být o $750-425=325$ kg více, ne o $25$ kg → Ne.','13.2 Nejvíce je hroznového vína ($1\\,125$ kg) → Ano.','13.3 $\\frac{1}{9}\\cdot 1\\,125=125$ a $\\frac{1}{6}\\cdot 750=125$, hodnoty jsou stejné → Ano.'},
  '13.1: Ne; 13.2: Ano; 13.3: Ano',
  3, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
