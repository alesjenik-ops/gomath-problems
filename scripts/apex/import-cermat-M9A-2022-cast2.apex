String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 1. řádný termín (M9A)';
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
  'CERMAT 2022 M9A · úloha 6',
  new List<String>{'Domeček je vytvořen z pravidelného čtyřbokého hranolu a kolmého trojbokého hranolu. Oba hranoly mají jednu stěnu společnou. Rozměry čtyřbokého hranolu jsou $x$, $x$ a $20\\ \\mathrm{cm}$. Podstavou trojbokého hranolu je pravoúhlý trojúhelník s odvěsnami délek $6\\ \\mathrm{cm}$ a $8\\ \\mathrm{cm}$.','Vypočtěte v cm$^3$','6.1 \\quad objem trojbokého hranolu,','6.2 \\quad objem pravidelného čtyřbokého hranolu.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 473 145"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M392 14L439 39M439 39L439 99M350 56L392 14M397 81L439 39M397 141L439 99M337 81L350 56L397 81L337 81M337 81L397 81L397 141L337 141Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M364 64C360 71 350 74 343 70C343 70 343 70 343 70" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M351 65C351 64 352 64 352 64C353 64 353 64 353 65C353 65 353 66 352 66C352 66 351 65 351 65Z" style="fill:#000000"/><text x="328" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="385" y="66" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="439" y="131" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20 cm</text><text x="390" y="117" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑥</text><text x="367" y="139" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝑥</text></svg>',
  'obr.svg',
  'Domeček z pravidelného čtyřbokého hranolu (rozměry x, x, 20 cm) a kolmého trojbokého hranolu, jehož podstavou je pravoúhlý trojúhelník s odvěsnami 6 cm a 8 cm; oba hranoly mají společnou stěnu.',
  '',
  new List<String>{'Přepona pravoúhlého trojúhelníku (společná hrana obou hranolů) je $\\sqrt{6^2+8^2}=\\sqrt{100}=10\\ \\mathrm{cm}$; to je zároveň hrana čtvercové podstavy, tedy $x=10\\ \\mathrm{cm}$. Oba hranoly jsou dlouhé $20\\ \\mathrm{cm}$.','6.1: podstavou trojbokého hranolu je pravoúhlý trojúhelník o obsahu $\\frac{1}{2}\\cdot6\\cdot8=24\\ \\mathrm{cm}^2$; objem $=24\\cdot20=480\\ \\mathrm{cm}^3$.','6.2: pravidelný čtyřboký hranol má čtvercovou podstavu $x^2=10^2=100\\ \\mathrm{cm}^2$; objem $=100\\cdot20=2\\,000\\ \\mathrm{cm}^3$.'},
  '6.1: $480\\ \\mathrm{cm}^3$; 6.2: $2\\,000\\ \\mathrm{cm}^3$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 7',
  new List<String>{'Děti i dospělí užívají doporučené dávky vitaminů denně po celý rok. Dle příbalového letáku je doporučená denní dávka vitaminů pro dítě poloviční než pro dospělého. Dva dospělí spotřebují dohromady jedno balení vitaminů za $30$ dní.','Vypočtěte,','7.1 \\quad kolik balení vitaminů spotřebuje jeden dospělý za $360$ dní,','7.2 \\quad za kolik dní spotřebuje jedno balení vitaminů jedno dítě,','7.3 \\quad za kolik dní spotřebují jedno balení vitaminů dohromady dva dospělí a jedno dítě.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Dva dospělí spotřebují za den $\\frac{1}{30}$ balení, jeden dospělý tedy $\\frac{1}{60}$ balení za den; jedno dítě má poloviční dávku, tj. $\\frac{1}{120}$ balení za den.','7.1: $360\\cdot\\frac{1}{60}=6$ balení.','7.2: $1:\\frac{1}{120}=120$ dní.','7.3: společná denní spotřeba dvou dospělých a jednoho dítěte $=\\frac{1}{30}+\\frac{1}{120}=\\frac{4}{120}+\\frac{1}{120}=\\frac{5}{120}=\\frac{1}{24}$ balení za den, tedy $24$ dní.'},
  '7.1: $6$ balení; 7.2: za $120$ dní; 7.3: za $24$ dní',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','pomer','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);
c.add(
  'CERMAT 2022 M9A · úloha 8',
  new List<String>{'Za $4$ dortíky zaplatíme v cukrárně celkem $x$ korun, stejně jako za $5$ koláčů.','8.1 \\quad Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $1$ dortík.','8.2 \\quad Vyjádřete výrazem s proměnnou $x$, kolik korun zaplatíme v cukrárně za $4$ koláče.','8.3 \\quad V cukrárně jsme za $5$ dortíků a $4$ koláče zaplatili celkem $246$ korun. Vypočtěte, kolik korun jsme zaplatili za jeden dortík.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: $1$ dortík stojí $\\frac{x}{4}$ korun.','8.2: $1$ koláč stojí $\\frac{x}{5}$ korun, $4$ koláče tedy $\\frac{4}{5}x$ korun.','8.3: $5\\cdot\\frac{x}{4}+4\\cdot\\frac{x}{5}=246\\Rightarrow\\frac{25x+16x}{20}=246\\Rightarrow\\frac{41x}{20}=246\\Rightarrow x=120$; jeden dortík stojí $\\frac{120}{4}=30$ korun.'},
  '8.1: $\\frac{1}{4}x$; 8.2: $\\frac{4}{5}x$; 8.3: $30$ korun',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
