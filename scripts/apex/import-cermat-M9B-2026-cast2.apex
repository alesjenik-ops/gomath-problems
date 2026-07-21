String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
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
  'CERMAT 2026 M9B · úloha 7',
  new List<String>{'Kruh o poloměru $10\\ \\mathrm{cm}$ je rozdělen na tři shodné bílé části a tři shodné šedé části jako na obrázku.','7.1 Určete, kolikrát je obsah jedné bílé části kruhu větší než obsah jedné šedé části.','7.2 Vypočtěte v cm obvod jedné bílé části kruhu. Výsledek zaokrouhlete na desetiny centimetru.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 501 168"><path d="M466 4L467 4L467 23L466 23Z" style="fill:#000000"/><path d="M466 23L467 23L467 39L466 39Z" style="fill:#000000"/><path d="M466 39L467 39L467 55L466 55Z" style="fill:#000000"/><path d="M466 55L467 55L467 73L466 73Z" style="fill:#000000"/><path d="M466 73L467 73L467 92L466 92Z" style="fill:#000000"/><path d="M466 92L467 92L467 111L466 111Z" style="fill:#000000"/><path d="M4 133L466 133L466 134L4 134Z" style="fill:#000000"/><path d="M466 133L467 133L467 134L466 134Z" style="fill:#000000"/><path d="M466 133L467 133L467 134L466 134Z" style="fill:#000000"/><path d="M466 111L467 111L467 133L466 133Z" style="fill:#000000"/><path d="M321 15C330 13 339 14 348 17L330 68L321 15Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M381 86C378 95 372 103 365 109L330 68L381 86Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M289 102C283 95 279 87 277 77L330 68L289 102Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><path d="M276 68C276 38 300 14 330 14C360 14 384 38 384 68C384 98 360 122 330 122C300 122 276 98 276 68M419 17C447 27 462 58 452 86C452 86 452 86 452 86L401 68L419 17" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M336 53C344 56 348 65 345 73M406 53C414 56 419 65 416 73" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M337 64C337 63 338 63 339 63C339 63 340 63 340 64C340 64 339 65 339 65C338 65 337 64 337 64Z" style="fill:#000000"/><path d="M408 64C408 63 409 63 409 63C410 63 411 63 411 64C411 64 410 65 409 65C409 65 408 64 408 64Z" style="fill:#000000"/><text x="431" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">max. 3 body</text><text x="429" y="106" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Jedna</text><text x="429" y="120" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">bílá část</text></svg>',
  'obr.svg',
  'Kruh o poloměru 10 cm rozdělený na tři shodné bílé a tři shodné šedé části; vpravo je vyznačena jedna bílá část.',
  '',
  new List<String>{'Jedna bílá část je kruhová výseč se středovým úhlem $90^\\circ$, jedna šedá výseč má úhel $30^\\circ$.','7.1: poměr obsahů je $90:30=3$, bílá část je $3$krát větší.','7.2: obvod $=$ dva poloměry $+$ čtvrtinový oblouk $=2\\cdot10+\\frac{1}{4}\\cdot2\\pi\\cdot10\\doteq20+15{,}7=35{,}7\\ \\mathrm{cm}$.'},
  '7.1: $3$krát; 7.2: $35{,}7\\ \\mathrm{cm}$',
  3, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 8',
  new List<String>{'Délky dvou stran trojúhelníku $ABC$ jsou $a=7\\ \\mathrm{cm}$, $b=30\\ \\mathrm{cm}$. Obvod trojúhelníku $ABC$ v cm je vyjádřen celým číslem.','Určete, kolik cm musí měřit strana $c$ trojúhelníku $ABC$, aby byl jeho obvod','8.1 nejmenší možný,','8.2 největší možný.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Trojúhelníková nerovnost: $b-a<c<b+a$, tedy $23<c<37$.','8.1: nejmenší celé $c=24\\ \\mathrm{cm}$ (obvod $61\\ \\mathrm{cm}$).','8.2: největší celé $c=36\\ \\mathrm{cm}$ (obvod $73\\ \\mathrm{cm}$).'},
  '8.1: $24\\ \\mathrm{cm}$; 8.2: $36\\ \\mathrm{cm}$',
  2, 3, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
