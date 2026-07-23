String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M7B 2024 - uloha 8 (konstrukce)',
  new List<String>{'Je dana primka $p$, bod $A$, ktery lezi na primce $p$, a bod $S_b$, ktery lezi mimo primku $p$ (viz obrazek).','8.1 Sestrojte rovnoramenny trojuhelnik $ABC$ se zakladnou $BC$, pokud plati, ze teznice k zakladne $BC$ lezi na primce $p$ a bod $S_b$ je stredem strany $b$.','8.2 Narysujte teziste trojuhelniku $ABC$ a tento bod popiste pismenem $T$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif"> <line x1="60" y1="280" x2="360" y2="60" stroke="#000" stroke-width="2"/> <text x="72" y="276" font-size="15" font-style="italic">p</text> <text x="314" y="90" font-size="14">x</text> <text x="330" y="82" font-size="15" font-style="italic">A</text> <text x="242" y="196" font-size="14">x</text> <text x="256" y="198" font-size="15" font-style="italic">S</text> <text x="268" y="202" font-size="10">b</text> </svg>',
  'primka-p-bod-A.svg',
  'Primka p, bod A lezici na primce p a bod S_b lezici mimo primku p.',
  'Vychozi obrazek k uloze 8',
  new List<String>{'Strana $b$ je strana $AC$, jejim stredem je bod $S_b$; bod $C$ proto lezi na primce $AS_b$ tak, ze $|S_bC| = |AS_b|$ (kruznice $k_1$ se stredem $S_b$ a polomerem $|AS_b|$).','Trojuhelnik je rovnoramenny se zakladnou $BC$ a teznici z $A$ na primce $p$; primka $p$ je tedy osou strany $BC$. Patu $X$ kolmice $m$ z bodu $C$ na primku $p$ ziskame jako $m\\cap p$; bod $B$ je obrazem $C$ v soumernosti podle $p$, tj. na primce $CX$ plati $|XB| = |CX|$ (kruznice $k_2$).','Teziste $T$ je prusecik primky $p$ (na niz lezi teznice z $A$) a teznice $BS_b$: $T = p\\cap BS_b$.'},
  'Rovnoramenny trojuhelnik $ABC$: $C$ na primce $AS_b$ s $|S_bC|=|AS_b|$, $B$ obraz $C$ v osove soumernosti podle $p$; teziste $T = p\\cap BS_b$ (viz nacrt v klici).',
  3, 8, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
