String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
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
  'CERMAT M5A 2025 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $R$ a přímky $p$, $q$, které se protínají v bodě $A$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Na jedné z přímek $p$, $q$ leží vrchol $B$ a na druhé přímce vrchol $C$ tohoto obdélníku. Bodem $R$ prochází strana $BC$ obdélníku $ABCD$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" font-family="sans-serif"> <rect x="10" y="10" width="620" height="340" fill="none" stroke="#ccc"/> <line x1="70" y1="300" x2="610" y2="235" stroke="#000" stroke-width="2"/><text x="60" y="312" font-size="16" font-style="italic">p</text> <line x1="255" y1="345" x2="320" y2="60" stroke="#000" stroke-width="2"/><text x="318" y="58" font-size="16" font-style="italic">q</text> <text x="278" y="296" font-size="15" font-style="italic">A</text> <text x="360" y="176" font-size="15" font-style="italic">R</text><text x="357" y="190" font-size="15">×</text> </svg>',
  'primky-pq.svg',
  'Bod R a dvě různoběžné přímky p, q protínající se v bodě A.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Bod $A$ je průsečík přímek $p$, $q$. Strana $AB$ leží na jedné z přímek a strana $BC$ je na ni kolmá a prochází bodem $R$; bod $B$ je tedy pata kolmice spuštěné z bodu $R$ na tuto přímku. Průsečík této kolmice (přímky $BR$) s druhou přímkou je vrchol $C$. Vrchol $D$ doplníme tak, aby $ABCD$ byl obdélník.','Bod $B$ může ležet na přímce $p$, nebo na přímce $q$, proto úloha má dvě řešení.'},
  'Dvě řešení. $A$ je průsečík přímek $p$, $q$; $B$ je pata kolmice z bodu $R$ na jednu z přímek, $C$ je průsečík této kolmice s druhou přímkou, $D$ doplní obdélník $ABCD$ (viz náčrt v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2025 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží bod $S$ a různoběžné přímky $m$, $n$ (viz obrázek).','Na přímce $m$ leží strana $EF$ trojúhelníku $EFG$ a na přímce $n$ leží strana $EG$ tohoto trojúhelníku. Bod $S$ má od všech tří vrcholů trojúhelníku $EFG$ stejnou vzdálenost.','Sestrojte vrcholy trojúhelníku $EFG$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 360" font-family="sans-serif"> <rect x="10" y="10" width="620" height="340" fill="none" stroke="#ccc"/> <line x1="150" y1="290" x2="620" y2="110" stroke="#000" stroke-width="2"/><text x="158" y="300" font-size="16" font-style="italic">m</text> <line x1="150" y1="250" x2="600" y2="350" stroke="#000" stroke-width="2"/><text x="158" y="248" font-size="16" font-style="italic">n</text> <text x="405" y="156" font-size="15" font-style="italic">S</text><text x="402" y="170" font-size="15">×</text> </svg>',
  'primky-mn.svg',
  'Bod S a dvě různoběžné přímky m, n.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Bod $E$ je průsečík přímek $m$, $n$ (leží na obou stranách $EF$ i $EG$). Bod $S$ je stejně vzdálen od všech vrcholů, je to tedy střed kružnice opsané. Sestrojíme kružnici se středem $S$ a poloměrem $SE$; její druhý průsečík s přímkou $m$ je vrchol $F$ a druhý průsečík s přímkou $n$ je vrchol $G$. Trojúhelník $EFG$ narýsujeme.'},
  'Bod $E$ je průsečík přímek $m$, $n$; kružnice se středem $S$ a poloměrem $SE$ protne přímku $m$ v bodě $F$ a přímku $n$ v bodě $G$; trojúhelník $EFG$ (viz náčrt v klíči).',
  2, 5, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
