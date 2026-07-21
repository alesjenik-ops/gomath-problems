String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)';
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
  'CERMAT 2022 M9C · úloha 12',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek). Úhly $2\\alpha$ a $3\\alpha$ jsou vyznačené u jedné z rovnoběžek, kolmost druhé dvojice přímek je vyznačena pravým úhlem.','Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $20°$','B) $20°$','C) $28°$','D) $34°$','E) větší než $34°$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 172"><path d="M466 4L467 4L467 23L466 23Z" style="fill:#000000"/><path d="M466 23L467 23L467 39L466 39Z" style="fill:#000000"/><path d="M466 39L467 39L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 76L466 76Z" style="fill:#000000"/><path d="M466 76L467 76L467 95L466 95Z" style="fill:#000000"/><path d="M466 95L467 95L467 114L466 114Z" style="fill:#000000"/><path d="M466 114L467 114L467 139L466 139Z" style="fill:#000000"/><path d="M4 167L466 167L466 168L4 168Z" style="fill:#000000"/><path d="M466 167L467 167L467 168L466 168Z" style="fill:#000000"/><path d="M466 167L467 167L467 168L466 168Z" style="fill:#000000"/><path d="M466 139L467 139L467 167L466 167Z" style="fill:#000000"/><path d="M345 10L298 118M441 13L377 160M393 160L301 21M455 41L315 133" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M439 26L433 20M440 24L434 18M343 23L337 17M343 21L338 16M365 118C373 114 375 104 370 97M337 27C327 23 316 24 307 30M312 37C301 44 298 58 305 69C308 73 311 76 315 77M390 83C394 89 399 93 405 96" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M365 107C365 107 365 106 366 106C367 106 367 107 367 107C367 108 367 108 366 108C365 108 365 108 365 107Z" style="fill:#000000"/><text x="319" y="40" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="326" y="40" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="308" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3</text><text x="315" y="62" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="403" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text></svg>',
  'obr.svg',
  'Čtyři přímky – dvě rovnoběžné (označené shodnými značkami) a dvě navzájem kolmé (pravý úhel); u jedné rovnoběžky úhly 2α a 3α, u druhé hledaný úhel β.',
  '',
  new List<String>{'Úhly $2\\alpha$ a $3\\alpha$ jsou vedlejší (dohromady přímý úhel): $2\\alpha+3\\alpha=180^\\circ$, tedy $\\alpha=36^\\circ$ a $2\\alpha=72^\\circ$.','Šikmá přímka procházející tímto vrcholem svírá s rovnoběžkami úhel $2\\alpha=72^\\circ$. Druhá přímka je na ni kolmá, proto s rovnoběžkou svírá úhel $\\beta=90^\\circ-72^\\circ=18^\\circ$, což je méně než $20^\\circ$.'},
  'A) menší než $20°$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 13',
  new List<String>{'Kvádr o rozměrech $6\\ \\mathrm{cm}$, $4\\ \\mathrm{cm}$ a $5\\ \\mathrm{cm}$ jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly. Horní podstava (obdélník $6\\ \\mathrm{cm}\\times4\\ \\mathrm{cm}$) je oběma řezy rozdělena na tři trojúhelníky; všechny hranoly mají výšku $5\\ \\mathrm{cm}$.','Z těchto trojbokých hranolů vybereme ten, který má největší objem. Jaký je objem vybraného trojbokého hranolu?'},
  new List<String>{'A) $40\\ \\mathrm{cm}^3$','B) $60\\ \\mathrm{cm}^3$','C) $80\\ \\mathrm{cm}^3$','D) $120\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Největší z trojúhelníků na horní podstavě má za základnu celou hranu délky $6\\ \\mathrm{cm}$ a příslušnou výšku $4\\ \\mathrm{cm}$; jeho obsah je $\\frac{1}{2}\\cdot6\\cdot4=12\\ \\mathrm{cm}^2$.','Objem hranolu $=$ obsah podstavy $\\times$ výška $=12\\cdot5=60\\ \\mathrm{cm}^3$.'},
  'B) $60\\ \\mathrm{cm}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 14',
  new List<String>{'Penál má tvar rotačního válce. Poloměr podstavy válce je $5\\ \\mathrm{cm}$ a výška válce $20\\ \\mathrm{cm}$. Obě podstavy válce jsou bílé a plášť válce je tmavý.','Kolikrát větší je obsah pláště válce než obsah jedné podstavy?'},
  new List<String>{'A) $4$krát','B) $6$krát','C) $8$krát','D) $10$krát','E) $20$krát'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah pláště $S_{pl}=2\\pi r h=2\\pi\\cdot5\\cdot20=200\\pi$; obsah podstavy $S_{p}=\\pi r^2=\\pi\\cdot5^2=25\\pi$.','Poměr $\\frac{200\\pi}{25\\pi}=8$, plášť je tedy $8$krát větší.'},
  'C) $8$krát',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PCD22C0T03', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
