String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M9A 2017 – úloha 16',
  new List<String>{'V rovnostranném trojúhelníku se v jednotlivých řadách pravidelně střídají tmavé a bílé shodné trojúhelníčky. Ze dvou shodných trojúhelníků (jednoho postaveného a jednoho obráceného) je vytvořen kosočtverec. Obdobným způsobem lze z větších trojúhelníků vytvořit kosočtverec s větším počtem řad.','16.1 Kosočtverec má v každé řadě 4 bílé trojúhelníčky. Určete počet tmavých trojúhelníčků v kosočtverci.','16.2 Kosočtverec má v každé řadě 6 tmavých trojúhelníčků. Určete počet všech trojúhelníčků (bílých i tmavých) v kosočtverci.','16.3 Kosočtverec má v každé řadě 21 tmavých trojúhelníčků. Určete počet všech trojúhelníčků (bílých i tmavých) v kosočtverci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 95" font-family="sans-serif"><g stroke="#000" stroke-width="1"><polygon points="55,20 44,39 66,39" fill="#c9c9c9"/><polygon points="44,39 33,58 55,58" fill="#c9c9c9"/><polygon points="66,39 55,58 77,58" fill="#c9c9c9"/><polygon points="44,39 66,39 55,58" fill="#ffffff"/><polygon points="33,58 22,77 44,77" fill="#c9c9c9"/><polygon points="55,58 44,77 66,77" fill="#c9c9c9"/><polygon points="77,58 66,77 88,77" fill="#c9c9c9"/><polygon points="33,58 55,58 44,77" fill="#ffffff"/><polygon points="55,58 77,58 66,77" fill="#ffffff"/><polygon points="132,20 154,20 143,39" fill="#c9c9c9"/><polygon points="154,20 176,20 165,39" fill="#c9c9c9"/><polygon points="176,20 198,20 187,39" fill="#c9c9c9"/><polygon points="143,39 165,39 154,20" fill="#ffffff"/><polygon points="165,39 187,39 176,20" fill="#ffffff"/><polygon points="143,39 165,39 154,58" fill="#c9c9c9"/><polygon points="165,39 187,39 176,58" fill="#c9c9c9"/><polygon points="154,58 176,58 165,39" fill="#ffffff"/><polygon points="154,58 176,58 165,77" fill="#c9c9c9"/><polygon points="269,39 291,39 280,20" fill="#c9c9c9"/><polygon points="291,39 313,39 302,20" fill="#ffffff"/><polygon points="313,39 335,39 324,20" fill="#ffffff"/><polygon points="280,20 302,20 291,39" fill="#c9c9c9"/><polygon points="302,20 324,20 313,39" fill="#c9c9c9"/><polygon points="324,20 346,20 335,39" fill="#c9c9c9"/><polygon points="258,58 280,58 269,39" fill="#c9c9c9"/><polygon points="280,58 302,58 291,39" fill="#c9c9c9"/><polygon points="302,58 324,58 313,39" fill="#ffffff"/><polygon points="269,39 291,39 280,58" fill="#ffffff"/><polygon points="291,39 313,39 302,58" fill="#c9c9c9"/><polygon points="313,39 335,39 324,58" fill="#c9c9c9"/><polygon points="247,77 269,77 258,58" fill="#c9c9c9"/><polygon points="269,77 291,77 280,58" fill="#c9c9c9"/><polygon points="291,77 313,77 302,58" fill="#c9c9c9"/><polygon points="258,58 280,58 269,77" fill="#ffffff"/><polygon points="280,58 302,58 291,77" fill="#ffffff"/><polygon points="302,58 324,58 313,77" fill="#c9c9c9"/></g><g font-size="20" text-anchor="middle"><text x="108" y="58">+</text><text x="228" y="58">=</text></g></svg>',
  'kosoctverec-trojuhelnicky.svg',
  'Rovnostranný trojúhelník o třech řadách a obrácený trojúhelník tvoří kosočtverec o třech řadách po šesti trojúhelníčcích.',
  'Vznik kosočtverce ze dvou shodných trojúhelníků (3 řady)',
  new List<String>{'Kosočtverec o $n$ řadách má v každé řadě $2n$ trojúhelníčků: $n+1$ tmavých a $n-1$ bílých. Celkem má $2n^2$ trojúhelníčků.','16.1 $n-1=4$, tedy $n=5$; tmavých je $n\\cdot(n+1)=5\\cdot 6=30$.','16.2 $n+1=6$, tedy $n=5$; všech je $2\\cdot 5^2=50$.','16.3 $n+1=21$, tedy $n=20$; všech je $2\\cdot 20^2=800$.'},
  '16.1: $30$ tmavých; 16.2: $50$ trojúhelníčků; 16.3: $800$ trojúhelníčků',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
