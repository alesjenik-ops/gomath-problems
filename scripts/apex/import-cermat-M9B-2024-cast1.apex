String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)';
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
  'CERMAT 2024 M9B · úloha 1',
  new List<String>{'Josef má krok $75\\ \\mathrm{cm}$, Naďa $60\\ \\mathrm{cm}$; oba ušli $10\\,000$ kroků. O kolik kilometrů ušel Josef více než Naďa?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Josef $10\\,000\\cdot75=750\\,000\\ \\mathrm{cm}=7{,}5\\ \\mathrm{km}$; Naďa $10\\,000\\cdot60=600\\,000\\ \\mathrm{cm}=6\\ \\mathrm{km}$.','Rozdíl $7{,}5-6=1{,}5\\ \\mathrm{km}$.'},
  'o $1{,}5\\ \\mathrm{km}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 2',
  new List<String>{'Adam a Ota jdou z místa A do místa C. Adam jde po rovných silnicích přes místo B (úsek $AB=40\\ \\mathrm{m}$, $BC=30\\ \\mathrm{m}$, pravý úhel u B), Ota jde zkratkou přímo z A do C (viz obrázek).','O kolik procent je Adamova cesta delší než cesta, kterou jde Ota?'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 459 152"><path d="M4 146L455 146L455 148L4 148Z" style="fill:#231f20"/><path d="M130 4L297 4L297 116L130 116Z" style="fill:#dcddde"/><path d="M130 4L297 4L297 116L130 116ZM130 116L297 4" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M282 116C282 108 289 102 297 102" style="fill:none;stroke:#231f20;stroke-width:1"/><path d="M290 110C290 110 291 110 291 110C291 110 291 110 291 110C291 110 291 111 291 111C291 111 290 110 290 110Z" style="fill:#231f20;stroke:#231f20;stroke-width:1"/><path d="M296 58L297 58L297 81L296 81ZM301 64L297 57L293 64C293 64 293 65 293 65C293 65 294 65 294 65L297 59L296 59L300 65C300 65 300 65 301 65C301 65 301 64 301 64Z" style="fill:#231f20"/><path d="M198 116L221 116L221 117L198 117ZM215 112L222 116L215 120C215 120 215 120 215 120C215 120 215 119 215 119L221 116L221 117L215 113C215 113 215 113 215 112C215 112 215 112 215 112Z" style="fill:#231f20"/></svg>',
  'obr.svg',
  'Obdélník ABC: Adam jde z A do B (40 m) a do C (30 m, pravý úhel u B), Ota jde úhlopříčkou z A do C.',
  '',
  new List<String>{'Adam ujde $40+30=70\\ \\mathrm{m}$; Ota (úhlopříčka) $\\sqrt{40^2+30^2}=50\\ \\mathrm{m}$.','$\\frac{70-50}{50}=\\frac{20}{50}=40\\ \\%$.'},
  'o $40\\ \\%$',
  2, 4, '3',
  new List<String>{'zs2','r9','geometrie','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 3',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{3}{4}+\\dfrac{4}{3}\\right)\\cdot\\left(\\dfrac{2}{3}-\\dfrac{6}{5}\\right)=$','3.2 \\quad $\\dfrac{\\frac{5}{9}-\\frac{3}{2}:\\frac{3}{5}}{\\frac{2}{3}+\\frac{1}{6}-\\frac{7}{12}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\left(\\frac{9}{12}+\\frac{16}{12}\\right)\\cdot\\left(\\frac{10}{15}-\\frac{18}{15}\\right)=\\frac{25}{12}\\cdot\\left(-\\frac{8}{15}\\right)=-\\frac{10}{9}$.','3.2: čitatel $\\frac{5}{9}-\\frac{3}{2}\\cdot\\frac{5}{3}=\\frac{5}{9}-\\frac{5}{2}=-\\frac{35}{18}$; jmenovatel $\\frac{8+2-7}{12}=\\frac{1}{4}$; $-\\frac{35}{18}:\\frac{1}{4}=-\\frac{70}{9}$.'},
  '3.1: $-\\frac{10}{9}$; 3.2: $-\\frac{70}{9}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 4',
  new List<String>{'4.1 Umocněte: $(-3-2x)^2=$','4.2 Upravte a rozložte na součin podle vzorce: $6\\,400-(x^2-3\\,600)=$','4.3 Zjednodušte (bez závorek): $(3x+1)^2-x\\cdot7x-(2x-5)\\cdot(x+4)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(3+2x)^2=4x^2+12x+9$.','4.2: $6\\,400-x^2+3\\,600=10\\,000-x^2=(100-x)(100+x)$.','4.3: $(9x^2+6x+1)-7x^2-(2x^2+3x-20)=3x+21$.'},
  '4.1: $4x^2+12x+9$; 4.2: $(100-x)(100+x)$; 4.3: $3x+21$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 5',
  new List<String>{'Řešte rovnice.','5.1 \\quad $1{,}6:2-\\dfrac{x}{2}=3\\cdot0{,}7x+3{,}4$','5.2 \\quad $\\dfrac{5-2y}{3}+\\dfrac{y}{9}=\\dfrac{3-y}{6}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}8-\\frac{x}{2}=2{,}1x+3{,}4\\Rightarrow -0{,}5x-2{,}1x=2{,}6\\Rightarrow -2{,}6x=2{,}6\\Rightarrow x=-1$.','5.2: vynásobením $18$: $6(5-2y)+2y=3(3-y)\\Rightarrow 30-10y=9-3y\\Rightarrow 21=7y\\Rightarrow y=3$.'},
  '5.1: $x=-1$; 5.2: $y=3$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
