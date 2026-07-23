String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M5C 2024 – úloha 7',
  new List<String>{'V rovině leží přímka $p$ a bod $K$, který neleží na této přímce (viz obrázek).','7.1 Narýsujte jeden čtverec $KLMN$ tak, aby body $L$ a $M$ ležely na přímce $p$.','7.2 Do stejného obrázku narýsujte rovnoramenný trojúhelník $KZM$ tak, aby ramena trojúhelníku tvořily úsečky $KM$ a $KZ$ a zároveň bod $Z$ ležel na přímce $p$. Při hledání bodu $Z$ použijte kružítko.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="245" x2="420" y2="85" stroke="#000" stroke-width="2"/> <text x="432" y="82" font-size="16" font-style="italic">p</text> <text x="200" y="122" font-size="16" font-style="italic" text-anchor="middle">K</text> <text x="200" y="138" font-size="16" text-anchor="middle">×</text> </svg>',
  'primka-bod-K.svg',
  'Přímka p vedená šikmo a bod K nad ní, který na přímce neleží.',
  'Výchozí obrázek k úloze 7',
  new List<String>{'7.1 Z bodu $K$ spustíme kolmici na přímku $p$; její pata je vrchol $L$. Bod $M$ leží na přímce $p$ tak, že $|LM|=|KL|$ (strana čtverce). Vrchol $N$ doplníme tak, aby $KLMN$ byl čtverec ($|KN|=|LM|$, $KN$ rovnoběžné s $LM$).','7.2 Rameno $KM$ je již sestrojeno. Bod $Z$ na přímce $p$ najdeme tak, aby $|KZ|=|KM|$: kružnice se středem $K$ a poloměrem $|KM|$ protne přímku $p$ v bodě $Z$ (různém od $M$). Trojúhelník $KZM$ je pak rovnoramenný se základnou $ZM$.'},
  'Konstrukce: 7.1 čtverec $KLMN$ ($L$ pata kolmice z $K$ na $p$, $M$ na $p$ s $|LM|=|KL|$); 7.2 bod $Z$ na $p$ s $|KZ|=|KM|$ (kružnice se středem $K$, poloměr $|KM|$), trojúhelník $KZM$ rovnoramenný – viz náčrt v klíči.',
  6, 10, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 8',
  new List<String>{'Ve čtvercové síti je nakreslen obrazec, který se skládá z částí označených písmeny $A$, $B$, $C$, $D$ a $E$ a jehož vrcholy leží v mřížových bodech. Každý čtvereček čtvercové sítě má stranu délky $1$ cm a obsah $1$ cm² (viz obrázek).','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Obvod části $E$ je $18$ cm.','8.2 Obsah části $A$ je právě čtyřikrát větší než obsah části $B$.','8.3 Obsah celého obrazce je větší než $60$ cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 258 226" font-family="sans-serif"><line x1="30" y1="20" x2="30" y2="196" stroke="#ccc"/><line x1="52" y1="20" x2="52" y2="196" stroke="#ccc"/><line x1="74" y1="20" x2="74" y2="196" stroke="#ccc"/><line x1="96" y1="20" x2="96" y2="196" stroke="#ccc"/><line x1="118" y1="20" x2="118" y2="196" stroke="#ccc"/><line x1="140" y1="20" x2="140" y2="196" stroke="#ccc"/><line x1="162" y1="20" x2="162" y2="196" stroke="#ccc"/><line x1="184" y1="20" x2="184" y2="196" stroke="#ccc"/><line x1="206" y1="20" x2="206" y2="196" stroke="#ccc"/><line x1="228" y1="20" x2="228" y2="196" stroke="#ccc"/><line x1="30" y1="20" x2="228" y2="20" stroke="#ccc"/><line x1="30" y1="42" x2="228" y2="42" stroke="#ccc"/><line x1="30" y1="64" x2="228" y2="64" stroke="#ccc"/><line x1="30" y1="86" x2="228" y2="86" stroke="#ccc"/><line x1="30" y1="108" x2="228" y2="108" stroke="#ccc"/><line x1="30" y1="130" x2="228" y2="130" stroke="#ccc"/><line x1="30" y1="152" x2="228" y2="152" stroke="#ccc"/><line x1="30" y1="174" x2="228" y2="174" stroke="#ccc"/><line x1="30" y1="196" x2="228" y2="196" stroke="#ccc"/><polygon points="30,20 118,20 118,108" fill="#e3e3e3" stroke="#000"/><polygon points="140,20 228,20 140,108" fill="#e3e3e3" stroke="#000"/><polygon points="30,196 118,196 118,108" fill="#e3e3e3" stroke="#000"/><polygon points="140,196 228,196 140,108" fill="#e3e3e3" stroke="#000"/><rect x="118" y="20" width="22" height="176" fill="#f4f4f4" stroke="#000"/><text x="70" y="60" font-size="14" text-anchor="middle" font-weight="bold">A</text><text x="188" y="60" font-size="14" text-anchor="middle" font-weight="bold">C</text><text x="70" y="176" font-size="14" text-anchor="middle" font-weight="bold">B</text><text x="188" y="176" font-size="14" text-anchor="middle" font-weight="bold">D</text><text x="129" y="112" font-size="14" text-anchor="middle" font-weight="bold">E</text></svg>',
  'obrazec-sit.svg',
  'Obrazec ve čtvercové síti složený z trojúhelníkových částí A, B, C, D a svislého úzkého obdélníku E.',
  'Schematický nákres obrazce ve čtvercové síti',
  new List<String>{'8.1 Část $E$ je úzký obdélník o rozměrech $1$ cm krát $8$ cm, jeho obvod je $2\\cdot(1+8)=18$ cm – pravdivé (A).','8.2 Obsah části $A$ není přesně čtyřnásobkem obsahu části $B$ – nepravdivé (N).','8.3 Celkový obsah obrazce není větší než $60$ cm² – nepravdivé (N).'},
  '8.1: A; 8.2: N; 8.3: N',
  3, 5, '3',
  new List<String>{'zs1','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
