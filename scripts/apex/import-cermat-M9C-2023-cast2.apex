String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 7',
  new List<String>{'Rotační válec má výšku $12\\ \\mathrm{cm}$. Odstraněním čtyř částí vytvoříme z tohoto válce kvádr s rozměry $8\\ \\mathrm{cm}$, $6\\ \\mathrm{cm}$ a $12\\ \\mathrm{cm}$. Všechny hrany kvádru leží na povrchu válce.','7.1 Vypočtěte v cm poloměr podstavy válce.','7.2 Vypočtěte v cm$^3$ objem válce. Výsledek zaokrouhlete na desítky cm$^3$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 158"><path d="M4 153L5 153L5 154L4 154Z" style="fill:#000000"/><path d="M4 153L5 153L5 154L4 154Z" style="fill:#000000"/><path d="M5 153L467 153L467 154L5 154Z" style="fill:#000000"/><path d="M467 153L468 153L468 154L467 154Z" style="fill:#000000"/><path d="M467 153L468 153L468 154L467 154Z" style="fill:#000000"/><path d="M4 4L5 4L5 153L4 153Z" style="fill:#000000"/><path d="M467 4L468 4L468 153L467 153Z" style="fill:#000000"/><path d="M186 70L261 70L261 122L186 122ZM186 122L223 86M261 122L298 86M261 70L298 33M186 70L223 33M223 86L223 33M223 86L298 86M298 86L298 33M223 33L298 33M130 92C113 109 84 109 66 91C49 74 49 45 66 27M67 27C84 10 113 10 131 27C148 45 148 74 131 91M16 96C16 71 37 51 62 51C87 51 107 71 107 96C107 121 87 142 62 142C37 142 16 121 16 96M30 64L67 27M94 128L131 91" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M61 33L136 33L136 85L61 85ZM25 70L99 70L99 122L25 122ZM25 122L61 85M25 70L61 33M99 122L136 85M99 70L136 33" style="fill:none;stroke:#000000;stroke-width:1"/><text x="225" y="137" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="171" y="102" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="298" y="115" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12 cm</text></svg>',
  'obr.svg',
  'Rotační válec o výšce 12 cm a z něj vytvořený kvádr s rozměry 8 cm, 6 cm a 12 cm; hrany kvádru leží na povrchu válce.',
  '',
  new List<String>{'7.1: obdélník $8\\times6$ je vepsán do podstavy válce, jeho úhlopříčka je průměrem: $\\sqrt{8^2+6^2}=\\sqrt{100}=10\\ \\mathrm{cm}$, tedy $r=5\\ \\mathrm{cm}$.','7.2: $V=\\pi r^2 h=\\pi\\cdot25\\cdot12=300\\pi\\doteq942\\doteq940\\ \\mathrm{cm}^3$.'},
  '7.1: $r=5\\ \\mathrm{cm}$; 7.2: $V\\doteq940\\ \\mathrm{cm}^3$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 8',
  new List<String>{'V obchodě s oříšky prodávají různé směsi. Jejich cena závisí pouze na hmotnosti a ceně použitých surovin. Ceny za $1\\ \\mathrm{kg}$: arašídy $80$ korun, kešu $280$ korun, mandle $200$ korun.','8.1 Dvoukilogramové balení směsi arašídů a mandlí obsahuje $800\\ \\mathrm{g}$ arašídů a $1\\,200\\ \\mathrm{g}$ mandlí. Vypočtěte, kolik korun stojí jeden kilogram této směsi.','8.2 Jiná směs obsahuje pouze arašídy a kešu, přičemž $1\\ \\mathrm{kg}$ této směsi stojí $200$ korun. Velké balení této směsi obsahuje $500\\ \\mathrm{g}$ arašídů. Vypočtěte, kolik gramů kešu obsahuje velké balení této směsi.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: cena $2\\ \\mathrm{kg}$ $=0{,}8\\cdot80+1{,}2\\cdot200=64+240=304$ korun, tedy $1\\ \\mathrm{kg}$ stojí $152$ korun.','8.2: nechť balení obsahuje $m$ kg kešu; $\\frac{0{,}5\\cdot80+m\\cdot280}{0{,}5+m}=200\\Rightarrow40+280m=100+200m\\Rightarrow80m=60\\Rightarrow m=0{,}75\\ \\mathrm{kg}=750\\ \\mathrm{g}$.'},
  '8.1: $152$ korun; 8.2: $750\\ \\mathrm{g}$',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
