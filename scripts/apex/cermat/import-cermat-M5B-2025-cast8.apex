String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M5B 2025 - uloha 14',
  new List<String>{'Pripojovanim ctverecku k velkemu bilemu ctverci vytvarime obrazce (viz obrazek). Prvni obrazec ma tvar ctverce a vznikl pripojenim $7$ mensich tmavych ctverecku. Postupnym pripojenim dalsich $20$ ctverecku dvou ruznych velikosti byl z prvniho obrazce vytvoren druhy, ktery ma take tvar ctverce. Treti obrazec vznikl z druheho pripojenim dalsich $11$ ctverecku a ma tvar obdelniku. Prvni obrazec ma obvod $80$ cm.','14.1 Vypoctete v cm obvod druheho obrazce.','14.2 Vypoctete, o kolik cm se lisi delky sousednich stran tretiho obrazce.','14.3 Na obrazku je silne vyznacena uzavrena lomena cara, ktera kopiruje strany ctverecku ve tretim obrazci. Urcete v cm celkovou delku teto lomene cary.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 190" font-family="sans-serif"><text x="60.0" y="47" font-size="12" text-anchor="middle">1. obrazec</text><rect x="30" y="55" width="60" height="60" fill="#f6f6f6" stroke="#000" stroke-width="1.5"/><line x1="45" y1="55" x2="45" y2="115" stroke="#ccc"/><line x1="60" y1="55" x2="60" y2="115" stroke="#ccc"/><line x1="75" y1="55" x2="75" y2="115" stroke="#ccc"/><line x1="30" y1="70" x2="90" y2="70" stroke="#ccc"/><line x1="30" y1="85" x2="90" y2="85" stroke="#ccc"/><line x1="30" y1="100" x2="90" y2="100" stroke="#ccc"/><rect x="30" y="55" width="60" height="15" fill="#808080" stroke="#000"/><rect x="75" y="70" width="15" height="45" fill="#808080" stroke="#000"/><text x="195.0" y="37" font-size="12" text-anchor="middle">2. obrazec</text><rect x="150" y="45" width="90" height="90" fill="#f6f6f6" stroke="#000" stroke-width="1.5"/><line x1="165" y1="45" x2="165" y2="135" stroke="#ccc"/><line x1="180" y1="45" x2="180" y2="135" stroke="#ccc"/><line x1="195" y1="45" x2="195" y2="135" stroke="#ccc"/><line x1="210" y1="45" x2="210" y2="135" stroke="#ccc"/><line x1="225" y1="45" x2="225" y2="135" stroke="#ccc"/><line x1="150" y1="60" x2="240" y2="60" stroke="#ccc"/><line x1="150" y1="75" x2="240" y2="75" stroke="#ccc"/><line x1="150" y1="90" x2="240" y2="90" stroke="#ccc"/><line x1="150" y1="105" x2="240" y2="105" stroke="#ccc"/><line x1="150" y1="120" x2="240" y2="120" stroke="#ccc"/><text x="345.0" y="32" font-size="12" text-anchor="middle">3. obrazec</text><rect x="300" y="40" width="90" height="96" fill="#f6f6f6" stroke="#000" stroke-width="1.5"/><line x1="315" y1="40" x2="315" y2="136" stroke="#ccc"/><line x1="330" y1="40" x2="330" y2="136" stroke="#ccc"/><line x1="345" y1="40" x2="345" y2="136" stroke="#ccc"/><line x1="360" y1="40" x2="360" y2="136" stroke="#ccc"/><line x1="375" y1="40" x2="375" y2="136" stroke="#ccc"/><line x1="300" y1="55" x2="390" y2="55" stroke="#ccc"/><line x1="300" y1="70" x2="390" y2="70" stroke="#ccc"/><line x1="300" y1="85" x2="390" y2="85" stroke="#ccc"/><line x1="300" y1="100" x2="390" y2="100" stroke="#ccc"/><line x1="300" y1="115" x2="390" y2="115" stroke="#ccc"/><line x1="300" y1="130" x2="390" y2="130" stroke="#ccc"/></svg>',
  'obrazce-ctverce.svg',
  'Prvni obrazec (ctverec), druhy obrazec (vetsi ctverec) a treti obrazec (obdelnik) vytvorene pripojovanim ctverecku.',
  'Prvni, druhy a treti obrazec (schematicky nakres)',
  new List<String>{'Prvni obrazec je ctverec o obvodu $80$ cm, tedy o strane $20$ cm.','14.1 Druhy obrazec je ctverec o strane $30$ cm; jeho obvod je $4\\cdot 30=120$ cm.','14.2 Treti obrazec je obdelnik o rozmerech $30$ cm $\\times\\,32$ cm; sousedni strany se lisi o $32-30=2$ cm.','14.3 Souctem delek jednotlivych useku lomene cary podle obrazku vyjde $134$ cm.'},
  '14.1: $120$ cm; 14.2: o $2$ cm; 14.3: $134$ cm',
  4, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
