String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
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
  'CERMAT M5B 2021 – úloha 9',
  new List<String>{'Třídy 5. A a 5. B se zúčastnily soutěže o třech kolech. V tabulce jsou počty bodů získané v jednotlivých kolech, některé údaje chybí (viz tabulka).','Třída 5. A získala nejméně bodů v 1. kole a nejvíce bodů ve 3. kole. Počet bodů získaných ve 2. kole se od obou zbývajících kol liší o stejný počet bodů.','Kolik bodů získaly dohromady obě třídy?'},
  new List<String>{'A) méně než 264 bodů','B) 264 bodů','C) 267 bodů','D) 270 bodů','E) více než 270 bodů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 410 158" font-family="sans-serif"><line x1="10" y1="10" x2="10" y2="138" stroke="#000"/><line x1="92" y1="10" x2="92" y2="138" stroke="#000"/><line x1="170" y1="10" x2="170" y2="138" stroke="#000"/><line x1="248" y1="10" x2="248" y2="138" stroke="#000"/><line x1="326" y1="10" x2="326" y2="138" stroke="#000"/><line x1="404" y1="10" x2="404" y2="138" stroke="#000"/><line x1="10" y1="10" x2="404" y2="10" stroke="#000"/><line x1="10" y1="42" x2="404" y2="42" stroke="#000"/><line x1="10" y1="74" x2="404" y2="74" stroke="#000"/><line x1="10" y1="106" x2="404" y2="106" stroke="#000"/><line x1="10" y1="138" x2="404" y2="138" stroke="#000"/><text x="51" y="30" font-size="11" text-anchor="middle" font-weight="bold">Třída</text><text x="131" y="30" font-size="11" text-anchor="middle" font-weight="bold">1. kolo</text><text x="209" y="30" font-size="11" text-anchor="middle" font-weight="bold">2. kolo</text><text x="287" y="30" font-size="11" text-anchor="middle" font-weight="bold">3. kolo</text><text x="365" y="30" font-size="11" text-anchor="middle" font-weight="bold">Součet</text><text x="51" y="62" font-size="11" text-anchor="middle">5. A</text><text x="131" y="62" font-size="11" text-anchor="middle">34</text><text x="287" y="62" font-size="11" text-anchor="middle">52</text><text x="51" y="94" font-size="11" text-anchor="middle">5. B</text><text x="365" y="94" font-size="11" text-anchor="middle">138</text><text x="51" y="126" font-size="11" text-anchor="middle">Obě třídy</text></svg>',
  'tabulka-body.svg',
  'Tabulka bodů tříd 5. A a 5. B ve třech kolech; některé buňky jsou prázdné.',
  'Body v soutěži (k úlohám 9 a 10)',
  new List<String>{'Ve 2. kole se 5. A liší od $34$ i od $52$ stejně, tedy $\\frac{34+52}{2}=43$. Součet 5. A $=34+43+52=129$. Obě třídy $=129+138=267$ bodů.'},
  'C) 267 bodů',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2021 – úloha 10',
  new List<String>{'Třídy 5. A a 5. B se zúčastnily soutěže o třech kolech (viz tabulka).','Třída 5. B získala ve 2. kole o $6$ bodů méně než v 1. kole a ve 3. kole dvakrát více bodů než v 1. kole.','Kolik bodů získaly dohromady obě třídy v 1. kole soutěže?'},
  new List<String>{'A) 67 bodů','B) 70 bodů','C) 78 bodů','D) 82 bodů','E) jiný počet bodů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 410 158" font-family="sans-serif"><line x1="10" y1="10" x2="10" y2="138" stroke="#000"/><line x1="92" y1="10" x2="92" y2="138" stroke="#000"/><line x1="170" y1="10" x2="170" y2="138" stroke="#000"/><line x1="248" y1="10" x2="248" y2="138" stroke="#000"/><line x1="326" y1="10" x2="326" y2="138" stroke="#000"/><line x1="404" y1="10" x2="404" y2="138" stroke="#000"/><line x1="10" y1="10" x2="404" y2="10" stroke="#000"/><line x1="10" y1="42" x2="404" y2="42" stroke="#000"/><line x1="10" y1="74" x2="404" y2="74" stroke="#000"/><line x1="10" y1="106" x2="404" y2="106" stroke="#000"/><line x1="10" y1="138" x2="404" y2="138" stroke="#000"/><text x="51" y="30" font-size="11" text-anchor="middle" font-weight="bold">Třída</text><text x="131" y="30" font-size="11" text-anchor="middle" font-weight="bold">1. kolo</text><text x="209" y="30" font-size="11" text-anchor="middle" font-weight="bold">2. kolo</text><text x="287" y="30" font-size="11" text-anchor="middle" font-weight="bold">3. kolo</text><text x="365" y="30" font-size="11" text-anchor="middle" font-weight="bold">Součet</text><text x="51" y="62" font-size="11" text-anchor="middle">5. A</text><text x="131" y="62" font-size="11" text-anchor="middle">34</text><text x="287" y="62" font-size="11" text-anchor="middle">52</text><text x="51" y="94" font-size="11" text-anchor="middle">5. B</text><text x="365" y="94" font-size="11" text-anchor="middle">138</text><text x="51" y="126" font-size="11" text-anchor="middle">Obě třídy</text></svg>',
  'tabulka-body.svg',
  'Tabulka bodů tříd 5. A a 5. B ve třech kolech; některé buňky jsou prázdné.',
  'Body v soutěži (k úlohám 9 a 10)',
  new List<String>{'5. B v 1. kole $b$: $b+(b-6)+2b=138$, tj. $4b=144$, $b=36$. Obě třídy v 1. kole $=34+36=70$ bodů.'},
  'B) 70 bodů',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
