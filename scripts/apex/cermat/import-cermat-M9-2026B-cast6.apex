String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M9B 2026 – úloha 14',
  new List<String>{'Pomocí hrnku naléváme do prázdného kanystru vodu ze studánky. Po nalití $28$ hrnků plných vody bylo zaplněno sedm osmin objemu kanystru. Když jsme přilili ještě $1$ hrnek plný vody, do úplného zaplnění kanystru chybělo $1050$ ml vody.','Jaký je objem hrnku?'},
  new List<String>{'A) $350$ ml','B) $300$ ml','C) $245$ ml','D) $210$ ml','E) jiný objem'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Objem hrnku označme $h$, objem kanystru $V$. Platí $28h=\\frac{7}{8}V$, tedy $V=32h$. Po $29$ hrncích zbývá $V-29h=32h-29h=3h$, což je $1050$ ml. Odtud $h=350$ ml.'},
  'A) $350$ ml',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2026 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Bedna s jablky váží $20$ kg a je o $25\\,\\%$ těžší než bedna s hruškami. Kolik kg váží bedna s hruškami?','15.2 Z nasbíraných jahod jsme $65\\,\\%$ použili na výrobu džemu, $20\\,\\%$ na výrobu sirupu a zbývající $3$ kg jsme zamrazili. Kolik kg jahod jsme použili na výrobu džemu?','15.3 Celková hmotnost dvou zavazadel je $42$ kg. Menší zavazadlo je o $60\\,\\%$ lehčí než větší zavazadlo. O kolik kg se liší hmotnosti obou zavazadel?'},
  new List<String>{'A) $12$ kg','B) $13$ kg','C) $15$ kg','D) $16$ kg','E) $18$ kg','F) jiný počet kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $20=1{,}25\\cdot h\\Rightarrow h=16$ kg → D.','15.2 Zamražené $3$ kg tvoří $100\\,\\%-65\\,\\%-20\\,\\%=15\\,\\%$, celkem tedy $20$ kg; na džem $65\\,\\%$ z $20=13$ kg → B.','15.3 Větší zavazadlo $v$, menší $0{,}4v$; $v+0{,}4v=42\\Rightarrow v=30$ kg, menší $12$ kg, rozdíl $30-12=18$ kg → E.'},
  '15.1: D ($16$ kg); 15.2: B ($13$ kg); 15.3: E ($18$ kg)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
