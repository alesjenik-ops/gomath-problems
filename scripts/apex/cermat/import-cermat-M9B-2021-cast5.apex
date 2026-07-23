String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
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
  'CERMAT M9B 2021 – úloha 10',
  new List<String>{'V rovině leží tři různé body $A$, $M$, $N$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$. Bod $M$ leží uvnitř strany $AB$, bod $N$ uvnitř strany $AD$ a výška na stranu $AB$ měří $5$ cm. Vrchol $D$ má od vrcholů $A$ i $B$ stejnou vzdálenost, tedy $|BD|=|AD|$.','Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 440" font-family="sans-serif"> <line x1="290" y1="185" x2="310" y2="205" stroke="#000" stroke-width="2"/> <line x1="310" y1="185" x2="290" y2="205" stroke="#000" stroke-width="2"/> <text x="296" y="228" font-size="15" font-style="italic">N</text> <line x1="450" y1="305" x2="470" y2="325" stroke="#000" stroke-width="2"/> <line x1="470" y1="305" x2="450" y2="325" stroke="#000" stroke-width="2"/> <text x="456" y="348" font-size="15" font-style="italic">M</text> <line x1="170" y1="385" x2="190" y2="405" stroke="#000" stroke-width="2"/> <line x1="190" y1="385" x2="170" y2="405" stroke="#000" stroke-width="2"/> <text x="176" y="428" font-size="15" font-style="italic">A</text> </svg>',
  'body-AMN.svg',
  'Tři body A, M, N vyznačené křížky; A vlevo dole, N nahoře, M vpravo uprostřed.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Přímka strany $AB$ prochází body $A$, $M$; přímka strany $AD$ prochází body $A$, $N$. Vrchol $D$ je průsečík polopřímky $AN$ s rovnoběžkou s přímkou $AB$ vzdálenou $5$ cm (výška na $AB$); tím je dána délka $|AD|$. Vrchol $B$ leží na polopřímce $AM$ ve vzdálenosti $|BD|=|AD|$ od $D$ (druhý průsečík kružnice se středem $D$ a poloměrem $|AD|$ s přímkou $AB$). Vrchol $C$ doplníme tak, aby $ABCD$ byl rovnoběžník ($|BC|=|AD|$, $BC\\parallel AD$).'},
  'Konstrukce rovnoběžníku $ABCD$: $D$ je průsečík polopřímky $AN$ s rovnoběžkou s $AB$ ve vzdálenosti $5$ cm, $B$ leží na polopřímce $AM$ tak, že $|BD|=|AD|$, vrchol $C$ doplňuje rovnoběžník – viz obrázek v klíči.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2021 – úloha 11',
  new List<String>{'V knihovně je $480$ knih psaných česky, zbývajících $40\\,\\%$ knih je cizojazyčných. Z cizojazyčných knih je jedna osmina psána německy a ostatní anglicky.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 V knihovně je méně než $300$ cizojazyčných knih.','11.2 V knihovně tvoří německy psané knihy $5\\,\\%$ všech knih.','11.3 V knihovně je $280$ knih psaných anglicky.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'České knihy tvoří $60\\,\\%$, tedy $480$ knih $=60\\,\\%$ a všech knih je $480:0{,}6=800$. Cizojazyčných je $40\\,\\%$, tj. $320$; z nich německy $320:8=40$ a anglicky $320-40=280$.','11.1 Cizojazyčných je $320$, což není méně než $300$ → N.','11.2 Německy: $\\frac{40}{800}=5\\,\\%$ → A.','11.3 Anglicky psaných je $280$ → A.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','procenta','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
