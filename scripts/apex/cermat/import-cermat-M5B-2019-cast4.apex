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
  'CERMAT M5B 2019 – úloha 8',
  new List<String>{'Čtvercová síť je tvořena čtverečky o obsahu $1$ cm². Ve čtvercové síti je zakreslen čtverec, který je rozdělen na $3$ trojúhelníky a tmavý obrazec. Trojúhelníky jsou označeny písmeny $A$ až $C$. Vrcholy všech útvarů leží v mřížových bodech.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Obsah trojúhelníku $A$ je dvojnásobkem obsahu trojúhelníku $B$.','8.2 Obsah celého čtverce je $12$krát větší než obsah trojúhelníku $C$.','8.3 Obsah tmavého obrazce je větší než $15$ cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 262 214" font-family="sans-serif"><g stroke="#000" stroke-width="1.6"><polygon points="62,186 146,18 202,186" fill="#333333"/><polygon points="34,18 146,18 34,186" fill="#c9c9c9"/><polygon points="146,18 202,18 202,186" fill="#c9c9c9"/><polygon points="34,186 146,18 62,186" fill="#c9c9c9"/></g><g stroke="#888" stroke-width="0.6"><line x1="34" y1="18" x2="34" y2="186"/><line x1="34" y1="18" x2="202" y2="18"/><line x1="62" y1="18" x2="62" y2="186"/><line x1="34" y1="46" x2="202" y2="46"/><line x1="90" y1="18" x2="90" y2="186"/><line x1="34" y1="74" x2="202" y2="74"/><line x1="118" y1="18" x2="118" y2="186"/><line x1="34" y1="102" x2="202" y2="102"/><line x1="146" y1="18" x2="146" y2="186"/><line x1="34" y1="130" x2="202" y2="130"/><line x1="174" y1="18" x2="174" y2="186"/><line x1="34" y1="158" x2="202" y2="158"/><line x1="202" y1="18" x2="202" y2="186"/><line x1="34" y1="186" x2="202" y2="186"/></g><rect x="34" y="18" width="168" height="168" fill="none" stroke="#000" stroke-width="2"/><g font-size="14" font-weight="bold"><text x="59.2" y="85.2">A</text><text x="171.20000000000002" y="85.2">B</text><text x="67.6" y="169.20000000000002">C</text></g><text x="206" y="177.6" font-size="10">1 cm²</text></svg>',
  'ctvercova-sit.svg',
  'Čtverec 6 krát 6 ve čtvercové síti rozdělený na tři šedé trojúhelníky A, B, C a tmavý obrazec; jeden čtvereček má obsah 1 cm².',
  'Schematický nákres (obsahy útvarů odpovídají zadání)',
  new List<String>{'Čtverec má stranu $6$ cm, tedy obsah $36$ cm². Trojúhelníky mají obsah $A = 12$ cm², $B = 6$ cm² a $C = 3$ cm²; tmavý obrazec má $36 - 12 - 6 - 3 = 15$ cm².','8.1 $12 = 2 \\cdot 6$ → Ano.','8.2 $36 = 12 \\cdot 3$ → Ano.','8.3 Tmavý obrazec má $15$ cm², což není více než $15$ cm² → Ne.'},
  '8.1: Ano; 8.2: Ano; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2019 – úloha 9',
  new List<String>{'Umělec prodal v létě $72$ obrazů. Na podzim prodal o čtvrtinu obrazů méně než v létě. V zimě pak prodal jen osminu toho, co prodal v létě.','Kolikrát více obrazů umělec prodal na podzim než v zimě?'},
  new List<String>{'A) dvakrát','B) třikrát','C) čtyřikrát','D) pětkrát','E) šestkrát'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Podzim: $72 - \\frac{72}{4} = 72 - 18 = 54$ obrazů. Zima: $\\frac{72}{8} = 9$ obrazů. Poměr $54 : 9 = 6$.'},
  'E) šestkrát',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2019 – úloha 10',
  new List<String>{'Do prázdného klobouku jsme vysypali červené a zelené kuličky, zelených bylo o $6$ více než červených. Pak jsme z klobouku vytáhli třetinu všech červených a třetinu všech zelených kuliček. V klobouku tak ubylo $12$ kuliček.','Kolik červených kuliček v klobouku zbylo?'},
  new List<String>{'A) $5$','B) $10$','C) $12$','D) $15$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Červené $c$, zelené $c + 6$. Vytáhli třetinu obou: $\\frac{1}{3}(c + c + 6) = 12$, tj. $2c + 6 = 36$, $c = 15$. Zbylo červených $\\frac{2}{3} \\cdot 15 = 10$.'},
  'B) $10$',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
