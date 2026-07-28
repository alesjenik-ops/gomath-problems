String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD16C0T01';
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
  'CERMAT M5A 2016 – úloha 10',
  new List<String>{'Oddělením dvou trojúhelníků $AFD$ a $BCE$ z obdélníku $ABCD$ vznikne bílý obrazec $ABEF$. Všechny uvedené body jsou v mřížových bodech čtvercové sítě (viz obrázek).','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah trojúhelníku $AFD$ je 2krát menší než obsah trojúhelníku $BCE$.','10.2 Obsah bílého obrazce $ABEF$ je 9krát větší než obsah trojúhelníku $AFD$.','10.3 Obvod bílého obrazce $ABEF$ je stejný jako součet obvodů trojúhelníků $AFD$ a $BCE$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 390 220" font-family="sans-serif"><polygon points="50,178 96,40 50,40" fill="#d0d0d0"/><polygon points="326,178 326,40 234,40" fill="#d0d0d0"/><line x1="50" y1="40" x2="50" y2="178" stroke="#999"/><line x1="96" y1="40" x2="96" y2="178" stroke="#999"/><line x1="142" y1="40" x2="142" y2="178" stroke="#999"/><line x1="188" y1="40" x2="188" y2="178" stroke="#999"/><line x1="234" y1="40" x2="234" y2="178" stroke="#999"/><line x1="280" y1="40" x2="280" y2="178" stroke="#999"/><line x1="326" y1="40" x2="326" y2="178" stroke="#999"/><line x1="50" y1="40" x2="326" y2="40" stroke="#999"/><line x1="50" y1="86" x2="326" y2="86" stroke="#999"/><line x1="50" y1="132" x2="326" y2="132" stroke="#999"/><line x1="50" y1="178" x2="326" y2="178" stroke="#999"/><rect x="50" y="40" width="276" height="138" fill="none" stroke="#000" stroke-width="3"/><line x1="50" y1="178" x2="96" y2="40" stroke="#000" stroke-width="3"/><line x1="234" y1="40" x2="326" y2="178" stroke="#000" stroke-width="3"/><text x="44" y="32" font-size="16" font-style="italic">D</text><text x="90" y="32" font-size="16" font-style="italic">F</text><text x="228" y="32" font-size="16" font-style="italic">E</text><text x="330" y="32" font-size="16" font-style="italic">C</text><text x="36" y="196" font-size="16" font-style="italic">A</text><text x="332" y="196" font-size="16" font-style="italic">B</text></svg>',
  'obdelnik-ABCD.svg',
  'Obdélník ABCD ve čtvercové síti 6 krát 3 s oddělenými trojúhelníky AFD a BCE.',
  'Obdélník $ABCD$ ve čtvercové síti',
  new List<String>{'Jeden čtvereček sítě má obsah $1$; obdélník má rozměry $6$ a $3$, tedy obsah $18$.','10.1 $S_{AFD}=\\frac{1\\cdot 3}{2}=1{,}5$ a $S_{BCE}=\\frac{2\\cdot 3}{2}=3$; opravdu $1{,}5=3:2$. Tvrzení platí.','10.2 $S_{ABEF}=18-1{,}5-3=13{,}5$ a $13{,}5=9\\cdot 1{,}5$. Tvrzení platí.','10.3 Obvod $ABEF$ je $|AB|+|BE|+|EF|+|FA|=6+3+|BE|+|FA|$. Obvod $AFD$ je $3+1+|FA|$ a obvod $BCE$ je $3+2+|BE|$, dohromady $9+|FA|+|BE|$. Obě hodnoty se rovnají. Tvrzení platí.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ano',
  3, 6, '4',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2016 – úloha 11',
  new List<String>{'Na knižní veletrh šli tři kamarádi. Dva z nich měli vstup za plnou cenu a jeden za poloviční cenu. Na veletrhu si všichni tři koupili stejnou knihu.','Jedna kniha a jeden vstup za plnou cenu stály celkem 250 Kč, další dvě knihy a oba zbývající vstupy 470 Kč.','Kolik korun stála jedna kniha?'},
  new List<String>{'A) méně než 190 Kč','B) 190 Kč','C) 200 Kč','D) 210 Kč','E) více než 210 Kč'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme $k$ cenu knihy a $v$ cenu plného vstupu. Platí $k+v=250$ a $2k+v+\\frac{v}{2}=470$.','Z první rovnice $v=250-k$; dosazením: $2k+1{,}5\\cdot(250-k)=470$, tedy $0{,}5k+375=470$.','Odtud $0{,}5k=95$ a $k=190$ Kč.'},
  'B) 190 Kč',
  2, 4, '4',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
