String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M5A 2023 – úloha 5',
  new List<String>{'Pro děti klubu SEN se letos otevřel pouze sportovní, divadelní a robotický kroužek. Každé dítě klubu SEN navštěvuje alespoň jeden z těchto tří kroužků – 3 děti navštěvují všechny tři kroužky, 8 dětí navštěvuje právě dva kroužky a ostatní děti jediný kroužek. Sportovní kroužek navštěvuje 14 dětí, divadelní 12 dětí a robotický 6 dětí.','5.1 Vypočtěte, kolik dětí klubu SEN navštěvuje pouze jeden kroužek.','5.2 Vypočtěte, kolik dětí je v klubu SEN.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Součet všech návštěvností je $14+12+6=32$. Dítě se třemi kroužky se v součtu počítá třikrát, se dvěma dvakrát a s jedním jednou: $32=3\\cdot 3+2\\cdot 8+x$, kde $x$ je počet dětí s jediným kroužkem.','5.1 $32=9+16+x$, tedy $x=7$ dětí navštěvuje pouze jeden kroužek.','5.2 V klubu je $x+8+3=7+8+3=18$ dětí.'},
  '5.1: $7$ dětí; 5.2: $18$ dětí',
  4, 5, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2023 – úloha 6',
  new List<String>{'Na odměny pro tři nejlepší soutěžící byla připravena finanční částka v korunách. První soutěžící získal polovinu této částky. Druhý soutěžící dostal 300 korun. Třetí soutěžící získal zbytek připravené částky, což bylo třikrát méně korun, než získal první soutěžící.','6.1 Vypočtěte, kolikrát více korun dostal druhý soutěžící než třetí soutěžící.','6.2 Vypočtěte, kolik korun bylo celkem připraveno na odměny.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celková částka je $C$. První dostal $\\tfrac{C}{2}$, třetí $\\tfrac{1}{3}\\cdot\\tfrac{C}{2}=\\tfrac{C}{6}$. Zbytek pro třetího: $C-\\tfrac{C}{2}-300=\\tfrac{C}{6}$, tedy $\\tfrac{C}{2}-\\tfrac{C}{6}=300$, $\\tfrac{C}{3}=300$, $C=900$.','6.2 Celkem bylo připraveno $900$ korun.','6.1 První $450$, třetí $150$, druhý $300$ korun; druhý dostal $300:150=2$krát více než třetí.'},
  '6.1: $2$krát více; 6.2: $900$ korun',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5A 2023 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $C$ a přímky $a$, $b$ (viz obrázek).','Bod $C$ je vrchol trojúhelníku $ABC$. Na přímce $a$ leží vrchol $A$ a na přímce $b$ vrchol $B$ tohoto trojúhelníku. Strana $AC$ trojúhelníku $ABC$ je rovnoběžná s přímkou $b$. Strany $AB$ a $AC$ mají stejnou délku.','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="150" y1="35" x2="120" y2="275" stroke="#000" stroke-width="2"/><text x="156" y="40" font-size="16" font-style="italic">a</text> <line x1="40" y1="255" x2="430" y2="175" stroke="#000" stroke-width="2"/><text x="436" y="176" font-size="16" font-style="italic">b</text> <text x="336" y="92" font-size="15" font-style="italic">C</text><text x="330" y="108" font-size="15">×</text> </svg>',
  'primky-C-ab.svg',
  'Bod C a dvě přímky a, b protínající se v levé části obrázku.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Protože $AC\\parallel b$, sestrojíme bodem $C$ rovnoběžku s přímkou $b$; její průsečík s přímkou $a$ je vrchol $A$. Vrchol $B$ leží na přímce $b$ ve vzdálenosti $|AB|=|AC|$ od bodu $A$: kružnice se středem $A$ a poloměrem $|AC|$ protne přímku $b$ ve dvou bodech $B_1$, $B_2$. Úloha má dvě řešení.'},
  'Dvě řešení: $A$ je průsečík přímky $a$ s rovnoběžkou s $b$ vedenou bodem $C$; $B_1$, $B_2$ leží na přímce $b$ a platí $|AB|=|AC|$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
