String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M7B 2018 – úloha 10',
  new List<String>{'Čtvercová síť je tvořena čtverečky s délkou strany 1 cm. Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah obrazce $A$ je stejný jako obsah obrazce $B$.','10.2 Obsah obrazce $A$ je větší než $12$ cm².','10.3 Obvod obrazce $A$ je větší než obvod obrazce $B$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 320" font-family="sans-serif"><line x1="20" y1="15" x2="20" y2="285" stroke="#999" stroke-width="1"/><line x1="50" y1="15" x2="50" y2="285" stroke="#999" stroke-width="1"/><line x1="80" y1="15" x2="80" y2="285" stroke="#999" stroke-width="1"/><line x1="110" y1="15" x2="110" y2="285" stroke="#999" stroke-width="1"/><line x1="140" y1="15" x2="140" y2="285" stroke="#999" stroke-width="1"/><line x1="170" y1="15" x2="170" y2="285" stroke="#999" stroke-width="1"/><line x1="200" y1="15" x2="200" y2="285" stroke="#999" stroke-width="1"/><line x1="230" y1="15" x2="230" y2="285" stroke="#999" stroke-width="1"/><line x1="260" y1="15" x2="260" y2="285" stroke="#999" stroke-width="1"/><line x1="290" y1="15" x2="290" y2="285" stroke="#999" stroke-width="1"/><line x1="320" y1="15" x2="320" y2="285" stroke="#999" stroke-width="1"/><line x1="20" y1="15" x2="320" y2="15" stroke="#999" stroke-width="1"/><line x1="20" y1="45" x2="320" y2="45" stroke="#999" stroke-width="1"/><line x1="20" y1="75" x2="320" y2="75" stroke="#999" stroke-width="1"/><line x1="20" y1="105" x2="320" y2="105" stroke="#999" stroke-width="1"/><line x1="20" y1="135" x2="320" y2="135" stroke="#999" stroke-width="1"/><line x1="20" y1="165" x2="320" y2="165" stroke="#999" stroke-width="1"/><line x1="20" y1="195" x2="320" y2="195" stroke="#999" stroke-width="1"/><line x1="20" y1="225" x2="320" y2="225" stroke="#999" stroke-width="1"/><line x1="20" y1="255" x2="320" y2="255" stroke="#999" stroke-width="1"/><line x1="20" y1="285" x2="320" y2="285" stroke="#999" stroke-width="1"/><polygon points="80,15 170,15 80,195 50,195 50,105" fill="#ffffff" stroke="#000" stroke-width="2.5"/><polygon points="260,45 320,45 230,225 170,225" fill="#ffffff" stroke="#000" stroke-width="2.5"/><text x="86" y="111" font-size="16" font-weight="bold">A</text><text x="242" y="141" font-size="16" font-weight="bold">B</text><rect x="290" y="255" width="30" height="30" fill="#d9d9d9" stroke="#999"/><text x="292" y="251" font-size="12">1 cm</text></svg>',
  'sit-obrazce-AB.svg',
  'Čtvercová síť s dvěma bílými šikmými obrazci A a B o stejném obsahu; obrazec B je protáhlejší.',
  'Bílé obrazce A a B ve čtvercové síti (schematicky)',
  new List<String>{'Přepočtem čtverečků (např. doplněním obrazce do obdélníku a odečtením trojúhelníků) vyjde obsah obrazce $A$ i obrazce $B$ shodně $13{,}5$ cm².','10.1 Obsahy obou obrazců jsou stejné → Ano.','10.2 Obsah obrazce $A$ je $13{,}5$ cm² $>12$ cm² → Ano.','10.3 Obrazec $B$ je protáhlejší (šikmější), jeho obvod je větší; obvod $A$ tedy není větší než obvod $B$ → Ne.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ne',
  4, 5, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
