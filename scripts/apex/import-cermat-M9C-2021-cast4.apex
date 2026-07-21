String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, náhradní termín (M9C)';
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
  'CERMAT 2021 M9C · úloha 11',
  new List<String>{'Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$. Po snadné trase ujedeme v první části od startu $S$ do místa $K$ $45\\ \\mathrm{km}$, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$. Náročná trasa je dlouhá $45\\ \\mathrm{km}$ a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 U snadné trasy je poměr délky první části ku délce druhé části $2:1$.','11.2 Druhá část snadné trasy měří $30\\ \\mathrm{km}$.','11.3 Druhá část náročné trasy měří $25\\ \\mathrm{km}$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Snadná trasa: první část $45\\ \\mathrm{km}$ je o polovinu více než druhá, tedy druhá $=45:1{,}5=30\\ \\mathrm{km}$; poměr $45:30=3:2$.','Náročná trasa: první $=\\frac{4}{5}\\cdot$druhá a první $+$ druhá $=45$; $\\frac{4}{5}d+d=45\\Rightarrow\\frac{9}{5}d=45\\Rightarrow d=25\\ \\mathrm{km}$ (první $=20\\ \\mathrm{km}$).','11.1: poměr je $3:2$, nikoli $2:1$ — \\textbf{N}. 11.2: druhá část snadné trasy $=30\\ \\mathrm{km}$ — \\textbf{A}. 11.3: druhá část náročné trasy $=25\\ \\mathrm{km}$ — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 6, '4',
  new List<String>{'zs2','r9','pomer','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 12',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). V obrázku jsou vyznačeny úhly $\\alpha$, $2\\alpha$ a $36^\\circ$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $18^\\circ$','B) $36^\\circ$','C) $44^\\circ$','D) $48^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 172"><path d="M4 167L5 167L5 168L4 168Z" style="fill:#000000"/><path d="M4 167L5 167L5 168L4 168Z" style="fill:#000000"/><path d="M5 167L467 167L467 168L5 168Z" style="fill:#000000"/><path d="M467 167L468 167L468 168L467 168Z" style="fill:#000000"/><path d="M467 167L468 167L468 168L467 168Z" style="fill:#000000"/><path d="M4 4L5 4L5 167L4 167Z" style="fill:#000000"/><path d="M467 4L468 4L468 167L467 167Z" style="fill:#000000"/><path d="M64 36L72 36L72 50L64 50Z" style="fill:#ffffff"/><path d="M131 60L145 60L145 75L131 75Z" style="fill:#ffffff"/><path d="M92 112L109 112L109 126L92 126Z" style="fill:#ffffff"/><path d="M24 58L226 28M29 120L229 91M50 25L207 125M191 14L86 156" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M61 52C60 46 61 40 65 34M121 70C128 59 142 56 153 63C153 63 154 63 154 64M99 138C91 131 86 122 84 112M219 25L218 33M221 25L220 33M222 88L221 96M224 87L223 96" style="fill:none;stroke:#000000;stroke-width:1"/><text x="68" y="49" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="134" y="74" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="141" y="74" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="98" y="126" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">36</text><text x="106" y="125" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text></svg>',
  'obr.svg',
  'Čtyři přímky, z nichž dvě jsou rovnoběžné (označené), proťaté dvěma příčkami; vyznačené úhly α u horní rovnoběžky, 2α v průsečíku příček a 36° u dolní rovnoběžky.',
  '',
  new List<String>{'Rovnoběžné přímky jsou proťaty dvěma příčkami. Úhel $\\alpha$ u horní rovnoběžky odpovídá (střídavý úhel) úhlu $\\alpha$ v trojúhelníku u dolní rovnoběžky. Vnitřní úhly tohoto trojúhelníku jsou $\\alpha$, $36^\\circ$ a $2\\alpha$ (vrcholový k vyznačenému úhlu $2\\alpha$).','Součet vnitřních úhlů trojúhelníku: $\\alpha+2\\alpha+36^\\circ=180^\\circ\\Rightarrow3\\alpha=144^\\circ\\Rightarrow\\alpha=48^\\circ$.'},
  'D) $48^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PCD21C0T03', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
