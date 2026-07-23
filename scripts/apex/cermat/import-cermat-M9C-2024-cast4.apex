String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M9C 2024 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží bod $E$ a kružnice $k$ se středem $S$, která prochází bodem $A$ (viz obrázek).','Bod $A$ je vrchol pravoúhlého lichoběžníku $ABCD$ se základnami $AB$ a $CD$ a pravým úhlem při vrcholu $A$. Vrcholy $C$ a $D$ tohoto lichoběžníku leží na kružnici $k$, bod $E$ je střed ramene $BC$.','Sestrojte zbývající vrcholy $B$, $C$ a $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif"> <circle cx="200" cy="180" r="130" fill="none" stroke="#000" stroke-width="1.5"/> <text x="200" y="185" font-size="14" text-anchor="middle">×</text> <text x="212" y="192" font-size="14" font-style="italic">S</text> <text x="108" y="277" font-size="14" text-anchor="middle">×</text> <text x="94" y="277" font-size="14" font-style="italic">A</text> <text x="372" y="185" font-size="14" text-anchor="middle">×</text> <text x="384" y="185" font-size="14" font-style="italic">E</text> <text x="118" y="82" font-size="15" font-style="italic">k</text> </svg>',
  'kruznice-k-E.svg',
  'Kružnice k se středem S procházející bodem A vlevo dole a samostatný bod E vpravo vně kružnice.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Kružnice $k$ je Thaletovou kružnicí trojúhelníku $ACD$ (pravý úhel u $D$), proto úhlopříčka $AC$ prochází středem $S$. Vrchol $C$ je tedy průsečík polopřímky $AS$ s kružnicí $k$: $C=AS\\cap k$.','Bod $E$ je střed ramene $BC$, proto sestrojíme kružnici $m(E;|EC|)$ a vrchol $B$ najdeme jako $B=CE\\cap m$ (tak, že $|EB|=|EC|$).','V bodě $A$ vztyčíme kolmici k přímce $AB$ (pravý úhel při vrcholu $A$); její průsečík s kružnicí $k$ je vrchol $D$. Spojením $A$, $B$, $C$, $D$ vznikne lichoběžník $ABCD$.'},
  'Konstrukce lichoběžníku $ABCD$: $C=AS\\cap k$; $B$ na polopřímce $CE$ s $|EB|=|EC|$; $D$ je průsečík kolmice k $AB$ v bodě $A$ s kružnicí $k$ ($k$ je Thaletova kružnice nad průměrem $AC$). Viz obrázek v klíči.',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 10 (konstrukce)',
  new List<String>{'V rovině je dána přímka $o$ a body $A$ a $S$, které neleží na přímce $o$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného lichoběžníku $ABCD$, bod $S$ je střed strany $BC$. Přímka $o$ je osa souměrnosti lichoběžníku.','Sestrojte lichoběžník $ABCD$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 340" font-family="sans-serif"> <line x1="232" y1="70" x2="180" y2="300" stroke="#000" stroke-width="1.5"/> <text x="240" y="66" font-size="15" font-style="italic">o</text> <text x="150" y="235" font-size="14" text-anchor="middle">×</text> <text x="150" y="252" font-size="14" font-style="italic" text-anchor="middle">A</text> <text x="290" y="200" font-size="14" text-anchor="middle">×</text> <text x="300" y="205" font-size="14" font-style="italic">S</text> </svg>',
  'primka-o-AS.svg',
  'Šikmá přímka o (osa souměrnosti) a dva body: A vlevo dole a S vpravo, oba mimo přímku.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Rovnoramenný lichoběžník je souměrný podle osy $o$. Vrchol $B$ je obrazem vrcholu $A$ v osové souměrnosti podle osy $o$: $B=O_o(A)$.','Bod $S$ je střed strany $BC$, proto vrchol $C$ leží na polopřímce $BS$ tak, že $|CS|=|BS|$.','Vrchol $D$ je obrazem vrcholu $C$ v osové souměrnosti podle osy $o$: $D=O_o(C)$. Spojením vznikne lichoběžník $ABCD$.'},
  'Konstrukce lichoběžníku $ABCD$: $B=O_o(A)$; $C$ na polopřímce $BS$ s $|CS|=|BS|$; $D=O_o(C)$. Viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
