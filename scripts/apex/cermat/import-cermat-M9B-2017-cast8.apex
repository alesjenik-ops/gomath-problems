String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD17C0T02';
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
  'CERMAT M9B 2017 – úloha 16',
  new List<String>{'Dva nebo více shodných obdélníků poskládáme těsně vedle sebe do jedné řady. Pokud se každé dva sousední obdélníky dotýkají kratší stranou, vznikne obrazec typu A, dotýkají-li se delší stranou, vznikne obrazec typu B.','Platí: Obvody obrazců typu A a B složených ze dvou obdélníků se liší o 10 cm. Přidáme-li k oběma obrazcům další obdélníky, rozdíl mezi obvody obou obrazců se změní.','16.1 Vypočtěte, o kolik cm se liší obvody obrazců A a B, obsahuje-li každý z nich tři obdélníky.','16.2 Vypočtěte, o kolik cm se liší obvody obrazců A a B, obsahuje-li každý z nich šest obdélníků.','16.3 Obvody obrazců A a B, které obsahují stejný počet obdélníků, se liší o 100 cm. Vypočtěte, z kolika obdélníků je složen jeden z těchto obrazců.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 280" font-family="sans-serif"><g fill="#f0f0f0" stroke="#000" stroke-width="2"><rect x="48" y="18" width="60" height="36"/><rect x="108" y="18" width="60" height="36"/><rect x="300" y="6" width="36" height="60"/><rect x="336" y="6" width="36" height="60"/><rect x="48" y="98" width="60" height="36"/><rect x="108" y="98" width="60" height="36"/><rect x="168" y="98" width="60" height="36"/><rect x="300" y="86" width="36" height="60"/><rect x="336" y="86" width="36" height="60"/><rect x="372" y="86" width="36" height="60"/><rect x="48" y="188" width="60" height="36"/><rect x="108" y="188" width="60" height="36"/><rect x="214" y="188" width="60" height="36"/><rect x="300" y="176" width="36" height="60"/><rect x="336" y="176" width="36" height="60"/><rect x="414" y="176" width="36" height="60"/></g><g font-size="17" font-weight="bold"><text x="20" y="42">A</text><text x="272" y="42">B</text><text x="20" y="122">A</text><text x="272" y="122">B</text><text x="20" y="212">A</text><text x="272" y="212">B</text></g><text x="180" y="212" font-size="18">...</text><text x="380" y="212" font-size="18">...</text></svg>',
  'obrazce-AB.svg',
  'Obrazce typu A (obdélníky vedle sebe dotýkající se kratší stranou) a typu B (dotýkající se delší stranou) pro dva, tři a více obdélníků.',
  'Obrazce typu A a typu B',
  new List<String>{'Označme delší stranu obdélníku $a$ a kratší $b$. Obrazec typu A z $n$ obdélníků má obvod $2(na+b)$, obrazec typu B obvod $2(a+nb)$.','Rozdíl obvodů je $2(na+b)-2(a+nb)=2(n-1)(a-b)$.','Pro $n=2$ je rozdíl $2(a-b)=10$ cm, tedy $a-b=5$ cm a obecně je rozdíl $10(n-1)$ cm.','16.1 Pro $n=3$: $10\\cdot 2=20$ cm.','16.2 Pro $n=6$: $10\\cdot 5=50$ cm.','16.3 $10(n-1)=100$, tedy $n-1=10$ a $n=11$ obdélníků.'},
  '16.1: o $20$ cm; 16.2: o $50$ cm; 16.3: $11$ obdélníků',
  4, 8, '4',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
