String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 14',
  new List<String>{'Kvádr s podstavou o rozměrech $6\\ \\mathrm{cm}$ a $8\\ \\mathrm{cm}$ a výškou $10\\ \\mathrm{cm}$ lze dvěma svislými úhlopříčnými řezy rozdělit na čtyři trojboké hranoly s výškou $10\\ \\mathrm{cm}$. Odebráním jednoho z trojbokých hranolů vznikne z kvádru pětiboký hranol (viz obrázek vpravo).','O kolik cm$^2$ se liší povrch pětibokého hranolu a povrch původního kvádru?'},
  new List<String>{'A) o $4\\ \\mathrm{cm}^2$','B) o $16\\ \\mathrm{cm}^2$','C) o $24\\ \\mathrm{cm}^2$','D) o $30\\ \\mathrm{cm}^2$','E) o jiný počet cm$^2$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 473 146"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 71L466 71Z" style="fill:#000000"/><path d="M466 71L467 71L467 87L466 87Z" style="fill:#000000"/><path d="M466 87L467 87L467 106L466 106Z" style="fill:#000000"/><path d="M466 106L467 106L467 122L466 122Z" style="fill:#000000"/><path d="M4 141L466 141L466 142L4 142Z" style="fill:#000000"/><path d="M466 141L467 141L467 142L466 142Z" style="fill:#000000"/><path d="M466 141L467 141L467 142L466 142Z" style="fill:#000000"/><path d="M466 122L467 122L467 141L466 141Z" style="fill:#000000"/><path d="M211 42L275 42L275 121L211 121ZM211 121L228 104M228 104L292 104M275 121L292 104M228 104L228 25M292 104L292 25M211 42L228 25M228 25L292 25M275 42L292 25M339 121L356 104M356 104L419 104M402 121L419 104M356 104L356 25M419 104L419 25M339 42L356 25M356 25L419 25M402 42L419 25M339 121L379 113L402 121M339 42L379 34L402 42M339 42L339 121M402 42L402 121M379 113L379 34" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M211 121L292 104M228 104L275 121M228 25L275 42M211 42L292 25M251 34L251 113M419 104L339 121M402 121L356 104M339 42L419 25M402 42L356 25" style="fill:none;stroke:#000000;stroke-width:1"/><text x="244" y="136" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="301" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="312" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text><text x="389" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8 cm</text><text x="429" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6 cm</text><text x="439" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10 cm</text></svg>',
  'obr.svg',
  'Kvádr 6 cm × 8 cm × 10 cm a pětiboký hranol vzniklý odebráním jednoho ze čtyř trojbokých hranolů.',
  '',
  new List<String>{'Odebraný trojboký hranol má základnu na straně délky $8\\ \\mathrm{cm}$; úhlopříčka podstavy $6\\times8$ je $\\sqrt{6^2+8^2}=10\\ \\mathrm{cm}$, poloviny úhlopříček (řezné hrany) měří $5\\ \\mathrm{cm}$.','Ztratíme boční stěnu $8\\times10=80\\ \\mathrm{cm}^2$ a z podstavy i horní stěny po trojúhelníku o obsahu $\\frac{1}{2}\\cdot8\\cdot3=12\\ \\mathrm{cm}^2$, tedy $2\\cdot12=24\\ \\mathrm{cm}^2$.','Přibudou dvě řezné stěny $5\\times10=50\\ \\mathrm{cm}^2$, tj. $2\\cdot50=100\\ \\mathrm{cm}^2$.','Změna povrchu $=100-80-24=-4\\ \\mathrm{cm}^2$; povrchy se liší o $4\\ \\mathrm{cm}^2$.'},
  'A) o $4\\ \\mathrm{cm}^2$',
  2, 4, '5',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','vyber','bez-kalkulacky'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Letos se na gymnázium přihlásilo $420$ uchazečů, což je o $40\\ \\%$ více, než se jich přihlásilo loni. Kolik uchazečů se přihlásilo loni?','15.2 On-line kurzu českého jazyka se zúčastnilo $180$ žáků, což je o $25\\ \\%$ méně, než se jich zúčastnilo on-line kurzu matematiky. Kolik žáků se zúčastnilo kurzu matematiky?','15.3 Včera navštívilo plavecký bazén celkem $680$ dospělých, mezi nimiž bylo mužů o $30\\ \\%$ méně než žen. Kolik mužů včera navštívilo bazén?','Nabídka: A) méně než $240$; B) $240$; C) $260$; D) $280$; E) $300$; F) více než $300$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $420:1{,}4=300$ — \\textbf{E}.','15.2: $180:0{,}75=240$ — \\textbf{B}.','15.3: muži $=0{,}7\\cdot$ ženy; $0{,}7z+z=680\\Rightarrow1{,}7z=680\\Rightarrow z=400$, mužů $280$ — \\textbf{D}.'},
  '15.1: E; 15.2: B; 15.3: D',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
