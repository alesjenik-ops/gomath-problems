String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
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
  'CERMAT M7C 2022 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $P$, $Q$ a přímka $o$ (viz obrázek).','Body $P$, $Q$ jsou vrcholy trojúhelníku $PQR$. Přímka $o$ je osou některé strany tohoto trojúhelníku.','Sestrojte vrchol $R$ trojúhelníku $PQR$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <rect x="8" y="8" width="444" height="304" fill="none" stroke="#bbb"/> <line x1="150" y1="290" x2="410" y2="70" stroke="#000" stroke-width="2"/> <text x="420" y="66" font-size="16" font-style="italic">o</text> <text x="150" y="95" font-size="15" text-anchor="middle">×</text> <text x="150" y="80" font-size="15" text-anchor="middle" font-style="italic">P</text> <text x="120" y="205" font-size="15" text-anchor="middle">×</text> <text x="120" y="225" font-size="15" text-anchor="middle" font-style="italic">Q</text> </svg>',
  'body-PQ-o.svg',
  'Body P a Q a šikmá přímka o v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Přímka $o$ může být osou strany $PR$, nebo osou strany $QR$. Je-li $o$ osou $PR$, je vrchol $R$ obrazem bodu $P$ v osové souměrnosti s osou $o$ (řešení $R_1$). Je-li $o$ osou $QR$, je vrchol $R$ obrazem bodu $Q$ v osové souměrnosti s osou $o$ (řešení $R_2$). Úloha má dvě řešení.'},
  'Dvě řešení: $R_1$ je obraz bodu $P$ a $R_2$ je obraz bodu $Q$ v osové souměrnosti s osou $o$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $X$ a rovnoběžné přímky $c$, $p$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Bod $X$ leží uvnitř strany $AB$ obdélníku. Na přímce $c$ leží vrchol $C$ obdélníku $ABCD$ a na přímce $p$ jeden ze zbývajících dvou vrcholů obdélníku.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <rect x="8" y="8" width="444" height="304" fill="none" stroke="#bbb"/> <line x1="60" y1="90" x2="400" y2="90" stroke="#000" stroke-width="2"/> <text x="40" y="95" font-size="16" font-style="italic">c</text> <line x1="60" y1="150" x2="400" y2="150" stroke="#000" stroke-width="2"/> <text x="40" y="155" font-size="16" font-style="italic">p</text> <text x="255" y="215" font-size="15" text-anchor="middle">×</text> <text x="255" y="233" font-size="15" text-anchor="middle" font-style="italic">X</text> <text x="175" y="270" font-size="15" text-anchor="middle">×</text> <text x="175" y="288" font-size="15" text-anchor="middle" font-style="italic">A</text> </svg>',
  'body-AX-cp.svg',
  'Body A a X a dvě rovnoběžné vodorovné přímky c a p v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Strana $AB$ leží na přímce $AX$; strana $AD$ je k ní kolmá. Vrchol $C$ leží na přímce $c$ a jeden z vrcholů $B$, $D$ leží na přímce $p$. Rozborem obou možností (na přímce $p$ leží buď $B$, nebo $D$) a využitím rovnoběžnosti $c\\parallel p$ dostaneme dvě polohy obdélníku – $AB_1C_1D_1$ a $AB_2C_2D_2$. Úloha má dvě řešení.'},
  'Dvě řešení – obdélníky $AB_1C_1D_1$ a $AB_2C_2D_2$ ($C$ na přímce $c$, jeden ze zbývajících vrcholů na přímce $p$); viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
