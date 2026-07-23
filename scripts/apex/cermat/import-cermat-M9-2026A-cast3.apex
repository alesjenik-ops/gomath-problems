String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD26C0T01';
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
  'CERMAT M9A 2026 – úloha 8',
  new List<String>{'Na obrázku je trojúhelník $ABC$. Přímka $o$ je osou jeho vnitřního úhlu při vrcholu $B$. Přímka $q$ prochází vrcholem $C$ a je kolmá ke straně $AB$ tohoto trojúhelníku. Na straně $AB$ leží střed $S$ kružnice $k$ opsané trojúhelníku $ABC$. Velikosti některých úhlů jsou uvedeny v obrázku.','Vypočtěte ve stupních velikost úhlu:','8.1 $\\varphi$,','8.2 $\\alpha$.','Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 300" font-family="sans-serif"> <circle cx="200" cy="160" r="120" fill="none" stroke="#000"/> <line x1="80" y1="160" x2="320" y2="160" stroke="#000"/> <line x1="80" y1="160" x2="108" y2="83" stroke="#000"/> <line x1="320" y1="160" x2="108" y2="83" stroke="#000"/> <line x1="108" y1="48" x2="108" y2="288" stroke="#000" stroke-dasharray="3 3"/> <line x1="44" y1="112" x2="320" y2="160" stroke="#000" stroke-dasharray="7 3 2 3"/> <rect x="108" y="150" width="10" height="10" fill="none" stroke="#000"/> <circle cx="200" cy="160" r="2.5" fill="#000"/> <text x="66" y="174" font-size="15" font-style="italic">A</text> <text x="326" y="170" font-size="15" font-style="italic">B</text> <text x="96" y="76" font-size="15" font-style="italic">C</text> <text x="196" y="180" font-size="14" font-style="italic">S</text> <text x="100" y="44" font-size="15" font-style="italic">q</text> <text x="300" y="96" font-size="15" font-style="italic">k</text> <text x="32" y="110" font-size="15" font-style="italic">o</text> <text x="130" y="122" font-size="13">100°</text> <text x="100" y="151" font-size="14">α</text> <text x="286" y="151" font-size="14">φ</text> </svg>',
  'kruznice-opsana.svg',
  'Trojúhelník ABC vepsaný do kružnice k se středem S na straně AB (průměr), přímka q kolmá k AB ve vrcholu C, osa o vnitřního úhlu při B, vyznačené úhly 100°, φ a α.',
  'Schematický nákres k úloze 8 (obrázek je pouze ilustrativní)',
  new List<String>{'Střed $S$ kružnice opsané leží na straně $AB$, proto je $AB$ průměr a podle Thaletovy věty $|\\angle ACB|=90^\\circ$. Přímka $q$ je kolmá ke straně $AB$.','8.1 Přímky $o$ a $q$ svírají úhel $100^\\circ$; protože $q\\perp AB$, svírá osa $o$ se stranou $AB$ úhel $\\varphi=100^\\circ-90^\\circ=10^\\circ$.','8.2 Osa $o$ půlí vnitřní úhel při vrcholu $B$, takže $|\\angle ABC|=2\\varphi=20^\\circ$. V pravoúhlém trojúhelníku pak $\\alpha=90^\\circ-20^\\circ=70^\\circ$.'},
  '8.1: $\\varphi=10^\\circ$; 8.2: $\\alpha=70^\\circ$',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží bod $A$ a přímky $b$, $c$ (viz obrázek).','Bod $A$ je vrchol trojúhelníku $ABC$. Strana $AB$ tohoto trojúhelníku je kolmá k přímce $b$ a vrchol $B$ leží na přímce $b$. Strana $BC$ je o $2$ cm delší než strana $AB$ a vrchol $C$ leží na přímce $c$.','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" font-family="sans-serif"> <line x1="30" y1="92" x2="372" y2="172" stroke="#000" stroke-width="2"/> <line x1="150" y1="272" x2="242" y2="40" stroke="#000" stroke-width="2"/> <text x="34" y="84" font-size="15" font-style="italic">c</text> <text x="246" y="46" font-size="15" font-style="italic">b</text> <text x="92" y="206" font-size="14" text-anchor="middle">×</text> <text x="92" y="224" font-size="14" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primky-bc.svg',
  'Bod A a dvě různoběžné přímky b a c.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrchol $B$ je pata kolmice spuštěné z bodu $A$ na přímku $b$ (protože $AB\\perp b$ a $B$ leží na $b$). Délka $|AB|$ je tím dána.','Vrchol $C$ leží na přímce $c$ a zároveň na kružnici se středem $B$ a poloměrem $|BC|=|AB|+2$ cm. Průsečíky této kružnice s přímkou $c$ dávají dvě řešení $C_1$, $C_2$.'},
  'Dvě řešení: $B$ je pata kolmice z bodu $A$ na přímku $b$; $C$ je průsečík přímky $c$ s kružnicí se středem $B$ a poloměrem $|AB|+2$ cm (body $C_1$, $C_2$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
