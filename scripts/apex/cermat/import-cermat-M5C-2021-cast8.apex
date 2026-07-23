String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M5C 2021 – úloha 14',
  new List<String>{'Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Na obrázku jsou tři nejmenší trojúhelníkové obrazce. Jednotlivé řady obrazce jsou očíslovány vždy od nejkratší po nejdelší.','Obrazec má $19$ řad. Určete počet:','14.1 bílých trojúhelníků v 9. řadě.','14.2 tmavých trojúhelníků v 16. řadě.','14.3 tmavých šestiúhelníků v celém obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 230" font-family="sans-serif"><polygon points="63.0,34 117.0,34 90,85.3" fill="none" stroke="#000" stroke-width="2"/><polygon points="90.0,40 77.01,47.5 77.01,62.5 90.0,70 102.99,62.5 102.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="71.5" y="80.75" font-size="11" text-anchor="middle">1.</text><text x="62.5" y="63.65" font-size="11" text-anchor="middle">2.</text><text x="53.5" y="46.55" font-size="11" text-anchor="middle">3.</text><polygon points="194.0,34 286.0,34 240,121.39999999999999" fill="none" stroke="#000" stroke-width="2"/><polygon points="221.0,40 208.01,47.5 208.01,62.5 221.0,70 233.99,62.5 233.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="259.0,40 246.01,47.5 246.01,62.5 259.0,70 271.99,62.5 271.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="240.0,76 227.01,83.5 227.01,98.5 240.0,106 252.99,98.5 252.99,83.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="221.4" y="116.66" font-size="11" text-anchor="middle">1.</text><text x="212.2" y="99.17999999999999" font-size="11" text-anchor="middle">2.</text><text x="203.0" y="81.69999999999999" font-size="11" text-anchor="middle">3.</text><text x="193.8" y="64.22" font-size="11" text-anchor="middle">4.</text><text x="184.6" y="46.739999999999995" font-size="11" text-anchor="middle">5.</text><polygon points="365.0,34 495.0,34 430,157.5" fill="none" stroke="#000" stroke-width="2"/><polygon points="392.0,40 379.01,47.5 379.01,62.5 392.0,70 404.99,62.5 404.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="430.0,40 417.01,47.5 417.01,62.5 430.0,70 442.99,62.5 442.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="468.0,40 455.01,47.5 455.01,62.5 468.0,70 480.99,62.5 480.99,47.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="411.0,76 398.01,83.5 398.01,98.5 411.0,106 423.99,98.5 423.99,83.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="449.0,76 436.01,83.5 436.01,98.5 449.0,106 461.99,98.5 461.99,83.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><polygon points="430.0,112 417.01,119.5 417.01,134.5 430.0,142 442.99,134.5 442.99,119.5" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="411.35714285714283" y="152.67857142857142" font-size="11" text-anchor="middle">1.</text><text x="402.07142857142856" y="135.03571428571428" font-size="11" text-anchor="middle">2.</text><text x="392.7857142857143" y="117.39285714285714" font-size="11" text-anchor="middle">3.</text><text x="383.5" y="99.75" font-size="11" text-anchor="middle">4.</text><text x="374.2142857142857" y="82.10714285714285" font-size="11" text-anchor="middle">5.</text><text x="364.92857142857144" y="64.46428571428572" font-size="11" text-anchor="middle">6.</text><text x="355.6428571428571" y="46.82142857142857" font-size="11" text-anchor="middle">7.</text><text x="590" y="120" font-size="20">…</text></svg>',
  'trojuhelniky.svg',
  'Tři nejmenší trojúhelníkové obrazce z tmavých šestiúhelníků uspořádaných do trojúhelníku, řady číslované od nejkratší.',
  '1., 2. a 3. nejmenší obrazec',
  new List<String>{'V $k$-té řadě je $2k-1$ malých trojúhelníků. Bílých je pro lichou řadu $\\frac{k+1}{2}$, pro sudou řadu $\\frac{k-2}{2}$; tmavých je zbytek, tj. pro lichou $\\frac{3(k-1)}{2}$ a pro sudou $\\frac{3k}{2}$.','14.1 Řada $9$ (lichá): bílých $\\frac{9+1}{2}=5$.','14.2 Řada $16$ (sudá): tmavých $\\frac{3\\cdot 16}{2}=24$.','14.3 Šestiúhelníky tvoří $9$ řad po $1,2,\\dots,9$, celkem $1+2+\\dots+9=45$ šestiúhelníků (tj. $45\\cdot 6=270$ tmavých trojúhelníků).'},
  '14.1: $5$ bílých trojúhelníků; 14.2: $24$ tmavých trojúhelníků; 14.3: $45$ tmavých šestiúhelníků',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
