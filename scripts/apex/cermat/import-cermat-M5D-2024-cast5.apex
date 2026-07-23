String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
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
  'CERMAT M5D 2024 – úloha 11',
  new List<String>{'Kruhový diagram znázorňuje prodej vybraného ovoce a zeleniny za uplynulý týden (jablka $5$ dílů, hrušky $3$ díly, cibule $1$ díl, mrkev $1$ díl). Cibule a hrušek se dohromady prodalo $76$ kg.','Kolik kilogramů ovoce (jablek a hrušek) se za uplynulý týden celkem prodalo?'},
  new List<String>{'A) $152$','B) $95$','C) $57$','D) $38$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"><path d="M 170 150 L 170.0 40.0 A 110 110 0 0 1 170.0 260.0 Z" fill="#9a9a9a" stroke="#000"/><path d="M 170 150 L 170.0 260.0 A 110 110 0 0 1 65.4 116.0 Z" fill="#c9c9c9" stroke="#000"/><path d="M 170 150 L 65.4 116.0 A 110 110 0 0 1 105.3 61.0 Z" fill="#e6e6e6" stroke="#000"/><path d="M 170 150 L 105.3 61.0 A 110 110 0 0 1 170.0 40.0 Z" fill="#f4f4f4" stroke="#000"/><rect x="310" y="60" width="16" height="16" fill="#9a9a9a" stroke="#000"/><text x="332" y="73" font-size="13">jablka: 5 dilu</text><rect x="310" y="86" width="16" height="16" fill="#c9c9c9" stroke="#000"/><text x="332" y="99" font-size="13">hrusky: 3 dily</text><rect x="310" y="112" width="16" height="16" fill="#e6e6e6" stroke="#000"/><text x="332" y="125" font-size="13">cibule: 1 dil</text><rect x="310" y="138" width="16" height="16" fill="#f4f4f4" stroke="#000"/><text x="332" y="151" font-size="13">mrkev: 1 dil</text></svg>',
  'kruhovy-diagram.svg',
  'Kruhový diagram rozdělený na 10 dílů: jablka 5 dílů, hrušky 3 díly, cibule 1 díl, mrkev 1 díl.',
  'Prodej ovoce a zeleniny (kruhový diagram)',
  new List<String>{'Cibule ($1$ díl) a hrušky ($3$ díly) tvoří $4$ díly $=76$ kg, tedy $1$ díl $=19$ kg. Jablka a hrušky ($5+3=8$ dílů): $8\\cdot 19=152$ kg.'},
  'A) $152$',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2024 – úloha 12',
  new List<String>{'Dělník pracuje stále stejným tempem a vyrobí $1\\,200$ součástek za $3$ hodiny.','12.1 Za jak dlouho vyrobí dělník $4\\,000$ těchto součástek? (A) za $8$ hodin; (B) za $9$ hodin; (C) za $10$ hodin; (D) za $11$ hodin; (E) za $12$ hodin.','12.2 Za jak dlouho by bylo vyrobeno $12\\,000$ těchto součástek, pokud by první polovinu součástek vyráběl dělník sám a druhou polovinu ve spolupráci s kolegou, který pracuje stejným tempem jako on? (A) za $7{,}5$ hodiny; (B) za $10$ hodin; (C) za $15$ hodin; (D) za $17{,}5$ hodiny; (E) za $22{,}5$ hodiny.','12.3 Kolik součástek vyrobí dva dělníci za $9$ hodin za předpokladu, že druhý dělník pracuje také stále stejným, ale polovičním tempem? (A) $1\\,800$; (B) $3\\,600$; (C) $4\\,000$; (D) $5\\,400$; (E) $7\\,200$.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Dělník vyrobí $1\\,200:3=400$ součástek za hodinu.','12.1 $4\\,000:400=10$ hodin → C.','12.2 První polovina $6\\,000$ dělník sám: $6\\,000:400=15$ h; druhá polovina $6\\,000$ dva dělníci ($800$/h): $6\\,000:800=7{,}5$ h; celkem $15+7{,}5=22{,}5$ h → E.','12.3 První dělník $9\\cdot 400=3\\,600$, druhý (poloviční tempo $200$/h) $9\\cdot 200=1\\,800$; celkem $3\\,600+1\\,800=5\\,400$ → D.'},
  '12.1: C) za $10$ hodin; 12.2: E) za $22{,}5$ hodiny; 12.3: D) $5\\,400$ součástek',
  3, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
