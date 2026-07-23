String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M5B 2018 – úloha 6',
  new List<String>{'Část plochy hladiny rybníka je znečištěná. Za každý den ($24$ hodin) se velikost znečištěné plochy zdvojnásobí.','6.1 Vypočtěte, kolikrát se zvětší velikost znečištěné plochy za dva dny.','6.2 Vypočtěte, kolikrát menší byla velikost znečištěné plochy před třemi dny.','6.3 Znečištěná plocha pokrývá osminu plochy hladiny rybníka. Vypočtěte, za kolik dnů se znečištěná plocha rozšíří na celou plochu hladiny rybníka.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Za jeden den se plocha zdvojnásobí, za dva dny se tedy zvětší $2 \\cdot 2 = 4$krát.','6.2 Každý den zpět je plocha poloviční, před třemi dny byla $2 \\cdot 2 \\cdot 2 = 8$krát menší.','6.3 Z osminy: za $1$ den čtvrtina, za $2$ dny polovina a za $3$ dny celá plocha. Znečištění pokryje celou hladinu za $3$ dny.'},
  '6.1: $4$krát; 6.2: $8$krát; 6.3: $3$ dny',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2018 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $F$, $G$ (viz obrázek). Bod $A$ je vrchol čtverce $ABCD$. Na polopřímce $AF$ leží vrchol $B$ tohoto čtverce a uvnitř strany $CD$ tohoto čtverce leží bod $G$.','Sestrojte chybějící vrcholy $B$, $C$, $D$ čtverce $ABCD$, označte je písmeny a čtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif"> <rect x="6" y="6" width="468" height="328" fill="none" stroke="#ccc"/> <text x="178" y="90" font-size="16" text-anchor="middle">×</text> <text x="178" y="80" font-size="16" font-style="italic" text-anchor="middle">G</text> <text x="355" y="182" font-size="16" text-anchor="middle">×</text> <text x="362" y="198" font-size="16" font-style="italic">F</text> <text x="168" y="236" font-size="16" text-anchor="middle">×</text> <text x="168" y="252" font-size="16" font-style="italic" text-anchor="middle">A</text> </svg>',
  'body-AFG.svg',
  'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'Strana $AB$ leží na polopřímce $AF$, protější strana $CD$ je s ní rovnoběžná a prochází bodem $G$. Bodem $G$ vedeme rovnoběžku s $AF$ (přímku strany $CD$). V bodě $A$ vztyčíme kolmici k $AF$; její průsečík s touto rovnoběžkou je vrchol $D$ a délka $|AD|$ je stranou čtverce. Na polopřímce $AF$ naneseme $|AB| = |AD|$ (vrchol $B$) a v bodě $B$ vztyčíme kolmici k $AF$, jejíž průsečík s rovnoběžkou je vrchol $C$. Bod $G$ leží uvnitř strany $CD$.'},
  'Čtverec $ABCD$ se stranou $AB$ na polopřímce $AF$; délka strany je rovna vzdálenosti bodu $G$ od přímky $AF$ (vrchol $D$ je pata kolmice k $AF$ v bodě $A$ na rovnoběžce s $AF$ vedené bodem $G$) – viz nákres v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $F$, $G$ a je sestrojen čtverec $ABCD$ z úlohy 7.1 (viz obrázek).','Na úsečce $AD$ sestrojte a označte bod $E$, který je vrcholem rovnoramenného trojúhelníku $EFG$ se základnou $EG$, a trojúhelník $EFG$ narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif"> <rect x="6" y="6" width="468" height="328" fill="none" stroke="#ccc"/> <text x="178" y="90" font-size="16" text-anchor="middle">×</text> <text x="178" y="80" font-size="16" font-style="italic" text-anchor="middle">G</text> <text x="355" y="182" font-size="16" text-anchor="middle">×</text> <text x="362" y="198" font-size="16" font-style="italic">F</text> <text x="168" y="236" font-size="16" text-anchor="middle">×</text> <text x="168" y="252" font-size="16" font-style="italic" text-anchor="middle">A</text> </svg>',
  'body-AFG.svg',
  'Body A, F, G v rovině: G nahoře uprostřed, F vpravo, A dole vlevo.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'Trojúhelník $EFG$ je rovnoramenný se základnou $EG$, takže ramena $FE$ a $FG$ jsou shodná: $|FE| = |FG|$. Bod $E$ proto leží na kružnici se středem $F$ a poloměrem $|FG|$; jeho poloha je dána průsečíkem této kružnice s úsečkou $AD$. Poté trojúhelník $EFG$ narýsujeme.'},
  'Bod $E$ je průsečík úsečky $AD$ s kružnicí se středem $F$ a poloměrem $|FG|$ (pak $|FE| = |FG|$); trojúhelník $EFG$ má základnu $EG$ – viz nákres v klíči.',
  2, 5, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
