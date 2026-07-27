String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M5B 2017 – úloha 1.1',
  new List<String>{'Vypočtěte: $200\\cdot 4\\cdot 60 + 60 - 60\\cdot 2\\cdot 400 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$200\\cdot 4\\cdot 60 = 48\\,000$ a $60\\cdot 2\\cdot 400 = 48\\,000$, tedy $48\\,000 + 60 - 48\\,000 = 60$.'},
  '$60$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2017 – úloha 1.2',
  new List<String>{'Vypočtěte: $51 + 51 + 7\\cdot 51 + 51 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$51\\cdot(1+1+7+1) = 51\\cdot 10 = 510$.'},
  '$510$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2017 – úloha 2',
  new List<String>{'V zápisu výpočtu chybí u dvou čísel poslední číslice. Doplňte číslice tak, aby obě dělení vyšla beze zbytku, a příklad vypočtěte:','$136\\square : 11 + 229\\square : 11 =$','Do záznamového archu opište příklad s oběma doplněnými číslicemi a výsledek, dílčí výpočty neopisujte.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Poslední číslice doplníme tak, aby čísla byla dělitelná 11: jediné možnosti jsou $1364$ a $2299$. Pak $1364:11 = 124$ a $2299:11 = 209$, součet $124 + 209 = 333$.'},
  '$1364:11 + 2299:11 = 333$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2017 – úloha 3',
  new List<String>{'Medvědí dvojice jí jablka stále stejným tempem. Medvěd sní za stejnou dobu dvakrát více jablek než medvědice. Medvědice spořádá 5 jablek za 40 sekund.','3.1 Určete, za kolik sekund sní medvěd jedno jablko.','3.2 Určete, kolik jablek sní medvědice za 4 minuty.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Medvědice sní 1 jablko za $40:5 = 8$ sekund. Medvěd jí dvakrát rychleji, jedno jablko sní za $8:2 = 4$ sekundy.','3.2 4 minuty $= 240$ sekund; medvědice sní 5 jablek za 40 s, tedy za 240 s sní $\\frac{240}{40}\\cdot 5 = 30$ jablek.'},
  '3.1: za $4$ sekundy; 3.2: $30$ jablek',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2017 – úloha 4',
  new List<String>{'Na plánku lyžařské běžecké trati je vyznačeno místo startu, stanoviště $A$, $B$ a stánek (viz obrázek). V pořadí zleva jsou $B$, stánek, $A$, start; vzdálenost stanovišť $B$ a $A$ je $18$ km.','Start je od stanoviště $B$ třikrát dále než od stanoviště $A$. Stánek je o $4$ km blíž ke stanovišti $A$ než ke stanovišti $B$.','4.1 Určete v km vzdálenost startu od stanoviště $B$.','4.2 Určete v km vzdálenost stánku od stanoviště $A$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 180" font-family="sans-serif"> <line x1="40" y1="90" x2="580" y2="90" stroke="#000" stroke-width="2"/> <line x1="90" y1="80" x2="90" y2="100" stroke="#000" stroke-width="2"/> <line x1="230" y1="80" x2="230" y2="100" stroke="#000" stroke-width="2"/> <line x1="360" y1="80" x2="360" y2="100" stroke="#000" stroke-width="2"/> <line x1="470" y1="80" x2="470" y2="100" stroke="#000" stroke-width="2"/> <text x="90" y="70" font-size="16" text-anchor="middle" font-weight="bold">B</text> <text x="230" y="70" font-size="16" text-anchor="middle" font-weight="bold">Stánek</text> <text x="360" y="70" font-size="16" text-anchor="middle" font-weight="bold">A</text> <text x="470" y="70" font-size="16" text-anchor="middle" font-weight="bold">Start</text> <path d="M90 118 L90 135 L360 135 L360 118" fill="none" stroke="#000" stroke-width="1.5"/> <text x="225" y="160" font-size="15" text-anchor="middle">18 km</text> </svg>',
  'trat.svg',
  'Přímka se stanovišti B, stánek, A a start; vzdálenost B až A je 18 km.',
  'Plánek běžecké trati',
  new List<String>{'4.1 Start je za stanovištěm $A$. Označíme vzdálenost startu od $A$ jako $x$. Pak $3x = 18 + x$, tedy $x = 9$ km a vzdálenost startu od $B$ je $18 + 9 = 27$ km.','4.2 Vzdálenosti stánku od $B$ a od $A$ dávají dohromady $18$ km a liší se o $4$ km. Kratší z nich (ke stanovišti $A$) je $(18 - 4):2 = 7$ km.'},
  '4.1: $27$ km; 4.2: $7$ km',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
