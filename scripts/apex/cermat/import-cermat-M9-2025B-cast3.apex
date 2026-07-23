String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD25C0T02';
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
  'CERMAT M9B 2025 - uloha 9 (konstrukce)',
  new List<String>{'V rovine lezi body $A$, $B$, $M$ (viz obrazek).','Body $A$, $B$ jsou vrcholy rovnoramenneho trojuhelniku $ABC$. Bod $M$ je uvnitr tohoto trojuhelniku a lezi na teznici $t_c$ na stranu $AB$. (Bod $M$ neni tezistem trojuhelniku $ABC$.)','Sestrojte vrchol $C$ trojuhelniku $ABC$, oznacte ho pismenem a trojuhelnik narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 240" font-family="sans-serif"> <rect x="10" y="10" width="340" height="220" fill="none" stroke="#ccc"/> <text x="188" y="112" font-size="15" text-anchor="middle">x</text> <text x="188" y="100" font-size="14" text-anchor="middle" font-style="italic">M</text> <text x="96" y="182" font-size="15" text-anchor="middle">x</text> <text x="96" y="196" font-size="14" text-anchor="middle" font-style="italic">A</text> <text x="256" y="172" font-size="15" text-anchor="middle">x</text> <text x="256" y="186" font-size="14" text-anchor="middle" font-style="italic">B</text> </svg>',
  'body-ABM.svg',
  'Body A, B a M v rovine; M lezi nad useckou AB.',
  'Vychozi obrazek k uloze 9',
  new List<String>{'Teznice $t_c$ spojuje stred $S$ strany $AB$ s vrcholem $C$; protoze na ni lezi bod $M$, sestrojime primku $l$ prochazejici stredem $S$ usecky $AB$ a bodem $M$ - na ni lezi hledany vrchol $C$. Trojuhelnik je rovnoramenny s ramenem $AB$: bud $|AC|=|AB|$ (vrchol $C_1$ jako prusecik primky $l$ s kruznici se stredem $A$ a polomerem $|AB|$), nebo $|BC|=|AB|$ (vrchol $C_2$ jako prusecik primky $l$ s kruznici se stredem $B$ a polomerem $|AB|$). Uloha ma dve reseni.'},
  'Dve reseni: stred $S$ usecky $AB$, primka $l=SM$ nese vrchol $C$; $C_1$ na kruznici $(A;|AB|)$, $C_2$ na kruznici $(B;|AB|)$ - viz obrazek v klici.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 10 (konstrukce)',
  new List<String>{'V rovine lezi body $A$, $D$, $M$ (viz obrazek).','Body $A$, $D$ jsou vrcholy rovnobezniku $ABCD$. Na poloprimce $DM$ lezi jedna z uhlopricek tohoto rovnobezniku. Druha uhlopricka rovnobezniku $ABCD$ ma stejnou delku jako usecka $DM$.','Sestrojte vrcholy $B$, $C$ rovnobezniku $ABCD$, oznacte je pismeny a rovnobeznik narysujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 240" font-family="sans-serif"> <rect x="10" y="10" width="340" height="220" fill="none" stroke="#ccc"/> <text x="250" y="118" font-size="15" text-anchor="middle">x</text> <text x="250" y="106" font-size="14" text-anchor="middle" font-style="italic">M</text> <text x="96" y="176" font-size="15" text-anchor="middle">x</text> <text x="96" y="190" font-size="14" text-anchor="middle" font-style="italic">D</text> <text x="152" y="194" font-size="15" text-anchor="middle">x</text> <text x="152" y="208" font-size="14" text-anchor="middle" font-style="italic">A</text> </svg>',
  'body-ADM.svg',
  'Body A, D a M v rovine.',
  'Vychozi obrazek k uloze 10',
  new List<String>{'V rovnobezniku $ABCD$ se uhlopricky $AC$ a $BD$ puli ve stredu $S$. Uhlopricka $BD$ lezi na poloprimce $DM$, takze vrchol $B$ i stred $S$ lezi na poloprimce $DM$. Protoze $|AC|=|DM|$ a $S$ je stred usecky $AC$, plati $|AS|=\\frac{|DM|}{2}$; stred $S$ najdeme jako prusecik poloprimky $DM$ s kruznici se stredem $A$ a polomerem $\\frac{|DM|}{2}$. Vrchol $C$ je obrazem bodu $A$ ve stredove soumernosti se stredem $S$ (lezi na kruznici $(A;|DM|)$), vrchol $B$ obrazem bodu $D$ podle tehoz stredu. Uloha ma jedno reseni.'},
  'Stred $S$ = prusecik poloprimky $DM$ s kruznici $\\left(A;\\frac{|DM|}{2}\\right)$; $C$ obraz $A$ podle $S$ (na kruznici $(A;|DM|)$), $B$ obraz $D$ podle $S$ - viz obrazek v klici.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
