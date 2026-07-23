String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
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
  'CERMAT M9A 2021 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží polopřímka $BX$ a přímka $o$ (viz obrázek).','Bod $B$ je vrchol trojúhelníku $ABC$. Přímka $o$ je osou strany $AB$. Velikost vnitřního úhlu $BAC$ je $60^\\circ$ a vrchol $C$ leží na polopřímce $BX$.','Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="150" y1="62" x2="330" y2="255" stroke="#000" stroke-width="2"/> <text x="138" y="58" font-size="16" font-style="italic">o</text> <line x1="60" y1="238" x2="410" y2="150" stroke="#000" stroke-width="2"/> <line x1="60" y1="231" x2="60" y2="245" stroke="#000" stroke-width="2"/> <text x="46" y="256" font-size="16" font-style="italic">B</text> <line x1="332" y1="163" x2="342" y2="181" stroke="#000" stroke-width="2"/> <text x="338" y="200" font-size="16" font-style="italic">X</text> </svg>',
  'poloprimka-BX-o.svg',
  'Polopřímka BX (z bodu B doprava nahoru přes bod X) a přímka o protínající ji.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Přímka $o$ je osou úsečky $AB$, proto vrchol $A$ získáme jako obraz daného bodu $B$ v osové souměrnosti podle přímky $o$.','Při vrcholu $A$ sestrojíme k přímce $AB$ úhel velikosti $60^\\circ$; jeho rameno protne polopřímku $BX$ ve vrcholu $C$. Trojúhelník $ABC$ narýsujeme.'},
  'Vrchol $A$ je obraz bodu $B$ v osové souměrnosti podle přímky $o$ (osy $AB$); vrchol $C$ je průsečík polopřímky $BX$ s ramenem úhlu velikosti $60^\\circ$ sestrojeného při vrcholu $A$ k přímce $AB$ – viz obrázek v klíči.',
  2, 6, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $B$, $P$ a přímka $q$ procházející bodem $B$ (viz obrázek).','Bod $B$ je vrchol rovnoramenného lichoběžníku $ABCD$ se základnou $AB$, rameno $BC$ leží na přímce $q$. Úhlopříčky $AC$ a $BD$ se protínají v bodě $P$ a jsou na sebe kolmé.','Sestrojte vrcholy $A$, $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="252" y1="300" x2="398" y2="58" stroke="#000" stroke-width="2"/> <text x="404" y="52" font-size="16" font-style="italic">q</text> <line x1="272" y1="258" x2="288" y2="268" stroke="#000" stroke-width="2"/> <text x="292" y="272" font-size="16" font-style="italic">B</text> <text x="196" y="150" font-size="18" text-anchor="middle">×</text> <text x="196" y="170" font-size="16" font-style="italic">P</text> </svg>',
  'body-BP-q.svg',
  'Body B a P a přímka q procházející bodem B v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Úhlopříčka $BD$ prochází body $B$ a $P$, leží tedy na přímce $BP$. Druhá úhlopříčka $AC$ je k ní kolmá a prochází bodem $P$; její průsečík s přímkou $q$ je vrchol $C$.','Rovnoramenný lichoběžník se základnou $AB$ má $|PA|=|PB|$ a $|PC|=|PD|$. Vrchol $A$ naneseme na přímku $AC$ tak, aby $|PA|=|PB|$ (na opačnou stranu než $C$), vrchol $D$ na přímku $BP$ za bod $P$ tak, aby $|PD|=|PC|$. Lichoběžník narýsujeme.'},
  'Úhlopříčka $BD$ leží na přímce $BP$; kolmice k $BP$ vedená bodem $P$ protne přímku $q$ ve vrcholu $C$. Vrchol $A$ leží na této kolmici tak, že $|PA|=|PB|$ (na opačné straně než $C$), vrchol $D$ leží na přímce $BP$ za bodem $P$ tak, že $|PD|=|PC|$ – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 11',
  new List<String>{'Děti mají mapu s měřítkem $1:50\\,000$. Alena ujela na koloběžce trasu délky $10$ km a vypočetla, že na mapě je to $5$ cm. Beáta ušla trasu, která je na mapě zobrazena čarou délky $15$ cm. Čestmír ušel dvakrát delší trasu než Beáta.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Alenin výpočet je správný.','11.2 Beáta ušla trasu délky $7{,}5$ km.','11.3 Na mapě je Beátina trasa o polovinu kratší než Čestmírova trasa.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Měřítko $1:50\\,000$ znamená $1$ cm na mapě $=50\\,000$ cm $=0{,}5$ km ve skutečnosti.','11.1 $10$ km odpovídá na mapě $10:0{,}5=20$ cm, nikoli $5$ cm; výpočet je nesprávný → N.','11.2 Beátina trasa $15$ cm na mapě $=15\\cdot 0{,}5=7{,}5$ km → A.','11.3 Čestmír ušel dvakrát delší trasu, na mapě tedy $30$ cm; Beátiných $15$ cm je o polovinu (o $15$ cm) kratší než $30$ cm → A.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
