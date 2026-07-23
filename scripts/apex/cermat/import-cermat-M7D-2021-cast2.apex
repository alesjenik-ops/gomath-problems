String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD21C0T04';
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
  'CERMAT M7D 2021 – úloha 6',
  new List<String>{'V bílé krabičce jsou jen bílé kuličky, v zelené jen zelené a v modré jen modré. Bílých kuliček je $12$ a modrých $60$. Do bílé krabičky přendáme ze zelené a modré krabičky tolik kuliček, aby byl ve všech třech krabičkách stejný počet kuliček. Ze zelené krabičky musíme přendat o $9$ kuliček více než z modré.','6.1 Určete počet všech zelených kuliček.','6.2 Vypočtěte, kolik kuliček zůstane v modré krabičce.','6.3 Vypočtěte, kolik zelených kuliček přendáme do bílé krabičky.','Ve všech částech úlohy uveďte postup řešení.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem je kuliček $12+G+60=72+G$; po přerovnání je v každé krabičce $\\frac{72+G}{3}$.','6.1 Ze zelené přendáme $G-\\frac{72+G}{3}$, z modré $60-\\frac{72+G}{3}$; jejich rozdíl je $G-60=9$, tedy $G=69$ zelených kuliček.','6.2 V každé krabičce bude $\\frac{72+69}{3}=47$; v modré zůstane $47$ kuliček.','6.3 Ze zelené přendáme $69-47=22$ zelených kuliček (z modré $60-47=13$; rozdíl $9$).'},
  '6.1: $69$ zelených kuliček; 6.2: $47$ kuliček; 6.3: $22$ zelených kuliček',
  4, 6, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 7',
  new List<String>{'V pravoúhlém lichoběžníku $ABCD$ s pravým úhlem při vrcholu $A$ má základna $AB$ délku $15$ cm. Platí $|AB|:|CD|=3:2$ a $|AD|:|CD|=6:5$.','Vypočtěte','7.1 v cm délku strany $AD$,','7.2 v cm² obsah lichoběžníku $ABCD$.','V obou částech úlohy uveďte postup řešení.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 232" font-family="sans-serif"> <polygon points="45,190 265,190 175,70 45,70" fill="none" stroke="#000" stroke-width="2"/> <rect x="45" y="176" width="14" height="14" fill="none" stroke="#000" stroke-width="1"/> <text x="33" y="66" font-size="15" font-weight="bold">D</text> <text x="179" y="66" font-size="15" font-weight="bold">C</text> <text x="31" y="204" font-size="15" font-weight="bold">A</text> <text x="270" y="204" font-size="15" font-weight="bold">B</text> <text x="150" y="207" font-size="12" text-anchor="middle">15 cm</text> </svg>',
  'lichobeznik.svg',
  'Pravoúhlý lichoběžník ABCD s pravým úhlem u vrcholu A, dole základna AB = 15 cm, nahoře kratší základna CD.',
  'Pravoúhlý lichoběžník ABCD',
  new List<String>{'Z $|AB|:|CD|=3:2$ a $|AB|=15$ cm je $|CD|=15\\cdot\\frac{2}{3}=10$ cm.','7.1 Z $|AD|:|CD|=6:5$ je $|AD|=10\\cdot\\frac{6}{5}=12$ cm.','7.2 Výška lichoběžníku je $|AD|=12$ cm (pravý úhel u $A$). Obsah $S=\\frac{|AB|+|CD|}{2}\\cdot|AD|=\\frac{15+10}{2}\\cdot 12=150$ cm².'},
  '7.1: $|AD|=12$ cm; 7.2: $S=150$ cm²',
  3, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2021 – úloha 8',
  new List<String>{'V rovině leží úsečka $LM$ a bod $U$ (viz obrázek).','Úsečka $LM$ je strana rovnoramenného trojúhelníku $KLM$. V tomto trojúhelníku je každé z obou ramen dvakrát delší než základna. Bod $U$ leží uvnitř trojúhelníku $KLM$.','Sestrojte vrchol $K$ trojúhelníku $KLM$, označte jej písmenem a trojúhelník narýsujte. Najděte všechna $3$ řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 300" font-family="sans-serif"> <line x1="255" y1="55" x2="300" y2="240" stroke="#000" stroke-width="2"/> <line x1="248" y1="49" x2="262" y2="61" stroke="#000" stroke-width="2"/> <line x1="293" y1="234" x2="307" y2="246" stroke="#000" stroke-width="2"/> <text x="266" y="52" font-size="15" font-style="italic">M</text> <text x="312" y="246" font-size="15" font-style="italic">L</text> <text x="196" y="151" font-size="14">×</text> <text x="192" y="168" font-size="15" font-style="italic">U</text> </svg>',
  'usecka-LM-U.svg',
  'Úsečka LM (bod M nahoře, bod L dole) a bod U ležící vlevo od úsečky.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Úsečka $LM$ může být buď základna (pak $|KL|=|KM|=2|LM|$ a $K$ leží na ose úsečky $LM$), nebo rameno (pak druhé rameno je shodné s $LM$ a základna je poloviční). Z těchto poloh vyhovují tři, u nichž bod $U$ leží uvnitř trojúhelníku — vrcholy $K_1$, $K_2$, $K_3$.'},
  'Tři polohy vrcholu $K$ ($K_1$, $K_2$, $K_3$) rovnoramenného trojúhelníku $KLM$ s ramenem dvakrát delším než základna a s bodem $U$ uvnitř — viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
