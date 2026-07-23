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
  'CERMAT M7A 2023 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi bod $C$ a primky $a$, $b$ (viz obrazek).','Bod $C$ je vrchol trojuhelniku $ABC$. Na primce $a$ lezi vrchol $A$ a na primce $b$ vrchol $B$ tohoto trojuhelniku. Strana $AC$ trojuhelniku $ABC$ je rovnobezna s primkou $b$. Strany $AB$ a $AC$ maji stejnou delku.','Sestrojte vrcholy $A$, $B$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik naryytujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="150" y1="40" x2="126" y2="270" stroke="#000" stroke-width="2"/> <text x="158" y="42" font-size="16" font-style="italic">a</text> <line x1="40" y1="255" x2="430" y2="172" stroke="#000" stroke-width="2"/> <text x="438" y="170" font-size="16" font-style="italic">b</text> <text x="300" y="92" font-size="15" font-style="italic">C</text> <text x="296" y="108" font-size="15">x</text> </svg>',
  'bod-C-primky.svg',
  'Bod C a dve primky a, b protinajici se v rovine; primka a je temer svisla, primka b mirne stoupa doprava.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Bod $A$ lezi na primce $a$ a zaroven na rovnobezce vedene bodem $C$ rovnobezne s primkou $b$ (protoze $AC\\parallel b$); $A$ je prusecik techto dvou primek. Vrchol $B$ lezi na primce $b$ a plati $|AB|=|AC|$, proto $B$ je prusecik kruznice se stredem $A$ a polomerem $|AC|$ s primkou $b$. Kruznice protina primku $b$ ve dvou bodech, uloha ma dve reseni $B_1$, $B_2$.'},
  'Dve reseni. $A$ je prusecik primky $a$ s rovnobezkou vedenou bodem $C$ rovnobezne s $b$; $B_1$, $B_2$ jsou pruseciky kruznice se stredem $A$ a polomerem $|AC|$ s primkou $b$ (viz obrazek v klici).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $K$, $S$ a primka $p$ prochazejici bodem $S$ (viz obrazek).','Bod $K$ je vrchol obdelniku $KLMN$. Bod $S$ je stred strany $KL$ tohoto obdelniku. Primka $p$ prochazi stredem $S$ strany $KL$ a stredem jeste jedne strany obdelniku $KLMN$.','Sestrojte vrcholy $L$, $M$, $N$ obdelniku $KLMN$, oznacte je pismeny a obdelnik naryytujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="250" x2="420" y2="80" stroke="#000" stroke-width="2"/> <text x="428" y="78" font-size="16" font-style="italic">p</text> <text x="230" y="150" font-size="15">x</text> <text x="240" y="150" font-size="15" font-style="italic">S</text> <text x="248" y="200" font-size="15">x</text> <text x="256" y="205" font-size="15" font-style="italic">K</text> </svg>',
  'body-KS-primka.svg',
  'Body K a S a primka p prochazejici bodem S; bod K lezi pod primkou p, bod S na primce p.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'Vrchol $L$ je obrazem bodu $K$ ve stredove soumernosti se stredem $S$ (protoze $S$ je stred $KL$), lezi tedy na primce $KS$ ve stejne vzdalenosti za bodem $S$. Strany $KN$ a $LM$ jsou kolme na $KL$. Primka $p$ prochazi stredem strany $LM$ (nebo $KN$); jeji prusecik s kolmici vztycenou v bode $L$ (resp. $K$) je stred teto strany. Vrchol $M$ (resp. $N$) doplnime tak, aby tento prusecik byl stredem strany, a obdelnik dorysujeme. Podle toho, zda $p$ prochazi stredem strany $LM$, nebo $KN$, dostaneme dve reseni $M_1N_1$ a $M_2N_2$.'},
  'Dve reseni. $L$ je obraz $K$ ve stredove soumernosti se stredem $S$; primka $p$ urcuje stred strany $LM$ (resp. $KN$) jako prusecik s kolmici k $KL$ v bode $L$ (resp. $K$), odtud vrcholy $M$, $N$ (viz obrazek v klici).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
