String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
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
  'CERMAT M9D 2026 – úloha 15',
  new List<String>{'Tabulka udává počty žáků gymnázia, kteří se zúčastnili jednotlivých sportovních kurzů; některé údaje v tabulce chybí. Vodáckého kurzu se zúčastnilo celkem $28$ žáků, turistického kurzu celkem $30$ žáků a cyklistického kurzu se zúčastnilo $14$ chlapců (ostatní údaje chybí).','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Z celkového počtu účastníků vodáckého kurzu bylo $75$ % chlapců. Kolik dívek se zúčastnilo vodáckého kurzu?','15.2 Turistického kurzu se zúčastnilo o $50$ % více dívek než chlapců. O kolik méně chlapců než dívek se zúčastnilo turistického kurzu?','15.3 Na cyklistický kurz se přihlásilo $16$ dívek. Některé z nich se však tohoto kurzu nezúčastnily. Dívky tak nakonec tvořily pouze $44$ % účastníků cyklistického kurzu. Kolik dívek přihlášených na cyklistický kurz se kurzu nezúčastnilo?'},
  new List<String>{'A) $5$','B) $6$','C) $7$','D) $8$','E) $9$','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 200" font-family="sans-serif"> <rect x="20" y="20" width="420" height="165" fill="none" stroke="#000"/> <line x1="20" y1="80" x2="440" y2="80" stroke="#000"/> <line x1="20" y1="115" x2="440" y2="115" stroke="#000"/> <line x1="20" y1="150" x2="440" y2="150" stroke="#000"/> <line x1="140" y1="20" x2="140" y2="185" stroke="#000"/> <line x1="140" y1="50" x2="440" y2="50" stroke="#000"/> <line x1="240" y1="50" x2="240" y2="185" stroke="#000"/> <line x1="330" y1="50" x2="330" y2="185" stroke="#000"/> <text x="80" y="70" font-size="13" text-anchor="middle">Kurz</text> <text x="290" y="40" font-size="12" text-anchor="middle">Počet účastníků</text> <text x="190" y="70" font-size="12" text-anchor="middle">Chlapci</text> <text x="285" y="70" font-size="12" text-anchor="middle">Dívky</text> <text x="385" y="70" font-size="12" text-anchor="middle">Celkem</text> <text x="28" y="102" font-size="12">Vodácký</text> <text x="28" y="137" font-size="12">Turistický</text> <text x="28" y="172" font-size="12">Cyklistický</text> <text x="385" y="102" font-size="12" text-anchor="middle">28</text> <text x="385" y="137" font-size="12" text-anchor="middle">30</text> <text x="190" y="172" font-size="12" text-anchor="middle">14</text> </svg>',
  'tabulka-kurzy.svg',
  'Tabulka počtů účastníků kurzů: Vodácký celkem 28, Turistický celkem 30, Cyklistický chlapci 14; ostatní údaje (chlapci, dívky, celkem) chybí.',
  'Počty účastníků sportovních kurzů (některé údaje chybí)',
  new List<String>{'15.1 Vodáckého kurzu se zúčastnilo $28$ žáků, chlapců je $75$ %, tedy dívek je $25$ % z $28$, což je $7$ → C.','15.2 Turistický kurz má $30$ účastníků; dívek je o $50$ % více než chlapců: chlapci $+1{,}5\\cdot$ chlapci $=30$, tedy chlapců $12$ a dívek $18$; o $18-12=6$ méně chlapců → B.','15.3 Chlapců na cyklistickém kurzu je $14$ a tvoří $56$ % ($100\\%-44\\%$); účastníků je $\\frac{14}{0{,}56}=25$, dívek je $44$ % z $25$, tj. $11$. Z $16$ přihlášených dívek se nezúčastnilo $16-11=5$ → A.'},
  '15.1: C ($7$); 15.2: B ($6$); 15.3: A ($5$)',
  6, 9, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
