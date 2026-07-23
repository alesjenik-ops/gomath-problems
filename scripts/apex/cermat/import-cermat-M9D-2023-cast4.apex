String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $P$, $Q$, $R$ a přímka $a$ (viz obrázek).','Na přímce $a$ leží strana $AB$ čtverce $ABCD$. Dva ze tří bodů $P$, $Q$, $R$ leží uvnitř dvou různých stran tohoto čtverce a třetí bod leží vně čtverce $ABCD$.','Sestrojte všechny vrcholy čtverce $ABCD$, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 300" font-family="sans-serif"> <line x1="60" y1="185" x2="520" y2="240" stroke="#000" stroke-width="1.5"/> <text x="46" y="182" font-size="15" font-style="italic">a</text> <g text-anchor="middle"> <text x="250" y="122" font-size="14">×</text> <text x="250" y="108" font-size="15" font-style="italic">P</text> <text x="300" y="92" font-size="14">×</text> <text x="300" y="78" font-size="15" font-style="italic">Q</text> <text x="440" y="152" font-size="14">×</text> </g> <text x="454" y="156" font-size="15" font-style="italic">R</text> </svg>',
  'body-PQR-a.svg',
  'Body P, Q, R označené křížky nad šikmou přímkou a.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Strana $AB$ leží na přímce $a$, proto jsou strany $AD$ a $BC$ kolmé k $a$ a strana $CD$ je s přímkou $a$ rovnoběžná. Vzdálenost strany $CD$ od přímky $a$ je rovna délce strany čtverce.','Dva z bodů $P$, $Q$, $R$ leží na dvou různých stranách čtverce a třetí leží vně. Z jejich poloh určíme délku strany čtverce i jeho umístění na přímce $a$: kolmice k $a$ a rovnoběžka s $a$ v příslušných vzdálenostech dají vrcholy $A$, $B$, $C$, $D$. Úloha má dvě řešení (viz obrázek v klíči).'},
  'Čtverec $ABCD$ se stranou $AB$ na přímce $a$ ($AD\\perp a$, $BC\\perp a$, $CD\\parallel a$); dva z bodů $P$, $Q$, $R$ leží na jeho stranách, třetí vně. Úloha má dvě řešení – viz konstrukce v klíči.',
  3, 7, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží přímky $b$, $c$ a na přímce $b$ leží bod $A$ (viz obrázek).','Bod $A$ je vrchol trojúhelníku $ABC$ s pravým úhlem při vrcholu $A$. Na přímce $b$ leží vrchol $B$ a na přímce $c$ leží vrchol $C$ tohoto trojúhelníku. Velikost vnitřního úhlu trojúhelníku $ABC$ při vrcholu $C$ je $40^\\circ$.','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif"> <line x1="60" y1="120" x2="520" y2="95" stroke="#000" stroke-width="1.5"/> <text x="528" y="96" font-size="15" font-style="italic">c</text> <line x1="60" y1="150" x2="520" y2="235" stroke="#000" stroke-width="1.5"/> <text x="528" y="238" font-size="15" font-style="italic">b</text> <line x1="331" y1="196" x2="345" y2="207" stroke="#000"/> <text x="332" y="226" font-size="15" font-style="italic" text-anchor="middle">A</text> </svg>',
  'primky-bc.svg',
  'Dvě přímky b a c rozbíhající se doprava; na přímce b je vyznačen bod A.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Pravý úhel je u vrcholu $A$ a vrchol $B$ leží na přímce $b$, na níž leží i bod $A$; proto strana $AB$ splývá s přímkou $b$. Strana $AC$ je kolmá k $AB$, tedy k přímce $b$, a vrchol $C$ je průsečík kolmice k přímce $b$ vedené bodem $A$ s přímkou $c$.','V bodě $C$ sestrojíme na obě strany od polopřímky $CA$ úhel $40^\\circ$; jeho ramena protnou přímku $b$ ve dvou bodech $B_1$, $B_2$. Úloha má dvě řešení.'},
  'Pravoúhlý trojúhelník $ABC$ (pravý úhel u $A$): strana $AB$ leží na přímce $b$, $AC\\perp b$, takže $C$ je průsečík kolmice k $b$ bodem $A$ s přímkou $c$; vrchol $B$ získáme sestrojením úhlu $40^\\circ$ u vrcholu $C$ (dvě řešení $B_1$, $B_2$) – viz konstrukce v klíči.',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
