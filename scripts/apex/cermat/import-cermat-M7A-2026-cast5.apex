String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M7A 2026 - uloha 11',
  new List<String>{'Vsichni zaci 7. A psali test z matematiky. V grafu jsou uvedeny pocty jednotlivych znamek, ktere tito zaci z testu ziskali.','Jaky je aritmeticky prumer ziskanych znamek?'},
  new List<String>{'A) $2{,}7$','B) $3{,}0$','C) $3{,}7$','D) $4{,}0$','E) jiny prumer'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"><line x1="60" y1="40" x2="60" y2="250" stroke="#000"/><line x1="60" y1="250" x2="380" y2="250" stroke="#000"/><line x1="56" y1="250" x2="380" y2="250" stroke="#ddd"/><text x="52" y="254" font-size="11" text-anchor="end">0</text><line x1="56" y1="200" x2="380" y2="200" stroke="#ddd"/><text x="52" y="204" font-size="11" text-anchor="end">2</text><line x1="56" y1="150" x2="380" y2="150" stroke="#ddd"/><text x="52" y="154" font-size="11" text-anchor="end">4</text><line x1="56" y1="100" x2="380" y2="100" stroke="#ddd"/><text x="52" y="104" font-size="11" text-anchor="end">6</text><line x1="56" y1="50" x2="380" y2="50" stroke="#ddd"/><text x="52" y="54" font-size="11" text-anchor="end">8</text><rect x="84" y="100" width="40" height="150" fill="#c9c9c9" stroke="#000"/><text x="104.0" y="266" font-size="12" text-anchor="middle">1</text><rect x="148" y="125" width="40" height="125" fill="#c9c9c9" stroke="#000"/><text x="168.0" y="266" font-size="12" text-anchor="middle">2</text><rect x="212" y="200" width="40" height="50" fill="#c9c9c9" stroke="#000"/><text x="232.0" y="266" font-size="12" text-anchor="middle">3</text><rect x="276" y="175" width="40" height="75" fill="#c9c9c9" stroke="#000"/><text x="296.0" y="266" font-size="12" text-anchor="middle">4</text><rect x="340" y="150" width="40" height="100" fill="#c9c9c9" stroke="#000"/><text x="360.0" y="266" font-size="12" text-anchor="middle">5</text><text x="220" y="284" font-size="12" text-anchor="middle">Znamka z testu</text><text x="18" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 18 150)">Pocet znamek</text></svg>',
  'graf-znamky.svg',
  'Sloupcovy graf poctu znamek: znamka 1 sestkrat, 2 petkrat, 3 dvakrat, 4 trikrat, 5 ctyrikrat.',
  'Pocty jednotlivych znamek z testu',
  new List<String>{'Pocty znamek: $1\\to 6$, $2\\to 5$, $3\\to 2$, $4\\to 3$, $5\\to 4$; celkem $20$ zaku. Soucet znamek $1\\cdot 6+2\\cdot 5+3\\cdot 2+4\\cdot 3+5\\cdot 4=54$. Prumer $54:20=2{,}7$.'},
  'A) $2{,}7$',
  2, 3, '2',
  new List<String>{'zs2','r7','statistika','vypocet','pocetni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2026 - uloha 12',
  new List<String>{'Zaci se na skolnim sportovnim dni rozdelili do tri skupin A, B, C. (Pocet zaku ve skupinach A, B a C oznacime ve stejnem poradi pismeny $A$, $B$ a $C$.) Pro pocty zaku plati pomery $A:B=7:9$ a $B:C=4:7$. Ve skupine B je o 16 zaku vice nez ve skupine A.','O kolik se lisi pocet zaku ve skupine B a ve skupine C?'},
  new List<String>{'A) o 24 zaku','B) o 48 zaku','C) o 54 zaku','D) o 72 zaku','E) o jiny pocet zaku'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Sjednotime pomery pres $B$: $A:B=28:36$ a $B:C=36:63$, tedy $A:B:C=28:36:63$. Rozdil $B-A=8$ dilu $=16$ zaku, tj. $1$ dil $=2$ zaci. Rozdil $C-B=63-36=27$ dilu $=54$ zaku.'},
  'C) o 54 zaku',
  2, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
