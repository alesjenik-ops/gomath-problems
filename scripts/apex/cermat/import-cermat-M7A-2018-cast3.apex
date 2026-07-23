String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD18C0T01';
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
  'CERMAT M7A 2018 – úloha 8',
  new List<String>{'V rovině leží přímky $b$, $c$, $d$ (viz obrázek).','V průsečíku přímek $b$, $c$ je vrchol $A$ obdélníku $ABCD$. Vrchol $B$ téhož obdélníku leží na přímce $b$, vrchol $C$ na přímce $c$ a vrchol $D$ na přímce $d$.','Sestrojte chybějící vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 380" font-family="sans-serif" font-size="15"> <line x1="60" y1="72" x2="440" y2="72" stroke="#000" stroke-width="1.6"/> <text x="60" y="94" font-style="italic">d</text> <line x1="110" y1="300" x2="470" y2="170" stroke="#000" stroke-width="1.6"/> <text x="476" y="172" font-style="italic">c</text> <line x1="150" y1="110" x2="430" y2="350" stroke="#000" stroke-width="1.6"/> <text x="436" y="352" font-style="italic">b</text> </svg>',
  'primky-bcd.svg',
  'Tři přímky b, c, d v rovině; přímky b a c se protínají, přímka d je nad nimi.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Vrchol $A$ je průsečík přímek $b$ a $c$. Strana $AB$ leží na přímce $b$, proto je strana $AD$ kolmá k $b$: v bodě $A$ sestrojíme kolmici k přímce $b$ a její průsečík s přímkou $d$ je vrchol $D$. Bodem $D$ vedeme rovnoběžku s přímkou $b$; její průsečík s přímkou $c$ je vrchol $C$. Vrchol $B$ leží na přímce $b$ (jako pata kolmice z $C$ k $b$, resp. $B=A+(C-D)$).'},
  'Obdélník $ABCD$: $A$ je průsečík přímek $b$ a $c$; $D$ leží na přímce $d$ na kolmici k $b$ v bodě $A$; $C$ je na přímce $c$ na rovnoběžce s $b$ vedené bodem $D$; $B$ leží na přímce $b$. Viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 9',
  new List<String>{'V rovině leží úsečka $AD$ a bod $S_{BC}$ (viz obrázek). Body $A$, $D$ jsou vrcholy rovnoběžníku $ABCD$, bod $S_{BC}$ je střed strany $BC$ tohoto rovnoběžníku.','9.1 Sestrojte přímku $p$, na níž leží chybějící vrcholy $B$, $C$ rovnoběžníku $ABCD$.','9.2 Sestrojte střed $S$ rovnoběžníku.','9.3 Sestrojte chybějící vrcholy rovnoběžníku $ABCD$ a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 290" font-family="sans-serif" font-size="15"> <line x1="90" y1="200" x2="320" y2="120" stroke="#000" stroke-width="1.8"/> <line x1="84" y1="188" x2="96" y2="212" stroke="#000" stroke-width="1.6"/> <line x1="314" y1="108" x2="326" y2="132" stroke="#000" stroke-width="1.6"/> <text x="70" y="206" font-style="italic">A</text> <text x="326" y="116" font-style="italic">D</text> <line x1="344" y1="210" x2="356" y2="222" stroke="#000" stroke-width="1.6"/> <line x1="356" y1="210" x2="344" y2="222" stroke="#000" stroke-width="1.6"/> <text x="350" y="242" font-style="italic">S</text><text x="364" y="246" font-size="11">BC</text> </svg>',
  'usecka-AD-SBC.svg',
  'Úsečka AD (A vlevo dole, D vpravo nahoře) a bod S_BC vyznačený křížkem vpravo pod úsečkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 V rovnoběžníku je $BC$ rovnoběžná s $AD$; přímka $p$ je tedy rovnoběžka s přímkou $AD$ vedená bodem $S_{BC}$.','9.2 Střed $S$ rovnoběžníku je střed úsečky spojující střed strany $AD$ a bod $S_{BC}$ (leží také na úhlopříčce $AC$).','9.3 Protože $BC$ je rovnoběžná a stejně dlouhá jako $AD$ a $S_{BC}$ je střed $BC$, naneseme na přímku $p$ na obě strany od $S_{BC}$ polovinu délky $AD$; dostaneme vrcholy $B$ a $C$. Rovnoběžník $ABCD$ narýsujeme.'},
  'Přímka $p$ je rovnoběžka s $AD$ vedená bodem $S_{BC}$; na ni od $S_{BC}$ naneseme na obě strany $\\frac{1}{2}|AD|$ (vrcholy $B$, $C$); střed $S$ je střed úsečky $S_{AD}S_{BC}$. Viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
