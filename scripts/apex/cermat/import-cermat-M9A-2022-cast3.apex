String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
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
  'CERMAT M9A 2022 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $C$, $S$ a přímka $q$ (viz obrázek).','Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Bod $S$ je střed jednoho ramene tohoto trojúhelníku a na přímce $q$ leží jeden z vrcholů $A$, $B$.','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="60" y1="110" x2="400" y2="110" stroke="#000" stroke-width="2"/> <text x="408" y="115" font-size="16" font-style="italic">q</text> <text x="236" y="180" font-size="18" text-anchor="middle">×</text> <text x="248" y="172" font-size="15" font-style="italic">S</text> <text x="200" y="286" font-size="18" text-anchor="middle">×</text> <text x="206" y="300" font-size="15" font-style="italic">C</text> </svg>',
  'body-CSq.svg',
  'Body C a S a přímka q v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Bod $P$, obraz vrcholu $C$ ve středové souměrnosti se středem $S$ (tj. $S$ je střed úsečky $CP$), je koncovým bodem ramene, a je proto jedním z vrcholů základny (v klíči $A_1=B_2$). Kružnice se středem $C$ a poloměrem $|CP|=2|CS|$ protne přímku $q$ ve dvou bodech; ty spolu s $P$ určují dvě rovnoramenná řešení $A_1B_1C$ a $A_2B_2C$ (v každém je jeden vrchol základny na $q$).'},
  'Dvě řešení. Bod $P$ (v klíči $A_1=B_2$) je obraz $C$ ve středové souměrnosti podle $S$; kružnice se středem $C$ a poloměrem $|CP|=2|CS|$ protne přímku $q$ v bodech $B_1$ a $A_2$. Trojúhelníky $A_1B_1C$ a $A_2B_2C$ – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží bod $O$ a přímka $p$ (viz obrázek).','Bod $O$ je střed čtverce $ABCD$, jehož strana $BC$ leží na přímce $p$.','Sestrojte všechny vrcholy čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <line x1="250" y1="80" x2="405" y2="245" stroke="#000" stroke-width="2"/> <text x="410" y="252" font-size="16" font-style="italic">p</text> <text x="196" y="200" font-size="18" text-anchor="middle">×</text> <text x="182" y="212" font-size="15" font-style="italic">O</text> </svg>',
  'bod-O-p.svg',
  'Bod O a přímka p v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Vzdálenost středu $O$ od přímky $p$ je polovina strany čtverce. Sestrojíme patu kolmice z $O$ na $p$ (střed strany $BC$, v klíči $S_{BC}$); na přímce $p$ od ní naneseme na obě strany polovinu strany, čímž dostaneme $B$ a $C$ ($|BC|=2\\cdot|Op|$). Vrcholy $A$ a $D$ jsou obrazy $B$ a $C$ ve středové souměrnosti se středem $O$.'},
  'Střed strany $BC$ je pata kolmice z $O$ na $p$; $|BC|=2\\cdot|Op|$ a vrcholy $A$, $D$ jsou obrazy $B$, $C$ ve středové souměrnosti podle $O$ – viz obrázek v klíči.',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 11',
  new List<String>{'Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Tři čtvrtiny z $200$ minut je totéž jako polovina ze $3$ hodin.','11.2 Dvě třetiny z $2{,}4$ hodiny je více než $1$ hodina a $40$ minut.','11.3 Tři osminy z $5$ dnů je totéž jako pět osmin ze $3$ dnů.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'11.1 $\\dfrac{3}{4}\\cdot 200=150$ min; polovina ze $3$ hodin $=90$ min; $150\\ne 90$ → N.','11.2 $\\dfrac{2}{3}\\cdot 2{,}4=1{,}6$ hodiny $=1$ h $36$ min, což je méně než $1$ h $40$ min → N.','11.3 $\\dfrac{3}{8}\\cdot 5=\\dfrac{15}{8}$ dne a $\\dfrac{5}{8}\\cdot 3=\\dfrac{15}{8}$ dne; jsou stejné → A.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 4, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
