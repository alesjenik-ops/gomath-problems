String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
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
  'CERMAT M7C 2026 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož strany $AC$ a $BC$ mají stejnou délku. Bod $S$ je střed strany $AC$ a na přímce $p$ leží střed $P$ strany $BC$ trojúhelníku $ABC$.','Sestrojte vrchol $C$, střed $P$ a vrchol $B$, označte je písmeny a narýsujte trojúhelník $ABC$. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 360" font-family="sans-serif" font-size="16"> <line x1="60" y1="320" x2="580" y2="120" stroke="#000" stroke-width="2"/> <text x="588" y="115" font-style="italic">p</text> <text x="146" y="290" text-anchor="middle">×</text> <text x="140" y="278" font-style="italic">A</text> <text x="300" y="210" text-anchor="middle">×</text> <text x="296" y="198" font-style="italic">S</text> </svg>',
  'body-AS-primka-p.svg',
  'Body A a S a přímka p procházející bodem A.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bod $C$ je souměrný s bodem $A$ podle středu $S$ (protože $S$ je střed $AC$): leží na polopřímce $AS$ tak, že $|SC|=|AS|$; tím je určen jednoznačně a $|AC|=2\\,|AS|$.','Protože $|BC|=|AC|$ a $P$ je střed $BC$, platí $|CP|=\\tfrac{1}{2}|AC|$. Kružnice se středem $C$ a poloměrem $\\tfrac{1}{2}|AC|$ protne přímku $p$ ve dvou bodech $P_1$, $P_2$ (dvě polohy středu $P$).','Vrchol $B$ je souměrný s bodem $C$ podle bodu $P$. Dostáváme dvě řešení – trojúhelníky $ABC$ s vrcholy $B_1$ a $B_2$.'},
  'Dvě řešení. $C$ je obraz bodu $A$ ve středové souměrnosti se středem $S$; střed $P$ je průsečík přímky $p$ s kružnicí se středem $C$ a poloměrem $\\tfrac{1}{2}|AC|$ (polohy $P_1$, $P_2$); $B$ je obraz $C$ podle středu $P$ (viz náčrt v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2026 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $U$, $V$ a přímka $k$ (viz obrázek).','Bod $U$ leží uvnitř strany $KN$ obdélníku $KLMN$. Na přímce $k$ leží strana $KL$ tohoto obdélníku. Bod $V$ má stejnou vzdálenost od všech čtyř vrcholů obdélníku $KLMN$.','Sestrojte všechny vrcholy obdélníku $KLMN$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 340" font-family="sans-serif" font-size="16"> <line x1="70" y1="300" x2="600" y2="240" stroke="#000" stroke-width="2"/> <text x="606" y="238" font-style="italic">k</text> <text x="190" y="222" text-anchor="middle">×</text> <text x="185" y="208" font-style="italic">U</text> <text x="350" y="217" text-anchor="middle">×</text> <text x="345" y="203" font-style="italic">V</text> </svg>',
  'body-UV-primka-k.svg',
  'Body U a V a přímka k.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Strana $KN$ je kolmá ke straně $KL$, která leží na přímce $k$, a bod $U$ leží na $KN$. Vrchol $K$ je proto pata kolmice spuštěné z bodu $U$ na přímku $k$.','Bod $V$ má stejnou vzdálenost od všech vrcholů, je tedy středem obdélníku (průsečíkem úhlopříček). Vrchol $M$ je souměrný s $K$ podle středu $V$.','Kružnice se středem $V$ procházející bodem $K$ protne přímku $k$ ještě ve vrcholu $L$; vrchol $N$ je souměrný s $L$ podle středu $V$. Nakonec narýsujeme obdélník $KLMN$.'},
  '$K$ je pata kolmice z $U$ na přímku $k$; $V$ je střed obdélníku, takže $M$ je obraz $K$ podle $V$; $L$ je druhý průsečík kružnice se středem $V$ a poloměrem $|VK|$ s přímkou $k$ a $N$ je obraz $L$ podle $V$ (viz náčrt v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
