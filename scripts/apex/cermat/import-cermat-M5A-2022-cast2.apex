String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
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
  'CERMAT M5A 2022 – úloha 4',
  new List<String>{'Graf udává počet nehod, k nimž došlo v obcích A, B, C, D v jednotlivých čtvrtletích loňského roku, a celoroční počet nehod v obci E. V obci E nebyla ve 4. čtvrtletí žádná nehoda, ve 2. čtvrtletí bylo dvakrát více nehod než v 1. čtvrtletí a ve 3. čtvrtletí byl stejný počet nehod jako v 1. čtvrtletí. (První pololetí se skládá z 1. a 2. čtvrtletí, druhé pololetí ze 3. a 4. čtvrtletí.)','4.1 Určete celkový počet nehod, k nimž došlo ve 3. čtvrtletí v obcích A, B, C a D.','4.2 Určete, o kolik nehod více se v prvním pololetí stalo v obci D než v obci A.','4.3 Určete počet nehod, k nimž došlo ve 2. čtvrtletí v obci E.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif"><line x1="70" y1="20" x2="70" y2="250" stroke="#000"/><line x1="70" y1="250" x2="520" y2="250" stroke="#000"/><line x1="66" y1="250" x2="70" y2="250" stroke="#000"/><text x="62" y="254" font-size="10" text-anchor="end">0</text><line x1="66" y1="220" x2="70" y2="220" stroke="#000"/><text x="62" y="224" font-size="10" text-anchor="end">2</text><line x1="66" y1="190" x2="70" y2="190" stroke="#000"/><text x="62" y="194" font-size="10" text-anchor="end">4</text><line x1="66" y1="160" x2="70" y2="160" stroke="#000"/><text x="62" y="164" font-size="10" text-anchor="end">6</text><line x1="66" y1="130" x2="70" y2="130" stroke="#000"/><text x="62" y="134" font-size="10" text-anchor="end">8</text><line x1="66" y1="100" x2="70" y2="100" stroke="#000"/><text x="62" y="104" font-size="10" text-anchor="end">10</text><line x1="66" y1="70" x2="70" y2="70" stroke="#000"/><text x="62" y="74" font-size="10" text-anchor="end">12</text><line x1="66" y1="40" x2="70" y2="40" stroke="#000"/><text x="62" y="44" font-size="10" text-anchor="end">14</text><rect x="96" y="205" width="46" height="45" fill="#b8b8b8" stroke="#000"/><rect x="96" y="160" width="46" height="45" fill="#e2e2e2" stroke="#000"/><rect x="96" y="100" width="46" height="60" fill="#111111" stroke="#000"/><text x="119.0" y="266" font-size="12" text-anchor="middle">A</text><rect x="168" y="220" width="46" height="30" fill="#ffffff" stroke="#000"/><rect x="168" y="175" width="46" height="45" fill="#b8b8b8" stroke="#000"/><rect x="168" y="85" width="46" height="90" fill="#e2e2e2" stroke="#000"/><rect x="168" y="70" width="46" height="15" fill="#111111" stroke="#000"/><text x="191.0" y="266" font-size="12" text-anchor="middle">B</text><rect x="240" y="220" width="46" height="30" fill="#ffffff" stroke="#000"/><rect x="240" y="175" width="46" height="45" fill="#b8b8b8" stroke="#000"/><rect x="240" y="115" width="46" height="60" fill="#e2e2e2" stroke="#000"/><rect x="240" y="85" width="46" height="30" fill="#111111" stroke="#000"/><text x="263.0" y="266" font-size="12" text-anchor="middle">C</text><rect x="312" y="205" width="46" height="45" fill="#ffffff" stroke="#000"/><rect x="312" y="100" width="46" height="105" fill="#b8b8b8" stroke="#000"/><rect x="312" y="70" width="46" height="30" fill="#e2e2e2" stroke="#000"/><rect x="312" y="55" width="46" height="15" fill="#111111" stroke="#000"/><text x="335.0" y="266" font-size="12" text-anchor="middle">D</text><rect x="384" y="70" width="46" height="180" fill="#ffffff" stroke="#000"/><text x="407.0" y="266" font-size="12" text-anchor="middle">E</text><text x="30" y="135" font-size="11" text-anchor="middle" transform="rotate(-90 30 135)">Počet nehod</text></svg>',
  'graf-nehody.svg',
  'Skládaný sloupcový graf počtu nehod v obcích A až D po čtvrtletích a celoroční sloupec obce E (celkem 12).',
  'Schematický nákres grafu (součty a 3. čtvrtletí dle klíče)',
  new List<String>{'4.1 Ve 3. čtvrtletí: A $3$, B $6$, C $4$, D $2$; celkem $3+6+4+2=15$ nehod.','4.2 V 1. pololetí (1. a 2. čtvrtletí) měla obec A $3$ nehody a obec D $10$ nehod; rozdíl je $7$ nehod.','4.3 Celoroční počet v obci E je $12$; při rozložení 1. čtvrtletí $=x$, 2. čtvrtletí $=2x$, 3. čtvrtletí $=x$, 4. čtvrtletí $=0$ platí $4x=12$, tedy $x=3$ a 2. čtvrtletí $=2\\cdot 3=6$ nehod.'},
  '4.1: $15$ nehod; 4.2: o $7$ nehod; 4.3: $6$ nehod',
  4, 6, '3',
  new List<String>{'zs1','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
