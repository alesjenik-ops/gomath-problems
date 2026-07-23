String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
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
  'CERMAT M7D 2023 - uloha 8 (konstrukce)',
  new List<String>{'V rovine lezi body $P$, $Q$, $R$ a primka $a$ (viz obrazek).','Na primce $a$ lezi strana $AB$ ctverce $ABCD$. Dva ze tri bodu $P$, $Q$, $R$ lezi uvnitr dvou ruznych stran tohoto ctverce a treti bod lezi vne ctverce $ABCD$.','Sestrojte vsechny vrcholy ctverce $ABCD$, oznacte je pismeny a ctverec narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 210" font-family="sans-serif"> <line x1="40" y1="150" x2="420" y2="178" stroke="#000" stroke-width="2"/> <text x="45" y="140" font-size="15" font-style="italic">a</text> <g font-size="14"><text x="246" y="86" font-style="italic">Q</text><text x="243" y="102">x</text> <text x="186" y="116" font-style="italic">P</text><text x="198" y="120">x</text> <text x="366" y="132" font-style="italic">R</text><text x="352" y="136">x</text></g> </svg>',
  'body-pqr-a.svg',
  'Primka a a tri body P, Q, R nad ni.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Strana $AB$ lezi na primce $a$, strany ctverce jsou k $a$ kolme, resp. rovnobezne. Dva z bodu $P$, $Q$, $R$ lezi na dvou ruznych stranach ctverce, treti vne. Sestrojenim kolmic k primce $a$ a prenesenim strany ctverce dostaneme vrcholy $A$, $B$, $C$, $D$. Uloha ma dve reseni ($A_1B_1C_1D_1$ a $A_2B_2C_2D_2$).'},
  'Konstrukce ctverce $ABCD$ se stranou $AB$ na primce $a$ (dva body na stranach, jeden vne); dve reseni (viz nakres v klici).',
  3, 8, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi primky $b$, $c$ a na primce $b$ lezi bod $A$ (viz obrazek).','Bod $A$ je vrchol trojuhelniku $ABC$ s pravym uhlem pri vrcholu $A$. Na primce $b$ lezi vrchol $B$ a na primce $c$ lezi vrchol $C$ tohoto trojuhelniku. Velikost vnitrniho uhlu trojuhelniku $ABC$ pri vrcholu $C$ je $40^\\circ$.','Sestrojte vrcholy $B$, $C$ trojuhelniku $ABC$, oznacte je pismeny a trojuhelnik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif"> <g stroke="#000" stroke-width="2"><line x1="55" y1="120" x2="410" y2="90"/><line x1="55" y1="135" x2="410" y2="215"/></g> <g font-size="15" font-style="italic"><text x="416" y="90">c</text><text x="416" y="216">b</text><text x="228" y="192">A</text></g> <line x1="238" y1="170" x2="242" y2="184" stroke="#000"/> </svg>',
  'primky-bc-a.svg',
  'Dve primky b a c; na primce b lezi bod A.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'V bode $A$ vztycime kolmici k primce $b$ (rameno $AC$ praveho uhlu). Vrchol $C$ je prusecik teto kolmice s primkou $c$. Vrchol $B$ lezi na primce $b$ tak, aby vnitrni uhel pri $C$ byl $40^\\circ$. Uloha ma dve reseni (vrcholy $B_1$, $B_2$).'},
  'Konstrukce pravouhleho trojuhelniku $ABC$ (pravy uhel pri $A$, uhel pri $C$ roven $40^\\circ$); dve reseni $B_1$, $B_2$ (viz nakres v klici).',
  3, 8, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
