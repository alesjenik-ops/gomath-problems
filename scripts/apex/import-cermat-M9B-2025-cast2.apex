String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)';
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
  'CERMAT 2025 M9B · úloha 7',
  new List<String>{'Farmář prodával saláty za jednotnou cenu za kus a během tří dnů je všechny prodal. První den prodal třetinu všech salátů, druhý den o třetinu méně salátů než první den a třetí den zbytek.','7.1 Za všechny saláty utržil celkem $5\\,400$ korun. Vypočtěte, kolik korun utržil za saláty prodané druhý den.','7.2 Počet všech prodaných salátů označíme $x$. Vyjádřete výrazem, kolik salátů prodal druhý den.','7.3 Třetí den prodal $120$ salátů. Určete počet všech prodaných salátů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'První den $\\frac{1}{3}x$, druhý den o třetinu méně, tj. $\\frac{2}{3}\\cdot\\frac{1}{3}x=\\frac{2}{9}x$, třetí den zbytek $x-\\frac{1}{3}x-\\frac{2}{9}x=\\frac{4}{9}x$.','7.1: druhý den $\\frac{2}{9}$ tržby $=\\frac{2}{9}\\cdot5\\,400=1\\,200$ korun.','7.2: $\\frac{2}{9}x$ salátů.','7.3: $\\frac{4}{9}x=120\\Rightarrow x=270$ salátů.'},
  '7.1: $1\\,200$ korun; 7.2: $\\frac{2}{9}x$; 7.3: $270$ salátů',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','rovnice','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 8',
  new List<String>{'Velký pravoúhlý lichoběžník (rozměry na obrázku vlevo: rovnoběžné strany $100\\ \\mathrm{cm}$ a $140\\ \\mathrm{cm}$, výška $30\\ \\mathrm{cm}$) jsme jednou úsečkou rozdělili na menší lichoběžník a rovnoběžník (obrázek vpravo). Oba nové útvary mají stejný obvod.','8.1 Vypočtěte v $\\mathrm{cm}^2$ obsah velkého pravoúhlého lichoběžníku.','8.2 Vypočtěte v cm obvod velkého pravoúhlého lichoběžníku.','8.3 Vypočtěte v cm obvod rovnoběžníku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 445 116"><path d="M440 4L441 4L441 20L440 20Z" style="fill:#000000"/><path d="M440 20L441 20L441 112L440 112Z" style="fill:#000000"/><path d="M25 46L25 85L183 85L131 46ZM244 46L244 85L403 85L351 46ZM333 85L281 46" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M25 70C33 70 40 77 40 85M51 81L48 89M53 81L50 89M51 41L48 49M53 41L50 49M244 70C253 70 260 77 260 85M340 81L337 89M342 81L339 89M340 41L337 49M342 41L339 49M364 51L356 54M366 53L358 55M295 51L287 54M296 53L288 56" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M30 78C30 78 31 77 31 77C32 77 32 78 32 78C32 79 32 80 31 80C31 80 30 79 30 78Z" style="fill:#000000"/><path d="M250 78C250 78 250 77 251 77C251 77 252 78 252 78C252 79 251 80 251 80C250 80 250 79 250 78Z" style="fill:#000000"/><text x="105" y="100" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">140 cm</text><text x="79" y="43" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">100 cm</text><text x="7" y="72" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30 cm</text></svg>',
  'obr.svg',
  'Velký pravoúhlý lichoběžník (strany 100 a 140 cm, výška 30 cm) a jeho rozdělení úsečkou na menší lichoběžník a rovnoběžník.',
  '',
  new List<String>{'8.1: $S=\\frac{100+140}{2}\\cdot30=3\\,600\\ \\mathrm{cm}^2$.','8.2: šikmé rameno $\\sqrt{(140-100)^2+30^2}=\\sqrt{2500}=50\\ \\mathrm{cm}$; obvod $140+100+30+50=320\\ \\mathrm{cm}$.','8.3: řez rovnoběžný se šikmým ramenem; rovnoběžník má strany $50$ a $55\\ \\mathrm{cm}$, obvod $2\\cdot(50+55)=210\\ \\mathrm{cm}$.'},
  '8.1: $3\\,600\\ \\mathrm{cm}^2$; 8.2: $320\\ \\mathrm{cm}$; 8.3: $210\\ \\mathrm{cm}$',
  4, 6, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
