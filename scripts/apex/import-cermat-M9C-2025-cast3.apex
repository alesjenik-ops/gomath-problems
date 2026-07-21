String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
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
  'CERMAT 2025 M9C · úloha 9',
  new List<String>{'V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).','Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$.','Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 361"><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M5 18L467 18L467 19L5 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M4 19L5 19L5 38L4 38Z" style="fill:#000000"/><path d="M467 19L468 19L468 38L467 38Z" style="fill:#000000"/><path d="M4 38L5 38L5 357L4 357Z" style="fill:#000000"/><path d="M467 38L468 38L468 357L467 357Z" style="fill:#000000"/><path d="M175 160L181 166M181 160L175 166M364 199L66 199" style="fill:none;stroke:#000000;stroke-width:2"/><text x="111" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">VÝCHOZÍ TEXT A OBRÁZEK K ÚLOZE 9</text><text x="55" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="109" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="117" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="145" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="173" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text><text x="179" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="179" y="158" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="360" y="211" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text></svg>',
  'obr.svg',
  'Body B, M a přímka q v rovině.',
  '',
  new List<String>{'$BM$ je výška na stranu $AC$, tedy $BM\\perp AC$; přímka $AC$ prochází bodem $M$ kolmo k $BM$.','Vrchol $A$ je průsečík této přímky $AC$ s přímkou $q$.','Trojúhelník je rovnoramenný se základnou $AB$ (ramena $CA=CB$), takže $C$ leží na ose úsečky $AB$ i na přímce $AM$.'},
  'Přímka $AC\\perp BM$ prochází bodem $M$; $A=AC\\cap q$; vrchol $C$ leží na přímce $AM$ a na ose úsečky $AB$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 10',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ (viz obrázek).','Bod $A$ je vrchol obdélníku $ABCD$, jehož vrchol $D$ leží na přímce $p$. Bod $S$ je střed strany $CD$.','Sestrojte vrcholy $B$, $C$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 318"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 314L4 314Z" style="fill:#000000"/><path d="M467 23L468 23L468 314L467 314Z" style="fill:#000000"/><path d="M37 196L43 202M43 196L37 202M221 103L227 108M227 103L221 108M406 69L24 69" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="110" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="115" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="142" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="170" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="175" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="38" y="216" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="228" y="101" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="402" y="82" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'Body A, S a přímka p v rovině.',
  '',
  new List<String>{'$S$ je střed strany $CD$; strana $AD$ je kolmá k $CD$. Vrchol $D$ leží na přímce $p$.','Protože $AD\\perp DC$ a $S$ je střed $CD$, dopočítáme $D$ jako patu kolmice a $C$ jako obraz $D$ podle $S$; vrchol $B$ doplníme rovnoběžníkem.','Podle polohy vzniknou dvě řešení.'},
  'Vrchol $D$ na přímce $p$ s $AD\\perp DC$; $C$ je obraz $D$ podle středu $S$; $B$ dopočteme jako obdélník (dvě řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
