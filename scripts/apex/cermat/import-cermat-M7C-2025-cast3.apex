String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
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
  'CERMAT M7C 2025 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).','Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek tohoto trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$ trojúhelníku $ABC$.','Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <rect x="6" y="6" width="448" height="308" fill="none" stroke="#cccccc"/> <line x1="70" y1="185" x2="400" y2="185" stroke="#000" stroke-width="2"/> <text x="408" y="190" font-size="15" font-style="italic">q</text> <text x="231" y="122" font-size="14">×</text><text x="230" y="140" font-size="15" font-style="italic">M</text> <text x="251" y="260" font-size="14">×</text><text x="250" y="278" font-size="15" font-style="italic">B</text> </svg>',
  'body-BM-q.svg',
  'Body B a M a vodorovná přímka q v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Protože $BM$ je výška na stranu $AC$, je úhel $BMA$ pravý. Vrchol $A$ tedy leží na kolmici k přímce $BM$ vedené bodem $M$ a zároveň na přímce $q$; $A$ je jejich průsečík. Strana $AC$ leží na přímce $AM$. Trojúhelník je rovnoramenný se základnou $AB$, proto vrchol $C$ leží na ose úsečky $AB$; $C$ je průsečík přímky $AM$ s osou úsečky $AB$.'},
  'Konstrukce: $A$ = průsečík přímky $q$ s kolmicí k $BM$ v bodě $M$; $C$ = průsečík přímky $AM$ s osou úsečky $AB$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $D$, $M$ (viz obrázek).','Body $A$, $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$. Na polopřímce $DM$ leží vrchol $B$ tohoto lichoběžníku. Přitom délka strany $AB$ je stejná jako délka úsečky $DM$.','Sestrojte vrcholy $B$, $C$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 320" font-family="sans-serif"> <rect x="6" y="6" width="448" height="308" fill="none" stroke="#cccccc"/> <text x="298" y="122" font-size="14">×</text><text x="297" y="140" font-size="15" font-style="italic">M</text> <text x="151" y="206" font-size="14">×</text><text x="150" y="224" font-size="15" font-style="italic">D</text> <text x="246" y="222" font-size="14">×</text><text x="245" y="240" font-size="15" font-style="italic">A</text> </svg>',
  'body-ADM.svg',
  'Body A, D a M v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Vrchol $B$ leží na polopřímce $DM$ a platí $|AB|=|DM|$; sestrojíme jej jako průsečík polopřímky $DM$ s kružnicí se středem $A$ a poloměrem $|DM|$. Vrchol $C$ dopočteme tak, aby čtyřúhelník $ABCD$ byl pravoúhlý lichoběžník (dvě rovnoběžné strany a pravý úhel). Úloha má dvě řešení (vrcholy $C_1$, $C_2$).'},
  'Dvě řešení ($C_1$, $C_2$): $B$ na polopřímce $DM$ s $|AB|=|DM|$, $C$ doplní pravoúhlý lichoběžník $ABCD$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
