String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)';
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
  'CERMAT 2023 M9A · úloha 10',
  new List<String>{'V rovině leží body $A$, $P$ a kružnice $k$ se středem $S$. Bod $A$ je vrchol rovnoramenného trojúhelníku $ABC$, jehož základna leží na přímce $AP$; vrcholy $B$, $C$ leží na kružnici $k$ (viz obrázek).','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 502 332"><path d="M4 267L5 267L5 268L4 268Z" style="fill:#000000"/><path d="M4 267L5 267L5 268L4 268Z" style="fill:#000000"/><path d="M5 267L467 267L467 268L5 268Z" style="fill:#000000"/><path d="M467 267L468 267L468 268L467 268Z" style="fill:#000000"/><path d="M467 267L468 267L468 268L467 268Z" style="fill:#000000"/><path d="M4 4L5 4L5 267L4 267Z" style="fill:#000000"/><path d="M467 4L468 4L468 267L467 267Z" style="fill:#000000"/><path d="M343 146L337 141M343 141L337 146M161 79L155 73M161 73L155 79M187 132L182 127M187 127L182 132M76 129C76 70 125 21 185 21C244 21 293 70 293 129C293 189 244 238 185 238C125 238 76 189 76 129" style="fill:none;stroke:#000000;stroke-width:2"/><text x="11" y="281" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">(</text><text x="22" y="281" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="35" y="281" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="432" y="295" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">max. 3 body</text><text x="16" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10</text><text x="56" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Bod</text><text x="71" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="98" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vrchol</text><text x="169" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoramenného</text><text x="249" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">trojúhelníku</text><text x="292" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="319" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">, jehož</text><text x="361" y="310" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">základna</text><text x="81" y="326" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">leží na přímce</text><text x="123" y="326" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AP</text><text x="133" y="326" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="340" y="161" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="158" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="185" y="147" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="261" y="225" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">k</text></svg>',
  'obr.svg',
  'Body A, P a kružnice k se středem S v rovině.',
  '',
  new List<String>{'Základna $BC$ leží na přímce $AP$? Nikoli — základna trojúhelníku leží na přímce procházející $A$; body $B$, $C$ jsou průsečíky této přímky s kružnicí $k$.','Trojúhelník je rovnoramenný (rameno $AB=AC$), takže $A$ leží na ose tětivy $BC$; odtud se sestrojí přímka $BC$ a její průsečíky s $k$.'},
  'Body $B$, $C$ jsou průsečíky kružnice $k$ s přímkou (základnou) procházející $A$ tak, aby $AB=AC$ (rovnoramenný trojúhelník; více řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 11',
  new List<String>{'Na turistické mapě odpovídá každých $3{,}5\\ \\mathrm{cm}$ vzdálenosti $700\\ \\mathrm{m}$ ve skutečnosti. Délka vycházkové trasy je $6\\ \\mathrm{km}$, což je trojnásobek délky přímé trasy.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 Trasa, která na mapě měří $49\\ \\mathrm{mm}$, je ve skutečnosti delší než $1\\ \\mathrm{km}$.','11.2 Na mapě je vycházková trasa o $20\\ \\mathrm{cm}$ delší než přímá trasa.','11.3 Měřítko turistické mapy je $1:200\\,000$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Měřítko: $3{,}5\\ \\mathrm{cm}$ na mapě $=700\\ \\mathrm{m}=70\\,000\\ \\mathrm{cm}$, tedy $1:20\\,000$.','11.1: $49\\ \\mathrm{mm}=4{,}9\\ \\mathrm{cm}$ je $\\frac{4{,}9}{3{,}5}\\cdot700=980\\ \\mathrm{m}<1\\ \\mathrm{km}$ — N.','11.2: vycházková $6\\ \\mathrm{km}$ je na mapě $30\\ \\mathrm{cm}$, přímá $2\\ \\mathrm{km}$ je $10\\ \\mathrm{cm}$; rozdíl $20\\ \\mathrm{cm}$ — A.','11.3: měřítko je $1:20\\,000$, nikoli $1:200\\,000$ — N.'},
  '11.1: N; 11.2: A; 11.3: N',
  4, 5, '3',
  new List<String>{'zs2','r9','pomer','procenta','argumentace','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
