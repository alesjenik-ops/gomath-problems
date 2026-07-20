String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený J8 – Beranovi a Kozlovi na trase',
  new List<String>{'Na startu turistické etapy se sešli Beranovi a Kozlovi. Rozhodli se, že vyrazí do cíle jinou cestou podle situačního plánku na obrázku. Odstartovali ve stejný okamžik. Rychlost chůze Beranových byla o třetinu vyšší než Kozlových. Čtverec má rozměry $10$ km $\\times$ $10$ km; Beranovi jdou spodní a pravou stranou, Kozlovi levou a horní stranou.','8.1 Vypočtěte, jaká je vzdálenost mezi Beranovými a Kozlovými v okamžiku, kdy Beranovi ušli prvních $8$ km.','8.2 Vypočtěte, jaká bude vzdálenost mezi Beranovými a Kozlovými po dvou hodinách chůze, víme-li, že Beranovi jdou rychlostí $8$ km/h.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 450" font-family="sans-serif"> <rect x="90" y="70" width="330" height="300" fill="none" stroke="#000" stroke-width="2.5"/> <text x="428" y="64" font-size="16" font-weight="bold">CÍL</text> <text x="86" y="392" font-size="16" font-weight="bold" text-anchor="end">START</text> <line x1="90" y1="398" x2="420" y2="398" stroke="#333" stroke-width="1.5"/> <polygon points="420,398 410,393 410,403" fill="#333"/> <text x="255" y="420" font-size="15" text-anchor="middle">Beranovi</text> <line x1="66" y1="370" x2="66" y2="70" stroke="#333" stroke-width="1.5"/> <polygon points="66,70 61,80 71,80" fill="#333"/> <text x="52" y="220" font-size="15" text-anchor="middle" transform="rotate(-90 52 220)">Kozlovi</text> <text x="255" y="235" font-size="15" text-anchor="middle">10 km</text> <text x="180" y="225" font-size="15" text-anchor="middle" transform="rotate(-90 180 225)">10 km</text> <circle cx="90" cy="196" r="6" fill="#888"/> <circle cx="290" cy="370" r="6" fill="#888"/> <line x1="90" y1="196" x2="290" y2="370" stroke="#000" stroke-width="1.5" stroke-dasharray="4 5"/> </svg>',
  'trasa-ctverec.svg',
  'Čtvercová trasa 10 km krát 10 km; Beranovi jdou spodní a pravou stranou, Kozlovi levou a horní stranou, čárkovaná úsečka spojuje jejich okamžité polohy.',
  'Situační plánek trasy',
  new List<String>{'8.1 Beranovi mají o třetinu vyšší rychlost, takže Kozlovi ujdou $\\frac{3}{4}$ dráhy Beranových. Když Beranovi ušli $8$ km (po spodní straně), Kozlovi ušli $\\frac{3}{4}\\cdot 8=6$ km (po levé straně). Vzdálenost $=\\sqrt{8^2+6^2}=\\sqrt{100}=10$ km.','8.2 Za $2$ h ujdou Beranovi $16$ km: $10$ km spodní stranou a $6$ km nahoru po pravé straně. Kozlovi ujdou $\\frac{3}{4}\\cdot 16=12$ km: $10$ km levou stranou a $2$ km po horní straně. Vzdálenost $=\\sqrt{8^2+4^2}=\\sqrt{80}\\approx$ necelých $9$ km.'},
  '8.1: $10$ km; 8.2: $\\sqrt{80}\\approx 8{,}9$ km (necelých $9$ km)',
  4, 8, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený J9 – množina bodů k přímkám p, q',
  new List<String>{'V rovině leží přímky $p$ a $q$, které se protínají v bodě $S$.','Vyznačte množinu bodů, které jsou od přímky $q$ vzdáleny třikrát více než od přímky $p$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 380" font-family="sans-serif"> <text x="150" y="58" font-size="18" font-weight="bold" text-anchor="middle">S</text> <line x1="150" y1="70" x2="120" y2="360" stroke="#000" stroke-width="2"/> <text x="104" y="375" font-size="18" font-style="italic">q</text> <line x1="150" y1="70" x2="400" y2="300" stroke="#000" stroke-width="2"/> <text x="405" y="306" font-size="18" font-style="italic">p</text> </svg>',
  'primky-pq.svg',
  'Dvě různoběžné přímky p a q protínající se v bodě S.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Hledaná množina leží na přímkách procházejících bodem $S$ (průsečík $p$ a $q$), protože pro každý bod takové přímky je poměr vzdáleností od $p$ a $q$ stálý. Sestrojíme bod, jehož vzdálenost od $p$ je $1$ díl a od $q$ jsou $3$ díly (např. průsečík rovnoběžky s $p$ ve vzdálenosti $1$ a rovnoběžky s $q$ ve vzdálenosti $3$), a spojíme jej s $S$. Řešením jsou dvě přímky procházející $S$ (viz obrázek v klíči).'},
  'Dvě přímky procházející bodem $S$; jejich body mají od $q$ třikrát větší vzdálenost než od $p$ (viz konstrukce v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
