String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M5A 2019 – úloha 6',
  new List<String>{'Adéla dostala několik stejných papírových proužků tvaru obdélníku. Každý z nich beze zbytku rozstříhala na $8$ stejných čtverečků (viz obrázek).','Adéla z nastříhaných čtverečků sestavovala větší čtverce. Největší čtverec, který bylo možné z nastříhaných čtverečků sestavit, měl v každé řadě $5$ čtverečků. Adéla takový čtverec sestavila a ještě několik čtverečků jí zbylo. Obvod největšího sestaveného čtverce byl $40$ cm.','6.1 Určete, kolik papírových proužků Adéla dostala.','6.2 Určete, kolik čtverečků Adéle zbylo po sestavení největšího čtverce.','6.3 Vypočtěte v cm obvod jednoho papírového proužku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 110" font-family="sans-serif"><text x="200" y="30" font-size="14" text-anchor="middle">Papírový proužek</text><rect x="40" y="45" width="320" height="40" fill="none" stroke="#000" stroke-width="2"/><line x1="80" y1="45" x2="80" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="120" y1="45" x2="120" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="160" y1="45" x2="160" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="200" y1="45" x2="200" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="240" y1="45" x2="240" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="280" y1="45" x2="280" y2="85" stroke="#000" stroke-dasharray="3 3"/><line x1="320" y1="45" x2="320" y2="85" stroke="#000" stroke-dasharray="3 3"/></svg>',
  'prouzek.svg',
  'Papírový proužek tvaru obdélníku rozdělený na osm stejných čtverečků v jedné řadě.',
  'Papírový proužek rozdělený na 8 čtverečků',
  new List<String>{'6.1 Největší čtverec má $5\\cdot 5=25$ čtverečků. Celkový počet čtverečků je násobek osmi; jediný násobek osmi mezi $25$ a $35$ (méně než $6\\cdot 6=36$) je $32$, tedy proužků bylo $32:8=4$.','6.2 Zbylo $32-25=7$ čtverečků.','6.3 Obvod čtverce je $40$ cm, jeho strana $40:4=10$ cm; protože má v řadě $5$ čtverečků, má čtvereček stranu $10:5=2$ cm. Proužek je $1\\times 8$ čtverečků, tj. obdélník $2$ cm $\\times 16$ cm, a jeho obvod je $2\\cdot(2+16)=36$ cm.'},
  '6.1: $4$ proužky; 6.2: $7$ čtverečků; 6.3: $36$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2019 – úloha 7.1 (konstrukce)',
  new List<String>{'Uvnitř kružnice $k$ se středem $S$ leží body $A$, $L$. Kružnici $k$ protíná přímka $c$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Strana $CD$ leží na přímce $c$. Vrchol $B$ leží na kružnici $k$.','Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 400" font-family="sans-serif"><circle cx="235" cy="215" r="150" fill="none" stroke="#000" stroke-width="2"/><line x1="45" y1="150" x2="450" y2="95" stroke="#000" stroke-width="2"/><text x="452" y="94" font-size="16" font-style="italic">c</text><text x="392" y="330" font-size="16" font-style="italic">k</text><text x="190" y="180" font-size="16" text-anchor="middle">×</text><text x="176" y="176" font-size="15" font-style="italic">A</text><text x="248" y="210" font-size="16" text-anchor="middle">×</text><text x="236" y="226" font-size="15" font-style="italic">S</text><text x="192" y="275" font-size="16" text-anchor="middle">×</text><text x="178" y="272" font-size="15" font-style="italic">L</text></svg>',
  'kruznice-k.svg',
  'Kružnice k se středem S, uvnitř body A a L, přímka c protínající kružnici v horní části.',
  'Výchozí obrázek k úloze 7 (kružnice k, body A, L, přímka c)',
  new List<String>{'Strana $CD$ leží na přímce $c$ a v obdélníku je $AD\\perp CD$, proto vrchol $D$ je pata kolmice z bodu $A$ na přímku $c$. Strana $AB$ je rovnoběžná s $c$; vrchol $B$ je průsečík rovnoběžky s $c$ vedené bodem $A$ s kružnicí $k$ (dva průsečíky $B_1$, $B_2$). Vrchol $C$ je pata kolmice z $B$ na přímku $c$. Úloha má dvě řešení.'},
  'Dvě řešení: $D$ je pata kolmice z $A$ na přímku $c$, vrchol $B$ leží na kružnici $k$ na rovnoběžce s $c$ procházející bodem $A$ (polohy $B_1$, $B_2$), $C$ je pata kolmice z $B$ na $c$ – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
