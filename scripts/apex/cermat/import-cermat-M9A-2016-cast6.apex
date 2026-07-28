String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M9A 2016 – úloha 17',
  new List<String>{'Anna, Bára a Cilka si v 1. čtvrtletí spořily peníze. Úspory za březen zapomněly zaznamenat do grafu. V lednu uspořila Anna $80$ Kč, Bára $100$ Kč a Cilka $20$ Kč, v únoru uspořila Anna $60$ Kč, Bára $40$ Kč a Cilka $80$ Kč.','Lednové úspory Anny jsou aritmetickým průměrem jejích úspor za únor a březen.','V březnu uspořila Cilka o polovinu více než Bára, ale za celé čtvrtletí uspořily obě dívky stejnou částku.','17.1 Vypočtěte, kolik korun uspořila v březnu Anna.','17.2 Vypočtěte, kolik korun uspořila v březnu Bára a kolik Cilka.'},
  null,
  5,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 360" font-family="sans-serif"><text x="250" y="28" font-size="18" font-weight="bold" text-anchor="middle">Úspory</text><line x1="70" y1="300.0" x2="440" y2="300.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="304.0" font-size="12" text-anchor="end">0</text><line x1="70" y1="264.0" x2="440" y2="264.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="268.0" font-size="12" text-anchor="end">20</text><line x1="70" y1="228.0" x2="440" y2="228.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="232.0" font-size="12" text-anchor="end">40</text><line x1="70" y1="192.0" x2="440" y2="192.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="196.0" font-size="12" text-anchor="end">60</text><line x1="70" y1="156.0" x2="440" y2="156.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="160.0" font-size="12" text-anchor="end">80</text><line x1="70" y1="120.0" x2="440" y2="120.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="124.0" font-size="12" text-anchor="end">100</text><line x1="70" y1="84.0" x2="440" y2="84.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="88.0" font-size="12" text-anchor="end">120</text><line x1="70" y1="48.0" x2="440" y2="48.0" stroke="#bbbbbb" stroke-width="1"/><text x="62" y="52.0" font-size="12" text-anchor="end">140</text><line x1="70" y1="40" x2="70" y2="300" stroke="#000" stroke-width="1"/><line x1="70" y1="300" x2="440" y2="300" stroke="#000" stroke-width="1"/><text x="26" y="170" font-size="13">Kč</text><rect x="90" y="156.0" width="30" height="144.0" fill="#1a1a1a" stroke="#000"/><rect x="122" y="192.0" width="30" height="108.0" fill="#d9d9d9" stroke="#000"/><line x1="154" y1="48" x2="154" y2="300" stroke="#555555" stroke-dasharray="6 4"/><line x1="184" y1="48" x2="184" y2="300" stroke="#555555" stroke-dasharray="6 4"/><text x="169.0" y="140" font-size="18" font-weight="bold" text-anchor="middle">?</text><text x="138" y="320" font-size="13" text-anchor="middle">Anna</text><rect x="210" y="120.0" width="30" height="180.0" fill="#1a1a1a" stroke="#000"/><rect x="242" y="228.0" width="30" height="72.0" fill="#d9d9d9" stroke="#000"/><line x1="274" y1="48" x2="274" y2="300" stroke="#555555" stroke-dasharray="6 4"/><line x1="304" y1="48" x2="304" y2="300" stroke="#555555" stroke-dasharray="6 4"/><text x="289.0" y="140" font-size="18" font-weight="bold" text-anchor="middle">?</text><text x="258" y="320" font-size="13" text-anchor="middle">Bára</text><rect x="330" y="264.0" width="30" height="36.0" fill="#1a1a1a" stroke="#000"/><rect x="362" y="156.0" width="30" height="144.0" fill="#d9d9d9" stroke="#000"/><line x1="394" y1="48" x2="394" y2="300" stroke="#555555" stroke-dasharray="6 4"/><line x1="424" y1="48" x2="424" y2="300" stroke="#555555" stroke-dasharray="6 4"/><text x="409.0" y="140" font-size="18" font-weight="bold" text-anchor="middle">?</text><text x="378" y="320" font-size="13" text-anchor="middle">Cilka</text><rect x="460" y="80" width="14" height="14" fill="#1a1a1a" stroke="#000"/><text x="480" y="92" font-size="13">leden</text><rect x="460" y="106" width="14" height="14" fill="#d9d9d9" stroke="#000"/><text x="480" y="118" font-size="13">únor</text><rect x="460" y="132" width="14" height="14" fill="none" stroke="#555555" stroke-dasharray="4 3"/><text x="480" y="144" font-size="13">březen</text></svg>',
  'graf-uspory.svg',
  'Sloupcový graf úspor Anny, Báry a Cilky za leden a únor v korunách; sloupce za březen chybí a jsou označeny otazníkem.',
  'Úspory dívek v 1. čtvrtletí (v Kč), březen chybí',
  new List<String>{'17.1 Označme březnovou úsporu Anny $b$: $80=\\frac{60+b}{2}$, tedy $60+b=160$ a $b=100$ Kč.','17.2 Označme březnovou úsporu Báry $x$; Cilka uspořila $1{,}5x$.','Za čtvrtletí Bára uspořila $100+40+x$ a Cilka $20+80+1{,}5x$.','$140+x=100+1{,}5x$, tedy $0{,}5x=40$ a $x=80$ Kč.','Cilka uspořila $1{,}5\\cdot 80=120$ Kč.'},
  '17.1: $100$ Kč; 17.2: Bára $80$ Kč, Cilka $120$ Kč',
  3, 7, '3',
  new List<String>{'zs2','r9','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
