String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD26C0T02';
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
  'CERMAT M5B 2026 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $P$ a přímka $AQ$ (viz obrázek).','Bod $A$ je vrchol čtverce $ABCD$, jehož strana $AB$ leží na polopřímce $AQ$. Bodem $P$ prochází strana $CD$ tohoto čtverce.','Sestrojte vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 250" font-family="sans-serif"> <line x1="40" y1="145" x2="395" y2="216" stroke="#000" stroke-width="2"/> <text x="248" y="82" font-size="15" text-anchor="middle">×</text><text x="256" y="78" font-size="14" font-style="italic">P</text> <text x="120" y="167" font-size="15" text-anchor="middle">×</text><text x="106" y="182" font-size="14" font-style="italic">A</text> <text x="300" y="203" font-size="15" text-anchor="middle">×</text><text x="306" y="218" font-size="14" font-style="italic">Q</text> </svg>',
  'bod-P-primka-AQ.svg',
  'Bod P a přímka procházející body A a Q.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Strana $CD$ je rovnoběžná s $AQ$ a prochází bodem $P$; sestrojíme přímku rovnoběžnou s $AQ$ procházející $P$. Vzdálenost mezi přímkou $AQ$ a touto rovnoběžkou je rovna straně čtverce. Bod $B$ leží na polopřímce $AQ$ v této vzdálenosti od $A$, vrcholy $D$ a $C$ doplníme kolmicemi k $AQ$ v bodech $A$ a $B$.'},
  'Konstrukce čtverce $ABCD$ (strana $AB$ na polopřímce $AQ$, strana $CD$ prochází bodem $P$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2026 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $L$, $S$, $T$ (viz obrázek).','Bod $L$ je vrchol trojúhelníku $KLM$ a bod $S$ je střed strany $KL$ tohoto trojúhelníku. Vrchol $M$ leží na přímce $KT$. Strany $KL$ a $KM$ trojúhelníku $KLM$ mají stejnou délku.','Sestrojte vrcholy $K$, $M$ trojúhelníku $KLM$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 250" font-family="sans-serif"> <text x="120" y="72" font-size="15" text-anchor="middle">×</text><text x="128" y="68" font-size="14" font-style="italic">T</text> <text x="215" y="152" font-size="15" text-anchor="middle">×</text><text x="223" y="148" font-size="14" font-style="italic">S</text> <text x="248" y="207" font-size="15" text-anchor="middle">×</text><text x="256" y="203" font-size="14" font-style="italic">L</text> </svg>',
  'body-L-S-T.svg',
  'Body L, S a T v rovině.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Bod $S$ je střed $KL$ a $L$ je dán, proto je $K$ souměrný obraz bodu $L$ podle bodu $S$ (bod $K$ leží na polopřímce opačné k $SL$ ve stejné vzdálenosti). Vrchol $M$ leží na přímce $KT$ a platí $|KM|=|KL|$; kružnice se středem $K$ a poloměrem $|KL|$ protne přímku $KT$ ve dvou bodech $M_1$, $M_2$. Existují dvě řešení.'},
  'Dvě řešení: bod $K$ je souměrný obraz $L$ podle $S$, bod $M$ leží na přímce $KT$ ve vzdálenosti $|KM|=|KL|$ od $K$ (polohy $M_1$, $M_2$) – viz klíč.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
