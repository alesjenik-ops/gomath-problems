String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M7A 2019 – úloha 13–14',
  new List<String>{'Graf udává počty žáků jedné třídy v průběhu šesti let. Některé údaje v grafu chybí (označeny „?"). Pro každý rok platí, že počet všech žáků je součtem počtu chlapců a počtu dívek; po doplnění chybějících údajů odpovězte na otázky. Při řešení vycházejte pouze z doplněného grafu.','13 Kolikrát došlo k meziroční změně počtu chlapců v období od 1. do 6. roku? A) jedenkrát; B) dvakrát; C) třikrát; D) čtyřikrát; E) pětkrát','14 Ve kterém roce byl počet chlapců o čtvrtinu větší než počet dívek? A) v 1. roce; B) ve 2. roce; C) ve 3. roce; D) ve 4. roce; E) v 5. roce'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 350" font-family="sans-serif" font-size="12"><text x="18" y="170" transform="rotate(-90 18 170)" text-anchor="middle">Pocet zaku</text><line x1="60" y1="20" x2="60" y2="300" stroke="#000"/><line x1="60" y1="300" x2="600" y2="300" stroke="#000"/><line x1="56" y1="300.0" x2="60" y2="300.0" stroke="#000"/><text x="52" y="304.0" text-anchor="end">0</text><line x1="56" y1="268.0" x2="60" y2="268.0" stroke="#000"/><text x="52" y="272.0" text-anchor="end">4</text><line x1="56" y1="236.0" x2="60" y2="236.0" stroke="#000"/><text x="52" y="240.0" text-anchor="end">8</text><line x1="56" y1="204.0" x2="60" y2="204.0" stroke="#000"/><text x="52" y="208.0" text-anchor="end">12</text><line x1="56" y1="172.0" x2="60" y2="172.0" stroke="#000"/><text x="52" y="176.0" text-anchor="end">16</text><line x1="56" y1="140.0" x2="60" y2="140.0" stroke="#000"/><text x="52" y="144.0" text-anchor="end">20</text><line x1="56" y1="108.0" x2="60" y2="108.0" stroke="#000"/><text x="52" y="112.0" text-anchor="end">24</text><line x1="56" y1="76.0" x2="60" y2="76.0" stroke="#000"/><text x="52" y="80.0" text-anchor="end">28</text><line x1="56" y1="44.0" x2="60" y2="44.0" stroke="#000"/><text x="52" y="48.0" text-anchor="end">32</text><rect x="74" y="84.0" width="26" height="216.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><rect x="102" y="180.0" width="26" height="120.0" fill="#454545" stroke="#000" stroke-width="0.8"/><rect x="130" y="204.0" width="26" height="96.0" fill="#dcdcdc" stroke="#000" stroke-width="0.8"/><text x="115.0" y="316" text-anchor="middle">1. rok</text><rect x="168" y="100.0" width="26" height="200.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><text x="209.0" y="200" text-anchor="middle" font-size="16">?</text><rect x="224" y="220.0" width="26" height="80.0" fill="#dcdcdc" stroke="#000" stroke-width="0.8"/><text x="209.0" y="316" text-anchor="middle">2. rok</text><rect x="262" y="76.0" width="26" height="224.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><rect x="290" y="172.0" width="26" height="128.0" fill="#454545" stroke="#000" stroke-width="0.8"/><text x="331.0" y="200" text-anchor="middle" font-size="16">?</text><text x="303.0" y="316" text-anchor="middle">3. rok</text><rect x="356" y="60.0" width="26" height="240.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><text x="397.0" y="200" text-anchor="middle" font-size="16">?</text><rect x="412" y="188.0" width="26" height="112.0" fill="#dcdcdc" stroke="#000" stroke-width="0.8"/><text x="397.0" y="316" text-anchor="middle">4. rok</text><rect x="450" y="68.0" width="26" height="232.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><rect x="478" y="172.0" width="26" height="128.0" fill="#454545" stroke="#000" stroke-width="0.8"/><rect x="506" y="196.0" width="26" height="104.0" fill="#dcdcdc" stroke="#000" stroke-width="0.8"/><text x="491.0" y="316" text-anchor="middle">5. rok</text><rect x="544" y="124.0" width="26" height="176.0" fill="#9a9a9a" stroke="#000" stroke-width="0.8"/><text x="585.0" y="200" text-anchor="middle" font-size="16">?</text><rect x="600" y="220.0" width="26" height="80.0" fill="#dcdcdc" stroke="#000" stroke-width="0.8"/><text x="585.0" y="316" text-anchor="middle">6. rok</text><rect x="470" y="40" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="488" y="50">Vsichni zaci</text><rect x="470" y="60" width="12" height="12" fill="#454545" stroke="#000"/><text x="488" y="70">Chlapci</text><rect x="470" y="80" width="12" height="12" fill="#dcdcdc" stroke="#000"/><text x="488" y="90">Divky</text></svg>',
  'graf-zaci.svg',
  'Sloupcový graf počtu žáků, chlapců a dívek v šesti letech; chybějící sloupce jsou označeny otazníkem.',
  'Počty žáků, chlapců a dívek v průběhu šesti let',
  new List<String>{'Doplnění (všichni = chlapci + dívky): chlapci po letech $15, 15, 16, 16, 16, 12$; dívky $12, 10, 12, 14, 13, 10$; všichni $27, 25, 28, 30, 29, 22$.','13 Počet chlapců se změnil mezi 2. a 3. rokem a mezi 5. a 6. rokem, tedy dvakrát → B).','14 Chlapců je o čtvrtinu více než dívek, když $15=1{,}25\\cdot 12$; to platí jen v 1. roce → A).'},
  '13: B) dvakrát; 14: A) v 1. roce',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
