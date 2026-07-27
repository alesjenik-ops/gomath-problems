String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M9A 2017 – úloha 8',
  new List<String>{'Čtyřúhelník $ABCD$ je složen ze dvou pravoúhlých trojúhelníků $ABD$ a $BCD$ (pravé úhly jsou u vrcholů $A$ a $B$). Pro délky stran platí: $|AD|=3$ cm, $|BC|=12$ cm, $|BD|=5$ cm.','8.1 Vypočtěte v cm délku strany $AB$.','8.2 Vypočtěte v cm délku strany $CD$.','8.3 Vypočtěte v cm² obsah čtyřúhelníku $ABCD$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 340" font-family="sans-serif"> <g stroke="#000" stroke-width="2" fill="none"> <path d="M60,300 L140,300 L284,108 L60,240 Z"/><line x1="60" y1="240" x2="140" y2="300"/> </g> <g stroke="#000" stroke-width="1" fill="none"> <polygon points="60,290 70,290 70,300"/><polygon points="140,300 132,294 138,286 146,292"/> </g> <g font-size="15" font-style="italic"> <text x="48" y="318">A</text><text x="136" y="318">B</text><text x="292" y="102">C</text><text x="42" y="238">D</text> </g> <g font-size="13"> <text x="8" y="276">3 cm</text><text x="92" y="262">5 cm</text><text x="222" y="196">12 cm</text> </g> </svg>',
  'ctyruhelnik-abcd.svg',
  'Čtyřúhelník ABCD složený z pravoúhlých trojúhelníků ABD a BCD s úhlopříčkou BD délky 5 cm.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 V pravoúhlém trojúhelníku $ABD$: $|AB|=\\sqrt{5^2-3^2}=\\sqrt{16}=4$ cm.','8.2 V pravoúhlém trojúhelníku $BCD$: $|CD|=\\sqrt{5^2+12^2}=\\sqrt{169}=13$ cm.','8.3 $S=\\frac{3\\cdot 4}{2}+\\frac{5\\cdot 12}{2}=6+30=36$ cm².'},
  '8.1: $4$ cm; 8.2: $13$ cm; 8.3: $36$ cm²',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 9',
  new List<String>{'V rovině leží různoběžky $o$, $p$ a bod $L$ na přímce $p$ (viz obrázek).','Bod $L$ je vrchol rovnoramenného trojúhelníku $KLM$, přímka $o$ je osou souměrnosti tohoto trojúhelníku a strana $KL$ leží na přímce $p$.','Sestrojte chybějící vrcholy $K$, $M$ trojúhelníku $KLM$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"> <g stroke="#000" stroke-width="2"> <line x1="60" y1="240" x2="430" y2="240"/><line x1="150" y1="215" x2="400" y2="155"/> <line x1="395" y1="232" x2="395" y2="248"/> </g> <g font-size="15" font-style="italic"> <text x="70" y="262">p</text><text x="408" y="152">o</text><text x="390" y="266">L</text> </g> </svg>',
  'primky-op-bod-l.svg',
  'Dvě různoběžné přímky o a p a bod L ležící na přímce p.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Osa souměrnosti trojúhelníku prochází jedním vrcholem; protože $K$ i $L$ leží na přímce $p$ a osa $o$ není kolmá k $p$, musí osa procházet vrcholem $K$.','Vrchol $K$ je tedy průsečík přímek $o$ a $p$.','Vrchol $M$ je obraz bodu $L$ v osové souměrnosti podle přímky $o$ (vedeme kolmici z $L$ k $o$ a naneseme stejnou vzdálenost na druhou stranu).','Trojúhelník $KLM$ je rovnoramenný se základnou $LM$ a $|KL|=|KM|$.'},
  'Vrchol $K$ je průsečík přímek $o$ a $p$; vrchol $M$ je obraz bodu $L$ v osové souměrnosti podle přímky $o$. Trojúhelník $KLM$ má rameno $KL$ na přímce $p$ (viz obrázek v klíči správných řešení).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2017 – úloha 10',
  new List<String>{'V rovině leží body $A$, $B$ a $D$ (viz obrázek).','Body $A$, $B$ a $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$.','Sestrojte chybějící vrchol $C$ lichoběžníku $ABCD$ a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 330" font-family="sans-serif"> <g stroke="#000" stroke-width="2"> <line x1="70" y1="290" x2="182" y2="72"/><line x1="70" y1="290" x2="378" y2="167"/> <line x1="157" y1="99" x2="175" y2="111"/><line x1="337" y1="176" x2="353" y2="164"/> </g> <g font-size="15" font-style="italic"> <text x="52" y="308">A</text><text x="148" y="92">D</text><text x="350" y="196">B</text> </g> </svg>',
  'body-abd.svg',
  'Tři body A, B a D v rovině, body D a B jsou vyznačeny křížkem na polopřímkách vycházejících z bodu A.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'V lichoběžníku $ABCD$ jsou rovnoběžné strany $AB$ a $CD$.','Bodem $D$ vedeme rovnoběžku se stranou $AB$.','V bodě $B$ vztyčíme kolmici ke straně $AB$ (lichoběžník je pravoúhlý, pravé úhly jsou u vrcholů $B$ a $C$).','Vrchol $C$ je průsečík této kolmice s rovnoběžkou vedenou bodem $D$.'},
  'Vrchol $C$ je průsečík kolmice ke straně $AB$ vztyčené v bodě $B$ s rovnoběžkou se stranou $AB$ vedenou bodem $D$ (viz obrázek v klíči správných řešení).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
