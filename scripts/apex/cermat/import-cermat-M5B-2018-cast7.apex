String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
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
  'CERMAT M5B 2018 – úloha 12',
  new List<String>{'V krychli slepené ze $125$ krychliček (po $5$ v každé řadě) se vytvoří $9$ otvorů skrz naskrz. V první fázi se vytlačí $15$ krychliček (tři svislé otvory), ve druhé fázi tři otvory zepředu dozadu a ve třetí fázi tři otvory zprava doleva (viz obrázek).','Kolik krychliček zbyde v krychli po vytvoření všech $9$ otvorů?'},
  new List<String>{'A) 87','B) 88','C) 89','D) 90','E) jiný počet krychliček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 360" font-family="sans-serif"><g><polygon points="206,114 240,114 262,98 228,98" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="284,82 318,82 340,66 306,66" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="296,98 330,98 352,82 318,82" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="184,232 218,232 218,198 184,198" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="218,266 252,266 252,232 218,232" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="252,198 286,198 286,164 252,164" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="342,250 342,216 364,200 364,234" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="386,184 386,150 408,134 408,168" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/><polygon points="364,166 364,132 386,116 386,150" fill="#5a5a5a" stroke="#000" stroke-width="0.8"/></g><g stroke="#000" stroke-width="0.8"><line x1="150" y1="300" x2="150" y2="130"/><line x1="150" y1="300" x2="320" y2="300"/><line x1="150" y1="130" x2="260" y2="50"/><line x1="150" y1="130" x2="320" y2="130"/><line x1="320" y1="300" x2="430" y2="220"/><line x1="320" y1="300" x2="320" y2="130"/><line x1="184" y1="300" x2="184" y2="130"/><line x1="150" y1="266" x2="320" y2="266"/><line x1="184" y1="130" x2="294" y2="50"/><line x1="172" y1="114" x2="342" y2="114"/><line x1="320" y1="266" x2="430" y2="186"/><line x1="342" y1="284" x2="342" y2="114"/><line x1="218" y1="300" x2="218" y2="130"/><line x1="150" y1="232" x2="320" y2="232"/><line x1="218" y1="130" x2="328" y2="50"/><line x1="194" y1="98" x2="364" y2="98"/><line x1="320" y1="232" x2="430" y2="152"/><line x1="364" y1="268" x2="364" y2="98"/><line x1="252" y1="300" x2="252" y2="130"/><line x1="150" y1="198" x2="320" y2="198"/><line x1="252" y1="130" x2="362" y2="50"/><line x1="216" y1="82" x2="386" y2="82"/><line x1="320" y1="198" x2="430" y2="118"/><line x1="386" y1="252" x2="386" y2="82"/><line x1="286" y1="300" x2="286" y2="130"/><line x1="150" y1="164" x2="320" y2="164"/><line x1="286" y1="130" x2="396" y2="50"/><line x1="238" y1="66" x2="408" y2="66"/><line x1="320" y1="164" x2="430" y2="84"/><line x1="408" y1="236" x2="408" y2="66"/><line x1="320" y1="300" x2="320" y2="130"/><line x1="150" y1="130" x2="320" y2="130"/><line x1="320" y1="130" x2="430" y2="50"/><line x1="260" y1="50" x2="430" y2="50"/><line x1="320" y1="130" x2="430" y2="50"/><line x1="430" y1="220" x2="430" y2="50"/></g><g stroke="#000" stroke-width="1.8" fill="none"><polygon points="150,300 320,300 320,130 150,130" fill="none" stroke="#000" stroke-width="0.8"/></g><g font-size="14"><text x="250" y="30" text-anchor="middle">1. fáze</text><line x1="250" y1="36" x2="250" y2="72" stroke="#000"/><polygon points="250,78 246,68 254,68" fill="#000"/><text x="430" y="150" font-size="14">3. fáze</text><line x1="428" y1="146" x2="390" y2="146" stroke="#000"/><polygon points="384,146 394,142 394,150" fill="#000"/><text x="70" y="345" font-size="14">2. fáze</text><line x1="110" y1="330" x2="150" y2="300" stroke="#000"/><polygon points="155,296 145,299 150,306" fill="#000"/></g></svg>',
  'krychle-otvory.svg',
  'Schematická krychle 5 krát 5 krát 5 se svislými, předozadními a bočními otvory; ústí otvorů jsou vyznačena tmavě, u stěn jsou popisky 1., 2. a 3. fáze.',
  'Krychle se třemi směry otvorů (schematicky)',
  new List<String>{'V první fázi se vytlačí $15$ krychliček, ve druhé $11$ (viz úloha 11) a ve třetí zbývajících $10$ nových krychliček (ostatní už byly vytlačeny v místech křížení otvorů). Celkem se odebere $15 + 11 + 10 = 36$ krychliček, takže v krychli zbyde $125 - 36 = 89$ krychliček.'},
  'C) 89',
  2, 4, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
