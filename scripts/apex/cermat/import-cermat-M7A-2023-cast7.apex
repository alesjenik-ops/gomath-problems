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
  'CERMAT M7A 2023 - uloha 16',
  new List<String>{'Ze stejne velkych svetlych a tmavych ctverecku tvorime obrazce tvaru ctverce nebo obdelniku. Zakladni obrazec je tvoren jednou nebo vice radami svetlych ctverecku (napr. 2 rady, 3 sloupce, 6 ctverecku). Z kazdeho zakladniho obrazce vytvorime rozsireny obrazec tak, ze pridame nahoru jednu radu tmavych ctverecku a pak vlevo i vpravo po jednom sloupci tmavych ctverecku (napr. rozsireny obrazec ma 3 rady, 5 sloupcu, 15 ctverecku - z toho 9 tmavych).','16.1 Ze zakladniho obrazce, ktery ma 5 rad, vytvorime rozsireny obrazec pridanim 30 tmavych ctverecku. Urcete pocet sloupcu v zakladnim obrazci.','16.2 Rozsireny obrazec ma 3 rady a tvori jej stejny pocet tmavych a svetlych ctverecku. Urcete pocet sloupcu v rozsirenem obrazci.','16.3 Muzeme najit mnoho rozsirenych obrazcu s 50 tmavymi ctverecky. Urcete pocet vsech techto rozsirenych obrazcu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 200" font-family="sans-serif"><rect x="40" y="60" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="64" y="60" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="88" y="60" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="40" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="64" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="88" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><text x="76" y="130" font-size="12" text-anchor="middle">zakladni obrazec</text><text x="76" y="146" font-size="11" text-anchor="middle">(2 rady, 3 sloupce)</text><rect x="250" y="60" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="274" y="60" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="298" y="60" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="322" y="60" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="346" y="60" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="250" y="84" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="274" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="298" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="322" y="84" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="346" y="84" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="250" y="108" width="24" height="24" fill="#7a7a7a" stroke="#000"/><rect x="274" y="108" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="298" y="108" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="322" y="108" width="24" height="24" fill="#e8e8e8" stroke="#000"/><rect x="346" y="108" width="24" height="24" fill="#7a7a7a" stroke="#000"/><text x="310" y="154" font-size="12" text-anchor="middle">rozsireny obrazec</text><text x="310" y="170" font-size="11" text-anchor="middle">(3 rady, 5 sloupcu)</text></svg>',
  'obrazce.svg',
  'Priklad zakladniho obrazce (2 rady, 3 sloupce, svetle ctverecky) a rozsireneho obrazce (3 rady, 5 sloupcu) s tmavou horni radou a tmavymi krajnimi sloupci.',
  'Zakladni a rozsireny obrazec (priklad)',
  new List<String>{'Ma-li zakladni obrazec $r$ rad a $s$ sloupcu, pridame jednu radu ($s+2$ ctverecku nahore) a dva sloupce (po $r$ ctverecich), takze tmavych je $2r+s+2$ a svetlych $r\\cdot s$.','16.1 $r=5$: $2\\cdot 5+s+2=30\\Rightarrow s=18$ sloupcu.','16.2 Rozsireny ma 3 rady, tedy $r=2$. Tmavych $=$ svetlych: $2\\cdot 2+s+2=2s\\Rightarrow s=6$, rozsireny ma $s+2=8$ sloupcu.','16.3 $2r+s+2=50\\Rightarrow 2r+s=48$. Pro $r=1,2,\\dots,23$ vychazi $s=48-2r\\ge 2$, tj. $23$ ruznych rozsirenych obrazcu.'},
  '16.1: $18$ sloupcu; 16.2: $8$ sloupcu; 16.3: $23$ rozsirenych obrazcu',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
