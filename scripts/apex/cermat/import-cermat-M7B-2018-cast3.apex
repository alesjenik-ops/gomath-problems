String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
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
  'CERMAT M7B 2018 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží různoběžky $o$, $p$ a bod $D$ na přímce $o$ (viz obrázek).','Bod $D$ je vrchol kosočtverce $ABCD$. Přímka $o$ je osou souměrnosti tohoto kosočtverce a další dva vrcholy $A$, $B$ leží na přímce $p$.','Sestrojte a popište chybějící vrcholy $A$, $B$, $C$ kosočtverce $ABCD$ a kosočtverec narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 380" font-family="sans-serif"> <line x1="40" y1="300" x2="410" y2="312" stroke="#000" stroke-width="2"/> <text x="415" y="312" font-size="16" font-style="italic">p</text> <line x1="130" y1="60" x2="350" y2="360" stroke="#000" stroke-width="2"/> <text x="352" y="372" font-size="16" font-style="italic">o</text> <text x="182" y="118" font-size="16">×</text><text x="196" y="112" font-size="16" font-style="italic">D</text> </svg>',
  'primky-op-D.svg',
  'Dvě různoběžky o a p a bod D ležící na přímce o nad průsečíkem obou přímek.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Osa souměrnosti $o$ kosočtverce prochází vrcholem $D$, je to tedy úhlopříčka $DB$; bod $B$ proto leží na $o$ i na $p$, tj. $B=o\\cap p$. Střed $S$ kosočtverce je střed úsečky $BD$. Druhá úhlopříčka $AC$ je kolmá k $o$ a prochází bodem $S$; její průsečík s přímkou $p$ je vrchol $A$. Vrchol $C$ je obraz bodu $A$ v osové souměrnosti podle přímky $o$ (tj. $C$ je souměrný s $A$ podle $S$).'},
  'Konstrukce kosočtverce $ABCD$: $B=o\\cap p$, $S$ je střed $BD$, $A$ je průsečík kolmice k $o$ v bodě $S$ s přímkou $p$, $C$ je obraz $A$ v souměrnosti podle $o$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží přímka $AB$ a mimo ni bod $T$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$ a bod $T$ je jeho těžiště.','Sestrojte a popište chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 340" font-family="sans-serif"> <line x1="50" y1="300" x2="430" y2="300" stroke="#000" stroke-width="2"/> <line x1="150" y1="292" x2="150" y2="308" stroke="#000" stroke-width="2"/> <line x1="330" y1="292" x2="330" y2="308" stroke="#000" stroke-width="2"/> <text x="144" y="326" font-size="16" font-style="italic">A</text> <text x="324" y="326" font-size="16" font-style="italic">B</text> <text x="296" y="168" font-size="16">×</text><text x="310" y="162" font-size="16" font-style="italic">T</text> </svg>',
  'primka-AB-T.svg',
  'Přímka s vyznačenými body A a B a bod T ležící nad úsečkou AB.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Sestrojíme střed $M$ strany $AB$ (osa úsečky $AB$). Těžiště $T$ leží na těžnici $CM$ a dělí ji v poměru $CT:TM=2:1$. Vrchol $C$ tedy leží na polopřímce $MT$ tak, že $|MC|=3\\cdot|MT|$ (bod $C$ získáme trojnásobným nanesením vzdálenosti $|MT|$ od bodu $M$ přes $T$).'},
  'Konstrukce trojúhelníku $ABC$: $M$ je střed $AB$, vrchol $C$ leží na polopřímce $MT$ ve vzdálenosti $|MC|=3\\cdot|MT|$ (těžiště dělí těžnici v poměru $2:1$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
