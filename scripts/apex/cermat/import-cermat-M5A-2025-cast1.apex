String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M5A 2025 – úloha 1.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$\\square : 11 = (5 + 5\\cdot 20) - 101$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pravá strana: $5 + 5\\cdot 20 - 101 = 5 + 100 - 101 = 4$. Pak $\\square : 11 = 4$, tedy $\\square = 4\\cdot 11 = 44$.'},
  '$44$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2025 – úloha 1.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$(188 - 152) : \\left(1 + \\square\\right) = 4 + 20 : 4$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pravá strana: $4 + 20 : 4 = 4 + 5 = 9$. Levá strana: $(188 - 152) : (1 + \\square) = 36 : (1 + \\square)$. Z $36 : (1 + \\square) = 9$ plyne $1 + \\square = 4$, tedy $\\square = 3$.'},
  '$3$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2025 – úloha 2',
  new List<String>{'2.1 Tabulka má obsahovat všechna celá čísla od 0 do 8. Do prázdných polí tabulky se doplní chybějící čísla tak, aby byl součet v každém sloupci i v každém řádku stejný. Určete číslo, které patří do prostředního pole tabulky.','2.2 V diagramu se do prázdných kroužků doplní taková čísla, aby byly všechny výpočty provedené ve směru šipek správné. Určete obě čísla doplněná do prázdných kroužků.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 220" font-family="sans-serif"> <text x="105" y="26" font-size="12" text-anchor="middle">2.1 tabulka (čísla 0 až 8)</text> <line x1="30" y1="45" x2="180" y2="45" stroke="#000"/> <line x1="30" y1="95" x2="180" y2="95" stroke="#000"/> <line x1="30" y1="145" x2="180" y2="145" stroke="#000"/> <line x1="30" y1="195" x2="180" y2="195" stroke="#000"/> <line x1="30" y1="45" x2="30" y2="195" stroke="#000"/> <line x1="80" y1="45" x2="80" y2="195" stroke="#000"/> <line x1="130" y1="45" x2="130" y2="195" stroke="#000"/> <line x1="180" y1="45" x2="180" y2="195" stroke="#000"/> <rect x="80" y="95" width="50" height="50" fill="none" stroke="#000" stroke-width="3"/> <text x="55" y="77" font-size="20" text-anchor="middle">0</text> <text x="155" y="127" font-size="20" text-anchor="middle">2</text> <text x="105" y="177" font-size="20" text-anchor="middle">1</text> <text x="155" y="177" font-size="20" text-anchor="middle">3</text> <text x="430" y="26" font-size="12" text-anchor="middle">2.2 diagram</text> <circle cx="372" cy="120" r="30" fill="none" stroke="#000"/> <circle cx="488" cy="120" r="30" fill="none" stroke="#000"/> <path d="M 400 108 Q 430 78 460 108" fill="none" stroke="#000"/> <polygon points="460,108 451,103 454,113" fill="#000"/> <text x="430" y="72" font-size="14" text-anchor="middle">+ 90</text> <path d="M 460 132 Q 430 162 400 132" fill="none" stroke="#000"/> <polygon points="400,132 409,127 406,137" fill="#000"/> <text x="430" y="180" font-size="14" text-anchor="middle">: 3</text> </svg>',
  'tabulka-diagram.svg',
  'Tabulka 3 krát 3 s čísly 0, 2, 1, 3 a zvýrazněným prostředním polem; diagram se dvěma kroužky a šipkami plus 90 a děleno 3.',
  'Doplňovaná tabulka (2.1) a diagram se šipkami (2.2)',
  new List<String>{'2.1 Součet čísel 0 až 8 je $36$, v každém řádku i sloupci tedy $36 : 3 = 12$. Doplněním vyjde prostřední pole $6$ (řádky $0, 5, 7$; $4, 6, 2$; $8, 1, 3$).','2.2 Levý kroužek $x$, pravý $x + 90$; při návratu dělíme třemi: $(x + 90) : 3 = x$, odtud $x + 90 = 3x$, $x = 45$ a $x + 90 = 135$.'},
  '2.1: $6$; 2.2: $45$; $135$',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2025 – úloha 3',
  new List<String>{'Mirek má menší jízdní kolo než jeho táta. Mirek na rovné cestě zjišťoval, kolikrát se u obou jízdních kol otočí přední kolo, jestliže obě jízdní kola urazí stejnou vzdálenost. Když se Mirkovo přední kolo otočilo 30krát, tátovo přední kolo se otočilo jen 25krát.','Mirek a jeho táta urazili na svých jízdních kolech stejnou vzdálenost. Vypočtěte, kolikrát se otočilo Mirkovo přední kolo,','3.1 jestliže se tátovo přední kolo otočilo 30krát,','3.2 jestliže tátovo přední kolo vykonalo o 30 otáček méně než Mirkovo přední kolo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Poměr počtu otáček Mirkova a tátova předního kola je při stejné dráze $30 : 25 = 6 : 5$ (menší kolo se otočí vícekrát).','3.1 Když se tátovo kolo otočí $30$krát, Mirkovo se otočí $30\\cdot\\frac{6}{5} = 36$krát.','3.2 Je-li Mirkovo $M$ a tátovo $M - 30$, platí $M : (M - 30) = 6 : 5$, tj. $5M = 6(M - 30)$, $M = 180$. Mirkovo kolo se otočilo $180$krát.'},
  '3.1: $36$krát; 3.2: $180$krát',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
