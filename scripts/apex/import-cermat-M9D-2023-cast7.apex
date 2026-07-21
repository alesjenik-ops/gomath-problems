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
  'CERMAT 2023 M9D · úloha 13',
  new List<String>{'Přímka $p$ prochází vrcholy A, B trojúhelníku ABC, jehož vnitřní úhly mají velikosti $\\alpha$, $\\beta$, $\\gamma$. Bodem B prochází rovnoběžka se stranou AC (viz obrázek). U vrcholu B jsou vyznačeny úhly $30^\\circ$ (mezi rovnoběžkou a stranou BA) a $2\\beta+\\gamma$ (vnější úhel při B).','Jaká je velikost úhlu $\\gamma$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $115^\\circ$','B) $120^\\circ$','C) $135^\\circ$','D) $140^\\circ$','E) $150^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 161"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 77L466 77Z" style="fill:#000000"/><path d="M466 77L467 77L467 96L466 96Z" style="fill:#000000"/><path d="M466 96L467 96L467 115L466 115Z" style="fill:#000000"/><path d="M466 115L467 115L467 134L466 134Z" style="fill:#000000"/><path d="M4 156L466 156L466 157L4 157Z" style="fill:#000000"/><path d="M466 156L467 156L467 157L466 157Z" style="fill:#000000"/><path d="M466 156L467 156L467 157L466 157Z" style="fill:#000000"/><path d="M466 134L467 134L467 156L466 156Z" style="fill:#000000"/><path d="M360 131L317 46L447 131L360 131M268 14L447 131M317 46L455 46" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M413 131C413 125 415 118 418 113M355 71C351 78 345 83 337 87M334 80C319 88 300 84 289 71C278 59 276 40 286 26M352 115C357 113 364 113 369 116C374 119 378 125 378 131M358 46C358 54 356 62 351 69M402 42L399 50M400 42L398 50M401 127L398 135M403 127L400 135" style="fill:none;stroke:#000000;stroke-width:1"/><text x="154" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="190" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">trojúhelníku</text><text x="233" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="247" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="169" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="176" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="182" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text><text x="188" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="194" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛾</text><text x="200" y="37" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="224" y="56" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AC</text><text x="233" y="56" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="451" y="146" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="322" y="44" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="357" y="146" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="421" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="342" y="79" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text><text x="365" y="127" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛾</text><text x="274" y="30" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="345" y="59" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="353" y="59" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="287" y="61" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="304" y="61" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽+ 𝛾</text></svg>',
  'obr.svg',
  'Trojúhelník ABC s přímkou p procházející vrcholy A, B a rovnoběžkou se stranou AC vedenou bodem B; vyznačené úhly 30° a 2β+γ u vrcholu B.',
  '',
  new List<String>{'Rovnoběžka bodem B se stranou AC a příčka AB dávají střídavé úhly: $\\alpha=30^\\circ$.','Úhel $2\\beta+\\gamma$ je vnější úhel při B, tedy $2\\beta+\\gamma=180^\\circ-\\beta\\Rightarrow3\\beta+\\gamma=180^\\circ$.','Ze součtu úhlů $\\alpha+\\beta+\\gamma=180^\\circ$ a $\\alpha=30^\\circ$ plyne $\\beta+\\gamma=150^\\circ$.','Odečtením: $2\\beta=30^\\circ\\Rightarrow\\beta=15^\\circ$, tedy $\\gamma=150^\\circ-15^\\circ=135^\\circ$.'},
  'C) $135^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
