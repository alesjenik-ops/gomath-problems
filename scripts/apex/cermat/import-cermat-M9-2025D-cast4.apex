String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD25C0T04';
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
  'CERMAT M9D 2025 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $L$, $M$ a přímka $p$ procházející bodem $M$ (viz obrázek).','Body $L$, $M$ jsou vrcholy rovnoběžníku $KLMN$. Na přímce $p$ leží střed $S$ souměrnosti tohoto rovnoběžníku. Délka strany $LM$ je stejná jako délka úhlopříčky $LN$.','Sestrojte střed $S$ a vrcholy $K$, $N$ rovnoběžníku $KLMN$, označte je písmeny a rovnoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <rect x="10" y="10" width="440" height="230" fill="none" stroke="#ccc"/> <line x1="55" y1="150" x2="410" y2="92" stroke="#000" stroke-width="1.8"/> <line x1="368" y1="96" x2="374" y2="110" stroke="#000" stroke-width="1.4"/> <text x="360" y="88" font-size="15" font-style="italic">M</text> <text x="418" y="98" font-size="15" font-style="italic">p</text> <text x="234" y="182" font-size="15">×</text><text x="231" y="200" font-size="15" font-style="italic">L</text> </svg>',
  'body-LM-primka-p.svg',
  'Body L a M a přímka p procházející bodem M.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Střed $S$ je střed obou úhlopříček, tedy střed úsečky $LN$; proto $|LN|=2|LS|$ a z podmínky $|LM|=|LN|$ plyne $|LS|=\\dfrac{|LM|}{2}$. Bod $S$ leží na přímce $p$ a zároveň na kružnici se středem $L$ a poloměrem $\\dfrac{|LM|}{2}$; to dává dvě polohy $S_1$, $S_2$ (dvě řešení).','Vrchol $N$ je obraz bodu $L$ ve středové souměrnosti se středem $S$ ($S$ je střed $LN$), vrchol $K$ je obraz bodu $M$ ($S$ je střed $KM$).'},
  'Dvě řešení: $S$ leží na přímce $p$ ve vzdálenosti $\\dfrac{|LM|}{2}$ od bodu $L$ ($S_1$, $S_2$); $N$ je obraz $L$ a $K$ obraz $M$ ve středové souměrnosti se středem $S$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 11',
  new List<String>{'Kružnice se středem $S$ prochází body $A$, $B$, $K$, $L$. Úsečky $AB$ a $KL$ se protínají v bodě $S$. V obrázku jsou vyznačeny velikosti některých úhlů (úhel při vrcholu $K$ je $64^\\circ$).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N). Velikosti úhlů neměřte, ale vypočtěte (obrázek je pouze ilustrativní).','11.1 $\\alpha>64^\\circ$','11.2 $\\alpha+\\beta>90^\\circ$','11.3 $\\gamma-\\alpha>\\delta$'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif"> <circle cx="230" cy="150" r="120" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="110" y1="150" x2="350" y2="150" stroke="#000" stroke-width="1.4"/> <line x1="185" y1="55" x2="275" y2="245" stroke="#000" stroke-width="1.4"/> <line x1="185" y1="55" x2="110" y2="150" stroke="#000" stroke-width="1.4"/> <line x1="185" y1="55" x2="350" y2="150" stroke="#000" stroke-width="1.4"/> <circle cx="230" cy="150" r="2.6" fill="#000"/> <text x="94" y="155" font-size="15" font-style="italic">A</text> <text x="356" y="155" font-size="15" font-style="italic">B</text> <text x="176" y="48" font-size="15" font-style="italic">K</text> <text x="280" y="260" font-size="15" font-style="italic">L</text> <text x="236" y="169" font-size="14" font-style="italic">S</text> <text x="192" y="83" font-size="12">64°</text> <text x="126" y="144" font-size="13">α</text> <text x="203" y="144" font-size="13">δ</text> <text x="250" y="144" font-size="13">γ</text> <text x="326" y="144" font-size="13">β</text> </svg>',
  'kruznice-uhly.svg',
  'Kružnice se středem S; průměry AB a KL se protínají v S; tětivy KA a KB, u vrcholu K úhel 64°, úhly alfa, beta, gama, delta.',
  'Schematický nákres (úhly neměřte)',
  new List<String>{'Úsečky $AB$ a $KL$ procházejí středem $S$, jsou to tedy průměry. Trojúhelník $AKB$ má nad průměrem $AB$ u vrcholu $K$ pravý úhel (Thaletova věta), takže $\\alpha+\\beta=90^\\circ$.','Trojúhelníky $ASK$ a $BSK$ jsou rovnoramenné ($SA=SK=SB$), proto $\\alpha=\\angle AKS$ a $\\beta=\\angle BKS$; z $\\angle AKS=64^\\circ$ plyne $\\alpha=64^\\circ$.','11.1 $\\alpha=64^\\circ$, není větší než $64^\\circ$ → N.','11.2 $\\alpha+\\beta=90^\\circ$, není větší než $90^\\circ$ → N.','11.3 $\\gamma=\\angle KSB=180^\\circ-2\\beta=2\\alpha=128^\\circ$, $\\delta=\\angle KSA=180^\\circ-2\\alpha=52^\\circ$; $\\gamma-\\alpha=64^\\circ>\\delta=52^\\circ$ → A.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
