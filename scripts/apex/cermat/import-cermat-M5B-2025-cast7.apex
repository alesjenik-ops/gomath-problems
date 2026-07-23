String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
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
  'CERMAT M5B 2025 - uloha 13',
  new List<String>{'Ve ctvercove siti je zakresleno $7$ obrazcu, ktere maji vrcholy v mrizovych bodech. Kazdy ctverecek ctvercove site ma stranu delky $1$ cm a obsah $1$ cm2 (viz obrazek).','Priradte ke kazde otazce (13.1-13.3) spravnou odpoved (A-F).','13.1 Kolik obrazcu ma obsah $3$ cm2?','13.2 Kolik obrazcu je osove soumernych alespon podle jedne osy soumernosti?','13.3 Kolik svetlych obrazcu ma stejny obvod jako tmavy trojuhelnik?'},
  new List<String>{'A) zadny obrazec','B) $1$ obrazec','C) $2$ obrazce','D) $3$ obrazce','E) $4$ obrazce','F) $5$ obrazcu'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 326 194" font-family="sans-serif"><line x1="20" y1="20" x2="20" y2="174" stroke="#ddd"/><line x1="42" y1="20" x2="42" y2="174" stroke="#ddd"/><line x1="64" y1="20" x2="64" y2="174" stroke="#ddd"/><line x1="86" y1="20" x2="86" y2="174" stroke="#ddd"/><line x1="108" y1="20" x2="108" y2="174" stroke="#ddd"/><line x1="130" y1="20" x2="130" y2="174" stroke="#ddd"/><line x1="152" y1="20" x2="152" y2="174" stroke="#ddd"/><line x1="174" y1="20" x2="174" y2="174" stroke="#ddd"/><line x1="196" y1="20" x2="196" y2="174" stroke="#ddd"/><line x1="218" y1="20" x2="218" y2="174" stroke="#ddd"/><line x1="240" y1="20" x2="240" y2="174" stroke="#ddd"/><line x1="262" y1="20" x2="262" y2="174" stroke="#ddd"/><line x1="284" y1="20" x2="284" y2="174" stroke="#ddd"/><line x1="306" y1="20" x2="306" y2="174" stroke="#ddd"/><line x1="20" y1="20" x2="306" y2="20" stroke="#ddd"/><line x1="20" y1="42" x2="306" y2="42" stroke="#ddd"/><line x1="20" y1="64" x2="306" y2="64" stroke="#ddd"/><line x1="20" y1="86" x2="306" y2="86" stroke="#ddd"/><line x1="20" y1="108" x2="306" y2="108" stroke="#ddd"/><line x1="20" y1="130" x2="306" y2="130" stroke="#ddd"/><line x1="20" y1="152" x2="306" y2="152" stroke="#ddd"/><line x1="20" y1="174" x2="306" y2="174" stroke="#ddd"/><polygon points="42,42 42,108 86,42" fill="#808080" stroke="#000"/><polygon points="108,42 152,42 152,31.0 174,53.0 152,75.0 152,64 108,64" fill="#eee" stroke="#000"/><polygon points="86,86 130,64 152,108 108,130" fill="#eee" stroke="#000"/><polygon points="218,108 218,64 240,42 262,64 262,108" fill="#eee" stroke="#000"/><polygon points="152,130 196,108 240,130 196,152" fill="#eee" stroke="#000"/><polygon points="42,152 130,152 86,130" fill="#eee" stroke="#000"/><polygon points="218,152 284,152 284,108" fill="#eee" stroke="#000"/><rect x="284" y="152" width="22" height="22" fill="#bbb" stroke="#000"/><text x="298" y="188" font-size="10" text-anchor="end">1 cm2</text></svg>',
  'obrazce-sit.svg',
  'Ctvercova sit se sedmi obrazci s vrcholy v mrizovych bodech; jeden trojuhelnik je tmavy, ostatni obrazce jsou svetle.',
  'Sedm obrazcu ve ctvercove siti (schematicky nakres)',
  new List<String>{'Odpovedi vychazeji z porovnani obrazcu v siti podle klice.','13.1 Obsah $3$ cm2 ma $5$ obrazcu -> F.','13.2 Osove soumerne jsou $4$ obrazce -> E.','13.3 Stejny obvod jako tmavy trojuhelnik maji $3$ svetle obrazce -> D.'},
  '13.1: F ($5$ obrazcu); 13.2: E ($4$ obrazce); 13.3: D ($3$ obrazce)',
  5, 7, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
