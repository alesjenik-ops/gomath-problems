String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
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
  'CERMAT M5A 2019 – úloha 12',
  new List<String>{'Graf udává počty žáků jedné třídy v průběhu šesti let. Některé údaje v grafu chybí (viz obrázek). Po doplnění chybějících údajů (počet chlapců a dívek dohromady dává počet všech žáků) vycházejte pouze z doplněného grafu.','Ve kterém roce byl počet chlapců o čtvrtinu větší než počet dívek?'},
  new List<String>{'A) v 1. roce','B) ve 2. roce','C) ve 3. roce','D) ve 4. roce','E) v 5. roce'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 700 340" font-family="sans-serif"><defs><pattern id="h" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#fff"/><line x2="0" y2="6" stroke="#333" stroke-width="2"/></pattern><pattern id="d" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1.2" fill="#666"/></pattern></defs><text x="47" y="304" font-size="11" text-anchor="end">0</text><text x="47" y="248" font-size="11" text-anchor="end">8</text><text x="47" y="192" font-size="11" text-anchor="end">16</text><text x="47" y="136" font-size="11" text-anchor="end">24</text><text x="47" y="80" font-size="11" text-anchor="end">32</text><line x1="55" y1="76" x2="55" y2="300" stroke="#000"/><line x1="55" y1="300" x2="680" y2="300" stroke="#000"/><text x="18" y="188" font-size="12" text-anchor="middle" transform="rotate(-90 18 188)">Počet žáků</text><rect x="71" y="111" width="16" height="189" fill="#b0b0b0" stroke="#000"/><rect x="90" y="195" width="16" height="105" fill="url(#h)" stroke="#000"/><rect x="109" y="216" width="16" height="84" fill="url(#d)" stroke="#000"/><text x="100" y="316" font-size="11" text-anchor="middle">1. rok</text><rect x="153" y="125" width="16" height="175" fill="#b0b0b0" stroke="#000"/><text x="180" y="160" font-size="16" text-anchor="middle" font-weight="bold">?</text><rect x="191" y="230" width="16" height="70" fill="url(#d)" stroke="#000"/><text x="182" y="316" font-size="11" text-anchor="middle">2. rok</text><rect x="235" y="104" width="16" height="196" fill="#b0b0b0" stroke="#000"/><rect x="254" y="188" width="16" height="112" fill="url(#h)" stroke="#000"/><text x="281" y="160" font-size="16" text-anchor="middle" font-weight="bold">?</text><text x="264" y="316" font-size="11" text-anchor="middle">3. rok</text><rect x="317" y="90" width="16" height="210" fill="#b0b0b0" stroke="#000"/><text x="344" y="160" font-size="16" text-anchor="middle" font-weight="bold">?</text><rect x="355" y="202" width="16" height="98" fill="url(#d)" stroke="#000"/><text x="346" y="316" font-size="11" text-anchor="middle">4. rok</text><rect x="399" y="97" width="16" height="203" fill="#b0b0b0" stroke="#000"/><rect x="418" y="188" width="16" height="112" fill="url(#h)" stroke="#000"/><rect x="437" y="209" width="16" height="91" fill="url(#d)" stroke="#000"/><text x="428" y="316" font-size="11" text-anchor="middle">5. rok</text><rect x="481" y="146" width="16" height="154" fill="#b0b0b0" stroke="#000"/><text x="508" y="160" font-size="16" text-anchor="middle" font-weight="bold">?</text><rect x="519" y="230" width="16" height="70" fill="url(#d)" stroke="#000"/><text x="510" y="316" font-size="11" text-anchor="middle">6. rok</text><rect x="560" y="80" width="13" height="13" fill="#b0b0b0" stroke="#000"/><text x="578" y="91" font-size="11">Všichni žáci</text><rect x="560" y="100" width="13" height="13" fill="url(#h)" stroke="#000"/><text x="578" y="111" font-size="11">Chlapci</text><rect x="560" y="120" width="13" height="13" fill="url(#d)" stroke="#000"/><text x="578" y="131" font-size="11">Dívky</text></svg>',
  'graf-zaci.svg',
  'Sdružený sloupcový graf počtu všech žáků, chlapců a dívek v 1. až 6. roce; některé sloupce chybí a jsou označeny otazníkem.',
  'Počty žáků v jednotlivých letech (chybějící údaje označeny ?)',
  new List<String>{'V 1. roce bylo $15$ chlapců a $12$ dívek a platí $15=12+\\tfrac{1}{4}\\cdot 12$, tedy chlapců bylo o čtvrtinu více než dívek. (Počty: chlapci $15,15,16,16,16,12$; dívky $12,10,12,14,13,10$ – v žádném jiném roce poměr o čtvrtinu neplatí.)'},
  'A) v 1. roce',
  2, 3, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
