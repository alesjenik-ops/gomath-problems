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
  'CERMAT M5B 2024 – úloha 9',
  new List<String>{'Lukáš a Pepa trhají jablka, která dávají do stejných beden. Každý z hochů pracuje stálým tempem. Za každou hodinu Pepa naplní jablky 5 beden a Lukáš 3 bedny.','Za jak dlouho oba chlapci společně naplní jablky 64 beden?'},
  new List<String>{'A) za 240 minut','B) za 360 minut','C) za 480 minut','D) za 840 minut','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Společně naplní za hodinu $5+3=8$ beden. $64:8=8$ hodin $=480$ minut → C.'},
  'C) za 480 minut',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2024 – úloha 10',
  new List<String>{'Dřevěná krychle byla natřena modrou barvou ze všech šesti stran. Poté byla rozřezána na 64 stejných krychliček (řezy jsou naznačeny na obrázku).','Kolik celkem takto vzniklých krychliček nemá žádnou stranu modrou?'},
  new List<String>{'A) více než 8','B) 8','C) 4','D) 0','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 300" font-family="sans-serif"><rect x="45" y="95" width="200" height="200" fill="none" stroke="#000"/><line x1="95" y1="95" x2="95" y2="295" stroke="#000"/><line x1="45" y1="145" x2="245" y2="145" stroke="#000"/><line x1="145" y1="95" x2="145" y2="295" stroke="#000"/><line x1="45" y1="195" x2="245" y2="195" stroke="#000"/><line x1="195" y1="95" x2="195" y2="295" stroke="#000"/><line x1="45" y1="245" x2="245" y2="245" stroke="#000"/><polygon points="45,95 245,95 297,53 97,53" fill="none" stroke="#000"/><line x1="95" y1="95" x2="147" y2="53" stroke="#000"/><line x1="58" y1="84" x2="258" y2="84" stroke="#000"/><line x1="145" y1="95" x2="197" y2="53" stroke="#000"/><line x1="71" y1="74" x2="271" y2="74" stroke="#000"/><line x1="195" y1="95" x2="247" y2="53" stroke="#000"/><line x1="84" y1="64" x2="284" y2="64" stroke="#000"/><polygon points="245,95 297,53 297,253 245,295" fill="none" stroke="#000"/><line x1="245" y1="145" x2="297" y2="103" stroke="#000"/><line x1="258" y1="84" x2="258" y2="284" stroke="#000"/><line x1="245" y1="195" x2="297" y2="153" stroke="#000"/><line x1="271" y1="74" x2="271" y2="274" stroke="#000"/><line x1="245" y1="245" x2="297" y2="203" stroke="#000"/><line x1="284" y1="64" x2="284" y2="264" stroke="#000"/></svg>',
  'krychle.svg',
  'Krychle rozdělená řezy na 4 krát 4 krát 4 malých krychliček (schematický nákres).',
  'Schematický nákres krychle 4 krát 4 krát 4',
  new List<String>{'$64=4\\cdot 4\\cdot 4$. Krychličky bez modré strany tvoří vnitřní krychli o hraně $2$: $2\\cdot 2\\cdot 2=8$ krychliček → B.'},
  'B) 8',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
