String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD23C0T03';
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
  'CERMAT M9C 2023 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží přímka $AB$ a přímka $p$ procházející bodem $B$ (viz obrázek).','Úsečka $AB$ je strana pravoúhlého lichoběžníku $ABCD$. Vrchol $C$ tohoto lichoběžníku leží na přímce $p$, úhlopříčka $AC$ má stejnou délku jako strana $AB$ lichoběžníku $ABCD$.','Sestrojte vrcholy $C$, $D$ lichoběžníku $ABCD$, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <line x1="60" y1="250" x2="360" y2="100" stroke="#000" stroke-width="1.5"/> <line x1="200" y1="80" x2="380" y2="170" stroke="#000" stroke-width="1.5"/> <line x1="83" y1="230" x2="97" y2="243" stroke="#000"/> <text x="46" y="262" font-size="15" font-style="italic">A</text> <text x="306" y="126" font-size="15" font-style="italic">B</text> <text x="386" y="176" font-size="15" font-style="italic">p</text> </svg>',
  'primka-AB-p.svg',
  'Přímka AB vedená od bodu A vlevo dole šikmo vzhůru a přímka p protínající ji v bodě B.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Úhlopříčka $AC$ má délku $|AB|$, proto vrchol $C$ leží na kružnici $k(A;|AB|)$. Zároveň $C$ leží na přímce $p$, takže $C$ je průsečík přímky $p$ s kružnicí $k$ — vzniknou dvě polohy $C_1$, $C_2$.','Základnami lichoběžníku jsou rovnoběžné strany $AB$ a $CD$; protože jde o pravoúhlý lichoběžník, je rameno $AD$ kolmé k $AB$. Vrchol $D$ je proto průsečík kolmice k $AB$ vedené bodem $A$ s rovnoběžkou s $AB$ vedenou bodem $C$. Úloha má dvě řešení ($D_1$, $D_2$).'},
  'Dvě řešení: $C$ je průsečík přímky $p$ s kružnicí $k(A;|AB|)$ (polohy $C_1$, $C_2$); dále $AB\\parallel CD$ a $AD\\perp AB$, takže $D$ je průsečík kolmice k $AB$ v bodě $A$ s rovnoběžkou s $AB$ bodem $C$. Viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $C$ a přímka $p$ procházející bodem $C$ (viz obrázek).','Úsečka $AC$ je základna rovnoramenného trojúhelníku $ABC$. Na přímce $p$ leží jedna ze tří výšek tohoto trojúhelníku.','10.1 Sestrojte osu souměrnosti trojúhelníku $ABC$ a označte ji písmenem $o$.','10.2 Sestrojte vrchol $B$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif"> <line x1="90" y1="60" x2="330" y2="270" stroke="#000" stroke-width="1.5"/> <line x1="98" y1="79" x2="114" y2="72" stroke="#000"/> <text x="72" y="78" font-size="15" font-style="italic">C</text> <text x="150" y="248" font-size="14" text-anchor="middle">x</text> <text x="150" y="266" font-size="15" font-style="italic" text-anchor="middle">A</text> <text x="338" y="284" font-size="15" font-style="italic">p</text> </svg>',
  'body-AC-p.svg',
  'Šikmá přímka p, na ní bod C nahoře označený tečkou, a bod A pod přímkou označený křížkem.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 Rovnoramenný trojúhelník se základnou $AC$ je souměrný podle osy úsečky $AC$; tuto osu sestrojíme a označíme $o$ (prochází vrcholem $B$).','10.2 Přímka $p$ prochází bodem $C$ a leží na ní jedna z výšek, jde tedy o výšku z vrcholu $C$ na stranu $AB$; platí $AB\\perp p$. Vrchol $B$ najdeme jako průsečík osy $o$ s kolmicí k přímce $p$ vedenou bodem $A$.'},
  '10.1: osa $o$ je osa úsečky $AC$ (prochází vrcholem $B$). 10.2: přímka $p$ je výška z vrcholu $C$, proto $AB\\perp p$ a vrchol $B$ je průsečík osy $o$ s kolmicí k $p$ vedenou bodem $A$. Viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
