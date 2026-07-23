String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M7A 2023 - uloha 10',
  new List<String>{'Graf udava, kolik kg odpadu vytridily tri skautske oddily R, S a T (papir, plast a kovy).','Rozhodnete o kazdem z tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).','10.1 Oddil S vytridil o ctvrtinu vice kg papiru nez oddil R.','10.2 Oddily S a T dohromady vytridily o tretinu vice kg plastu nez oddil R.','10.3 Vsechny tri oddily dohromady vytridily o polovinu mene kg kovu nez papiru.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 270" font-family="sans-serif"><line x1="60" y1="40" x2="60" y2="220" stroke="#000"/><line x1="60" y1="220" x2="465" y2="220" stroke="#000"/><line x1="60" y1="220" x2="60" y2="224" stroke="#000"/><text x="60" y="238" font-size="11" text-anchor="middle">0</text><line x1="105" y1="220" x2="105" y2="224" stroke="#000"/><text x="105" y="238" font-size="11" text-anchor="middle">3</text><line x1="150" y1="220" x2="150" y2="224" stroke="#000"/><text x="150" y="238" font-size="11" text-anchor="middle">6</text><line x1="195" y1="220" x2="195" y2="224" stroke="#000"/><text x="195" y="238" font-size="11" text-anchor="middle">9</text><line x1="240" y1="220" x2="240" y2="224" stroke="#000"/><text x="240" y="238" font-size="11" text-anchor="middle">12</text><line x1="285" y1="220" x2="285" y2="224" stroke="#000"/><text x="285" y="238" font-size="11" text-anchor="middle">15</text><line x1="330" y1="220" x2="330" y2="224" stroke="#000"/><text x="330" y="238" font-size="11" text-anchor="middle">18</text><line x1="375" y1="220" x2="375" y2="224" stroke="#000"/><text x="375" y="238" font-size="11" text-anchor="middle">21</text><line x1="420" y1="220" x2="420" y2="224" stroke="#000"/><text x="420" y="238" font-size="11" text-anchor="middle">24</text><line x1="465" y1="220" x2="465" y2="224" stroke="#000"/><text x="465" y="238" font-size="11" text-anchor="middle">27</text><text x="255" y="256" font-size="12" text-anchor="middle">pocet kg</text><rect x="60" y="40" width="90" height="34" fill="#c9c9c9" stroke="#000"/><rect x="150" y="40" width="225" height="34" fill="#ffffff" stroke="#000"/><rect x="375" y="40" width="45" height="34" fill="#555555" stroke="#000"/><text x="50" y="61" font-size="13" text-anchor="end">R</text><rect x="60" y="100" width="120" height="34" fill="#c9c9c9" stroke="#000"/><rect x="180" y="100" width="165" height="34" fill="#ffffff" stroke="#000"/><rect x="345" y="100" width="45" height="34" fill="#555555" stroke="#000"/><text x="50" y="121" font-size="13" text-anchor="end">S</text><rect x="60" y="160" width="15" height="34" fill="#c9c9c9" stroke="#000"/><rect x="75" y="160" width="135" height="34" fill="#ffffff" stroke="#000"/><rect x="210" y="160" width="60" height="34" fill="#555555" stroke="#000"/><text x="50" y="181" font-size="13" text-anchor="end">T</text><rect x="480" y="40" width="12" height="12" fill="#c9c9c9" stroke="#000"/><text x="498" y="51" font-size="12">papir</text><rect x="480" y="58" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="498" y="69" font-size="12">plast</text><rect x="480" y="76" width="12" height="12" fill="#555555" stroke="#000"/><text x="498" y="87" font-size="12">kovy</text></svg>',
  'graf-odpad.svg',
  'Skladany vodorovny sloupcovy graf pro oddily R, S, T se slozkami papir, plast a kovy v kg.',
  'Mnozstvi vytrideneho odpadu (kg)',
  new List<String>{'Z grafu: R - papir $6$, plast $15$, kovy $3$ kg; S - papir $8$, plast $11$, kovy $3$ kg; T - papir $1$, plast $9$, kovy $4$ kg.','10.1 O ctvrtinu vice nez $6$ je $7{,}5$ kg, papir S je $8\\ne 7{,}5$ kg, tedy Ne (N).','10.2 Plast S a T dohromady $11+9=20$ kg; o tretinu vice nez $15$ je $20$ kg, tedy Ano (A).','10.3 Kovu celkem $3+3+4=10$ kg, papiru celkem $6+8+1=15$ kg; o polovinu mene nez $15$ je $7{,}5\\ne 10$ kg, tedy Ne (N).'},
  '10.1: N; 10.2: A; 10.3: N',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
