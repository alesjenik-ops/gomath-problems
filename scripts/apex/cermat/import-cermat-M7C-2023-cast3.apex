String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
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
  'CERMAT M7C 2023 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi primka $AB$ a primka $p$ prochazejici bodem $B$ (viz obrazek).','Usecka $AB$ je strana pravouhleho lichobezniku $ABCD$. Vrchol $C$ tohoto lichobezniku lezi na primce $p$, uhloprícka $AC$ ma stejnou delku jako strana $AB$ lichobezniku $ABCD$.','Sestrojte vrcholy $C$, $D$ lichobezniku $ABCD$, oznacte je pismeny a lichobeznik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 380" font-family="sans-serif"> <line x1="95" y1="345" x2="600" y2="130" stroke="#000" stroke-width="2"/> <line x1="330" y1="30" x2="620" y2="250" stroke="#000" stroke-width="2"/> <circle cx="160" cy="322" r="3" fill="#000"/><text x="150" y="342" font-size="15" font-style="italic">A</text> <line x1="152" y1="316" x2="168" y2="328" stroke="#000" stroke-width="1"/> <circle cx="518" cy="163" r="3" fill="#000"/><text x="524" y="158" font-size="15" font-style="italic">B</text> <text x="612" y="248" font-size="15" font-style="italic">p</text> </svg>',
  'primka-ab-p.svg',
  'Primka AB (s vyznacenym bodem A) a primka p prochazejici bodem B.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Vrchol $C$ lezi na primce $p$ a zaroven na kruznici se stredem $A$ a polomerem $|AB|$ (protoze $|AC|=|AB|$); tim je bod $C$ urcen. Vrchol $D$ doplnime tak, aby $ABCD$ byl pravouhly lichobeznik. Uloha ma dve reseni - lichobezniky s vrcholem $D_1$ a $D_2$ (viz nacrt v klici).'},
  'Konstrukce pravouhleho lichobezniku $ABCD$: $C$ je prusecik primky $p$ s kruznici se stredem $A$ a polomerem $|AB|$; dve reseni $D_1$, $D_2$ (viz nacrt v klici).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2023 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $A$, $C$ a primka $p$ prochazejici bodem $C$ (viz obrazek).','Usecka $AC$ je zakladna rovnoramenneho trojuhelniku $ABC$. Na primce $p$ lezi jedna ze tri vysek tohoto trojuhelniku.','9.1 Sestrojte osu soumernosti trojuhelniku $ABC$ a oznacte ji pismenem $o$.','9.2 Sestrojte vrchol $B$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif"> <line x1="140" y1="64" x2="350" y2="386" stroke="#000" stroke-width="2"/> <circle cx="170" cy="110" r="3" fill="#000"/><text x="150" y="112" font-size="15" font-style="italic">C</text> <line x1="185" y1="100" x2="197" y2="116" stroke="#000" stroke-width="1"/> <text x="242" y="298" font-size="15">x</text><text x="248" y="316" font-size="15" font-style="italic">A</text> <text x="352" y="384" font-size="15" font-style="italic">p</text> </svg>',
  'body-ac-p.svg',
  'Body A, C a primka p prochazejici bodem C.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'9.1 Osa soumernosti rovnoramenneho trojuhelniku se zakladnou $AC$ je osa $o$ usecky $AC$ (kolmice v jejim stredu).','9.2 Na primce $p$ (prochazejici bodem $C$) lezi vyska z vrcholu $C$, proto je $p\\perp AB$. Stranu $AB$ sestrojime jako kolmici k primce $p$ vedenou bodem $A$; vrchol $B$ je prusecik teto kolmice s osou $o$ (viz nacrt v klici).'},
  'Osa $o$ je osa usecky $AC$; vrchol $B$ je prusecik osy $o$ s kolmici k primce $p$ vedenou bodem $A$ (viz nacrt v klici).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
