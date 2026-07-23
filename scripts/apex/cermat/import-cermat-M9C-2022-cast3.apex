String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD22C0T03';
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
  'CERMAT M9C 2022 – úloha 9',
  new List<String>{'V rovině leží body $P$, $Q$ a přímka $o$ (viz obrázek).','Body $P$, $Q$ jsou vrcholy trojúhelníku $PQR$. Přímka $o$ je osou některé strany tohoto trojúhelníku.','Sestrojte vrchol $R$ trojúhelníku $PQR$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 380" font-family="sans-serif"> <line x1="330" y1="345" x2="600" y2="110" stroke="#000" stroke-width="1.8"/> <text x="600" y="102" font-size="16" font-style="italic">o</text> <line x1="293" y1="93" x2="307" y2="107" stroke="#000" stroke-width="1.6"/> <line x1="293" y1="107" x2="307" y2="93" stroke="#000" stroke-width="1.6"/> <text x="300" y="83" font-size="16" font-style="italic">P</text> <line x1="228" y1="243" x2="242" y2="257" stroke="#000" stroke-width="1.6"/> <line x1="228" y1="257" x2="242" y2="243" stroke="#000" stroke-width="1.6"/> <text x="235" y="278" font-size="16" font-style="italic">Q</text> </svg>',
  'body-pq-o.svg',
  'Body P a Q a přímka o vedená šikmo v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Přímka $o$ může být osou strany $PR$, nebo osou strany $QR$. Je-li $o$ osou strany $PR$, je vrchol $R_{1}$ obrazem bodu $P$ v osové souměrnosti podle přímky $o$. Je-li $o$ osou strany $QR$, je vrchol $R_{2}$ obrazem bodu $Q$ v osové souměrnosti podle přímky $o$. Úloha má dvě řešení.'},
  'Dvě řešení: $R_{1}$ je obraz bodu $P$ a $R_{2}$ obraz bodu $Q$ v osové souměrnosti podle přímky $o$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 10',
  new List<String>{'V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 400" font-family="sans-serif"> <line x1="60" y1="95" x2="560" y2="95" stroke="#000" stroke-width="1.8"/> <text x="44" y="100" font-size="16" font-style="italic">c</text> <line x1="60" y1="180" x2="560" y2="180" stroke="#000" stroke-width="1.8"/> <text x="44" y="185" font-size="16" font-style="italic">p</text> <line x1="323" y1="248" x2="337" y2="262" stroke="#000" stroke-width="1.6"/> <line x1="323" y1="262" x2="337" y2="248" stroke="#000" stroke-width="1.6"/> <text x="330" y="282" font-size="16" font-style="italic">X</text> <line x1="243" y1="323" x2="257" y2="337" stroke="#000" stroke-width="1.6"/> <line x1="243" y1="337" x2="257" y2="323" stroke="#000" stroke-width="1.6"/> <text x="250" y="357" font-size="16" font-style="italic">A</text> </svg>',
  'body-ax-cp.svg',
  'Body A a X a dvě rovnoběžné vodorovné přímky c a p v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Strana $AB$ leží na přímce $AX$, ostatní strany obdélníku jsou k ní kolmé, resp. rovnoběžné. Vrchol $C$ leží na přímce $c$ a jeden z vrcholů $B$, $D$ na přímce $p$. Vyhovují dva obdélníky – s vrcholy $B_{1}C_{1}D_{1}$ a $B_{2}C_{2}D_{2}$. Úloha má dvě řešení.'},
  'Dvě řešení – obdélníky $AB_{1}C_{1}D_{1}$ a $AB_{2}C_{2}D_{2}$ (strana $AB$ na přímce $AX$, vrchol $C$ na přímce $c$, jeden z vrcholů $B$, $D$ na přímce $p$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
