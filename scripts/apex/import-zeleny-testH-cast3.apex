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
  'Zelený H8 – pozlacení jehlanu',
  new List<String>{'Radní v našem městě rozhodli o tom, že bude zrekonstruována pozlacená pyramida stojící na náměstí. Artefakt má tvar pravidelného čtyřbokého jehlanu se čtvercovou základnou $6\\times6$ metrů. Výška jehlanu je $4$ metry. Stěny jehlanu budou v rámci rekonstrukce znovu pozlaceny.','Zlacení probíhá polepením stěn jehlanu zlatými plátky o velikosti $8\\times8$ cm. Celková plocha zlatých plátků musí být o $\\frac{1}{15}$ větší, než je zlacená plocha. Cena $1$ balíčku $25$ zlatých plátků je $2000$ Kč.','8.1 Vypočtěte obsah plochy všech čtyř stěn jehlanu.','8.2 Vypočtěte celkovou cenu zlatých plátků potřebných k pozlacení stěn jehlanu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <polygon points="90,320 300,320 410,270 200,270" fill="none" stroke="#000" stroke-width="2"/> <line x1="90" y1="320" x2="245" y2="70" stroke="#000" stroke-width="2"/> <line x1="300" y1="320" x2="245" y2="70" stroke="#000" stroke-width="2"/> <line x1="410" y1="270" x2="245" y2="70" stroke="#000" stroke-width="2"/> <line x1="200" y1="270" x2="245" y2="70" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="200" y1="270" x2="300" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="200" y1="270" x2="90" y2="320" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="200" y1="270" x2="410" y2="270" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="245" y1="70" x2="245" y2="295" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="195" y="345" font-size="16" text-anchor="middle">6 metrů</text> <text x="470" y="200" font-size="15" text-anchor="middle" transform="rotate(-90 470 200)">výška = 4 metry</text> </svg>',
  'jehlan.svg',
  'Pravidelný čtyřboký jehlan se čtvercovou základnou 6 metrů a výškou 4 metry.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'8.1 Výška boční stěny (od vrcholu ke středu podstavné hrany): $\\sqrt{3^2+4^2}=5$ m. Obsah jedné stěny $\\frac{1}{2}\\cdot6\\cdot5=15$ m², čtyři stěny mají $60$ m².','8.2 Plocha plátků $60\\cdot\\frac{16}{15}=64$ m². Jeden plátek $8\\times8$ cm $=0{,}0064$ m², plátků je $64:0{,}0064=10\\,000$. Balíčků $10\\,000:25=400$, cena $400\\cdot2000=800\\,000$ Kč.'},
  '8.1: $60$ m²; 8.2: $800\\,000$ Kč',
  4, 8, '3',
  new List<String>{'zs2','r9','stereometrie','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'Zelený H9 – množina bodů (P, R, S)',
  new List<String>{'V rovině jsou dány body $P$, $R$ a $S$ (viz obrázek).','Vyznačte množinu bodů, které nejsou vzdáleny od bodů $P$ a $R$ více než $8$ cm a zároveň nejsou vzdáleny od bodu $S$ více než $9$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <text x="250" y="72" font-size="24" text-anchor="middle">+</text> <text x="250" y="52" font-size="18" text-anchor="middle" font-style="italic">S</text> <text x="120" y="345" font-size="24" text-anchor="middle">+</text> <text x="120" y="372" font-size="18" text-anchor="middle" font-style="italic">P</text> <text x="400" y="345" font-size="24" text-anchor="middle">+</text> <text x="400" y="372" font-size="18" text-anchor="middle" font-style="italic">R</text> </svg>',
  'body-prs.svg',
  'Tři body v rovině: S nahoře uprostřed, P vlevo dole a R vpravo dole.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Hledaná množina je průnik tří kruhů: kruhu se středem $P$ a poloměrem $8$ cm, kruhu se středem $R$ a poloměrem $8$ cm a kruhu se středem $S$ a poloměrem $9$ cm. Je to plocha ohraničená částmi příslušných kružnic $k_p$, $k_r$ a $k_s$; hraniční oblouky do množiny patří.'},
  'Plocha ohraničená tučně zvýrazněnými částmi kružnic $k_s$, $k_p$ a $k_r$ (průnik kruhů se středy $P$, $R$ o poloměru $8$ cm a se středem $S$ o poloměru $9$ cm); zvýrazněná hranice plochy je součástí množiny bodů.',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
