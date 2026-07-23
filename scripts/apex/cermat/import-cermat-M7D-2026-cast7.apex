String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
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
  'CERMAT M7D 2026 – úloha 15',
  new List<String>{'Tabulka udává počty žáků gymnázia, kteří se zúčastnili jednotlivých sportovních kurzů. Některé údaje v tabulce chybí. Vodácký kurz má celkem $28$ účastníků, turistický kurz $30$ účastníků a cyklistického kurzu se zúčastnilo $14$ chlapců (viz tabulka).','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Z celkového počtu účastníků vodáckého kurzu bylo $75\\,\\%$ chlapců. Kolik dívek se zúčastnilo vodáckého kurzu?','15.2 Turistického kurzu se zúčastnilo o $50\\,\\%$ více dívek než chlapců. O kolik méně chlapců než dívek se zúčastnilo turistického kurzu?','15.3 Na cyklistický kurz se přihlásilo $16$ dívek. Některé z nich se však tohoto kurzu nezúčastnily. Dívky tak nakonec tvořily pouze $44\\,\\%$ účastníků cyklistického kurzu. Kolik dívek přihlášených na cyklistický kurz se kurzu nezúčastnilo?'},
  new List<String>{'A) $5$','B) $6$','C) $7$','D) $8$','E) $9$','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 180" font-family="sans-serif"><line x1="20" y1="20" x2="20" y2="170" stroke="#000"/><line x1="150" y1="20" x2="150" y2="170" stroke="#000"/><line x1="250" y1="20" x2="250" y2="170" stroke="#000"/><line x1="350" y1="20" x2="350" y2="170" stroke="#000"/><line x1="450" y1="20" x2="450" y2="170" stroke="#000"/><line x1="150" y1="20" x2="450" y2="20" stroke="#000"/><line x1="20" y1="50" x2="450" y2="50" stroke="#000"/><line x1="20" y1="80" x2="450" y2="80" stroke="#000"/><line x1="20" y1="110" x2="450" y2="110" stroke="#000"/><line x1="20" y1="140" x2="450" y2="140" stroke="#000"/><line x1="20" y1="170" x2="450" y2="170" stroke="#000"/><line x1="20" y1="20" x2="20" y2="170" stroke="#000"/><text x="30" y="60" font-size="13">Kurz</text><text x="300" y="40" font-size="13" text-anchor="middle">Počet účastníků</text><text x="200" y="70" font-size="12" text-anchor="middle">Chlapci</text><text x="300" y="70" font-size="12" text-anchor="middle">Dívky</text><text x="400" y="70" font-size="12" text-anchor="middle">Celkem</text><text x="30" y="100" font-size="12">Vodácký</text><text x="400" y="100" font-size="12" text-anchor="middle">28</text><text x="30" y="130" font-size="12">Turistický</text><text x="400" y="130" font-size="12" text-anchor="middle">30</text><text x="30" y="160" font-size="12">Cyklistický</text><text x="200" y="160" font-size="12" text-anchor="middle">14</text></svg>',
  'tabulka-kurzy.svg',
  'Tabulka počtů účastníků kurzů: vodácký celkem 28, turistický celkem 30, cyklistický chlapci 14; ostatní údaje chybí.',
  'Počty účastníků sportovních kurzů',
  new List<String>{'15.1 Chlapci $75\\,\\%$, dívky $25\\,\\%$ z $28$: $\\frac{28}{4}=7$ dívek → C.','15.2 Dívky $=1{,}5\\cdot$ chlapci, dohromady $30$: chlapci $12$, dívky $18$; rozdíl $6$ → B.','15.3 Chlapci $14=56\\,\\%$ účastníků, celkem $\\frac{14}{0{,}56}=25$; dívek účastnilo $25-14=11$; z $16$ přihlášených se nezúčastnilo $16-11=5$ → A.'},
  '15.1: C ($7$ dívek); 15.2: B (o $6$ méně); 15.3: A ($5$ dívek)',
  6, 9, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
