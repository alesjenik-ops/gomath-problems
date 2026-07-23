String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
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
  'CERMAT M5B 2021 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží polopřímka $PX$ a bod $S$ (viz obrázek).','Bod $S$ je střed jedné strany obdélníku $ABCD$. Na polopřímce $PX$ leží strana $AB$ tohoto obdélníku a její délka je dvakrát větší než délka sousední strany $BC$.','Sestrojte vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <line x1="40" y1="120" x2="430" y2="188" stroke="#000" stroke-width="2"/> <line x1="40" y1="111" x2="40" y2="129" stroke="#000" stroke-width="2"/> <text x="28" y="142" font-size="16" font-style="italic">P</text> <line x1="322" y1="140" x2="332" y2="160" stroke="#000" stroke-width="2"/> <text x="322" y="178" font-size="16" font-style="italic">X</text> <text x="216" y="62" font-size="16" font-style="italic">S</text> <text x="211" y="80" font-size="16">×</text> </svg>',
  'poloprimka-S.svg',
  'Polopřímka PX a bod S ležící nad ní.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Bod $S$ je střed jedné strany obdélníku a platí $|AB|=2\\cdot|BC|$. Úloha má dvě řešení podle toho, které strany je $S$ středem; sestrojí se dva obdélníky $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na polopřímce $PX$ (viz obrázek v klíči).'},
  'Dvě řešení – obdélníky $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na polopřímce $PX$, $|AB|=2\\cdot|BC|$, bod $S$ střed jedné strany (viz obrázek v klíči).',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2021 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a úsečka $AB$ (viz obrázek).','Úsečka $AB$ tvoří jednu stranu rovnostranného trojúhelníku $ABC$. Vrchol $C$ trojúhelníku $ABC$ je současně vrcholem trojúhelníku $CDE$. Strany $CD$ a $CE$ trojúhelníku $CDE$ mají stejnou délku jako úsečka $AB$. Strana $DE$ leží na přímce $p$.','Sestrojte vrcholy $C$, $D$, $E$ trojúhelníku $CDE$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 275" font-family="sans-serif"> <line x1="70" y1="70" x2="410" y2="150" stroke="#000" stroke-width="2"/> <text x="418" y="156" font-size="16" font-style="italic">p</text> <line x1="110" y1="240" x2="360" y2="240" stroke="#000" stroke-width="2"/> <line x1="180" y1="233" x2="180" y2="247" stroke="#000" stroke-width="2"/> <text x="176" y="266" font-size="16" font-style="italic">A</text> <line x1="290" y1="233" x2="290" y2="247" stroke="#000" stroke-width="2"/> <text x="286" y="266" font-size="16" font-style="italic">B</text> </svg>',
  'primka-AB.svg',
  'Přímka p a pod ní úsečka AB s krajními body A a B.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Sestrojíme rovnostranný trojúhelník $ABC$ (vrchol $C$ jako průsečík oblouků o poloměru $|AB|$ se středy $A$ a $B$). Z bodu $C$ narýsujeme kružnici o poloměru $|AB|$; její průsečíky s přímkou $p$ jsou body $D$ a $E$. Trojúhelník $CDE$ je rovnoramenný s $|CD|=|CE|=|AB|$ a stranou $DE$ na přímce $p$.'},
  'Konstrukce: rovnostranný trojúhelník $ABC$, poté $D$, $E$ jako průsečíky kružnice se středem $C$ a poloměrem $|AB|$ s přímkou $p$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
