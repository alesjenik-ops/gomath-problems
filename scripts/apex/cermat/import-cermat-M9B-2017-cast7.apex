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
  'CERMAT M9B 2017 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Dvě plné lahve minerálky tvoří 5 % zásob. Kolik plných lahví minerálky tvoří čtvrtinu zásob?','15.2 V autobusu jede 21 osob. Dětí je mezi nimi o třetinu více než dospělých. Kolik dospělých jede v autobusu?','15.3 Tabulka udává počet žáků v devátých třídách. Mezi všemi žáky obou devátých tříd je 54 % dívek. Kolik chlapců je ve třídě 9. B?'},
  new List<String>{'A) méně než 9','B) 9','C) 10','D) 11','E) 12','F) více než 12'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 170" font-family="sans-serif"><line x1="30" y1="20" x2="30" y2="148" stroke="#000"/><line x1="150" y1="20" x2="150" y2="148" stroke="#000"/><line x1="235" y1="20" x2="235" y2="148" stroke="#000"/><line x1="320" y1="20" x2="320" y2="148" stroke="#000"/><line x1="410" y1="20" x2="410" y2="148" stroke="#000"/><line x1="30" y1="20" x2="410" y2="20" stroke="#000"/><line x1="30" y1="52" x2="410" y2="52" stroke="#000"/><line x1="30" y1="84" x2="410" y2="84" stroke="#000"/><line x1="30" y1="116" x2="410" y2="116" stroke="#000"/><line x1="30" y1="148" x2="410" y2="148" stroke="#000"/><text x="192" y="42" font-size="14" text-anchor="middle">9. A</text><text x="277" y="42" font-size="14" text-anchor="middle">9. B</text><text x="365" y="42" font-size="14" text-anchor="middle">Obě třídy</text><text x="36" y="74" font-size="14">Chlapci</text><text x="192" y="74" font-size="14" text-anchor="middle">11</text><text x="36" y="106" font-size="14">Dívky</text><text x="192" y="106" font-size="14" text-anchor="middle">14</text><text x="36" y="138" font-size="14">Všichni žáci</text><text x="192" y="138" font-size="14" text-anchor="middle">25</text><text x="365" y="138" font-size="14" text-anchor="middle">50</text></svg>',
  'tabulka-zaci.svg',
  'Tabulka počtu žáků: řádky Chlapci, Dívky, Všichni žáci; sloupce 9. A, 9. B, Obě třídy. Vyplněno 11, 14, 25 a 50.',
  'Počet žáků v devátých třídách',
  new List<String>{'15.1 $5$ % odpovídají $2$ lahvím, tedy $25$ % odpovídá $5\\cdot 2=10$ lahvím → C.','15.2 Je-li dospělých $d$, dětí je $\\frac{4}{3}d$: $d+\\frac{4}{3}d=21$, tj. $\\frac{7}{3}d=21$, odtud $d=9$ → B.','15.3 Dívek v obou třídách je $0{,}54\\cdot 50=27$, v 9. B tedy $27-14=13$. Žáků v 9. B je $50-25=25$, chlapců $25-13=12$ → E.'},
  '15.1: C ($10$ lahví); 15.2: B ($9$ dospělých); 15.3: E ($12$ chlapců)',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
