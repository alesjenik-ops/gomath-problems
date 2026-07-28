String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 10 (konstrukce)',
  new List<String>{'V rovině je dán trojúhelník $RST$. Vrcholy $R$, $S$ leží na přímce $o$ (viz obrázek).','10.1 Sestrojte bod $P$, který je obrazem bodu $R$ ve středové souměrnosti se středem $S$.','10.2 Sestrojte bod $O$, který je obrazem bodu $T$ v osové souměrnosti s osou $o$.','10.3 Sestrojte chybějící vrchol $Q$ rovnoběžníku $OPQR$ a rovnoběžník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 320" font-family="sans-serif"><line x1="30" y1="234" x2="350" y2="272" stroke="#000" stroke-width="2"/><line x1="120" y1="245" x2="360" y2="40" stroke="#000" stroke-width="2"/><line x1="250" y1="260" x2="360" y2="40" stroke="#000" stroke-width="2"/><text x="42" y="228" font-size="15" font-style="italic">o</text><text x="112" y="268" font-size="15" font-style="italic">R</text><text x="244" y="284" font-size="15" font-style="italic">S</text><text x="364" y="34" font-size="15" font-style="italic">T</text></svg>',
  'trojuhelnik-rst.svg',
  'Trojúhelník RST, vrcholy R a S leží na přímce o, vrchol T je nad přímkou.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'10.1 Bod $P$ leží na polopřímce $RS$ za bodem $S$ tak, že $|SP|=|RS|$ (bod $S$ je střed úsečky $RP$).','10.2 Bod $O$ získáme jako obraz $T$ v osové souměrnosti podle $o$: z $T$ vedeme kolmici k $o$ a naneseme stejnou vzdálenost na druhou stranu.','10.3 V rovnoběžníku $OPQR$ platí, že úhlopříčky se půlí; vrchol $Q$ doplníme tak, aby $QR \\parallel OP$ a $PQ \\parallel RO$. Body $R$, $P$ leží na přímce $o$, body $O$ a $Q$ na opačných stranách od $o$.'},
  'Konstrukce podle klíče: $S$ je střed úsečky $RP$; $O$ je obraz $T$ v osové souměrnosti podle $o$; $Q$ doplňuje rovnoběžník $OPQR$ (kosočtverečný útvar s vrcholy $O$ dole a $Q$ nahoře).',
  6, 8, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2015 – úloha 11',
  new List<String>{'Rozhodněte o každém z následujících výpočtů (11.1–11.3), zda je proveden správně (A), či nikoli (N).','11.1 3 kg $-$ 20 g $=$ 280 g','11.2 5 km $-$ 72 m $=$ 4 928 m','11.3 14 m² $+$ 3,2 dm² $+$ 5 cm² $=$ 140 325 cm²'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'11.1 $3$ kg $=3\\,000$ g, tedy $3\\,000-20=2\\,980$ g, nikoli 280 g → Ne.','11.2 $5$ km $=5\\,000$ m, tedy $5\\,000-72=4\\,928$ m → Ano.','11.3 $14$ m² $=140\\,000$ cm², $3{,}2$ dm² $=320$ cm²; $140\\,000+320+5=140\\,325$ cm² → Ano.'},
  '11.1: Ne; 11.2: Ano; 11.3: Ano',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2015 – úloha 12',
  new List<String>{'Čtverec $ABCD$ je dvěma úsečkami rozdělen na čtyři části: čtverec s obvodem 8 cm, čtverec s obvodem 24 cm a dva tmavé obdélníky.','Rozhodněte o každém z následujících tvrzení (12.1–12.3), zda je pravdivé (A), či nikoli (N).','12.1 Oba tmavé obdélníky jsou shodné.','12.2 Obvod čtverce $ABCD$ je 36 cm.','12.3 Obsah plochy tvořené oběma bílými čtverci je 40 cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 320" font-family="sans-serif"><rect x="70" y="40" width="180" height="60" fill="#9e9e9e" stroke="#000"/><rect x="250" y="40" width="60" height="60" fill="#fff" stroke="#000"/><rect x="70" y="100" width="180" height="180" fill="#fff" stroke="#000"/><rect x="250" y="100" width="60" height="180" fill="#bdbdbd" stroke="#000"/><rect x="70" y="40" width="240" height="240" fill="none" stroke="#000" stroke-width="2"/><text x="56" y="32" font-size="15" font-style="italic">D</text><text x="314" y="32" font-size="15" font-style="italic">C</text><text x="56" y="298" font-size="15" font-style="italic">A</text><text x="314" y="298" font-size="15" font-style="italic">B</text><text x="280" y="75" font-size="11" text-anchor="middle">o₁ = 8 cm</text><text x="160" y="190" font-size="12" text-anchor="middle">o₂ = 24 cm</text></svg>',
  'ctverec-abcd.svg',
  'Čtverec ABCD rozdělený dvěma úsečkami na malý bílý čtverec vpravo nahoře, velký bílý čtverec vlevo dole a dva tmavé obdélníky.',
  'Rozdělení čtverce ABCD',
  new List<String>{'Malý čtverec má stranu $8:4=2$ cm, velký čtverec stranu $24:4=6$ cm. Strana čtverce $ABCD$ je $2+6=8$ cm.','12.1 Oba tmavé obdélníky mají rozměry $6$ cm a $2$ cm, jsou tedy shodné → Ano.','12.2 Obvod $ABCD$ je $4\\cdot 8=32$ cm, nikoli 36 cm → Ne.','12.3 Obsah bílých čtverců je $2^2+6^2=4+36=40$ cm² → Ano.'},
  '12.1: Ano; 12.2: Ne; 12.3: Ano',
  3, 5, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
