String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD24C0T03';
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
  'CERMAT M5C 2024 – úloha 12',
  new List<String>{'Tři sourozenci Sára, Dana a Lukáš postupně šetřili každý do své pokladničky peníze, které dostávali. Zároveň si ze své pokladničky brali peníze na drobnosti pro sebe či dárky pro ostatní. Graf znázorňuje částky, které si jednotliví sourozenci našetřili (nad osou), nebo které utratili (pod osou) každý měsíc v první polovině roku (viz graf).','12.1 Kolik peněz měl v pokladničce Lukáš na konci června, když víme, že $1$. ledna měl v pokladničce $600$ Kč? Vyberte z možností: A) $200$ Kč, B) $400$ Kč, C) $750$ Kč, D) $1\\,000$ Kč, E) Výsledek nelze určit.','12.2 O kolik se změnila částka, kterou měla v pokladničce Sára, za první polovinu roku? Vyberte z možností: A) $400$ Kč, B) $650$ Kč, C) $750$ Kč, D) $1\\,250$ Kč, E) $1\\,800$ Kč.','12.3 Kolik peněz dohromady měli všichni sourozenci na konci června, když víme, že Sára měla v pokladničce $1$. ledna $1\\,050$ Kč, Dana $750$ Kč a Lukáš $600$ Kč? Vyberte z možností: A) Výsledek nelze určit, B) $1\\,250$ Kč, C) $1\\,800$ Kč, D) $2\\,400$ Kč, E) $4\\,200$ Kč.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 340" font-family="sans-serif"><line x1="70" y1="50" x2="70" y2="260" stroke="#000"/><line x1="70" y1="170" x2="480" y2="170" stroke="#000" stroke-width="1.5"/><line x1="66" y1="170" x2="70" y2="170" stroke="#000"/><text x="62" y="174" font-size="10" text-anchor="end">0</text><line x1="66" y1="140" x2="70" y2="140" stroke="#000"/><text x="62" y="144" font-size="10" text-anchor="end">100</text><line x1="66" y1="110" x2="70" y2="110" stroke="#000"/><text x="62" y="114" font-size="10" text-anchor="end">200</text><line x1="66" y1="80" x2="70" y2="80" stroke="#000"/><text x="62" y="84" font-size="10" text-anchor="end">300</text><line x1="66" y1="50" x2="70" y2="50" stroke="#000"/><text x="62" y="54" font-size="10" text-anchor="end">400</text><line x1="66" y1="200" x2="70" y2="200" stroke="#000"/><text x="62" y="204" font-size="10" text-anchor="end">100</text><line x1="66" y1="230" x2="70" y2="230" stroke="#000"/><text x="62" y="234" font-size="10" text-anchor="end">200</text><line x1="66" y1="260" x2="70" y2="260" stroke="#000"/><text x="62" y="264" font-size="10" text-anchor="end">300</text><text x="22" y="110" font-size="11" text-anchor="middle" transform="rotate(-90 22 110)">našetřené peníze</text><text x="22" y="225" font-size="11" text-anchor="middle" transform="rotate(-90 22 225)">utracené peníze</text><text x="115" y="278" font-size="10" text-anchor="middle">leden</text><text x="180" y="278" font-size="10" text-anchor="middle">únor</text><text x="245" y="278" font-size="10" text-anchor="middle">březen</text><text x="310" y="278" font-size="10" text-anchor="middle">duben</text><text x="375" y="278" font-size="10" text-anchor="middle">květen</text><text x="440" y="278" font-size="10" text-anchor="middle">červen</text><rect x="300" y="60" width="14" height="12" fill="#fff" stroke="#000"/><text x="320" y="70" font-size="11">Sára</text><rect x="300" y="78" width="14" height="12" fill="#dcdcdc" stroke="#000"/><text x="320" y="88" font-size="11">Dana (šrafovaně)</text><rect x="300" y="96" width="14" height="12" fill="#9a9a9a" stroke="#000"/><text x="320" y="106" font-size="11">Lukáš</text><text x="270" y="305" font-size="10" text-anchor="middle" fill="#555">Schematický nákres struktury grafu; přesné měsíční hodnoty viz testový sešit.</text></svg>',
  'graf-pokladnicky.svg',
  'Sloupcový graf našetřených (nad osou) a utracených (pod osou) částek tří sourozenců Sáry, Dany a Lukáše za měsíce leden až červen.',
  'Schematický nákres grafu (přesné hodnoty viz testový sešit)',
  new List<String>{'12.1 Součet Lukášových měsíčních změn (našetřené minus utracené) je $+400$ Kč; k počátečním $600$ Kč: $600+400=1\\,000$ Kč → D.','12.2 Změna Sářiny částky za pololetí je nárůst o $650$ Kč → B.','12.3 Sářiny, Danovy a Lukášovy změny za pololetí dají dohromady $+1\\,800$ Kč; s počátečními $1\\,050+750+600=2\\,400$ Kč je konečný stav $2\\,400+1\\,800=4\\,200$ Kč → E.'},
  '12.1: D) $1\\,000$ Kč; 12.2: B) $650$ Kč; 12.3: E) $4\\,200$ Kč',
  3, 5, '3',
  new List<String>{'zs1','statistika','porozumeni','pocetni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
