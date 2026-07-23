String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M7A 2022 – úloha 7',
  new List<String>{'Graf udává počet nehod, k nimž došlo v obcích $A$, $B$, $C$ v jednotlivých čtvrtletích loňského roku, a celoroční počet nehod v obci $D$.','7.1 Určete celkový počet nehod, k nimž došlo ve 3. čtvrtletí v obcích $A$, $B$ a $C$.','7.2 Vyjádřete zlomkem, jakou část celoročního počtu nehod v obci $C$ tvoří nehody, k nimž v této obci došlo v 1. čtvrtletí.','7.3 Určete, o kolik procent byl celoroční počet nehod v obci $A$ větší než celoroční počet nehod v obci $B$.','7.4 V obci $D$ byly počty nehod v 1., 2. a 3. čtvrtletí v poměru $1:2:1$ a ve 4. čtvrtletí již k žádné dopravní nehodě nedošlo. Určete počet nehod ve 3. čtvrtletí v obci $D$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif"><defs><pattern id="h7" width="6" height="6" patternUnits="userSpaceOnUse" patternTransform="rotate(45)"><rect width="6" height="6" fill="#fff"/><line x1="0" y1="0" x2="0" y2="6" stroke="#000" stroke-width="1.4"/></pattern><pattern id="d7" width="6" height="6" patternUnits="userSpaceOnUse"><rect width="6" height="6" fill="#fff"/><circle cx="3" cy="3" r="1.1" fill="#000"/></pattern></defs><line x1="60" y1="30" x2="60" y2="250" stroke="#000"/><line x1="60" y1="250" x2="480" y2="250" stroke="#000"/><line x1="56" y1="250.0" x2="60" y2="250.0" stroke="#000"/><text x="52" y="254.0" font-size="11" text-anchor="end">0</text><line x1="56" y1="218.6" x2="60" y2="218.6" stroke="#000"/><text x="52" y="222.6" font-size="11" text-anchor="end">4</text><line x1="56" y1="187.1" x2="60" y2="187.1" stroke="#000"/><text x="52" y="191.1" font-size="11" text-anchor="end">8</text><line x1="56" y1="155.7" x2="60" y2="155.7" stroke="#000"/><text x="52" y="159.7" font-size="11" text-anchor="end">12</text><line x1="56" y1="124.3" x2="60" y2="124.3" stroke="#000"/><text x="52" y="128.3" font-size="11" text-anchor="end">16</text><line x1="56" y1="92.9" x2="60" y2="92.9" stroke="#000"/><text x="52" y="96.9" font-size="11" text-anchor="end">20</text><line x1="56" y1="61.4" x2="60" y2="61.4" stroke="#000"/><text x="52" y="65.4" font-size="11" text-anchor="end">24</text><line x1="56" y1="30.0" x2="60" y2="30.0" stroke="#000"/><text x="52" y="34.0" font-size="11" text-anchor="end">28</text><text x="18" y="140" font-size="12" text-anchor="middle" transform="rotate(-90 18 140)">Počet nehod</text><rect x="88" y="202.9" width="44" height="47.1" fill="url(#h7)" stroke="#000"/><rect x="88" y="171.4" width="44" height="31.4" fill="#9a9a9a" stroke="#000"/><rect x="88" y="124.3" width="44" height="47.1" fill="url(#d7)" stroke="#000"/><rect x="88" y="92.9" width="44" height="31.4" fill="#111" stroke="#000"/><text x="110" y="266" font-size="12" text-anchor="middle">A</text><rect x="160" y="218.6" width="44" height="31.4" fill="url(#h7)" stroke="#000"/><rect x="160" y="171.4" width="44" height="47.1" fill="#9a9a9a" stroke="#000"/><rect x="160" y="140.0" width="44" height="31.4" fill="url(#d7)" stroke="#000"/><rect x="160" y="124.3" width="44" height="15.7" fill="#111" stroke="#000"/><text x="182" y="266" font-size="12" text-anchor="middle">B</text><rect x="232" y="171.4" width="44" height="78.6" fill="url(#h7)" stroke="#000"/><rect x="232" y="140.0" width="44" height="31.4" fill="#9a9a9a" stroke="#000"/><rect x="232" y="77.1" width="44" height="62.9" fill="url(#d7)" stroke="#000"/><rect x="232" y="45.7" width="44" height="31.4" fill="#111" stroke="#000"/><text x="254" y="266" font-size="12" text-anchor="middle">C</text><rect x="304" y="61.4" width="44" height="188.6" fill="#fff" stroke="#000"/><text x="326" y="266" font-size="12" text-anchor="middle">D</text><rect x="70" y="290" width="13" height="13" fill="url(#h7)" stroke="#000"/><text x="87" y="301" font-size="11">1. čtvrtletí</text><rect x="178" y="290" width="13" height="13" fill="#9a9a9a" stroke="#000"/><text x="195" y="301" font-size="11">2. čtvrtletí</text><rect x="286" y="290" width="13" height="13" fill="url(#d7)" stroke="#000"/><text x="303" y="301" font-size="11">3. čtvrtletí</text><rect x="394" y="290" width="13" height="13" fill="#111" stroke="#000"/><text x="411" y="301" font-size="11">4. čtvrtletí</text></svg>',
  'graf-nehody.svg',
  'Skládaný sloupcový graf počtu nehod v obcích A, B, C podle čtvrtletí a celoroční sloupec obce D.',
  'Počet nehod v obcích podle čtvrtletí',
  new List<String>{'7.1 Ve 3. čtvrtletí: obec $A$ $6$, obec $B$ $4$, obec $C$ $8$ nehod, celkem $18$ nehod.','7.2 Obec $C$ má celkem $26$ nehod, v 1. čtvrtletí $10$: $\\frac{10}{26}=\\frac{5}{13}$.','7.3 Obec $A$ má $20$, obec $B$ $16$ nehod: $\\frac{20-16}{16}=0{,}25$, tj. o $25\\,\\%$.','7.4 Poměr $1:2:1$ dává $4$ díly $=24$ nehod, jeden díl $=6$; ve 3. čtvrtletí je $1$ díl, tj. $6$ nehod.'},
  '7.1: $18$ nehod; 7.2: $\\frac{5}{13}$; 7.3: o $25\\,\\%$; 7.4: $6$ nehod',
  4, 7, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
