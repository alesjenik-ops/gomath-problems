String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
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
  'CERMAT M7B 2024 - uloha 11',
  new List<String>{'Zubni lekar si zaznamenava, kolik pacientu behem tydne osetril. Kazdy den ma pulhodinovou prestavku. Ordinacni doba a pocty osetrenych muzu, zen a deti jsou v tabulce.','Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).','11.1 Za cely tyden osetril dany lekar za jednu hodinu v prumeru $3$ pacienty.','11.2 Prumerny cas na osetreni jednoho pacienta byl u daneho lekare nejkratsi ve stredu.','11.3 Prumerny cas na osetreni jednoho pacienta byl u daneho lekare v pondeli vice nez $20$ minut.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 188" font-family="sans-serif"><text x="330" y="34" font-size="12" text-anchor="middle">Ordinacni doba</text><rect x="90" y="42" width="96" height="34" fill="#e6e6e6" stroke="#000"/><text x="138" y="57" font-size="11" text-anchor="middle">pondeli</text><text x="138" y="71" font-size="10" text-anchor="middle">7:00-13:30</text><rect x="186" y="42" width="96" height="34" fill="#e6e6e6" stroke="#000"/><text x="234" y="57" font-size="11" text-anchor="middle">utery</text><text x="234" y="71" font-size="10" text-anchor="middle">7:00-14:30</text><rect x="282" y="42" width="96" height="34" fill="#e6e6e6" stroke="#000"/><text x="330" y="57" font-size="11" text-anchor="middle">streda</text><text x="330" y="71" font-size="10" text-anchor="middle">7:00-14:30</text><rect x="378" y="42" width="96" height="34" fill="#e6e6e6" stroke="#000"/><text x="426" y="57" font-size="11" text-anchor="middle">ctvrtek</text><text x="426" y="71" font-size="10" text-anchor="middle">11:00-18:00</text><rect x="474" y="42" width="96" height="34" fill="#e6e6e6" stroke="#000"/><text x="522" y="57" font-size="11" text-anchor="middle">patek</text><text x="522" y="71" font-size="10" text-anchor="middle">7:00-14:00</text><rect x="0" y="76" width="90" height="34" fill="#e6e6e6" stroke="#000"/><text x="45" y="97" font-size="11" text-anchor="middle">muzi</text><rect x="90" y="76" width="96" height="34" fill="#fff" stroke="#000"/><text x="138" y="97" font-size="12" text-anchor="middle">7</text><rect x="186" y="76" width="96" height="34" fill="#fff" stroke="#000"/><text x="234" y="97" font-size="12" text-anchor="middle">6</text><rect x="282" y="76" width="96" height="34" fill="#fff" stroke="#000"/><text x="330" y="97" font-size="12" text-anchor="middle">9</text><rect x="378" y="76" width="96" height="34" fill="#fff" stroke="#000"/><text x="426" y="97" font-size="12" text-anchor="middle">9</text><rect x="474" y="76" width="96" height="34" fill="#fff" stroke="#000"/><text x="522" y="97" font-size="12" text-anchor="middle">7</text><rect x="0" y="110" width="90" height="34" fill="#e6e6e6" stroke="#000"/><text x="45" y="131" font-size="11" text-anchor="middle">zeny</text><rect x="90" y="110" width="96" height="34" fill="#fff" stroke="#000"/><text x="138" y="131" font-size="12" text-anchor="middle">5</text><rect x="186" y="110" width="96" height="34" fill="#fff" stroke="#000"/><text x="234" y="131" font-size="12" text-anchor="middle">10</text><rect x="282" y="110" width="96" height="34" fill="#fff" stroke="#000"/><text x="330" y="131" font-size="12" text-anchor="middle">7</text><rect x="378" y="110" width="96" height="34" fill="#fff" stroke="#000"/><text x="426" y="131" font-size="12" text-anchor="middle">11</text><rect x="474" y="110" width="96" height="34" fill="#fff" stroke="#000"/><text x="522" y="131" font-size="12" text-anchor="middle">6</text><rect x="0" y="144" width="90" height="34" fill="#e6e6e6" stroke="#000"/><text x="45" y="165" font-size="11" text-anchor="middle">deti</text><rect x="90" y="144" width="96" height="34" fill="#fff" stroke="#000"/><text x="138" y="165" font-size="12" text-anchor="middle">6</text><rect x="186" y="144" width="96" height="34" fill="#fff" stroke="#000"/><text x="234" y="165" font-size="12" text-anchor="middle">4</text><rect x="282" y="144" width="96" height="34" fill="#fff" stroke="#000"/><text x="330" y="165" font-size="12" text-anchor="middle">7</text><rect x="378" y="144" width="96" height="34" fill="#fff" stroke="#000"/><text x="426" y="165" font-size="12" text-anchor="middle">1</text><rect x="474" y="144" width="96" height="34" fill="#fff" stroke="#000"/><text x="522" y="165" font-size="12" text-anchor="middle">4</text><rect x="0" y="42" width="90" height="34" fill="#e6e6e6" stroke="#000"/></svg>',
  'tabulka-ordinace.svg',
  'Tabulka poctu osetrenych muzu, zen a deti a ordinacni doby pro pondeli az patek.',
  'Pocet pacientu a ordinacni doba v jednotlivych dnech',
  new List<String>{'Cista ordinacni doba (bez pulhodinove prestavky) a pocet pacientu: pondeli $6$ h / $18$, utery $7$ h / $20$, streda $7$ h / $23$, ctvrtek $6{,}5$ h / $21$, patek $6{,}5$ h / $17$.','11.1 Celkem $99$ pacientu za $33$ hodin, tj. $99:33 = 3$ pacienti za hodinu - pravda (A).','11.2 Prumerny cas na pacienta: streda $420:23 \\approx 18{,}3$ min je nejmene ze vsech dnu - pravda (A).','11.3 V pondeli $360:18 = 20$ min, coz neni vice nez $20$ minut - nepravda (N).'},
  '11.1: A; 11.2: A; 11.3: N',
  3, 6, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
