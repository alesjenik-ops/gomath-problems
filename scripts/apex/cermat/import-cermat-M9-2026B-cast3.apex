String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
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
  'CERMAT M9B 2026 – úloha 8',
  new List<String>{'Délky dvou stran trojúhelníku $ABC$ jsou $a=7$ cm, $b=30$ cm. Obvod trojúhelníku $ABC$ v cm je vyjádřen celým číslem.','8.1 Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod nejmenší možný.','8.2 Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod největší možný.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle trojúhelníkové nerovnosti platí $b-a<c<b+a$, tj. $23<c<37$. Strana $c$ je celé číslo.','8.1 Nejmenší možná strana je $c=24$ cm (obvod $61$ cm).','8.2 Největší možná strana je $c=36$ cm (obvod $73$ cm).'},
  '8.1: $24$ cm; 8.2: $36$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $O$, $P$ (viz obrázek).','Bod $A$ je vrchol pravidelného šestiúhelníku $ABCDEF$. Přímka $OP$ je osa strany $AB$ tohoto šestiúhelníku. Na polopřímce $OP$ leží střed souměrnosti $S$ šestiúhelníku $ABCDEF$.','Sestrojte vrcholy $B$, $C$, $D$, $E$, $F$ šestiúhelníku $ABCDEF$, označte je písmeny a šestiúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif"> <rect x="6" y="6" width="408" height="248" fill="none" stroke="#ccc"/> <text x="334" y="84" font-size="15" font-style="italic">P</text><text x="326" y="76" font-size="14">×</text> <text x="162" y="122" font-size="15" font-style="italic">A</text><text x="154" y="134" font-size="14">×</text> <text x="150" y="206" font-size="15" font-style="italic">O</text><text x="142" y="198" font-size="14">×</text> </svg>',
  'body-AOP.svg',
  'Body A, O, P v rovině; O a P leží níže, bod A nad nimi.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $B$ je obrazem bodu $A$ v osové souměrnosti podle přímky $OP$ (osa strany $AB$). Střed $S$ leží na přímce $OP$ ve vzdálenosti $|AB|$ od bodu $A$ (u pravidelného šestiúhelníku je poloměr kružnice opsané roven délce strany), sestrojíme ho jako průsečík kružnice se středem $A$ a poloměrem $|AB|$ s přímkou $OP$. Sestrojíme kružnici opsanou se středem $S$ a poloměrem $|SA|$; na ni od bodu $A$ postupně naneseme tětivy délky $|AB|$ a získáme vrcholy $C$, $D$, $E$, $F$. Šestiúhelník $ABCDEF$ narýsujeme.'},
  'Konstrukce pravidelného šestiúhelníku $ABCDEF$ ($B$ obraz $A$ v osové souměrnosti podle $OP$; střed $S$ na $OP$ s $|SA|=|AB|$; vrcholy na kružnici opsané) – viz náčrt v klíči.',
  2, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$, $D$ (viz obrázek).','Body $A$ a $B$ jsou vrcholy pravoúhlého trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Body $B$ a $D$ jsou vrcholy pravoúhlého trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. Vrcholy $B$ a $C$ jsou společnými vrcholy obou trojúhelníků.','Sestrojte vrchol $C$, označte ho písmenem a narýsujte trojúhelníky $ABC$ a $BCD$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 260" font-family="sans-serif"> <rect x="6" y="6" width="408" height="248" fill="none" stroke="#ccc"/> <text x="176" y="120" font-size="15" font-style="italic">A</text><text x="168" y="132" font-size="14">×</text> <text x="344" y="120" font-size="15" font-style="italic">B</text><text x="336" y="132" font-size="14">×</text> <text x="112" y="216" font-size="15" font-style="italic">D</text><text x="120" y="208" font-size="14">×</text> </svg>',
  'body-ABD.svg',
  'Body A, B, D v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Bod $C$ vidí úsečku $AB$ pod pravým úhlem, leží tedy na Thaletově kružnici nad průměrem $AB$. Zároveň vidí úsečku $BD$ pod pravým úhlem, leží tedy na Thaletově kružnici nad průměrem $BD$. Vrchol $C$ je průsečík obou Thaletových kružnic různý od bodu $B$; ve správné konstrukci leží bod $C$ na polopřímce $DA$. Narýsujeme trojúhelníky $ABC$ a $BCD$.'},
  'Konstrukce: $C$ je průsečík Thaletovy kružnice nad $AB$ a Thaletovy kružnice nad $BD$ (leží na polopřímce $DA$, úhel $DCB$ je pravý) – viz náčrt v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
