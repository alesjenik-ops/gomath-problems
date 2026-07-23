String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
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
  'CERMAT M7C 2021 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $M$. Bodem $A$ prochází přímka $c$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Vrchol $C$ tohoto obdélníku leží na přímce $c$ a jeho vzdálenost od bodu $M$ je polovinou vzdálenosti bodu $A$ od bodu $M$. Vrchol $D$ obdélníku $ABCD$ leží na polopřímce $AM$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"> <line x1="40" y1="120" x2="420" y2="205" stroke="#000" stroke-width="2"/> <text x="425" y="210" font-size="15" font-style="italic">c</text> <line x1="70" y1="120" x2="72" y2="134" stroke="#000" stroke-width="2"/> <circle cx="71" cy="127" r="2.5" fill="#000"/><text x="60" y="150" font-size="15" font-style="italic">A</text> <text x="332" y="92" font-size="15" font-style="italic">M</text><text x="328" y="108" font-size="14">x</text> </svg>',
  'body-A-M-primka-c.svg',
  'Bod A ležící na přímce c a bod M mimo přímku.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Vrchol $C$ leží na přímce $c$ a zároveň na kružnici se středem $M$ a poloměrem $\\frac{1}{2}|AM|$; ta protíná přímku $c$ ve dvou bodech $C_1$, $C_2$. Strana $AD$ leží na polopřímce $AM$, proto je vrchol $D$ patou kolmice spuštěné z bodu $C$ na přímku $AM$. Vrchol $B$ doplníme tak, aby $ABCD$ byl obdélník. Úloha má dvě řešení.'},
  'Dvě řešení: $C_1$, $C_2$ jsou průsečíky přímky $c$ s kružnicí se středem $M$ a poloměrem $\\frac{1}{2}|AM|$; $D$ je pata kolmice z $C$ na přímku $AM$, $B$ doplňuje obdélník $ABCD$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$, $L$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.','Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <text x="185" y="150" font-size="14">x</text><text x="182" y="168" font-size="15" font-style="italic">L</text> <text x="392" y="150" font-size="14">x</text><text x="389" y="168" font-size="15" font-style="italic">B</text> <text x="150" y="205" font-size="14">x</text><text x="147" y="223" font-size="15" font-style="italic">A</text> </svg>',
  'body-A-B-L.svg',
  'Tři body A, B a L v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $L$ je průsečíkem os vnitřních úhlů při vrcholech $A$ a $B$. Přímka $AL$ je osou úhlu $BAC$, proto polopřímka $AC$ vznikne osovou souměrností polopřímky $AB$ podle přímky $AL$. Obdobně polopřímka $BC$ vznikne osovou souměrností polopřímky $BA$ podle přímky $BL$. Průsečík polopřímek $AC$ a $BC$ je hledaný vrchol $C$.'},
  'Vrchol $C$ je průsečík obrazů polopřímek $AB$ a $BA$ v osových souměrnostech podle přímek $AL$ a $BL$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
