String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, druhý náhradní termín (M9D)';
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
  'CERMAT 2021 M9D · úloha 12',
  new List<String>{'Na obrázku jsou čtyři přímky; shodně označené přímky (dvojitou čárkou) jsou rovnoběžné. Nejvýše položená přímka procházející vrcholem úhlu $62^\\circ$ žádné označení nemá.','Jaká je velikost úhlu $\\varphi$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $128^\\circ$','B) $126^\\circ$','C) $118^\\circ$','D) $114^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 124"><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M5 4L467 4L467 5L5 5Z" style="fill:#000000"/><path d="M4 5L5 5L5 120L4 120Z" style="fill:#000000"/><path d="M53 34L73 34L73 48L53 48Z" style="fill:#ffffff"/><path d="M133 34L145 34L145 48L133 48Z" style="fill:#ffffff"/><path d="M76 85L95 85L95 100L76 100Z" style="fill:#ffffff"/><path d="M123 40C130 33 142 33 149 40C151 42 152 45 153 48M75 104C73 94 75 83 83 75M73 33C74 42 71 50 65 57M33 21L26 23M34 22L27 24M104 16L97 19M105 18L98 20M187 68L187 77M189 68L189 76M170 38L170 47M172 38L172 46" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M27 19L113 106M98 15L170 87M193 71L61 109M176 41L35 82M24 36L161 26" style="fill:none;stroke:#000000;stroke-width:2"/><text x="64" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">62°</text><text x="139" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝜑</text><text x="87" y="99" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">66°</text></svg>',
  'obr.svg',
  'Dvě rovnoběžné klesající přímky proťaté třemi téměř vodorovnými přímkami; u průsečíků jsou vyznačeny úhly 62°, 66° a hledaný úhel φ. Dvojité čárky značí rovnoběžnost.',
  '',
  new List<String>{'Obě „klesající“ přímky jsou rovnoběžné, stejně tak prostřední a spodní „stoupající“ přímka. Nejvýše položená přímka (u úhlu $62^\\circ$) rovnoběžná není, proto je údaj $62^\\circ$ pro výpočet nadbytečný.','Úhel $\\varphi$ a úhel $66^\\circ$ jsou úhly u dvou rovnoběžných (klesajících) přímek proťatých prostřední příčkou — jsou to přilehlé (přísluš­né doplňkové) úhly, jejichž součet je $180^\\circ$: $\\varphi=180^\\circ-66^\\circ=114^\\circ$.'},
  'D) $114^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','uvazovani'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 13',
  new List<String>{'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1\\ \\mathrm{cm}\\times1\\ \\mathrm{cm}\\times2\\ \\mathrm{cm}$. Stojící díl má dole čtvercovou stěnu (stojí na výšku $2\\ \\mathrm{cm}$), ležící díl leží (výška $1\\ \\mathrm{cm}$).','Stavba má podobu tří spojených kvádrů (rozměry šířka $\\times$ hloubka $\\times$ výška v cm): levý $3\\times4\\times6$, prostřední $3\\times4\\times7$, pravý $3\\times4\\times5$. Díly jsou naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů.','Kolik ležících dílů stavba obsahuje?'},
  new List<String>{'A) $0$','B) $6$','C) $12$','D) $18$','E) $24$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Každý sloupec $1\\times1$ o sudé výšce lze zaplnit jen stojícími díly; při liché výšce zbude navrchu vrstva vysoká $1\\ \\mathrm{cm}$, kterou musí vyplnit ležící díly.','Levý kvádr má výšku $6$ (sudou) — jen stojící díly. Prostřední ($7$) a pravý ($5$) mají lichou výšku, proto má každý navrchu vrstvu $3\\times4=12$ jednotkových krychliček.','Celkem je navrchu $12+12=24$ jednotkových krychliček; jeden ležící díl pokryje $2$ z nich, takže ležících dílů je $24:2=12$.'},
  'C) $12$',
  2, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','uvazovani','vyber','slovni'},
  'M9PDD21C0T04', 2021
);
c.add(
  'CERMAT 2021 M9D · úloha 14',
  new List<String>{'Ve třídě je o polovinu více chlapců než děvčat.','Které z následujících tvrzení je pravdivé?'},
  new List<String>{'A) Chlapci tvoří tři pětiny žáků třídy.','B) Děvčata tvoří $33\\ \\%$ žáků třídy.','C) Počet žáků třídy je trojnásobkem počtu děvčat.','D) Počet dívek ve třídě je o polovinu menší než počet chlapců.','E) Žádné z výše uvedených tvrzení není pravdivé.'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet děvčat označme $d$, chlapců je $1{,}5d$, žáků celkem $2{,}5d$.','A) chlapci tvoří $\\frac{1{,}5d}{2{,}5d}=\\frac{3}{5}$ žáků — \\textbf{pravda}.','B) děvčata tvoří $\\frac{d}{2{,}5d}=40\\ \\%$ (ne $33\\ \\%$); C) celkem je $2{,}5\\times$ počet děvčat (ne trojnásobek); D) děvčat je o třetinu méně než chlapců (ne o polovinu). Ostatní tvrzení tedy neplatí.'},
  'A) Chlapci tvoří tři pětiny žáků třídy.',
  2, 3, '3',
  new List<String>{'zs2','r9','pomer','procenta','uvazovani','vyber','bez-kalkulacky','slovni'},
  'M9PDD21C0T04', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
