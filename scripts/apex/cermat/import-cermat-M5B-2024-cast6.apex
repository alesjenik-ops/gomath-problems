String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD24C0T02';
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
  'CERMAT M5B 2024 – úloha 11',
  new List<String>{'Kruhový diagram, který je rozdělen na 10 shodných částí, znázorňuje výsledky písemné práce z matematiky, kterou psali všichni žáci z devátého ročníku. Známky 1, 3 a 4 mělo celkem 56 žáků (viz obrázek).','Kolik žáků celkem je v devátém ročníku?'},
  new List<String>{'A) 140','B) 112','C) 93','D) 80','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 300" font-family="sans-serif"><path d="M 165 150 L 165.0 30.0 A 120 120 0 0 1 235.5 52.9 Z" fill="#e8e8e8" stroke="#000"/><text x="188.0" y="84.2" font-size="15" text-anchor="middle" font-weight="bold">1</text><path d="M 165 150 L 235.5 52.9 A 120 120 0 0 1 279.1 187.1 Z" fill="#ffffff" stroke="#000"/><text x="235.8" y="132.0" font-size="15" text-anchor="middle" font-weight="bold">2</text><path d="M 165 150 L 279.1 187.1 A 120 120 0 0 1 50.9 187.1 Z" fill="#8f8f8f" stroke="#000"/><text x="165.0" y="229.4" font-size="15" text-anchor="middle" font-weight="bold">3</text><path d="M 165 150 L 50.9 187.1 A 120 120 0 0 1 94.5 52.9 Z" fill="#cfcfcf" stroke="#000"/><text x="94.2" y="132.0" font-size="15" text-anchor="middle" font-weight="bold">4</text><path d="M 165 150 L 94.5 52.9 A 120 120 0 0 1 165.0 30.0 Z" fill="#bcbcbc" stroke="#000"/><text x="142.0" y="84.2" font-size="15" text-anchor="middle" font-weight="bold">5</text><line x1="165" y1="150" x2="165.0" y2="30.0" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="235.5" y2="52.9" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="279.1" y2="112.9" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="279.1" y2="187.1" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="235.5" y2="247.1" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="165.0" y2="270.0" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="94.5" y2="247.1" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="50.9" y2="187.1" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="50.9" y2="112.9" stroke="#000" stroke-width="0.7"/><line x1="165" y1="150" x2="94.5" y2="52.9" stroke="#000" stroke-width="0.7"/></svg>',
  'kruhovy-diagram.svg',
  'Kruhový diagram rozdělený na 10 shodných dílků: známka 1 (1 dílek), 2 (2 dílky), 3 (4 dílky), 4 (2 dílky), 5 (1 dílek).',
  'Výsledky písemné práce (10 shodných dílků)',
  new List<String>{'Diagram má $10$ shodných dílků. Známky $1$, $3$ a $4$ zabírají $1+4+2=7$ dílků a odpovídají $56$ žákům, tj. jeden dílek $=56:7=8$ žáků. Celkem $10\\cdot 8=80$ žáků → D.'},
  'D) 80',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','pocetni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2024 – úloha 12',
  new List<String>{'Čerpadlo, které trvale čerpá vodu stejnou rychlostí, naplní vodou 3 stejné prázdné nádrže za 2 hodiny.','12.1 Za jak dlouho jediné takové čerpadlo naplní 12 takových prázdných nádrží?','12.2 Jak dlouho by se 12 takových prázdných nádrží plnilo vodou, pokud by se po naplnění šesti prázdných nádrží přidalo k prvnímu čerpadlu ještě druhé úplně stejné čerpadlo?','12.3 Jak dlouho by se 15 takových prázdných nádrží plnilo vodou dvěma takovými úplně stejnými čerpadly?'},
  new List<String>{'12.1: A) za 4 hodiny; B) za 6 hodin; C) za 8 hodin; D) za 10 hodin; E) za 12 hodin','12.2: A) 1 hodinu; B) 2 hodiny; C) 4 hodiny; D) 6 hodin; E) 8 hodin','12.3: A) 1 hodinu; B) 2 hodiny; C) 3 hodiny; D) 4 hodiny; E) 5 hodin'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jedno čerpadlo naplní $3$ nádrže za $2$ h, tj. $1{,}5$ nádrže za hodinu.','12.1 $12:1{,}5=8$ hodin → C.','12.2 Prvních $6$ nádrží jedno čerpadlo za $6:1{,}5=4$ h, dalších $6$ nádrží dvě čerpadla ($3$ nádrže/h) za $2$ h; celkem $6$ hodin → D.','12.3 Dvě čerpadla naplní $3$ nádrže za hodinu, $15:3=5$ hodin → E.'},
  '12.1: C) za 8 hodin; 12.2: D) 6 hodin; 12.3: E) 5 hodin',
  3, 6, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
