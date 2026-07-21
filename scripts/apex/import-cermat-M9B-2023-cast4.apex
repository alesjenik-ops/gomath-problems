String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2023 M9B · úloha 10',
  new List<String>{'V rovině leží body $C$, $Q$ a kružnice $k$ se středem $S$, procházející bodem $C$. Bod $C$ je vrchol trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$; vrcholy $A$, $B$ leží na kružnici $k$ a bodem $Q$ prochází jedna strana trojúhelníku (viz obrázek).','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 344"><path d="M4 323L5 323L5 324L4 324Z" style="fill:#000000"/><path d="M4 323L5 323L5 324L4 324Z" style="fill:#000000"/><path d="M5 323L467 323L467 324L5 324Z" style="fill:#000000"/><path d="M467 323L468 323L468 324L467 324Z" style="fill:#000000"/><path d="M467 323L468 323L468 324L467 324Z" style="fill:#000000"/><path d="M4 4L5 4L5 323L4 323Z" style="fill:#000000"/><path d="M467 4L468 4L468 323L467 323Z" style="fill:#000000"/><path d="M224 173L219 167M224 167L219 173M192 45L190 37M290 140L285 135M290 135L285 140M89 170C89 97 148 37 221 37C295 37 354 97 354 170C354 243 295 303 221 303C148 303 89 243 89 170" style="fill:none;stroke:#000000;stroke-width:2"/><text x="11" y="338" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">(</text><text x="22" y="338" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="35" y="338" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="222" y="188" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="321" y="277" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text><text x="189" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="288" y="155" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Q</text></svg>',
  'obr.svg',
  'Body C, Q a kružnice k se středem S procházející bodem C.',
  '',
  new List<String>{'Pravý úhel u $C$ znamená, že přepona $AB$ je průměrem kružnice $k$ (Thaletova věta), tedy $AB$ prochází středem $S$.','Přímka $AB$ prochází body $S$ a $Q$; její průsečíky s kružnicí $k$ jsou vrcholy $A$, $B$ (dvě řešení podle označení).'},
  'Přepona $AB$ je průměr kružnice $k$ (Thaletova věta), leží na přímce $SQ$; $A$, $B$ jsou průsečíky přímky $SQ$ s $k$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 11',
  new List<String>{'Obdélník se stranami $8\\ \\mathrm{cm}$ a $3\\ \\mathrm{cm}$ se skládá ze čtyř shodných trojúhelníků; jejich přemístěním vznikl kosočtverec (viz obrázek).','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 Obsah kosočtverce je větší než obsah obdélníku.','11.2 Strana kosočtverce měří $5\\ \\mathrm{cm}$.','11.3 Výška kosočtverce měří $4{,}8\\ \\mathrm{cm}$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah obdélníku $=8\\cdot3=24\\ \\mathrm{cm}^2$; kosočtverec vznikl přemístěním týchž trojúhelníků, obsah zůstává $24\\ \\mathrm{cm}^2$.','11.1: obsahy jsou stejné — N.','11.2: strana kosočtverce je přepona trojúhelníku s odvěsnami $4$ a $3$: $\\sqrt{4^2+3^2}=5\\ \\mathrm{cm}$ — A.','11.3: výška $=\\frac{24}{5}=4{,}8\\ \\mathrm{cm}$ — A.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 12',
  new List<String>{'V rovině leží rovnoramenný trojúhelník $ABC$ se základnou $AB$. Bod $S$ je střed základny $AB$ a prochází jím rovnoběžka s přímkou $AC$; v obrázku jsou vyznačeny úhly $\\varphi$ a $\\omega$ (viz obrázek).','Jaký je součet $\\varphi+\\omega$? (Velikosti neměřte, ale vypočtěte.)'},
  new List<String>{'A) $150^\\circ$','B) $155^\\circ$','C) $160^\\circ$','D) $165^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Z rovnoramennosti trojúhelníku a rovnoběžnosti přímky vedené bodem $S$ s ramenem $AC$ se dopočtou úhly $\\varphi$ a $\\omega$; jejich součet neodpovídá žádné z hodnot A–D.'},
  'E) jiná velikost',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
