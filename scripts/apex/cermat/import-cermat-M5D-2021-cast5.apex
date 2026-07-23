String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
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
  'CERMAT M5D 2021 – úloha 9',
  new List<String>{'Soutěž měla čtyři kola. V grafu jsou uvedeny výsledky družstva v prvních třech kolech. V $1.$ kole družstvo získalo o $15$ bodů méně než ve $2.$ kole. Ve $4.$ kole družstvo získalo o polovinu více bodů než ve $3.$ kole.','Kolik bodů získalo družstvo ve $4.$ kole?'},
  new List<String>{'A) $25$ bodů','B) $30$ bodů','C) $35$ bodů','D) $40$ bodů','E) jiný počet bodů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif"><line x1="70" y1="250" x2="366" y2="250" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="230" x2="366" y2="230" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="210" x2="366" y2="210" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="190" x2="366" y2="190" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="170" x2="366" y2="170" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="150" x2="366" y2="150" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="130" x2="366" y2="130" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="110" x2="366" y2="110" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="90" x2="366" y2="90" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="70" x2="366" y2="70" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="50" x2="366" y2="50" stroke="#bbb" stroke-width="0.8"/><line x1="70" y1="30" x2="70" y2="250" stroke="#000" stroke-width="1.5"/><line x1="70" y1="250" x2="366" y2="250" stroke="#000" stroke-width="1.5"/><rect x="98" y="150" width="46" height="100" fill="#666" stroke="#000"/><text x="121" y="266" font-size="12" text-anchor="middle">1. kolo</text><rect x="172" y="90" width="46" height="160" fill="#666" stroke="#000"/><text x="195" y="266" font-size="12" text-anchor="middle">2. kolo</text><rect x="246" y="170" width="46" height="80" fill="#666" stroke="#000"/><text x="269" y="266" font-size="12" text-anchor="middle">3. kolo</text><rect x="320" y="130" width="46" height="120" fill="none" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/><text x="343" y="194" font-size="22" text-anchor="middle" font-weight="bold">?</text><text x="343" y="266" font-size="12" text-anchor="middle">4. kolo</text><text x="20" y="140" font-size="12" transform="rotate(-90 20 140)" text-anchor="middle">Počet bodů</text><text x="64" y="254" font-size="12" text-anchor="end">0</text></svg>',
  'graf-kola.svg',
  'Sloupcový graf s počty bodů v 1., 2. a 3. kole; 4. kolo je označeno otazníkem.',
  'Počet bodů v jednotlivých kolech',
  new List<String>{'Z grafu: $1.$ kolo $25$ bodů, $2.$ kolo $40$ bodů (o $15$ více), $3.$ kolo $20$ bodů. Ve $4.$ kole je $20+\\frac{1}{2}\\cdot 20=30$ bodů.'},
  'B) $30$ bodů',
  2, 3, '2',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
