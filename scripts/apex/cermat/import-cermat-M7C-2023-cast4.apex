String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M7C 2023 - uloha 10',
  new List<String>{'Na tabore je kazde dite zarazeno do jednoho ze tri oddilu $A$, $B$ a $C$. V oddile $A$ je dvakrat vice deti nez v oddile $C$. Pomer poctu deti v oddile $A$ ku poctu deti v oddile $B$ je $4:3$. Graf udava pocty chlapcu a divek v jednotlivych oddilech, dva udaje vsak chybi.','Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).','10.1 V oddile $C$ je $5$ divek.','10.2 V oddile $B$ je chlapcu o polovinu vice nez divek.','10.3 Na tabore je divek o petinu mene nez chlapcu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 360" font-family="sans-serif"><circle cx="175" cy="180" r="130" fill="none" stroke="#000" stroke-width="1.6"/><circle cx="175" cy="180" r="52" fill="none" stroke="#000" stroke-width="1.6"/><line x1="175" y1="128" x2="175" y2="50" stroke="#000" stroke-width="1.4"/><line x1="130" y1="206" x2="62" y2="245" stroke="#000" stroke-width="1.4"/><line x1="220" y1="206" x2="288" y2="245" stroke="#000" stroke-width="1.4"/><text x="199" y="171" font-size="18" font-weight="bold" text-anchor="middle">A</text><text x="151" y="171" font-size="18" font-weight="bold" text-anchor="middle">C</text><text x="175" y="213" font-size="18" font-weight="bold" text-anchor="middle">B</text><text x="221" y="104" font-size="12" text-anchor="middle">chlapci 9</text><text x="267" y="176" font-size="12" text-anchor="middle">divky 7</text><text x="129" y="104" font-size="12" text-anchor="middle">chlapci 3</text><text x="84" y="168" font-size="12" text-anchor="middle">divky ?</text><text x="110" y="249" font-size="12" text-anchor="middle">divky 4</text><text x="240" y="249" font-size="12" text-anchor="middle">chlapci ?</text></svg>',
  'graf-oddily.svg',
  'Prstencovy graf tri oddilu A, B, C s pocty chlapcu a divek; dva udaje (divky v C, chlapci v B) chybi.',
  'Schematicky nakres grafu (dva udaje chybi)',
  new List<String>{'V oddile $A$ je $9+7=16$ deti. Oddil $C$ ma polovinu, tj. $8$ deti; z toho $3$ chlapci, takze divek je $8-3=5$ -> 10.1 A.','Pomer $A:B=4:3$ dava $B=\\dfrac{3}{4}\\cdot 16=12$ deti; z toho $4$ divky, tedy chlapcu $12-4=8$. To je dvakrat vice nez divek (ne o polovinu vice) -> 10.2 N.','Celkem divek $7+4+5=16$, chlapcu $9+8+3=20$. Petina z $20$ je $4$ a $20-4=16$ -> divek je o petinu mene nez chlapcu -> 10.3 A.'},
  '10.1: A (ano); 10.2: N (ne); 10.3: A (ano)',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2023 - uloha 11',
  new List<String>{'V obchode s orisky michaji smes arasidu a mandli a prodavaji ji v ruzne velkych baleních. Sto gramu teto smesi se prodava za $20$ korun, pricemz sto gramu arasidu stoji $10$ korun. Tereza si koupila $800$gramove baleni teto smesi. V takovem baleni je vzdy $300$ g arasidu. Cena smesi zavisi pouze na hmotnosti a cene pouzitych surovin.','Kolik korun stoji sto gramu mandli?'},
  new List<String>{'A) $26$ korun','B) $27$ korun','C) $28$ korun','D) $29$ korun','E) jiny pocet korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Baleni $800$ g stoji $8\\cdot 20=160$ korun. Arasidy ($300$ g) stoji $3\\cdot 10=30$ korun, takze $500$ g mandli stoji $160-30=130$ korun. Sto gramu mandli stoji $130:5=26$ korun.'},
  'A) $26$ korun',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
