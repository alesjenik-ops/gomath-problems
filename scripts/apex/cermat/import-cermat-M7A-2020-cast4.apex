String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M7A 2020 – úloha 10',
  new List<String>{'Ve čtvercové síti jsou zakresleny dva tmavé obrazce $A$, $B$. Vrcholy obou obrazců leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky $1$ cm.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah obrazce $A$ je $7$ cm².','10.2 Obsah obrazce $B$ je o $1$ cm² větší než obsah obrazce $A$.','10.3 Obvod obrazce $B$ je stejný jako obvod obrazce $A$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 236" font-family="sans-serif"><line x1="26" y1="20" x2="26" y2="200" stroke="#bbb" stroke-width="1"/><line x1="56" y1="20" x2="56" y2="200" stroke="#bbb" stroke-width="1"/><line x1="86" y1="20" x2="86" y2="200" stroke="#bbb" stroke-width="1"/><line x1="116" y1="20" x2="116" y2="200" stroke="#bbb" stroke-width="1"/><line x1="146" y1="20" x2="146" y2="200" stroke="#bbb" stroke-width="1"/><line x1="176" y1="20" x2="176" y2="200" stroke="#bbb" stroke-width="1"/><line x1="206" y1="20" x2="206" y2="200" stroke="#bbb" stroke-width="1"/><line x1="236" y1="20" x2="236" y2="200" stroke="#bbb" stroke-width="1"/><line x1="266" y1="20" x2="266" y2="200" stroke="#bbb" stroke-width="1"/><line x1="296" y1="20" x2="296" y2="200" stroke="#bbb" stroke-width="1"/><line x1="326" y1="20" x2="326" y2="200" stroke="#bbb" stroke-width="1"/><line x1="356" y1="20" x2="356" y2="200" stroke="#bbb" stroke-width="1"/><line x1="386" y1="20" x2="386" y2="200" stroke="#bbb" stroke-width="1"/><line x1="26" y1="20" x2="386" y2="20" stroke="#bbb" stroke-width="1"/><line x1="26" y1="50" x2="386" y2="50" stroke="#bbb" stroke-width="1"/><line x1="26" y1="80" x2="386" y2="80" stroke="#bbb" stroke-width="1"/><line x1="26" y1="110" x2="386" y2="110" stroke="#bbb" stroke-width="1"/><line x1="26" y1="140" x2="386" y2="140" stroke="#bbb" stroke-width="1"/><line x1="26" y1="170" x2="386" y2="170" stroke="#bbb" stroke-width="1"/><line x1="26" y1="200" x2="386" y2="200" stroke="#bbb" stroke-width="1"/><polygon points="56,50 146,50 146,140 86,170 116,110" fill="#9a9a9a" stroke="#000" stroke-width="2"/><polygon points="326,50 356,80 356,110 266,110 266,140 236,140 206,110" fill="#9a9a9a" stroke="#000" stroke-width="2"/><text x="112" y="98" font-size="16" font-weight="bold">A</text><text x="292" y="98" font-size="16" font-weight="bold">B</text><text x="26" y="214" font-size="12">strana čtverečku 1 cm</text></svg>',
  'ctvercova-sit-ab.svg',
  'Čtvercová síť se dvěma tmavými mnohoúhelníky A a B; vrcholy leží v mřížových bodech, strana čtverečku je 1 cm.',
  'Dva obrazce ve čtvercové síti (čtvereček 1 cm)',
  new List<String>{'Obsahy určíme rozdělením na trojúhelníky (nebo Pickovou větou): obrazec $A$ má obsah $6$ cm², obrazec $B$ má obsah $7$ cm².','10.1 Obsah $A$ je $6$ cm², nikoli $7$ cm² → N.','10.2 $7-6=1$ cm², obrazec $B$ je o $1$ cm² větší → A.','10.3 Oba obvody jsou $6+2\\sqrt{2}+2\\sqrt{5}$ cm (přibližně $13{,}3$ cm), tedy stejné → A.'},
  '10.1: N; 10.2: A; 10.3: A',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
