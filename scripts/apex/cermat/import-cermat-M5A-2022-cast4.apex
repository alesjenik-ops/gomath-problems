String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD22C0T01';
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
  'CERMAT M5A 2022 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $P$, $S$ a přímka $q$ (viz obrázek).','Bod $P$ je vrchol trojúhelníku $PQR$. Na přímce $q$ leží vrchol $Q$ tohoto trojúhelníku. Vrcholy $P$ a $Q$ leží na téže kružnici se středem $S$. Bod $S$ je zároveň středem strany $QR$.','Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="60" y1="250" x2="430" y2="150" stroke="#000" stroke-width="2"/> <text x="436" y="150" font-size="16" font-style="italic">q</text> <text x="330" y="150" font-size="15" text-anchor="middle">x</text> <text x="330" y="138" font-size="15" text-anchor="middle" font-style="italic">S</text> <text x="190" y="205" font-size="15" text-anchor="middle">x</text> <text x="190" y="223" font-size="15" text-anchor="middle" font-style="italic">P</text> </svg>',
  'primka-q.svg',
  'Body P a S a přímka q v rovině.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Sestrojíme kružnici se středem $S$ a poloměrem $|SP|$. Vrchol $Q$ je průsečík této kružnice s přímkou $q$; kružnici protíná ve dvou bodech $Q_1$, $Q_2$.','Protože $S$ je střed strany $QR$, leží $R$ na polopřímce opačné k $SQ$ tak, že $|SR|=|SQ|$ (bod $R$ je obraz $Q$ ve středové souměrnosti se středem $S$). Úloha má dvě řešení.'},
  'Dvě řešení. $Q$ je průsečík kružnice se středem $S$ a poloměrem $|SP|$ s přímkou $q$ ($Q_1$, $Q_2$); $R$ je souměrný s $Q$ podle středu $S$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2022 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $T$, $V$ a přímka $p$ procházející body $T$, $V$ (viz obrázek).','Bod $A$ je vrchol čtverce $ABCD$. Přímka $p$ protíná stranu $AB$ tohoto čtverce v bodě $T$ a stranu $CD$ v bodě $V$.','Sestrojte vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="120" y1="70" x2="380" y2="250" stroke="#000" stroke-width="2"/> <text x="384" y="264" font-size="16" font-style="italic">p</text> <text x="150" y="95" font-size="15">x</text> <text x="164" y="90" font-size="15" font-style="italic">V</text> <text x="330" y="222" font-size="15">x</text> <text x="344" y="217" font-size="15" font-style="italic">T</text> <text x="215" y="250" font-size="15" text-anchor="middle">x</text> <text x="215" y="268" font-size="15" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primka-p.svg',
  'Body A, T, V a přímka p procházející body T a V.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Strana $AB$ leží na přímce $AT$ (prochází body $A$ a $T$). Strana $CD$ je s ní rovnoběžná, prochází bodem $V$ a je od $AB$ vzdálena o délku strany čtverce.','Délka strany čtverce $|AB|$ se proto rovná vzdálenosti bodu $V$ od přímky $AT$. Bod $B$ naneseme na polopřímku $AT$ v této vzdálenosti; ve vrcholech $A$ a $B$ vztyčíme kolmice k $AB$ a doplníme vrcholy $D$ a $C$ tak, aby $ABCD$ byl čtverec.'},
  'Strana $AB$ leží na přímce $AT$ a její délka je rovna vzdálenosti bodu $V$ od přímky $AT$; kolmicemi v $A$ a $B$ doplníme vrcholy $B$, $C$, $D$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
