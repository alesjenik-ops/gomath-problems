String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
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
  'CERMAT M5B 2023 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou zakresleny bílé obrazce A, C, E a tmavé obrazce B, D, F (viz obrázek). Vrcholy všech obrazců leží v mřížových bodech čtvercové sítě. Obsah obrazce C je $9$ cm².','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 Obsah obrazce B tvoří čtvrtinu obsahu obrazce A.','8.2 Obsah obrazce C je třikrát větší než obsah obrazce D.','8.3 Obsah obrazce E je o třetinu větší než obsah obrazce F.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 392 122" font-family="sans-serif"><g stroke="#bbb" stroke-width="1"><line x1="16" y1="16" x2="16" y2="106"/><line x1="31" y1="16" x2="31" y2="106"/><line x1="46" y1="16" x2="46" y2="106"/><line x1="61" y1="16" x2="61" y2="106"/><line x1="76" y1="16" x2="76" y2="106"/><line x1="91" y1="16" x2="91" y2="106"/><line x1="106" y1="16" x2="106" y2="106"/><line x1="121" y1="16" x2="121" y2="106"/><line x1="136" y1="16" x2="136" y2="106"/><line x1="151" y1="16" x2="151" y2="106"/><line x1="166" y1="16" x2="166" y2="106"/><line x1="181" y1="16" x2="181" y2="106"/><line x1="196" y1="16" x2="196" y2="106"/><line x1="211" y1="16" x2="211" y2="106"/><line x1="226" y1="16" x2="226" y2="106"/><line x1="241" y1="16" x2="241" y2="106"/><line x1="256" y1="16" x2="256" y2="106"/><line x1="271" y1="16" x2="271" y2="106"/><line x1="286" y1="16" x2="286" y2="106"/><line x1="301" y1="16" x2="301" y2="106"/><line x1="316" y1="16" x2="316" y2="106"/><line x1="331" y1="16" x2="331" y2="106"/><line x1="346" y1="16" x2="346" y2="106"/><line x1="361" y1="16" x2="361" y2="106"/><line x1="376" y1="16" x2="376" y2="106"/><line x1="16" y1="16" x2="376" y2="16"/><line x1="16" y1="31" x2="376" y2="31"/><line x1="16" y1="46" x2="376" y2="46"/><line x1="16" y1="61" x2="376" y2="61"/><line x1="16" y1="76" x2="376" y2="76"/><line x1="16" y1="91" x2="376" y2="91"/><line x1="16" y1="106" x2="376" y2="106"/></g><g fill="#fff" stroke="#000" stroke-width="1.6"><polygon points="31,31 91,31 31,61"/><rect x="151" y="31" width="45" height="45"/><polygon points="271,31 271,91 316,91"/></g><g fill="#8a8a8a" stroke="#000" stroke-width="1.6"><polygon points="106,46 136,46 106,61"/><polygon points="211,31 256,31 211,61"/><polygon points="331,31 376,31 331,76"/></g><rect x="211" y="31" width="45" height="30" fill="none" stroke="#000" stroke-dasharray="4 3"/><g font-size="12" font-weight="bold" text-anchor="middle"><text x="46" y="48">A</text><text x="117" y="59">B</text><text x="174" y="61">C</text><text x="226" y="48">D</text><text x="286" y="80">E</text><text x="346" y="61">F</text></g></svg>',
  'ctvercova-sit.svg',
  'Čtvercová síť s bílými obrazci A, C, E a tmavými obrazci B, D, F; obrazce jsou pravoúhlé trojúhelníky a čtverec s vrcholy v mřížových bodech.',
  'Schematický nákres obrazců ve čtvercové síti (obsah C = 9 cm²)',
  new List<String>{'Obrazec C je čtverec $3\\times 3$ čtverečky s obsahem $9$ cm², takže jeden čtvereček sítě má obsah $1$ cm². Obsahy obrazců: A $=4$ cm², B $=1$ cm², C $=9$ cm², D $=3$ cm², E $=6$ cm², F $=4{,}5$ cm².','8.1 $B=1=\\frac{1}{4}\\cdot 4$, tj. čtvrtina obsahu A — pravdivé (A).','8.2 $C=9=3\\cdot 3=3D$ — pravdivé (A).','8.3 $E=6=4{,}5+\\frac{1}{3}\\cdot 4{,}5$, tj. o třetinu více než F — pravdivé (A).'},
  '8.1: Ano (A); 8.2: Ano (A); 8.3: Ano (A)',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 9',
  new List<String>{'Každá bytost na planetě Zorstar má právě tři nohy a zároveň má buď tři oči, nebo čtyři oči. Na náměstí se sešly bytosti, které měly dohromady $84$ nohou. Mezi nimi bylo tříokých bytostí o $8$ více než čtyřokých.','Kolik očí měly dohromady všechny bytosti, které se sešly na náměstí?'},
  new List<String>{'A) 94 očí','B) 96 očí','C) 102 očí','D) 122 očí','E) 130 očí'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Každá bytost má 3 nohy, dohromady $84$ nohou, tedy $84:3=28$ bytostí. Čtyřokých je $x$, tříokých $x+8$; z $x+(x+8)=28$ plyne $x=10$. Čtyřokých je $10$, tříokých $18$. Očí celkem $18\\cdot 3+10\\cdot 4=54+40=94$.'},
  'A) 94 očí',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
