String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
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
  'CERMAT M7A 2019 – úloha 8',
  new List<String>{'V rovině leží bod $P$ a úhel $TCU$ (viz obrázek).','8.1 Sestrojte a označte písmenem $o$ osu úhlu $TCU$.','8.2 Bod $C$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Ramena $AC$ a $BC$ tohoto trojúhelníku leží na polopřímkách $CT$ a $CU$. Bod $P$ leží na straně $AB$. Sestrojte a označte písmeny chybějící vrcholy trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif" font-size="14"> <line x1="70" y1="45" x2="70" y2="255" stroke="#000" stroke-width="1.6"/> <line x1="70" y1="45" x2="395" y2="190" stroke="#000" stroke-width="1.6"/> <text x="55" y="42" font-style="italic">C</text> <text x="55" y="268" font-style="italic">T</text> <text x="400" y="196" font-style="italic">U</text> <line x1="64" y1="238" x2="76" y2="238" stroke="#000" stroke-width="1.6"/> <line x1="368" y1="172" x2="378" y2="184" stroke="#000" stroke-width="1.6"/> <line x1="140" y1="188" x2="152" y2="200" stroke="#000" stroke-width="1.8"/> <line x1="152" y1="188" x2="140" y2="200" stroke="#000" stroke-width="1.8"/> <text x="140" y="220" font-style="italic">P</text> </svg>',
  'uhel-TCU.svg',
  'Bod P a úhel TCU s vrcholem C a rameny CT a CU.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 Osa $o$ úhlu $TCU$ prochází vrcholem $C$ a dělí úhel na dvě shodné části; je zároveň osou souměrnosti rovnoramenného trojúhelníku.','8.2 Základna $AB$ rovnoramenného trojúhelníku je kolmá k ose $o$. Bodem $P$ vedeme kolmici k ose $o$; její průsečíky s polopřímkami $CT$ a $CU$ jsou vrcholy $A$ a $B$.'},
  'Osa $o$ úhlu $TCU$ a rovnoramenný trojúhelník $ABC$ (základna $AB$ kolmá k ose $o$ a procházející bodem $P$; vrcholy $A$, $B$ na polopřímkách $CT$, $CU$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 9',
  new List<String>{'V rovině leží kružnice $k$ se středem $S$, přímka $p$ a bod $D$ (viz obrázek).','Bod $D$ je vrchol obdélníku $ABCD$. Na přímce $p$ leží strana $AB$ tohoto obdélníku. Vrchol $C$ leží na kružnici $k$. Sestrojte a označte písmeny chybějící vrcholy obdélníku $ABCD$ a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 330" font-family="sans-serif" font-size="14"> <circle cx="215" cy="160" r="135" fill="none" stroke="#000" stroke-width="1.6"/> <text x="88" y="115" font-style="italic">k</text> <line x1="65" y1="240" x2="390" y2="278" stroke="#000" stroke-width="1.6"/> <text x="398" y="283" font-style="italic">p</text> <line x1="209" y1="156" x2="221" y2="168" stroke="#000" stroke-width="1.6"/> <line x1="221" y1="156" x2="209" y2="168" stroke="#000" stroke-width="1.6"/> <text x="224" y="176" font-style="italic">S</text> <line x1="252" y1="104" x2="264" y2="116" stroke="#000" stroke-width="1.6"/> <line x1="264" y1="104" x2="252" y2="116" stroke="#000" stroke-width="1.6"/> <text x="268" y="112" font-style="italic">D</text> </svg>',
  'kruznice-p-D.svg',
  'Kružnice k se středem S, přímka p a bod D nad přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Strana $AD$ je kolmá k přímce $p$, takže vrchol $A$ je pata kolmice z bodu $D$ na přímku $p$. Strana $DC$ je rovnoběžná s $p$; vrchol $C$ leží na rovnoběžce s $p$ vedené bodem $D$ a zároveň na kružnici $k$ – to dává dvě polohy. Vrchol $B$ je pata kolmice z $C$ na přímku $p$. Úloha má dvě řešení.'},
  'Obdélník $ABCD$: $A$ je pata kolmice z $D$ na $p$; $C$ je průsečík rovnoběžky s $p$ vedené bodem $D$ a kružnice $k$; $B$ je pata kolmice z $C$ na $p$. Dvě řešení – viz obrázek v klíči.',
  2, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
