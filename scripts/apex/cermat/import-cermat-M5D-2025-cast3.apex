String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD25C0T04';
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
  'CERMAT M5D 2025 - uloha 6',
  new List<String>{'Na obrazku jsou obrazce $A$, $B$. Obrazec $A$ je obdelnik slozeny ze $4$ stejnych bilych obdelnicku a $4$ stejnych sedych ctvercku. Obvod bile casti obrazce $A$ je o $32$ cm vetsi nez obvod sede casti. Obrazec $B$ je osmiuhelnik, ktery vznikl preskladanim jednotlivych dilu obrazce $A$.','6.1 Urcete, kolik cm meri obvod obrazce $A$.','6.2 Urcete, o kolik cm se lisi obvody obrazcu $A$, $B$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 170" font-family="sans-serif" font-size="12"> <text x="70" y="24" text-anchor="middle">Obrazec A</text> <text x="270" y="24" text-anchor="middle">Obrazec B</text> <rect x="20" y="34" width="52" height="26" fill="#ffffff" stroke="#000"/> <rect x="72" y="34" width="52" height="26" fill="#ffffff" stroke="#000"/> <rect x="20" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/> <rect x="46" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/> <rect x="72" y="60" width="52" height="26" fill="#ffffff" stroke="#000"/> <rect x="20" y="86" width="52" height="26" fill="#ffffff" stroke="#000"/> <rect x="72" y="86" width="26" height="26" fill="#bbbbbb" stroke="#000"/> <rect x="98" y="86" width="26" height="26" fill="#bbbbbb" stroke="#000"/> <rect x="20" y="34" width="104" height="78" fill="none" stroke="#000" stroke-width="2"/> <polygon points="200,112 200,60 252,60 252,34 330,34 330,86 278,86 278,112" fill="none" stroke="#000" stroke-width="2"/> <rect x="200" y="60" width="26" height="26" fill="#bbbbbb" stroke="#000"/> <rect x="252" y="34" width="26" height="26" fill="#bbbbbb" stroke="#000"/> </svg>',
  'obrazce-AB.svg',
  'Obrazec A - obdelnik slozeny ze ctyr bilych obdelnicku a ctyr sedych ctvercku; obrazec B - osmiuhelnik vznikly preskladanim (schematicky).',
  'Schematicky nakres obrazcu A a B',
  new List<String>{'6.1 Bily obdelnicek ma rozmer $a\\times 2a$, kde $a$ je strana sedeho ctvercku. Soucet obvodu ctyr bilych dilu je $4\\cdot 2(a+2a)=24a$, soucet obvodu ctyr sedych ctvercku $4\\cdot 4a=16a$. Rozdil $24a-16a=8a=32$, tedy $a=4$ cm. Obrazec $A$ je obdelnik $12\\times 16$ cm a jeho obvod je $2\\cdot(12+16)=56$ cm.','6.2 Preskladanim dilu vznikne osmiuhelnik, jehoz obvod se od obvodu obrazce $A$ (tj. od $56$ cm) lisi o $8$ cm.'},
  '6.1: $56$ cm; 6.2: o $8$ cm',
  3, 6, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2025 - uloha 7.1 (konstrukce)',
  new List<String>{'V rovine lezi body $K$, $M$ (viz obrazek).','Body $K$, $M$ jsou vrcholy trojuhelniku $KLM$. Stred strany $LM$ tohoto trojuhelniku je bod $S$. Pritom trojuhelnik $KMS$ je rovnostranny.','Sestrojte bod $S$ a vrchol $L$ trojuhelniku $KLM$, oznacte je pismeny a trojuhelnik $KLM$ narysujte. Najdete vsechna reseni.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 240" font-family="sans-serif"> <rect x="10" y="10" width="440" height="220" fill="none" stroke="#cccccc"/> <text x="232" y="98" font-size="15" font-style="italic">M</text> <text x="230" y="112" font-size="15">x</text> <text x="292" y="176" font-size="15" font-style="italic">K</text> <text x="278" y="172" font-size="15">x</text> </svg>',
  'body-KM.svg',
  'Dva body K a M v rovine.',
  'Vychozi obrazek k uloze 7.1',
  new List<String>{'Trojuhelnik $KMS$ je rovnostranny, proto $|MS|=|KM|$ a bod $S$ lezi v pruseciku dvou kruznic o polomeru $|KM|$ se stredy $K$ a $M$ (dve polohy $S_1$, $S_2$). Bod $S$ je stred strany $LM$, takze vrchol $L$ dostaneme prodlouzenim usecky $MS$ za bod $S$ tak, ze $|SL|=|MS|$. Uloha ma dve reseni.'},
  'Dve reseni: bod $S$ jako vrchol rovnostranneho trojuhelniku $KMS$ (polohy $S_1$, $S_2$), vrchol $L$ soumerny s $M$ podle $S$ - viz obrazek v klici.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
