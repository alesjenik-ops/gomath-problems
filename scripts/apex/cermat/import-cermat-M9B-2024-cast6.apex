String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD24C0T02';
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
  'CERMAT M9B 2024 - uloha 15',
  new List<String>{'Zaci $9.$ rocniku mezi sebou provedli statisticky pruzkum. Kazdy zak volil svuj nejoblibenejsi predmet, pricemz kazdy si zvolil prave jeden. Vysledky hlasovani jsou zaznamenany v grafu (chlapci - srafovane, divky - sede) pro predmety M, Cj, Aj, Tv, Vv.','Rozhodnete o kazdem z nasledujicich tvrzeni 15.1-15.3, zda je pravdive (A), ci nikoli (N).','15.1 V $9.$ rocniku je stejny pocet divek jako chlapcu.','15.2 Cesky jazyk volilo vice nez $16\\,\\%$ vsech zaku $9.$ rocniku.','15.3 Pocet chlapcu, kteri volili matematiku, je o $75\\,\\%$ vetsi nez pocet devcat, ktera volila take matematiku.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif"><defs><pattern id="hatch" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><line x1="0" y1="3" x2="6" y2="3" stroke="#000" stroke-width="1"/></pattern></defs><line x1="60" y1="30" x2="60" y2="250" stroke="#000"/><line x1="60" y1="250" x2="430" y2="250" stroke="#000"/><line x1="56" y1="250" x2="60" y2="250" stroke="#000"/><text x="52" y="254" font-size="11" text-anchor="end">0</text><line x1="56" y1="226" x2="60" y2="226" stroke="#000"/><text x="52" y="230" font-size="11" text-anchor="end">1</text><line x1="56" y1="202" x2="60" y2="202" stroke="#000"/><text x="52" y="206" font-size="11" text-anchor="end">2</text><line x1="56" y1="178" x2="60" y2="178" stroke="#000"/><text x="52" y="182" font-size="11" text-anchor="end">3</text><line x1="56" y1="154" x2="60" y2="154" stroke="#000"/><text x="52" y="158" font-size="11" text-anchor="end">4</text><line x1="56" y1="130" x2="60" y2="130" stroke="#000"/><text x="52" y="134" font-size="11" text-anchor="end">5</text><line x1="56" y1="106" x2="60" y2="106" stroke="#000"/><text x="52" y="110" font-size="11" text-anchor="end">6</text><line x1="56" y1="82" x2="60" y2="82" stroke="#000"/><text x="52" y="86" font-size="11" text-anchor="end">7</text><line x1="56" y1="58" x2="60" y2="58" stroke="#000"/><text x="52" y="62" font-size="11" text-anchor="end">8</text><line x1="56" y1="34" x2="60" y2="34" stroke="#000"/><text x="52" y="38" font-size="11" text-anchor="end">9</text><rect x="82" y="82" width="18" height="168" fill="url(#hatch)" stroke="#000"/><rect x="100" y="154" width="18" height="96" fill="#b0b0b0" stroke="#000"/><text x="100" y="266" font-size="12" text-anchor="middle">M</text><rect x="140" y="202" width="18" height="48" fill="url(#hatch)" stroke="#000"/><rect x="158" y="106" width="18" height="144" fill="#b0b0b0" stroke="#000"/><text x="158" y="266" font-size="12" text-anchor="middle">Cj</text><rect x="198" y="130" width="18" height="120" fill="url(#hatch)" stroke="#000"/><rect x="216" y="58" width="18" height="192" fill="#b0b0b0" stroke="#000"/><text x="216" y="266" font-size="12" text-anchor="middle">Aj</text><rect x="256" y="82" width="18" height="168" fill="url(#hatch)" stroke="#000"/><rect x="274" y="130" width="18" height="120" fill="#b0b0b0" stroke="#000"/><text x="274" y="266" font-size="12" text-anchor="middle">Tv</text><rect x="314" y="154" width="18" height="96" fill="url(#hatch)" stroke="#000"/><rect x="332" y="202" width="18" height="48" fill="#b0b0b0" stroke="#000"/><text x="332" y="266" font-size="12" text-anchor="middle">Vv</text><rect x="335" y="40" width="14" height="14" fill="url(#hatch)" stroke="#000"/><text x="355" y="52" font-size="12">chlapci</text><rect x="335" y="60" width="14" height="14" fill="#b0b0b0" stroke="#000"/><text x="355" y="72" font-size="12">divky</text></svg>',
  'graf-predmety.svg',
  'Sloupcovy graf poctu chlapcu (srafovane) a divek (sede) pro predmety M, Cj, Aj, Tv, Vv s hodnotami chlapci 7, 2, 5, 7, 4 a divky 4, 6, 8, 5, 2.',
  'Nejoblibenejsi predmety - chlapci a divky',
  new List<String>{'Chlapci celkem: $7+2+5+7+4=25$, divky celkem: $4+6+8+5+2=25$.','15.1 Pocty jsou stejne (25 a 25) - Ano (A).','15.2 Cesky jazyk volilo $2+6=8$ zaku z $50$, tj. $\\frac{8}{50}=16\\,\\%$; neni to vice nez $16\\,\\%$ - Ne (N).','15.3 Matematiku volilo $7$ chlapcu a $4$ divky; $\\frac{7}{4}=1{,}75$, tj. o $75\\,\\%$ vice - Ano (A).'},
  '15.1: A (Ano); 15.2: N (Ne); 15.3: A (Ano)',
  3, 5, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
