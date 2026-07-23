String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9 nanečisto 2025 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží trojúhelník $ABC$, na jehož straně $BC$ je umístěn bod $A\'$ (viz obrázek).','Bod $A\'$ je vrchol trojúhelníku $A\'B\'C\'$, který je obrazem trojúhelníku $ABC$ ve středové souměrnosti se středem $S$.','9.1 Sestrojte a označte písmenem střed souměrnosti $S$.','9.2 Sestrojte vrcholy $B\'$ a $C\'$ trojúhelníku $A\'B\'C\'$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 340" font-family="sans-serif"> <polygon points="70,60 170,310 340,190" fill="none" stroke="#000" stroke-width="2"/> <circle cx="245" cy="145" r="3" fill="#000"/> <text x="52" y="58" font-size="16" font-style="italic">C</text> <text x="166" y="330" font-size="16" font-style="italic">A</text> <text x="350" y="192" font-size="16" font-style="italic">B</text> <text x="250" y="138" font-size="16" font-style="italic">A′</text> </svg>',
  'trojuhelnik-ABC.svg',
  'Trojúhelník ABC s bodem A (s čárkou) umístěným na straně BC.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Bod $A\'$ je obrazem vrcholu $A$, proto střed souměrnosti $S$ je střed úsečky $AA\'$.','9.2 Vrcholy $B\'$ a $C\'$ jsou obrazy bodů $B$ a $C$ ve středové souměrnosti se středem $S$ (bod $S$ je střed úseček $BB\'$ i $CC\'$). Spojením $A\'B\'C\'$ vznikne hledaný trojúhelník.'},
  'Střed $S$ je střed úsečky $AA\'$; body $B\'$, $C\'$ jsou obrazy bodů $B$, $C$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
  2, 5, '2',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2025 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží přímky $AC$ a $PX$, které se protínají v bodě $P$ (viz obrázek).','Body $A$, $C$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$ se základnami $AB$, $CD$ a pravým úhlem při vrcholu $D$. Bod $P$ je průsečík úhlopříček tohoto lichoběžníku. Vrchol $D$ leží na přímce $PX$.','Sestrojte vrcholy $B$, $D$ pravoúhlého lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 320" font-family="sans-serif"> <line x1="50" y1="285" x2="350" y2="70" stroke="#000" stroke-width="2"/> <line x1="80" y1="50" x2="405" y2="270" stroke="#000" stroke-width="2"/> <text x="55" y="278" font-size="15">×</text><text x="40" y="300" font-size="16" font-style="italic">A</text> <text x="342" y="80" font-size="15">×</text><text x="356" y="70" font-size="16" font-style="italic">C</text> <text x="393" y="262" font-size="15">×</text><text x="408" y="270" font-size="16" font-style="italic">X</text> <text x="228" y="150" font-size="16" font-style="italic">P</text> </svg>',
  'primky-AC-PX.svg',
  'Přímky AC a PX protínající se v bodě P; na přímkách jsou vyznačeny body A, C a X.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Pravý úhel je při vrcholu $D$ (úhel $ADC$), proto $D$ leží na Thaletově kružnici nad průměrem $AC$. Zároveň $D$ leží na přímce $PX$; průsečíky dávají dvě polohy $D_1$, $D_2$.','Bod $P$ je průsečík úhlopříček, takže vrchol $B$ leží na přímce $DP$; jeho polohu určuje rovnoběžnost základen $AB \\parallel CD$. Úloha má dvě řešení (lichoběžníky s vrcholy $D_1, B_1$ a $D_2, B_2$).'},
  'Dvě řešení: $D$ je průsečík Thaletovy kružnice nad $AC$ s přímkou $PX$ ($D_1$, $D_2$), vrchol $B$ leží na přímce $DP$ tak, že $AB \\parallel CD$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
