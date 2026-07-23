String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD22C0T01';
Integer YEAR = 2022;

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
  'CERMAT M7A 2022 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $D$, $R$ (viz obrázek).','Body $A$, $D$ jsou vrcholy pravoúhlého lichoběžníku $ABCD$ s pravým úhlem při vrcholu $D$. Základna $AB$ a rameno $AD$ tohoto lichoběžníku mají stejnou délku. Bod $R$ leží na rameni $BC$ lichoběžníku $ABCD$.','Sestrojte vrcholy $B$, $C$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 300" font-family="sans-serif"> <rect x="5" y="5" width="470" height="290" fill="none" stroke="#ccc"/> <text x="150" y="108" font-size="15" text-anchor="middle">×</text><text x="150" y="124" font-size="16" text-anchor="middle" font-style="italic">D</text> <text x="330" y="105" font-size="15" text-anchor="middle">×</text><text x="330" y="121" font-size="16" text-anchor="middle" font-style="italic">R</text> <text x="200" y="225" font-size="15" text-anchor="middle">×</text><text x="200" y="241" font-size="16" text-anchor="middle" font-style="italic">A</text> </svg>',
  'body-ADR.svg',
  'Tři body A, D, R v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Lichoběžník $ABCD$ je pravoúhlý s pravým úhlem u $D$ (a u $A$), takže rameno $AD$ je kolmé na obě základny. Ve vrcholu $A$ vztyčíme kolmici k $AD$ a naneseme $|AB|=|AD|$ (bod $B$). Základna $DC$ je kolmice k $AD$ v bodě $D$ (rovnoběžka s $AB$). Vrchol $C$ leží na této rovnoběžce a zároveň na přímce $BR$, protože bod $R$ je na rameni $BC$.'},
  'Konstrukce pravoúhlého lichoběžníku $ABCD$: pravý úhel u $A$ i $D$, $|AB|=|AD|$, základna $DC$ rovnoběžná s $AB$, vrchol $C$ na přímce $BR$ ($R$ na rameni $BC$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2022 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $P$, $S$ a přímka $q$ (viz obrázek).','Bod $P$ je vrchol trojúhelníku $PQR$. Na přímce $q$ leží vrchol $Q$ tohoto trojúhelníku. Vrcholy $P$ a $Q$ mají od bodu $S$ stejnou vzdálenost. Bod $S$ je zároveň středem strany $QR$.','Sestrojte vrcholy $Q$, $R$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"> <rect x="5" y="5" width="470" height="310" fill="none" stroke="#ccc"/> <line x1="60" y1="290" x2="430" y2="150" stroke="#000" stroke-width="2"/> <text x="440" y="150" font-size="16" font-style="italic">q</text> <text x="230" y="180" font-size="15" text-anchor="middle">×</text><text x="230" y="196" font-size="16" text-anchor="middle" font-style="italic">S</text> <text x="140" y="235" font-size="15" text-anchor="middle">×</text><text x="140" y="251" font-size="16" text-anchor="middle" font-style="italic">P</text> </svg>',
  'body-PSq.svg',
  'Body P a S a přímka q v rovině.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Protože $|SP|=|SQ|$ a bod $S$ je střed $QR$ (tedy $|SQ|=|SR|$), leží body $P$, $Q$, $R$ na kružnici se středem $S$ a poloměrem $|SP|$. Vrchol $Q$ je průsečík této kružnice s přímkou $q$ (dvě polohy $Q_1$, $Q_2$); vrchol $R$ je obraz bodu $Q$ ve středové souměrnosti podle bodu $S$. Úloha má dvě řešení.'},
  'Dvě řešení: kružnice se středem $S$ a poloměrem $|SP|$ protne přímku $q$ v bodech $Q_1$, $Q_2$; bod $R$ je souměrný s $Q$ podle středu $S$ (trojúhelníky $PQ_1R_1$, $PQ_2R_2$) – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
