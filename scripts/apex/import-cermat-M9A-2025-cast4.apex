String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
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
  'CERMAT 2025 M9A · úloha 8',
  new List<String>{'Záhon má tvar čtyřúhelníku, jehož tři strany jsou stejně dlouhé a každá z nich je o čtvrtinu kratší než čtvrtá (nejdelší) strana. Po obvodu je ve stejných rozestupech $40\\ \\mathrm{cm}$ vysázeno celkem $65$ rostlin, po jedné i v každém rohu.','8.1 Vypočtěte v metrech obvod záhonu.','8.2 Určete, o kolik se liší počet rostlin na nejdelší straně od počtu rostlin na protější straně.','8.3 Po obvodu se pravidelně střídají stejně početné skupinky červeně kvetoucích rostlin s dvojicemi bíle kvetoucích. Určete nejmenší možný počet červeně kvetoucích rostlin.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 135"><path d="M7 128L24 27L126 27L143 128L7 128M223 109C228 71 259 65 223 110C183 81 216 66 223 109M222 109C223 84 220 84 223 67M274 109C274 73 302 65 274 109C243 98 253 64 274 109M274 109C268 85 279 80 265 66M324 109C323 82 356 80 325 110C288 78 309 65 324 109M324 110C322 91 320 85 323 66M375 109C383 75 421 86 375 110C341 73 362 63 375 109M375 110C375 87 364 83 384 68" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M4 128C4 127 5 126 7 126C8 126 10 127 10 128C10 130 8 131 7 131C5 131 4 130 4 128Z" style="fill:#000000"/><path d="M13 128C13 127 14 126 15 126C17 126 18 127 18 128C18 130 17 131 15 131C14 131 13 130 13 128Z" style="fill:#000000"/><path d="M21 128C21 127 22 126 24 126C25 126 27 127 27 128C27 130 25 131 24 131C22 131 21 130 21 128Z" style="fill:#000000"/><path d="M30 128C30 127 31 126 32 126C34 126 35 127 35 128C35 130 34 131 32 131C31 131 30 130 30 128Z" style="fill:#000000"/><path d="M38 128C38 127 39 126 41 126C42 126 44 127 44 128C44 130 42 131 41 131C39 131 38 130 38 128Z" style="fill:#000000"/><path d="M140 128C140 127 141 126 143 126C144 126 146 127 146 128C146 130 144 131 143 131C141 131 140 130 140 128Z" style="fill:#000000"/><path d="M123 27C123 26 124 25 126 25C127 25 129 26 129 27C129 29 127 30 126 30C124 30 123 29 123 27Z" style="fill:#000000"/><path d="M21 27C21 26 22 25 24 25C25 25 27 26 27 27C27 29 25 30 24 30C22 30 21 29 21 27Z" style="fill:#000000"/><path d="M8 103C8 101 10 100 11 100C13 100 14 101 14 103C14 105 13 106 11 106C10 106 8 105 8 103Z" style="fill:#000000"/><path d="M7 112C7 110 8 109 10 109C11 109 13 110 13 112C13 113 11 114 10 114C8 114 7 113 7 112Z" style="fill:#000000"/><path d="M5 120C5 118 7 117 8 117C10 117 11 118 11 120C11 122 10 123 8 123C7 123 5 122 5 120Z" style="fill:#000000"/><path d="M222 110L222 118M273 110L273 118M324 110L324 118M375 110L375 118" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M273 115L223 115C223 115 223 115 223 115C223 115 223 115 223 115L273 115C273 115 273 115 273 115C273 115 273 115 273 115M267 118L273 115L267 112C267 112 267 112 267 113C266 113 267 113 267 113L273 115L273 115L267 117C267 118 266 118 267 118C267 118 267 118 267 118M229 112L222 115L229 118C229 118 229 118 229 118C229 118 229 118 229 117L223 115L223 115L229 113C229 113 229 113 229 113C229 112 229 112 229 112Z" style="fill:#000000"/><path d="M324 115L274 115C274 115 274 115 274 115C274 115 274 115 274 115L324 115C324 115 324 115 324 115C324 115 324 115 324 115M318 118L324 115L318 112C318 112 318 112 318 113C317 113 318 113 318 113L324 115L324 115L318 117C318 118 317 118 318 118C318 118 318 118 318 118M280 112L273 115L280 118C280 118 280 118 280 118C280 118 280 118 280 117L274 115L274 115L280 113C280 113 280 113 280 113C280 112 280 112 280 112Z" style="fill:#000000"/><path d="M375 115L325 115C325 115 325 115 325 115C325 115 325 115 325 115L375 115C375 115 375 115 375 115C375 115 375 115 375 115M369 118L375 115L369 112C369 112 369 112 369 113C369 113 369 113 369 113L375 115L375 115L369 117C369 118 369 118 369 118C369 118 369 118 369 118M331 112L324 115L331 118C331 118 331 118 331 118C331 118 331 118 331 117L325 115L325 115L331 113C331 113 331 113 331 113C331 112 331 112 331 112Z" style="fill:#000000"/><path d="M221 61L223 52L225 58L230 55L229 59L236 58L232 63L239 64L233 66L237 72L230 70L231 76L225 72L226 81L222 75L219 79L218 74L211 78L215 72L208 71L214 67L205 63L217 64L216 58L221 61Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M271 61L280 60L274 64L278 68L273 68L275 73L270 72L269 78L266 73L261 79L263 72L256 75L260 69L251 72L257 67L253 65L258 63L253 58L259 60L260 53L264 57L268 48L268 59L273 56L271 61Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M317 65L311 59L318 61L318 55L321 58L324 53L326 58L331 54L329 60L336 60L330 64L336 67L329 69L337 74L329 73L330 77L326 75L325 82L322 76L317 80L318 74L309 77L317 70L312 67L317 65Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M377 69L367 66L375 65L372 60L377 61L376 55L381 59L383 52L384 59L391 55L388 62L395 61L389 66L399 66L391 69L395 72L390 72L392 79L387 76L384 82L381 76L375 83L378 73L373 73L377 69Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><text x="176" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rostlině i v každém rohu záhonu. Rozestupy mezi rostlinami měří 40 cm.</text><text x="249" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40 cm</text><text x="300" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40 cm</text><text x="351" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">40 cm</text><text x="406" y="121" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="197" y="121" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text></svg>',
  'obr.svg',
  'Čtyřúhelníkový záhon se třemi stejně dlouhými stranami a jednou nejdelší; podél obvodu rostliny v rozestupech 40 cm.',
  '',
  new List<String>{'8.1: rozestupů je po obvodu $65$; obvod $65\\cdot0{,}4=26\\ \\mathrm{m}$.','8.2: kratší strana $=\\frac{3}{4}$ nejdelší; $3\\cdot\\frac{3}{4}L+L=\\frac{13}{4}L=26\\Rightarrow L=8\\ \\mathrm{m}$, kratší $6\\ \\mathrm{m}$. Rostlin na $8\\ \\mathrm{m}$ straně $21$, na $6\\ \\mathrm{m}$ straně $16$; rozdíl $5$.','8.3: skupinka $r$ červených $+$ dvojice bílých, $n$ skupin: $n(r+2)=65$; nejméně červených pro $r+2=5$, tj. $n=13$, $r=3$: $13\\cdot3=39$.'},
  '8.1: $26$ metrů; 8.2: o $5$ rostlin; 8.3: $39$ červeně kvetoucích rostlin',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','geometrie','argumentace','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
