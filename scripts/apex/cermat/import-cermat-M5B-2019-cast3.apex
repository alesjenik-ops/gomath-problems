String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD19C0T02';
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
  'CERMAT M5B 2019 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $O$, přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$. Strana $AB$ tohoto obdélníku leží na přímce $p$, bod $S$ leží uvnitř některé ze tří zbývajících stran obdélníku $ABCD$. Jeden krajní bod strany, která obsahuje bod $S$, leží na kružnici $k$.','Sestrojte a označte písmeny chybějící vrcholy $B$, $C$, $D$ obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif"> <circle cx="255" cy="140" r="90" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="45" y1="140" x2="445" y2="250" stroke="#000" stroke-width="1.6"/> <text x="200" y="66" font-size="15" font-style="italic">k</text> <text x="262" y="140" font-size="14">×</text><text x="270" y="150" font-size="14" font-style="italic">S</text> <text x="162" y="175" font-size="14">×</text><text x="150" y="190" font-size="14" font-style="italic">A</text> <text x="250" y="300" font-size="14">×</text><text x="258" y="312" font-size="14" font-style="italic">O</text> <text x="448" y="256" font-size="15" font-style="italic">p</text> </svg>',
  'primka-kruznice.svg',
  'Bod O, přímka p a kružnice k se středem S; bod A je průsečík přímky p a kružnice k.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'Strana $AB$ leží na přímce $p$, strany $AD$ a $BC$ jsou kolmé k $p$ a strana $CD$ je s $p$ rovnoběžná. Střed $S$ leží uvnitř jedné z těchto tří stran a jeden její krajní bod leží na kružnici $k$. Sestrojením kolmic k $p$ a využitím polohy bodu $S$ a kružnice $k$ získáme dvě řešení – obdélníky $ABC_1D_1$ a $ABC_2D_2$.'},
  'Konstrukce obdélníku $ABCD$; úloha má $2$ řešení (obdélníky $ABC_1D_1$ a $ABC_2D_2$) – viz nákres v klíči.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2019 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží bod $O$, přímka $p$ a kružnice $k$ se středem $S$. Bod $A$ je jedním ze dvou průsečíků přímky $p$ a kružnice $k$ (viz obrázek).','Body $A$, $O$ jsou vrcholy trojúhelníku $AOP$. Vrchol $P$ tohoto trojúhelníku leží na přímce $p$. Strana $AO$ má stejnou délku jako jedna z dalších stran trojúhelníku $AOP$.','Sestrojte a označte písmenem chybějící vrchol $P$ trojúhelníku $AOP$ a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 330" font-family="sans-serif"> <circle cx="255" cy="140" r="90" fill="none" stroke="#000" stroke-width="1.6"/> <line x1="45" y1="140" x2="445" y2="250" stroke="#000" stroke-width="1.6"/> <text x="200" y="66" font-size="15" font-style="italic">k</text> <text x="262" y="140" font-size="14">×</text><text x="270" y="150" font-size="14" font-style="italic">S</text> <text x="162" y="175" font-size="14">×</text><text x="150" y="190" font-size="14" font-style="italic">A</text> <text x="250" y="300" font-size="14">×</text><text x="258" y="312" font-size="14" font-style="italic">O</text> <text x="448" y="256" font-size="15" font-style="italic">p</text> </svg>',
  'primka-kruznice.svg',
  'Bod O, přímka p a kružnice k se středem S; bod A je průsečík přímky p a kružnice k.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'Strana $AO$ má stejnou délku jako $AP$, nebo jako $OP$. Je-li $|AP| = |AO|$, leží $P$ na kružnici se středem $A$ a poloměrem $|AO|$ a zároveň na přímce $p$. Je-li $|OP| = |AO|$, leží $P$ na kružnici se středem $O$ a poloměrem $|AO|$ a zároveň na přímce $p$. Celkem dostaneme tři různé polohy $P_1$, $P_2$, $P_3$.'},
  'Konstrukce trojúhelníku $AOP$; úloha má $3$ řešení (vrcholy $P_1$, $P_2$, $P_3$ na přímce $p$) – viz nákres v klíči.',
  3, 6, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
