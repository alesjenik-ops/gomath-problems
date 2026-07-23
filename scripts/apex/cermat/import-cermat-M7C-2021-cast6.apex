String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M7C 2021 – úloha 12',
  new List<String>{'Farma vykupuje tři druhy léčivých bylin A, B, C. Výkupní cenu za $1$ kg každé z bylin znázorňuje graf (skutečná cena v korunách není uvedena).','Chlapci ze skautského oddílu nasbírali $12$ kg byliny B, dívky sbíraly bylinu A. Dívky dostaly za nasbírané byliny stejnou částku jako chlapci.','Kolik kg byliny A nasbíraly dívky?'},
  new List<String>{'A) $8$ kg','B) $10$ kg','C) $11$ kg','D) $14$ kg','E) $15$ kg'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 494 264" font-family="sans-serif"><text x="262" y="24" font-size="14" text-anchor="middle">Ceny bylin za 1 kg</text><line x1="70" y1="36" x2="70" y2="234" stroke="#999" stroke-width="1"/><text x="70" y="250" font-size="11" text-anchor="middle">0</text><line x1="102" y1="36" x2="102" y2="234" stroke="#ddd" stroke-width="1"/><line x1="134" y1="36" x2="134" y2="234" stroke="#999" stroke-width="1"/><text x="134" y="250" font-size="11" text-anchor="middle">2</text><line x1="166" y1="36" x2="166" y2="234" stroke="#ddd" stroke-width="1"/><line x1="198" y1="36" x2="198" y2="234" stroke="#999" stroke-width="1"/><text x="198" y="250" font-size="11" text-anchor="middle">4</text><line x1="230" y1="36" x2="230" y2="234" stroke="#ddd" stroke-width="1"/><line x1="262" y1="36" x2="262" y2="234" stroke="#999" stroke-width="1"/><text x="262" y="250" font-size="11" text-anchor="middle">6</text><line x1="294" y1="36" x2="294" y2="234" stroke="#ddd" stroke-width="1"/><line x1="326" y1="36" x2="326" y2="234" stroke="#999" stroke-width="1"/><text x="326" y="250" font-size="11" text-anchor="middle">8</text><line x1="358" y1="36" x2="358" y2="234" stroke="#ddd" stroke-width="1"/><line x1="390" y1="36" x2="390" y2="234" stroke="#999" stroke-width="1"/><text x="390" y="250" font-size="11" text-anchor="middle">10</text><line x1="422" y1="36" x2="422" y2="234" stroke="#ddd" stroke-width="1"/><line x1="454" y1="36" x2="454" y2="234" stroke="#999" stroke-width="1"/><text x="454" y="250" font-size="11" text-anchor="middle">12</text><rect x="70" y="42" width="256" height="38" fill="#5a5a5a" stroke="#000"/><text x="58" y="66" font-size="13" text-anchor="end">A</text><rect x="70" y="106" width="320" height="38" fill="#5a5a5a" stroke="#000"/><text x="58" y="130" font-size="13" text-anchor="end">B</text><rect x="70" y="170" width="352" height="38" fill="#5a5a5a" stroke="#000"/><text x="58" y="194" font-size="13" text-anchor="end">C</text><line x1="70" y1="36" x2="70" y2="234" stroke="#000" stroke-width="1.5"/><line x1="70" y1="234" x2="454" y2="234" stroke="#000" stroke-width="1.5"/><text x="22" y="138" font-size="12" text-anchor="middle" transform="rotate(-90 22 138)">Druh bylin</text></svg>',
  'graf-ceny-bylin.svg',
  'Vodorovný sloupcový graf cen bylin: A odpovídá 8 dílkům, B 10 dílkům, C 11 dílkům.',
  'Výkupní ceny bylin za 1 kg',
  new List<String>{'Z grafu odpovídá cena byliny A $8$ dílkům a byliny B $10$ dílkům. Chlapci utržili $12\\cdot 10=120$ dílků. Dívky za bylinu A dostaly stejně, tedy $120:8=15$ kg.'},
  'E) $15$ kg',
  2, 4, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
