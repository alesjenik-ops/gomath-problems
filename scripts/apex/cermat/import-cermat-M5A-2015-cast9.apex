String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5A 2015 – úloha 16',
  new List<String>{'Na cestě od startu $S$ do cíle $C$ kolem vodní plochy je možné postupovat pouze po čarách čtvercové sítě.','Vyznačená cesta z $S$ do $C$ kolem vodní plochy měří 1 800 metrů, ale existují i kratší cesty.','16.1 Zakreslete jednu cestu, která vede kolem vodní plochy z $S$ do $C$ a má nejkratší možnou délku.','16.2 Vypočtěte nejkratší možnou délku cesty z $S$ do $C$ kolem vodní plochy.','16.3 Určete počet všech různých cest z $S$ do $C$ kolem vodní plochy, které mají nejkratší možnou délku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 570 310" font-family="sans-serif"><polygon points="33.6,240.7 217.9,240.7 217.9,160.9 185.6,159.0 153.3,164.7 147.6,183.7 100.1,181.8 86.8,145.7 60.2,143.8 33.6,162.8" fill="#b9b9b9"/><polygon points="72.4,38.2 121.0,31.7 170.4,30.6 206.5,34.4 213.0,46.9 213.0,69.7 217.9,94.4 225.5,124.8 223.6,147.6 212.2,164.7 162.8,170.4 159.0,143.8 166.6,117.2 174.2,94.4 159.0,73.5 124.8,52.6" fill="#b9b9b9"/><polygon points="219.8,27.9 235.0,27.9 248.3,48.8 250.2,79.2 238.8,100.1 219.8,107.7 206.5,100.1 212.2,84.9 227.4,83.0 233.1,67.8 227.4,48.8 219.8,41.2" fill="#b9b9b9"/><path d="M 26 254 V 26 M 64 254 V 26 M 102 254 V 26 M 140 254 V 26 M 178 254 V 26 M 216 254 V 26 M 254 254 V 26 M 26 254 H 254 M 26 216 H 254 M 26 178 H 254 M 26 140 H 254 M 26 102 H 254 M 26 64 H 254 M 26 26 H 254" fill="none" stroke="#000" stroke-width="1.2"/><path d="M 26 254 L 26 140 L 102 140 L 102 178 L 140 178 L 140 102 L 102 102 L 102 64 L 64 64 L 64 26 L 216 26 L 216 64" fill="none" stroke="#000" stroke-width="4" stroke-linejoin="round"/><circle cx="26" cy="254" r="4.5" fill="#000"/><text x="12" y="272" font-size="14" font-style="italic">S</text><circle cx="216" cy="64" r="4.5" fill="#000"/><text x="200" y="58" font-size="14" font-style="italic">C</text><polygon points="307.6,240.7 491.9,240.7 491.9,160.9 459.6,159.0 427.3,164.7 421.6,183.7 374.1,181.8 360.8,145.7 334.2,143.8 307.6,162.8" fill="#b9b9b9"/><polygon points="346.4,38.2 395.0,31.7 444.4,30.6 480.5,34.4 487.0,46.9 487.0,69.7 491.9,94.4 499.5,124.8 497.6,147.6 486.2,164.7 436.8,170.4 433.0,143.8 440.6,117.2 448.2,94.4 433.0,73.5 398.8,52.6" fill="#b9b9b9"/><polygon points="493.8,27.9 509.0,27.9 522.3,48.8 524.2,79.2 512.8,100.1 493.8,107.7 480.5,100.1 486.2,84.9 501.4,83.0 507.1,67.8 501.4,48.8 493.8,41.2" fill="#b9b9b9"/><path d="M 300 254 V 26 M 338 254 V 26 M 376 254 V 26 M 414 254 V 26 M 452 254 V 26 M 490 254 V 26 M 528 254 V 26 M 300 254 H 528 M 300 216 H 528 M 300 178 H 528 M 300 140 H 528 M 300 102 H 528 M 300 64 H 528 M 300 26 H 528" fill="none" stroke="#000" stroke-width="1.2"/><circle cx="300" cy="254" r="4.5" fill="#000"/><text x="286" y="272" font-size="14" font-style="italic">S</text><circle cx="490" cy="64" r="4.5" fill="#000"/><text x="474" y="58" font-size="14" font-style="italic">C</text><text x="126" y="304" font-size="12" text-anchor="middle">vyznačená cesta (1 800 m)</text><text x="400" y="304" font-size="12" text-anchor="middle">síť pro vlastní zákres</text></svg>',
  'mapa-cesta.svg',
  'Čtvercová síť 6 krát 6 s šedou vodní plochou, startem S v levém dolním rohu a cílem C; vlevo je tučně vyznačena cesta dlouhá 1 800 metrů.',
  'Schematický nákres sítě s vodní plochou (vyznačená cesta a prázdná síť)',
  new List<String>{'Vyznačená cesta se skládá z 18 stran čtverečků a měří 1 800 m, jedna strana čtverečku tedy měří $1\\,800:18=100$ m.','16.1 a 16.2 Vodní plocha uzavírá cestu vpravo i dole, proto je nutné jít nejprve nahoru po levém okraji sítě, potom případně o jeden krok doprava a dále nahoru k hornímu okraji, po horním okraji doprava až nad cíl a nakonec jeden krok dolů do $C$. Taková cesta má 12 stran čtverečků, tedy $12\\cdot 100=1\\,200$ m.','16.3 Odbočit doprava lze až ve třetím, čtvrtém nebo pátém mřížovém bodě levého okraje, případně až v horním rohu sítě. Nejkratších cest jsou proto 4.'},
  '16.1: viz obrázek (jedna z nejkratších cest); 16.2: $1\\,200$ m; 16.3: 4 cesty',
  4, 8, '4',
  new List<String>{'zs1','planimetrie','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
