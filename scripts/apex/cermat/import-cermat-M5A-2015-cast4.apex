String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 10',
  new List<String>{'Ve čtvercové síti je zakreslen obdélník $ABCD$ a dva trojúhelníky $AED$ a $EBF$. (Body $A$, $B$, $C$, $D$, $E$, $F$ jsou mřížové body.)','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah obdélníku $ABCD$ je pětkrát větší než obsah trojúhelníku $AED$.','10.2 Obsah trojúhelníku $AED$ je větší než obsah trojúhelníku $EBF$.','10.3 Obvod trojúhelníku $AED$ je větší než obvod trojúhelníku $EBF$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 180" font-family="sans-serif"><polygon points="45,136 149,136 45,32" fill="#b9b9b9"/><polygon points="149,136 305,136 305,84" fill="#b9b9b9"/><path d="M 45 32 V 136 M 97 32 V 136 M 149 32 V 136 M 201 32 V 136 M 253 32 V 136 M 305 32 V 136 M 45 32 H 305 M 45 84 H 305 M 45 136 H 305" fill="none" stroke="#444" stroke-width="1"/><rect x="45" y="32" width="260" height="104" fill="none" stroke="#000" stroke-width="2.5"/><path d="M 45 32 L 149 136 L 305 84" fill="none" stroke="#000" stroke-width="2.5"/><text x="31" y="24" font-size="15" font-style="italic">D</text><text x="309" y="24" font-size="15" font-style="italic">C</text><text x="31" y="158" font-size="15" font-style="italic">A</text><text x="303" y="158" font-size="15" font-style="italic">B</text><text x="145" y="158" font-size="15" font-style="italic">E</text><text x="313" y="89" font-size="15" font-style="italic">F</text></svg>',
  'sit-ABCD.svg',
  'Čtvercová síť 5 krát 2 s obdélníkem ABCD, šedým trojúhelníkem AED vlevo a šedým trojúhelníkem EBF vpravo.',
  'Obdélník $ABCD$ a trojúhelníky $AED$ a $EBF$ ve čtvercové síti',
  new List<String>{'Stranu čtverečku sítě označme 1. Obdélník $ABCD$ má rozměry $5\\times 2$, jeho obsah je 10.','10.1 Trojúhelník $AED$ má odvěsny $|AE|=2$ a $|AD|=2$, obsah je $2\\cdot 2:2=2$. Protože $10=5\\cdot 2$, tvrzení platí (A).','10.2 Trojúhelník $EBF$ má odvěsny $|EB|=3$ a $|BF|=1$, obsah je $3\\cdot 1:2=1{,}5$. Platí $2>1{,}5$, tvrzení platí (A).','10.3 Obvod $AED$ je $2+2+|ED|$, kde $|ED|$ je přepona nad odvěsnami 2 a 2, tedy asi $2{,}8$; obvod je asi $6{,}8$. Obvod $EBF$ je $3+1+|EF|$, kde $|EF|$ je přepona nad odvěsnami 3 a 1, tedy asi $3{,}2$; obvod je asi $7{,}2$. Obvod $AED$ je menší, tvrzení neplatí (N).'},
  '10.1: Ano; 10.2: Ano; 10.3: Ne',
  3, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 11',
  new List<String>{'Petr má stejný počet korunových, dvoukorunových a pětikorunových mincí. (Jiné mince Petr nemá.) Mince představují částku 96 Kč.','Kolik mincí má Petr?'},
  new List<String>{'A) 18','B) 24','C) 32','D) 36','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jedna trojice mincí (1 Kč, 2 Kč a 5 Kč) má hodnotu $1+2+5=8$ Kč.','Takových trojic je $96:8=12$, od každého druhu má tedy Petr 12 mincí a celkem $3\\cdot 12=36$ mincí.'},
  'D) 36',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
