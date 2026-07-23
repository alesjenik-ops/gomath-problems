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
  'CERMAT M5B 2018 – úloha 13',
  new List<String>{'Páté třídy (5. A, 5. B a 5. C) uspořádaly sběr papíru (viz tabulka). V 5. A dívky nasbíraly o $30$ kg papíru více než chlapci, a to o pětinu více než chlapci. V 5. B nasbírali žáci celkem $480$ kg papíru, přičemž dívky nasbíraly dvakrát více než chlapci. V 5. C je celkem $27$ žáků, každý žák přinesl stejné množství papíru; chlapců je o $3$ více než dívek, proto chlapci nasbírali celkem o $72$ kg papíru více než dívky.','Přiřaďte ke každé otázce (13.1–13.3) odpovídající odpověď (A–F).','13.1 Kolik kg papíru nasbírali žáci 5. A celkem?','13.2 Kolik kg papíru nasbíraly dívky 5. B?','13.3 Kolik kg papíru nasbírali chlapci 5. C?'},
  new List<String>{'A) méně než 320 kg','B) 320 kg','C) 330 kg','D) 350 kg','E) 360 kg','F) jiný počet kg'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 190" font-family="sans-serif"><g stroke="#000" stroke-width="1.2" fill="none"><line x1="20" y1="20" x2="420" y2="20"/><line x1="20" y1="60" x2="420" y2="60"/><line x1="20" y1="100" x2="420" y2="100"/><line x1="20" y1="140" x2="420" y2="140"/><line x1="20" y1="180" x2="420" y2="180"/><line x1="20" y1="20" x2="20" y2="180"/><line x1="120" y1="20" x2="120" y2="180"/><line x1="220" y1="20" x2="220" y2="180"/><line x1="320" y1="20" x2="320" y2="180"/><line x1="420" y1="20" x2="420" y2="180"/></g><g font-size="15" text-anchor="middle"><text x="170" y="45">dívky</text><text x="270" y="45">chlapci</text><text x="370" y="45">celkem</text><text x="70" y="85">5. A</text><text x="70" y="125">5. B</text><text x="70" y="165">5. C</text><text x="370" y="125">480 kg</text></g></svg>',
  'tabulka-sber.svg',
  'Tabulka se sloupci dívky, chlapci, celkem a řádky 5. A, 5. B, 5. C; vyplněná je jen buňka celkem u 5. B hodnotou 480 kg.',
  'Tabulka sběru papíru',
  new List<String>{'13.1 V 5. A je $30$ kg pětinou toho, co nasbírali chlapci, takže chlapci nasbírali $150$ kg a dívky $180$ kg; celkem $330$ kg → C.','13.2 V 5. B je poměr dívky : chlapci roven $2 : 1$, tedy chlapci nasbírali $\\frac{480}{3} = 160$ kg a dívky $320$ kg → B.','13.3 V 5. C je $12$ dívek a $15$ chlapců. Rozdíl $3$ žáků odpovídá $72$ kg, takže jeden žák přinesl $24$ kg; chlapci nasbírali $15 \\cdot 24 = 360$ kg → E.'},
  '13.1: C (330 kg); 13.2: B (320 kg); 13.3: E (360 kg)',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
