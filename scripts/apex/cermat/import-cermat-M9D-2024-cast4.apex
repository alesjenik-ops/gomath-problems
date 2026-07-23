String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
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
  'CERMAT M9D 2024 – úloha 9 (konstrukce)',
  new List<String>{'V rovině je dána přímka $p$ a body $A$ a $S$, které neleží na přímce $p$. Bod $A$ je vrchol obdélníku $ABCD$, bod $S$ je střed obdélníku (průsečík úhlopříček). Vrchol $D$ obdélníku leží na přímce $p$.','Sestrojte obdélník $ABCD$. Nalezněte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <line x1="60" y1="150" x2="410" y2="120" stroke="#000" stroke-width="2"/> <text x="120" y="132" font-size="16" font-style="italic">p</text> <text x="248" y="176" font-size="15" font-style="italic">S</text> <text x="243" y="192" font-size="15">×</text> <text x="170" y="206" font-size="15" font-style="italic">A</text> <text x="184" y="210" font-size="15">×</text> </svg>',
  'obdelnik-p-A-S.svg',
  'Primka p a dva body A a S, ktere na ni nelezi.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrchol $C$ je souměrný s bodem $A$ podle středu $S$: sestrojíme polopřímku $AS$ a kružnici $k(S;|SA|)$; druhý průsečík polopřímky $AS$ s $k$ je bod $C$. Kružnice $k$ je Thaletova kružnice nad úhlopříčkou $AC$, proto vrchol $D$ leží na $k$ a zároveň na přímce $p$; průsečíky $k$ a $p$ dají dvě polohy $D_1$, $D_2$. Vrchol $B$ je obraz $D$ ve středové souměrnosti podle $S$. Vzniknou obdélníky $AB_1CD_1$ a $AB_2CD_2$.'},
  'Dvě řešení: $C$ je obraz $A$ ve středové souměrnosti podle $S$; $k(S;|SA|)$ je Thaletova kružnice, její průsečíky s přímkou $p$ jsou $D_1$, $D_2$; $B$ je obraz $D$ podle $S$. Obdélníky $AB_1CD_1$ a $AB_2CD_2$ (viz náčrt v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $C$, $S$ a přímka $p$. Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$. Bod $S$ je střed strany $BC$ tohoto trojúhelníku. Strana $AB$ tohoto trojúhelníku je rovnoběžná s přímkou $p$.','Sestrojte pravoúhlý trojúhelník $ABC$. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="120" y1="272" x2="420" y2="170" stroke="#000" stroke-width="2"/> <text x="425" y="168" font-size="16" font-style="italic">p</text> <text x="138" y="118" font-size="15" font-style="italic">C</text> <text x="140" y="132" font-size="15">×</text> <text x="258" y="150" font-size="15" font-style="italic">S</text> <text x="252" y="164" font-size="15">×</text> </svg>',
  'trojuhelnik-C-S-p.svg',
  'Body C a S a primka p v rovine.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Bod $B$ je souměrný s $C$ podle středu $S$: sestrojíme polopřímku $CS$ a kružnici $k(S;|CS|)$; druhý průsečík polopřímky $CS$ s $k$ je bod $B$. Bodem $B$ vedeme rovnoběžku $p^\\prime$ s přímkou $p$ (na ní leží vrchol $A$, neboť $AB\\parallel p$). Pravý úhel může být u vrcholu $A$: kolmice z $C$ k $p^\\prime$ ji protne v bodě $A_1$. Nebo je pravý úhel u vrcholu $C$: kolmice k $CS$ v bodě $C$ protne $p^\\prime$ v bodě $A_2$. Vzniknou trojúhelníky $A_1BC$ a $A_2BC$.'},
  'Dvě řešení: $B$ je obraz $C$ podle $S$, $A$ leží na rovnoběžce s $p$ vedené bodem $B$; pravý úhel u $A$ ($A_1$ je pata kolmice z $C$) nebo u $C$ ($A_2$ na kolmici k $CS$ v bodě $C$). Trojúhelníky $A_1BC$ a $A_2BC$ (viz náčrt v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 11',
  new List<String>{'V obchodě prodávají dámská a pánská trička. Ráno před začátkem otevírací doby tvořila dámská trička $60\\,\\%$ z celkového naskladněného množství triček, zbytek byla trička pánská. Přes den se prodalo $45$ dámských triček, což je čtvrtina všech dámských triček naskladněných ten den ráno. Pánských triček se ze všech naskladněných pánských triček prodala polovina.','Kolik zůstalo na konci dne v obchodě triček (dámských i pánských dohromady)?'},
  new List<String>{'A) méně než $200$','B) $200$','C) $210$','D) $220$','E) více než $220$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'$45$ je čtvrtina dámských triček, dámských tedy bylo $180$. To je $60\\,\\%$ celku, celkem $180:0{,}6=300$ triček, z toho pánských $120$. Prodáno: dámských $45$, pánských $\\frac{120}{2}=60$. Zůstalo dámských $180-45=135$ a pánských $120-60=60$, celkem $195$ triček (méně než $200$).'},
  'A) méně než $200$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
