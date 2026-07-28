String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 17',
  new List<String>{'Na cestě od startu $S$ do cíle $C$ kolem vodní plochy je možné postupovat pouze po čarách čtvercové sítě.','17.1 Zakreslete jednu cestu, která vede kolem vodní plochy z $S$ do $C$ a má nejkratší možnou délku.','17.2 Pokud existuje větší počet různých cest kolem vodní plochy z $S$ do $C$ s nejkratší možnou délkou, další dvě z těchto cest zakreslete.','17.3 Určete počet všech různých cest z $S$ do $C$ kolem vodní plochy, které mají nejkratší možnou délku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 378 358" font-family="sans-serif"><polygon points="69.0,248.20000000000002 313.79999999999995,250.60000000000002 323.4,272.20000000000005 309.0,297.64 78.6,298.6 65.16,274.6" fill="#bdbdbd"/><polygon points="71.4,188.2 129.0,193.0 131.4,250.60000000000002 73.8,250.60000000000002" fill="#bdbdbd"/><polygon points="239.39999999999998,25.0 273.0,25.0 275.4,245.79999999999998 237.0,248.20000000000002" fill="#bdbdbd"/><polygon points="107.4,33.639999999999986 244.20000000000002,25.0 244.20000000000002,61.0" fill="#bdbdbd"/><polygon points="273.0,73.0 313.79999999999995,75.39999999999999 321.0,104.20000000000002 273.0,101.79999999999998" fill="#bdbdbd"/><polygon points="306.6,25.0 333.0,25.0 333.0,94.60000000000001 313.79999999999995,92.20000000000002 318.6,49.0 306.6,49.0" fill="#bdbdbd"/><line x1="45" y1="313" x2="45" y2="25" stroke="#000"/><line x1="45" y1="313" x2="333" y2="313" stroke="#000"/><line x1="93" y1="313" x2="93" y2="25" stroke="#000"/><line x1="45" y1="265" x2="333" y2="265" stroke="#000"/><line x1="141" y1="313" x2="141" y2="25" stroke="#000"/><line x1="45" y1="217" x2="333" y2="217" stroke="#000"/><line x1="189" y1="313" x2="189" y2="25" stroke="#000"/><line x1="45" y1="169" x2="333" y2="169" stroke="#000"/><line x1="237" y1="313" x2="237" y2="25" stroke="#000"/><line x1="45" y1="121" x2="333" y2="121" stroke="#000"/><line x1="285" y1="313" x2="285" y2="25" stroke="#000"/><line x1="45" y1="73" x2="333" y2="73" stroke="#000"/><line x1="333" y1="313" x2="333" y2="25" stroke="#000"/><line x1="45" y1="25" x2="333" y2="25" stroke="#000"/><circle cx="45" cy="313" r="5" fill="#000"/><text x="37" y="339" font-size="16" font-style="italic" text-anchor="middle">S</text><circle cx="285" cy="73" r="5" fill="#000"/><text x="269" y="65" font-size="16" font-style="italic" text-anchor="middle">C</text></svg>',
  'planek-cesty.svg',
  'Plánek čtvercové sítě 6 krát 6 s šedou vodní plochou; start S je v levém dolním rohu, cíl C je vpravo nahoře.',
  'Plánek s vodní plochou (schematicky)',
  new List<String>{'Cesta se vede jen po čarách sítě a nesmí vstoupit do vodní plochy; nejkratší cesty postupují stále směrem k cíli (bez zacházek).','17.1 a 17.2 Stačí zakreslit tři různé nejkratší cesty (viz obrázky v klíči správných řešení).','17.3 Postupným počítáním možností v jednotlivých uzlech sítě vyjde, že různých nejkratších cest je $8$.'},
  '17.1 a 17.2: zakreslení tří různých nejkratších cest kolem vodní plochy (viz klíč); 17.3: $8$ cest',
  4, 8, '4',
  new List<String>{'zs2','r7','kombinatorika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
