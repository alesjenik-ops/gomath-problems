String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
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
  'CERMAT M7C 2025 – úloha 5',
  new List<String>{'Cyklista jel část své trasy po rovině, část klesal a zbytek trasy stoupal. Po rovině ujel třetinu délky celé trasy, klesání bylo pětkrát kratší než celá trasa. Stoupání bylo na 14 km trasy a cyklista v něm za každou minutu ujel 280 m.','5.1 Vypočtěte v km délku celé cyklistovy trasy.','5.2 Vypočtěte, kolik minut cyklista na své trase stoupal.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Rovina je $\\frac{1}{3}$ trasy, klesání $\\frac{1}{5}$ trasy, stoupání $14$ km. Pro délku $c$ platí $c-\\frac{c}{3}-\\frac{c}{5}=14$, tj. $\\frac{7}{15}c=14$, $c=30$ km.','5.2 Ve stoupání jel $280$ m za minutu, tj. $0{,}28$ km/min. $14:0{,}28=50$ minut.'},
  '5.1: $30$ km; 5.2: $50$ minut',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2025 – úloha 6.1',
  new List<String>{'Písmena $K$, $L$ představují dvě různé číslice. V zápise součtu dvou trojciferných čísel $KLL+KLK$ se místo hvězdiček doplní chybějící číslice součtu tak, aby byl výpočet správný; součet má tvar $\\ast\\,\\ast\\,1\\,1$ (končí dvojčíslím $11$).','Určete číslice, kterými se nahradí písmena $K$, $L$, a zapište je v tomto pořadí.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Součet je čtyřciferný a končí $11$. Z jednotek $L+K$ končí $1$; ze součtu $KLL+KLK=1311$ (pro $K=6$, $L=5$: $655+656=1311$) vychází $K=6$, $L=5$.'},
  '$K=6$, $L=5$',
  1, 4, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 6.2',
  new List<String>{'Písmena $S$, $T$, $U$ představují tři navzájem různé číslice. V zápise součtu tří dvouciferných čísel $ST+ST+TU=211$ se písmena nahradí číslicemi tak, aby byl výpočet správný.','Určete číslice, kterými se nahradí písmena $S$, $T$, $U$, a zapište je v tomto pořadí. Najděte všechna tři řešení.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $2(10S+T)+(10T+U)=211$, tj. $20S+12T+U=211$. Tři řešení s navzájem různými číslicemi: $S,T,U=9,2,7$ ($92+92+27$); $8,4,3$ ($84+84+43$); $5,9,3$ ($59+59+93$).'},
  '$S,T,U$: $9,2,7$; $8,4,3$; $5,9,3$',
  3, 6, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 7',
  new List<String>{'Šestiúhelník na obrázku je rozdělen dvěma úhlopříčkami na dva bílé čtverce a dva shodné tmavé trojúhelníky. Poměr délek stran velkého a malého čtverce je $4:3$ a obvody obou čtverců se liší o 12 cm. Obvod jednoho tmavého trojúhelníku je stejný jako obvod malého čtverce.','7.1 Vypočtěte v cm délku strany malého čtverce.','7.2 Vypočtěte v cm² obsah šestiúhelníku.','7.3 Určete, kolikrát větší je obvod šestiúhelníku než obvod malého čtverce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 235 235" font-family="sans-serif"> <polygon points="10,130 100,130 100,10" fill="#b0b0b0" stroke="#000"/> <polygon points="100,130 220,130 100,220" fill="#b0b0b0" stroke="#000"/> <rect x="100" y="10" width="120" height="120" fill="#ffffff" stroke="#000"/> <rect x="10" y="130" width="90" height="90" fill="#ffffff" stroke="#000"/> <polygon points="10,130 100,10 220,10 220,130 100,220 10,220" fill="none" stroke="#000" stroke-width="2"/> <line x1="100" y1="10" x2="100" y2="220" stroke="#000"/> <line x1="10" y1="130" x2="220" y2="130" stroke="#000"/> <text x="160" y="74" font-size="11" text-anchor="middle">velký</text> <text x="55" y="178" font-size="11" text-anchor="middle">malý</text> </svg>',
  'sestiuhelnik.svg',
  'Šestiúhelník rozdělený dvěma úhlopříčkami na malý a velký bílý čtverec a dva shodné tmavé pravoúhlé trojúhelníky.',
  'Schematický nákres (poměr stran 4:3)',
  new List<String>{'7.1 Strany v poměru $4:3$, tj. $4k$ a $3k$. Rozdíl obvodů $4\\cdot 4k-4\\cdot 3k=4k=12$, tedy $k=3$. Malý čtverec má stranu $3k=9$ cm (velký $12$ cm).','7.2 Tmavý trojúhelník je pravoúhlý s odvěsnami $9$ a $12$ (obvod $9+12+15=36$ cm $=$ obvod malého čtverce), obsah $\\frac{1}{2}\\cdot 9\\cdot 12=54$ cm². Obsah šestiúhelníku $=12^2+9^2+2\\cdot 54=144+81+108=333$ cm².','7.3 Obvod šestiúhelníku $=12+12+15+15+9+9=72$ cm; obvod malého čtverce $=36$ cm. Poměr $72:36=2$, tedy 2krát.'},
  '7.1: $9$ cm; 7.2: $333$ cm²; 7.3: 2krát',
  4, 7, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
