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
  'CERMAT 2025 M9B · úloha 12',
  new List<String>{'V rovině leží dva shodné rovnoramenné trojúhelníky a přímka $p$ rovnoběžná se základnou jednoho z nich. Druhý trojúhelník má právě jedno rameno rovnoběžné s ramenem prvního trojúhelníku (viz obrázek); je vyznačen úhel $40^\\circ$.','Jaká je velikost úhlu $\\alpha$? (Velikosti neměřte, ale vypočtěte.)'},
  new List<String>{'A) $160^\\circ$','B) $140^\\circ$','C) $130^\\circ$','D) $110^\\circ$','E) jiná velikost'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 435 111"><path d="M255 104L294 13L334 104L255 104M366 104L326 13L420 45L366 104M246 77L431 77" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M309 46C300 50 289 50 280 46M280 100L277 107M282 100L279 107M280 73L277 81M282 73L279 81M312 62L318 57M318 59L313 64M343 61L349 56M350 58L344 63" style="fill:none;stroke:#000000;stroke-width:1"/><text x="26" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží dva</text><text x="129" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">shodné rovnoramenné</text><text x="224" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">trojúhelníky</text><text x="7" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="33" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="143" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoběžná se základnou jednoho z nich.</text><text x="92" y="44" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Druhý trojúhelník má právě jedno rameno</text><text x="99" y="60" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoběžné s ramenem prvního trojúhelníku.</text><text x="292" y="47" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40</text><text x="300" y="46" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text></svg>',
  'obr.svg',
  'Dva shodné rovnoramenné trojúhelníky a přímka p rovnoběžná se základnou jednoho z nich; vyznačený úhel 40° a hledaný úhel alfa.',
  '',
  new List<String>{'Rovnoramenný trojúhelník s úhlem $40^\\circ$ při vrcholu má úhly při základně $\\frac{180^\\circ-40^\\circ}{2}=70^\\circ$.','Z rovnoběžnosti přímky $p$ se základnou a rovnoběžnosti ramen vychází $\\alpha=180^\\circ-40^\\circ=140^\\circ$.'},
  'B) $140^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 13',
  new List<String>{'Ze shodných bílých a šedých krychliček byla sestavena krychle $4\\times4\\times4$. Šedé krychličky byly umístěny vždy podél jedné ze dvou úhlopříček každé stěny krychle (viz obrázek). Všechny zbývající krychličky jsou bílé.','Jaký je počet všech bílých krychliček v krychli?'},
  new List<String>{'A) méně než $36$','B) $36$','C) $48$','D) $54$','E) $72$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 464 9"><path d="M4 4L460 4L460 5L4 5Z" style="fill:#000000"/></svg>',
  'obr.svg',
  'Krychle 4×4×4 sestavená z bílých a šedých krychliček; šedé leží podél úhlopříček každé stěny.',
  '',
  new List<String>{'Krychle má $4^3=64$ krychliček. Šedé leží na stěnových úhlopříčkách; po odečtení sdílených hranových a rohových krychliček je šedých $16$.','Bílých je $64-16=48$.'},
  'C) $48$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 14',
  new List<String>{'Na výrobu dortu byly použity dvě formy tvaru rotačního válce. Poloměr podstavy první formy je $8\\ \\mathrm{cm}$, druhé o čtvrtinu menší; výška obou je $5\\ \\mathrm{cm}$. Každý korpus má stejný objem jako forma, v níž byl upečen.','Jaký je celkový objem obou korpusů dvoupatrového dortu?'},
  new List<String>{'A) $350\\pi\\ \\mathrm{cm}^3$','B) $400\\pi\\ \\mathrm{cm}^3$','C) $450\\pi\\ \\mathrm{cm}^3$','D) $500\\pi\\ \\mathrm{cm}^3$','E) $550\\pi\\ \\mathrm{cm}^3$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'První forma: $V_1=\\pi\\cdot8^2\\cdot5=320\\pi\\ \\mathrm{cm}^3$.','Druhá forma: poloměr $6\\ \\mathrm{cm}$, $V_2=\\pi\\cdot6^2\\cdot5=180\\pi\\ \\mathrm{cm}^3$; celkem $500\\pi\\ \\mathrm{cm}^3$.'},
  'D) $500\\pi\\ \\mathrm{cm}^3$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
