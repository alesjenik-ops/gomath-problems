String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
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
  'CERMAT M9 nanečisto 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží bod $E$ a přímka $p$ (viz obrázek).','Bod $E$ je vrchol pravidelného šestiúhelníku $ABCDEF$. Na přímce $p$ leží vrcholy $D$, $F$ tohoto šestiúhelníku.','Sestrojte vrcholy $A$, $B$, $C$, $D$, $F$ pravidelného šestiúhelníku $ABCDEF$, označte je písmeny a šestiúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif"> <line x1="60" y1="185" x2="410" y2="120" stroke="#000" stroke-width="2"/> <text x="70" y="205" font-size="16" font-style="italic">p</text> <text x="252" y="95" font-size="16" font-style="italic">E</text> <text x="247" y="112" font-size="16">x</text> </svg>',
  'bod-E-primka-p.svg',
  'Bod E označený křížkem a mírně stoupající přímka p pod ním.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrcholy $D$ a $F$ sousedí s vrcholem $E$, leží na přímce $p$ a platí $|ED|=|EF|$ (strana šestiúhelníku), vnitřní úhel při vrcholu $E$ je $120^\\circ$. Pata kolmice $M$ z bodu $E$ na přímku $p$ je střed úsečky $DF$; přitom $|EM|$ je polovina strany, takže strana $=2\\cdot|EM|$ a body $D$, $F$ naneseme na $p$ ve vzdálenosti $|EM|\\cdot\\sqrt{3}$ od $M$. Střed šestiúhelníku $S$ leží na kolmici pod $M$ ve vzdálenosti $|EM|$; opíšeme kružnici se středem $S$ a poloměrem $|SE|$ a doplníme vrcholy $A$, $B$, $C$.'},
  'Konstrukce pravidelného šestiúhelníku $ABCDEF$: vrcholy $D$, $F$ na přímce $p$ souměrně kolem paty kolmice z $E$, střed $S$ a opsaná kružnice, doplnění vrcholů $A$, $B$, $C$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $B$, $M$ (viz obrázek).','Úsečka $AB$ je strana rovnoběžníku $ABCD$. Na přímce $BM$ leží vrchol $D$ tohoto rovnoběžníku. Úhlopříčka $AC$ rovnoběžníku $ABCD$ má délku 6 cm.','10.1 Sestrojte střed $S$ rovnoběžníku $ABCD$ a označte ho písmenem.','10.2 Sestrojte vrcholy $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"> <text x="170" y="150" font-size="16">x</text><text x="166" y="138" font-size="16" font-style="italic">M</text> <text x="410" y="140" font-size="16">x</text><text x="408" y="128" font-size="16" font-style="italic">B</text> <text x="250" y="235" font-size="16">x</text><text x="248" y="255" font-size="16" font-style="italic">A</text> </svg>',
  'body-A-B-M.svg',
  'Tři body A, B, M označené křížky v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Střed $S$ je společný střed úhlopříček, tedy střed úsečky $AC$, proto $|AS|=3$ cm. Zároveň $S$ je střed úsečky $BD$; protože $D$ leží na přímce $BM$, leží i $S$ na přímce $BM$. Bod $S$ je tedy průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem 3 cm — vzniknou dvě polohy $S_1$, $S_2$. Vrchol $C$ je obrazem bodu $A$ ve středové souměrnosti podle $S$, vrchol $D$ obrazem bodu $B$. Úloha má dvě řešení.'},
  'Dvě řešení. Střed $S$ je průsečík přímky $BM$ s kružnicí se středem $A$ a poloměrem $3$ cm; $C$ a $D$ jsou obrazy bodů $A$ a $B$ ve středové souměrnosti podle $S$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
