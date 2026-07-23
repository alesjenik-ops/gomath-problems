String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
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
  'CERMAT M7D 2024 – úloha 8 (konstrukce)',
  new List<String>{'Je dána přímka $p$ a bod $A$ ležící mimo přímku $p$ (viz obrázek).','Sestrojte rovnoramenný trojúhelník $ABC$ se základnou $BC$, pokud platí: Bod $C$ leží na přímce $r$ rovnoběžné s přímkou $p$ a procházející bodem $A$. Výška k základně měří $4$ cm. Průsečík výšky se stranou $BC$ leží na přímce $p$.','Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="240" x2="420" y2="120" stroke="#000" stroke-width="2"/> <text x="404" y="112" font-size="16" font-style="italic">p</text> <text x="205" y="150" font-size="15" font-style="italic" text-anchor="middle">A</text> <text x="205" y="166" font-size="15" text-anchor="middle">x</text> </svg>',
  'primka-p-bod-A.svg',
  'Šikmá přímka p a bod A ležící nad přímkou p.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bodem $A$ vedeme přímku $r$ rovnoběžnou s $p$ (na ní leží $C$). Pata výšky $X$ leží na $p$ a $|AX|=4$ cm, proto je $X$ průsečíkem kružnice $k(A;4\\text{ cm})$ s přímkou $p$ (dvě polohy $X$, $X\'$).','V bodě $X$ vztyčíme kolmici $q$ k úsečce $AX$; její průsečík s přímkou $r$ je vrchol $C$. Protože $X$ je střed základny $BC$, naneseme na kolmici $q$ na opačnou stranu od $C$ délku $|XB|=|XC|$ a získáme $B$.','Úloha má dvě řešení – trojúhelníky $ABC$ a $AB\'C\'$.'},
  'Dvě řešení: pata výšky $X$ je průsečík kružnice $k(A;4\\text{ cm})$ s přímkou $p$, vrchol $C$ leží na rovnoběžce $r$ s $p$ bodem $A$ a $X$ je střed $BC$; trojúhelníky $ABC$ a $AB\'C\'$ (viz náčrt v klíči).',
  4, 8, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 9 (konstrukce)',
  new List<String>{'Jsou dány body $A$ a $D$ (viz obrázek).','Sestrojte lichoběžník $ABCD$ se základnami $AB$ a $CD$, pokud platí: Délka strany $AB$ je stejná jako délka strany $AD$. Velikost vnitřního úhlu $DAB$ je $130^\\circ$. Poměr velikostí stran $AB:CD$ je $2:3$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"> <text x="150" y="118" font-size="15" font-style="italic" text-anchor="middle">D</text> <text x="150" y="134" font-size="15" text-anchor="middle">x</text> <text x="240" y="196" font-size="15" text-anchor="middle">x</text> <text x="240" y="214" font-size="15" font-style="italic" text-anchor="middle">A</text> </svg>',
  'body-A-D.svg',
  'Body A a D v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'U vrcholu $A$ sestrojíme úhel $DAB=130^\\circ$. Na jeho druhém rameni naneseme $|AB|=|AD|$ (kružnice $k_1(A;|AD|)$), čímž získáme vrchol $B$.','Základny jsou rovnoběžné, vedeme proto bodem $D$ přímku $p\\parallel AB$. Na ní leží vrchol $C$ tak, že $|CD|=\\frac{3}{2}|AB|$ (kružnice $k_2(D;\\frac{3}{2}|AB|)$).','Spojením vrcholů získáme lichoběžník $ABCD$. Úloha má i druhé, osově souměrné řešení (nebylo předmětem hodnocení).'},
  '$|AB|=|AD|$, $\\angle DAB=130^\\circ$, $CD\\parallel AB$ a $|CD|=\\frac{3}{2}|AB|$; lichoběžník $ABCD$ (viz náčrt v klíči).',
  3, 7, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 10',
  new List<String>{'Hotel zpoplatňuje ubytování stálou sazbou za osobu a noc. Ubytování pro $4$ lidi na $10$ nocí stojí $56\\,000$ Kč.','Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 Jeden člověk zaplatí za ubytování na $5$ nocí $7\\,000$ Kč.','10.2 Tři lidé zaplatí za ubytování na $8$ nocí $33\\,600$ Kč.','10.3 Dva lidé zaplatí za ubytování na $20$ nocí $54\\,000$ Kč.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Sazba za osobu a noc je $56\\,000:(4\\cdot 10)=1400$ Kč.','10.1 $1\\cdot 5\\cdot 1400=7000$ Kč → A.','10.2 $3\\cdot 8\\cdot 1400=33\\,600$ Kč → A.','10.3 $2\\cdot 20\\cdot 1400=56\\,000$ Kč, nikoli $54\\,000$ Kč → N.'},
  '10.1: A; 10.2: A; 10.3: N',
  3, 4, '2',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
