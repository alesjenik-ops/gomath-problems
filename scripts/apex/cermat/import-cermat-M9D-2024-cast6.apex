String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
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
  'CERMAT M9D 2024 – úloha 15',
  new List<String>{'V obchodě mají dva druhy jablek. Kilogram jednoho druhu (dražších) jablek stojí $30$ Kč, kilogram druhého druhu (levnějších) jablek stojí $25$ Kč. Paní Vitamínová koupila $x$ kilogramů jablek, kde $x$ je celé číslo, a zaplatila $330$ Kč.','Rozhodněte o každém z tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).','15.1 Pokud paní Vitamínová koupila $12$ kg jablek, koupila stejné množství obou druhů jablek.','15.2 Paní Vitamínová mohla koupit jen levnější druh jablek.','15.3 Pokud chce paní Vitamínová koupit co nejvíce kilogramů jablek, musí koupit právě jeden kilogram dražších jablek.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme $d$ počet kg dražších a $l$ počet kg levnějších jablek: $30d+25l=330$, tj. $6d+5l=66$. Celočíselná nezáporná řešení jsou $(d,l)=(1,12)$, $(6,6)$, $(11,0)$.','15.1 Při $12$ kg jde o řešení $(6,6)$, tedy stejné množství obou druhů. Pravdivé (Ano).','15.2 Jen levnější druh by znamenal $d=0$, ale to není žádné z řešení ($25l=330$ nemá celé řešení). Nepravdivé (Ne).','15.3 Nejvíce kilogramů dává řešení $(1,12)$, tj. $13$ kg, kde je právě $1$ kg dražších jablek. Pravdivé (Ano).'},
  '15.1: Ano; 15.2: Ne; 15.3: Ano',
  3, 5, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2024 – úloha 16',
  new List<String>{'Přiřaďte ke každé podúloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Zvětšíme-li neznámé číslo o $4\\,\\%$, dostaneme číslo $780$. Jaké je toto neznámé číslo?','16.2 O kolik procent musíme zvětšit $\\frac{1}{8}$, abychom dostali $\\frac{1}{2}$?','16.3 Máme dvě čerpadla. Jejich výkony jsou v poměru $3:7$. Méně výkonné čerpadlo vyčerpá $150$ litrů vody za dvě hodiny. Kolik litrů vody vyčerpá výkonnější čerpadlo za $5$ hodin?'},
  new List<String>{'A) $300$','B) $400$','C) $720$','D) $750$','E) $875$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 $x\\cdot 1{,}04=780$, tedy $x=780:1{,}04=750$ → D.','16.2 Rozdíl $\\frac{1}{2}-\\frac{1}{8}=\\frac{3}{8}$; poměr k $\\frac{1}{8}$ je $\\frac{3/8}{1/8}=3=300\\,\\%$ → A.','16.3 Méně výkonné čerpadlo: $150$ l za $2$ h, tj. $75$ l/h; to jsou $3$ díly, jeden díl $25$ l/h. Výkonnější ($7$ dílů) má $175$ l/h, za $5$ h vyčerpá $175\\cdot 5=875$ litrů → E.'},
  '16.1: D ($750$); 16.2: A ($300\\,\\%$); 16.3: E ($875$ litrů)',
  6, 7, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
