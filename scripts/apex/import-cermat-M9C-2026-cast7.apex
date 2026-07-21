String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 11',
  new List<String>{'Tábor začal v pondělí snídaní a skončil v pátek po obědě. U snídaně měly mít službu vždy $4$ osoby, u oběda $5$ osob a u večeře také $5$ osob. Každé z $35$ dětí mělo službu v kuchyni právě jednou za celý tábor. Požadovaný počet osob vždy doplnili instruktoři, kteří měli službu společně s dětmi; každý instruktor měl službu nejvýše jedenkrát za den. V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), nebo nepravdivé (N):','11.1 V pátek mělo službu v kuchyni celkem $9$ dětí.','11.2 U každého jídla měli službu v kuchyni společně s dětmi nejvýše $3$ instruktoři.','11.3 Instruktorů muselo být na táboře nejméně $8$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 745 219"><path d="M4 198L466 198L466 199L4 199Z" style="fill:#000000"/><path d="M8 52L349 52L349 194L8 194ZM61 136L61 64M58 136L61 136M58 121L61 121M58 107L61 107M58 93L61 93M58 79L61 79M58 65L61 65M61 136L338 136M61 136L61 139M117 136L117 139M172 136L172 139M227 136L227 139M282 136L282 139M338 136L338 139" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M61 121L338 121M61 107L338 107M61 93L338 93M61 79L338 79M61 65L338 65M117 64L117 136M172 64L172 136M227 64L227 136M282 64L282 136M338 64L338 136" style="fill:none;stroke:#a6a6a6;stroke-width:1"/><path d="M290 61L301 61L301 136L290 136Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M69 107L80 107L80 136L69 136ZM124 121L136 121L136 136L124 136ZM179 93L191 93L191 136L179 136ZM234 121L246 121L246 136L234 136Z" style="fill:#595959;stroke:#000000;stroke-width:1"/><path d="M304 61L316 61L316 136L304 136Z" style="fill:#ffffff;stroke:#000000;stroke-width:1"/><path d="M83 79L95 79L95 136L83 136ZM138 93L150 93L150 136L138 136ZM194 93L205 93L205 136L194 136ZM249 107L261 107L261 136L249 136Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M98 121L109 121L109 136L98 136ZM153 93L165 93L165 136L153 136ZM208 107L220 107L220 136L208 136ZM263 93L275 93L275 136L263 136Z" style="fill:#969696;stroke:#000000;stroke-width:1"/><path d="M91 169L101 169L101 179L91 179Z" style="fill:#595959;stroke:#000000;stroke-width:1"/><path d="M158 169L168 169L168 179L158 179Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M213 169L223 169L223 179L213 179Z" style="fill:#969696;stroke:#000000;stroke-width:1"/><text x="225" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Požadovaný počet osob vždy doplnili instruktoři a ti pak měli službu společně s dětmi.</text><text x="121" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Přitom každý instruktor měl službu v kuchyni</text><text x="301" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">nejvýše jedenkrát za den</text><text x="370" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="179" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V grafu je uveden pouze rozpis služeb dětí, oba páteční údaje chybí.</text><text x="21" y="213" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="34" y="213" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="47" y="141" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">0</text><text x="47" y="127" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="47" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="47" y="99" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3</text><text x="47" y="85" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="47" y="70" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">5</text><text x="89" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pondělí</text><text x="144" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Úterý</text><text x="200" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Středa</text><text x="255" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Čtvrtek</text><text x="310" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Pátek</text><text x="29" y="124" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Počet dětí</text><text x="126" y="180" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Snídaně</text><text x="187" y="180" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Oběd</text><text x="244" y="180" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Večeře</text></svg>',
  'obr.svg',
  'Sloupcový graf rozpisu služeb dětí (snídaně, oběd, večeře) od pondělí do čtvrtka; oba páteční údaje chybí.',
  '',
  new List<String>{'Celkem je $35$ dětí; z grafu se sečtou služby dětí od pondělí do čtvrtka a dopočítá pátek.','11.1: v pátek (snídaně $+$ oběd) mělo službu jiný počet dětí než $9$ — N.','11.2: u některého jídla doplňovali děti více než $3$ instruktoři — N.','11.3: instruktorů muselo být nejméně $8$ — A.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','porozumeni','slovni','bezny-zivot'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
