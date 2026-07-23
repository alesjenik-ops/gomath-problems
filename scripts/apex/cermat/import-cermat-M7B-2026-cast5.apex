String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
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
  'CERMAT M7B 2026 – úloha 10',
  new List<String>{'Vojta dostal na začátku ledna k narozeninám novou herní konzoli a společně s ní i dvě hry. Obě hry začal v lednu hrát. V průběhu následujících měsíců získával další nové hry. Tabulka udává, kolik her získaných v tomto roce měl Vojta na konci uvedeného měsíce stále ještě rozehraných a kolik her měl již dohraných. Např. na konci června měl Vojta rozehranou jen 1 hru, zatímco dalších 7 her získaných v tomto roce již stihl do konce června dohrát.','Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 V únoru Vojta dohrál alespoň jednu z her rozehraných v lednu.','10.2 V březnu Vojta rozehrál pouze dvě nové hry.','10.3 V květnu Vojta dohrál stejný počet her jako v dubnu.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 622 116" font-family="sans-serif" font-size="13"><rect x="10" y="10" width="170" height="32" fill="none" stroke="#000"/><text x="16" y="31.0" text-anchor="start">Měsíc</text><rect x="180" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="216.0" y="31.0" text-anchor="middle">Leden</text><rect x="252" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="288.0" y="31.0" text-anchor="middle">Únor</text><rect x="324" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="360.0" y="31.0" text-anchor="middle">Březen</text><rect x="396" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="432.0" y="31.0" text-anchor="middle">Duben</text><rect x="468" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="504.0" y="31.0" text-anchor="middle">Květen</text><rect x="540" y="10" width="72" height="32" fill="none" stroke="#000"/><text x="576.0" y="31.0" text-anchor="middle">Červen</text><rect x="10" y="42" width="170" height="32" fill="none" stroke="#000"/><text x="16" y="63.0" text-anchor="start">Rozehraných her</text><rect x="180" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="216.0" y="63.0" text-anchor="middle">2</text><rect x="252" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="288.0" y="63.0" text-anchor="middle">1</text><rect x="324" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="360.0" y="63.0" text-anchor="middle">3</text><rect x="396" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="432.0" y="63.0" text-anchor="middle">1</text><rect x="468" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="504.0" y="63.0" text-anchor="middle">3</text><rect x="540" y="42" width="72" height="32" fill="none" stroke="#000"/><text x="576.0" y="63.0" text-anchor="middle">1</text><rect x="10" y="74" width="170" height="32" fill="none" stroke="#000"/><text x="16" y="95.0" text-anchor="start">Dohraných her</text><rect x="180" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="216.0" y="95.0" text-anchor="middle">0</text><rect x="252" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="288.0" y="95.0" text-anchor="middle">2</text><rect x="324" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="360.0" y="95.0" text-anchor="middle">3</text><rect x="396" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="432.0" y="95.0" text-anchor="middle">5</text><rect x="468" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="504.0" y="95.0" text-anchor="middle">5</text><rect x="540" y="74" width="72" height="32" fill="none" stroke="#000"/><text x="576.0" y="95.0" text-anchor="middle">7</text></svg>',
  'tabulka-hry.svg',
  'Tabulka počtu rozehraných a dohraných her na konci měsíců leden až červen: rozehraných 2, 1, 3, 1, 3, 1; dohraných 0, 2, 3, 5, 5, 7.',
  'Počet rozehraných a dohraných her na konci měsíce',
  new List<String>{'Na konci měsíce je celkem získaných her rovno součtu rozehraných a dohraných (dohrané se sčítají): leden $2$, únor $3$, březen $6$, duben $6$, květen $8$, červen $8$.','10.1 Do konce února Vojta dohrál $2$ hry, přičemž kromě dvou lednových měl k dispozici jen $1$ novou únorovou hru; alespoň jednu lednovou hru tedy dohrál. Pravdivé (A).','10.2 V březnu přibyly $6 - 3 = 3$ nové hry, ne dvě. Nepravdivé (N).','10.3 V dubnu dohrál $5 - 3 = 2$ hry, v květnu $5 - 5 = 0$ her; počty se liší. Nepravdivé (N).'},
  '10.1: A; 10.2: N; 10.3: N',
  4, 5, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
