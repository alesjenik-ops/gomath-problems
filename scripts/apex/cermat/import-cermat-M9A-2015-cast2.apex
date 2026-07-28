String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M9A 2015 – úloha 8',
  new List<String>{'Některé z bodů vyznačených v síti kvádru představují ve složeném kvádru jeden a týž vrchol. Například dva různé body $0$ a $E$ sítě kvádru představují ve složeném kvádru stejný vrchol.','Připište k uvedenému bodu všechny body sítě kvádru, které ve složeném kvádru představují stejný vrchol.','8.1 bod $1$','8.2 bod $2$','8.3 bod $3$'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif" font-size="15"> <rect x="60" y="90" width="60" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <rect x="120" y="90" width="100" height="110" fill="#ffffff" stroke="#000" stroke-width="2"/> <rect x="220" y="90" width="60" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <rect x="280" y="90" width="100" height="110" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <rect x="120" y="30" width="100" height="60" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <rect x="120" y="200" width="100" height="60" fill="#d3d3d3" stroke="#000" stroke-width="2"/> <text x="112" y="26" text-anchor="end" font-style="italic">A</text> <circle cx="240" cy="20" r="11" fill="#fff" stroke="#000"/><text x="240" y="25" text-anchor="middle" font-weight="bold">0</text> <text x="54" y="84" text-anchor="end" font-style="italic">B</text> <text x="114" y="84" text-anchor="end" font-style="italic">C</text> <text x="214" y="84" text-anchor="end" font-style="italic">D</text> <text x="288" y="84" font-style="italic">E</text> <circle cx="392" cy="74" r="11" fill="#fff" stroke="#000"/><text x="392" y="79" text-anchor="middle" font-weight="bold">2</text> <text x="54" y="220" text-anchor="end" font-style="italic">F</text> <text x="114" y="220" text-anchor="end" font-style="italic">G</text> <text x="214" y="220" text-anchor="end" font-style="italic">H</text> <circle cx="292" cy="222" r="11" fill="#fff" stroke="#000"/><text x="292" y="227" text-anchor="middle" font-weight="bold">1</text> <text x="390" y="220" font-style="italic">K</text> <circle cx="106" cy="274" r="11" fill="#fff" stroke="#000"/><text x="106" y="279" text-anchor="middle" font-weight="bold">3</text> <text x="228" y="279" font-style="italic">L</text> </svg>',
  'sit-kvadru.svg',
  'Síť kvádru: vodorovný pás čtyř stěn s body B, C, D, E, 2 v horní hraně a F, G, H, 1, K v dolní hraně, nad druhou stěnou chlopeň s body A a 0, pod ní chlopeň s body 3 a L.',
  'Síť kvádru s vyznačenými body',
  new List<String>{'Pás se ohne kolem kvádru: stěna $CDHG$ je přední, $BCGF$ levá, $DE1H$ pravá a $E2K1$ zadní; horní chlopeň $ACD0$ je horní podstava, dolní chlopeň $G3LH$ dolní podstava.','8.1 Bod $1$ je zadní dolní vrchol vpravo; stejný vrchol představuje bod $L$ z dolní podstavy.','8.2 Bod $2$ je zadní horní vrchol vlevo; stejný vrchol představují body $A$ (horní podstava) a $B$ (levá stěna).','8.3 Bod $3$ je zadní dolní vrchol vlevo; stejný vrchol představují body $F$ a $K$.'},
  '8.1: $L$; 8.2: $A$, $B$; 8.3: $F$, $K$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží různoběžky $o$, $p$ a bod $A$ na přímce $p$ (viz obrázek).','9.1 Sestrojte bod $B$, který je obrazem bodu $A$ v osové souměrnosti s osou $o$.','9.2 Sestrojte přímku $q$, která je obrazem přímky $p$ v osové souměrnosti s osou $o$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif" font-size="15"> <line x1="40" y1="40" x2="420" y2="120" stroke="#000" stroke-width="2"/> <text x="428" y="126" font-style="italic">o</text> <line x1="40" y1="40" x2="330" y2="185" stroke="#000" stroke-width="2"/> <text x="338" y="194" font-style="italic">p</text> <line x1="289" y1="158" x2="284" y2="169" stroke="#000" stroke-width="2"/> <text x="272" y="180" text-anchor="end" font-style="italic">A</text> </svg>',
  'primky-op.svg',
  'Dvě různoběžné přímky o a p protínající se vlevo nahoře a bod A ležící na přímce p.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Bodem $A$ vedeme kolmici k ose $o$ a označíme patu kolmice $P$. Bod $B$ leží na této kolmici na opačné straně osy tak, že $|PB|=|AP|$.','9.2 Průsečík $S$ přímek $o$ a $p$ je samodružný bod. Obraz $q$ přímky $p$ je proto přímka procházející body $S$ a $B$.'},
  'Bod $B$ je obraz bodu $A$ v osové souměrnosti podle osy $o$ (leží na kolmici z $A$ k ose ve stejné vzdálenosti od osy); přímka $q$ prochází průsečíkem přímek $o$ a $p$ a bodem $B$ – viz obrázek v klíči.',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
