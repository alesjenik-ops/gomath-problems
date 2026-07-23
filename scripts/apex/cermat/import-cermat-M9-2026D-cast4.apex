String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
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
  'CERMAT M9D 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a body $B$, $D$ (viz obrázek).','Body $B$, $D$ jsou vrcholy pravoúhlého rovnoramenného trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. Bod $C$ má od přímky $p$ větší vzdálenost než bod $B$.','9.1 Sestrojte vrchol $C$ trojúhelníku $BCD$ a označte ho písmenem.','9.2 Body $B$, $C$, $D$ jsou zároveň vrcholy lichoběžníku $ABCD$. Vrchol $A$ tohoto lichoběžníku leží na přímce $p$. Sestrojte vrchol $A$ lichoběžníku $ABCD$, označte ho písmenem a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif"> <line x1="110" y1="45" x2="250" y2="265" stroke="#000" stroke-width="2"/> <text x="92" y="52" font-size="16" font-style="italic">p</text> <text x="312" y="118" font-size="15" font-style="italic">D</text> <text x="308" y="135" font-size="14">x</text> <text x="300" y="212" font-size="15" font-style="italic">B</text> <text x="296" y="229" font-size="14">x</text> </svg>',
  'primka-p-body-BD.svg',
  'Klesající přímka p a dva body B, D označené křížky vpravo od přímky (D výše, B níže).',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Trojúhelník $BCD$ je pravoúhlý (pravý úhel u $C$) a rovnoramenný ($|CB|=|CD|$). Vrchol $C$ leží na Thaletově kružnici nad průměrem $BD$ a zároveň na ose úsečky $BD$; ze dvou průsečíků zvolíme ten, který je od přímky $p$ dále.','9.2 Vrchol $A$ lichoběžníku $ABCD$ leží na přímce $p$. Podle toho, která dvojice protějších stran je rovnoběžná, dostaneme dvě řešení: $A_1$ jako průsečík přímky $p$ s rovnoběžkou vedenou bodem $B$ k přímce $CD$ a $A_2$ jako průsečík přímky $p$ s rovnoběžkou vedenou bodem $D$ k přímce $BC$. Úloha má dvě řešení.'},
  'Konstrukce: pravoúhlý rovnoramenný trojúhelník $BCD$ (pravý úhel u $C$; $C$ na Thaletově kružnici nad $BD$ a na ose $BD$, dále od přímky $p$); vrchol $A$ na přímce $p$ dává dvě řešení lichoběžníku $ABCD$ ($A_1$, $A_2$) — viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $D$, $S$, $U$ (viz obrázek).','Bod $D$ je vrchol obdélníku $ABCD$. Bod $S$ je střed kružnice $k$, na níž leží všechny vrcholy tohoto obdélníku. Bodem $U$ prochází přímka $u$, na které leží vrcholy $A$, $C$ obdélníku $ABCD$.','Sestrojte kružnici $k$ a vrcholy $A$, $B$, $C$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <text x="122" y="92" font-size="15" font-style="italic">D</text> <text x="118" y="109" font-size="14">x</text> <text x="212" y="162" font-size="15" font-style="italic">S</text> <text x="208" y="179" font-size="14">x</text> <text x="372" y="150" font-size="15" font-style="italic">U</text> <text x="368" y="167" font-size="14">x</text> </svg>',
  'body-DSU.svg',
  'Tři body D, S, U označené křížky v rovině (D vlevo nahoře, S uprostřed, U vpravo).',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Bod $S$ je střed kružnice opsané obdélníku, tedy střed obou úhlopříček. Úhlopříčka $AC$ leží na přímce $u$, proto vrcholy $A$, $C$ jsou průsečíky přímky $u$ s kružnicí $k$; kružnici $k$ sestrojíme se středem $S$ a poloměrem $|SD|$. Vrchol $B$ je obraz vrcholu $D$ ve středové souměrnosti se středem $S$ (druhý průsečík přímky $DS$ s kružnicí $k$). Spojením $A$, $B$, $C$, $D$ vznikne obdélník.'},
  'Konstrukce: kružnice $k$ se středem $S$ a poloměrem $|SD|$; $A$, $C$ jsou průsečíky přímky $u$ s $k$; $B$ je obraz $D$ ve středové souměrnosti podle $S$; obdélník $ABCD$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
