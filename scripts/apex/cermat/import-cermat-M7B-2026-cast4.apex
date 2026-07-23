String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
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
  'CERMAT M7B 2026 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$, $M$ (viz obrázek).','Body $A$, $B$ jsou vrcholy kosočtverce $ABCD$. Bod $M$ leží na některé z úhlopříček tohoto kosočtverce.','Sestrojte vrcholy $C$, $D$ kosočtverce $ABCD$, označte je písmeny a kosočtverec narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"> <rect x="10" y="10" width="480" height="280" fill="none" stroke="#ccc"/> <text x="150" y="212" font-size="16">×</text><text x="146" y="230" font-size="15" font-style="italic">A</text> <text x="250" y="150" font-size="16">×</text><text x="248" y="168" font-size="15" font-style="italic">M</text> <text x="378" y="212" font-size="16">×</text><text x="376" y="230" font-size="15" font-style="italic">B</text> </svg>',
  'body-ABM.svg',
  'Body A, B (dole) a M (mezi nimi výše) v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Kosočtverec $ABCD$ má všechny strany shodné s $AB$; úhlopříčky $AC$ a $BD$ se navzájem půlí a jsou na sebe kolmé. Bod $M$ leží na jedné z úhlopříček, což dává dvě řešení.','1. řešení ($M$ na úhlopříčce $AC$): vrchol $C$ je průsečík přímky $AM$ s kružnicí se středem $B$ a poloměrem $|AB|$. Vrchol $D$ doplníme tak, aby střed $S$ úhlopříčky $AC$ byl zároveň středem $BD$.','2. řešení ($M$ na úhlopříčce $BD$): vrchol $D$ je průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem $|AB|$; vrchol $C$ doplníme tak, aby střed $BD$ byl zároveň středem $AC$.'},
  'Dvě řešení podle toho, zda $M$ leží na úhlopříčce $AC$ (vrcholy $C_1$, $D_1$), nebo na úhlopříčce $BD$ (vrcholy $C_2$, $D_2$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a body $Q$, $S$ (viz obrázek).','Bod $S$ je střed základny $AB$ rovnoramenného trojúhelníku $ABC$. Základna $AB$ je kolmá na přímku $p$ a vrchol $A$ leží na přímce $p$. Vrchol $C$ trojúhelníku $ABC$ leží na přímce $AQ$.','Sestrojte vrcholy trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 320" font-family="sans-serif"> <rect x="10" y="10" width="480" height="300" fill="none" stroke="#ccc"/> <line x1="70" y1="150" x2="210" y2="300" stroke="#000" stroke-width="2"/> <text x="60" y="150" font-size="16" font-style="italic">p</text> <text x="280" y="90" font-size="16">×</text><text x="298" y="94" font-size="15" font-style="italic">Q</text> <text x="300" y="220" font-size="16">×</text><text x="318" y="224" font-size="15" font-style="italic">S</text> </svg>',
  'primka-QS.svg',
  'Přímka p a body Q a S v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Přímka $AB$ je kolmá na $p$ a prochází bodem $S$; její průsečík s přímkou $p$ je vrchol $A$. Vrchol $B$ je obrazem $A$ ve středové souměrnosti se středem $S$ (bod $S$ je střed $AB$).','Trojúhelník je rovnoramenný se základnou $AB$, proto vrchol $C$ leží na ose základny, tj. na kolmici k $AB$ vedené bodem $S$ (na rovnoběžce s $p$ procházející bodem $S$). Vrchol $C$ je průsečík této osy s přímkou $AQ$.'},
  'Vrchol $A$ je průsečík kolmice k $p$ vedené bodem $S$ s přímkou $p$; $B$ je souměrný s $A$ podle $S$; vrchol $C$ leží na průsečíku přímky $AQ$ s osou úsečky $AB$ – viz obrázek v klíči.',
  2, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
