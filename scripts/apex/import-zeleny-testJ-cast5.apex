String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený J12 – hmotnost trubek plynovodu',
  new List<String>{'Plynovod tvoří ocelové trubky o vnějším průměru $1$ metr. Stěny trubek jsou silné $1$ cm. Jeden m³ oceli váží $8$ tun. $\\pi=3{,}14$.','Jaká je hmotnost trubek tvořících $1$ km dlouhý plynovod? Výsledek uveďte v tunách zaokrouhlených na jednotky.'},
  new List<String>{'A) $25$ tun','B) $249$ tun','C) $251$ tun','D) $2512$ tun','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Vnější poloměr $R=0{,}5$ m, vnitřní $r=0{,}49$ m. Obsah mezikruží $S=\\pi(R^2-r^2)=3{,}14\\cdot(0{,}25-0{,}2401)=3{,}14\\cdot 0{,}0099\\approx 0{,}0311$ m². Objem oceli na $1000$ m: $V\\approx 31{,}1$ m³. Hmotnost $\\approx 31{,}1\\cdot 8\\approx 249$ tun.'},
  'B) $249$ tun',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený J13 – úhel u pětiúhelníku a trojúhelníku',
  new List<String>{'Na obrázku je útvar složený z pravidelného pětiúhelníku a trojúhelníku. Přitom platí, že součet vnitřních úhlů jakéhokoli $n$-úhelníku $=(n-2)\\cdot 180^\\circ$.','Jak velký je úhel na obrázku označený symbolem „?"?'},
  new List<String>{'A) $18^\\circ$','B) $26^\\circ$','C) $36^\\circ$','D) $40^\\circ$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif"> <polygon points="155,37 283,130 234,281 76,281 27,130" fill="#d9d9d9" stroke="#000" stroke-width="2"/> <polygon points="283,130 491,281 234,281" fill="#ffffff" stroke="#000" stroke-width="2"/> <text x="466" y="274" font-size="20" text-anchor="middle">?</text> </svg>',
  'petiuhelnik-trojuhelnik.svg',
  'Pravidelný pětiúhelník, k jeho pravé straně je připojen trojúhelník; u dolního pravého vrcholu trojúhelníku je úhel označený otazníkem.',
  'Schematický nákres k úloze 13',
  new List<String>{'Vnitřní úhel pravidelného pětiúhelníku je $\\frac{(5-2)\\cdot 180^\\circ}{5}=108^\\circ$. V trojúhelníku vznikají u společné strany dva úhly po $180^\\circ-108^\\circ=72^\\circ$. Hledaný úhel $?=180^\\circ-72^\\circ-72^\\circ=36^\\circ$.'},
  'C) $36^\\circ$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený J14 – obvod útvaru z prolnutých čtverců',
  new List<String>{'Na obrázku je silnou čarou vyznačený útvar utvořený prolnutím $4$ stejných malých čtverců a jednoho velkého. Vrcholy velkého čtverce jsou průsečíky úhlopříček malých čtverců. Obsah velkého čtverce je $36$ cm², obsah jednoho každého malého čtverce je $16$ cm².','Jaký je obvod útvaru ohraničeného silnou čarou?'},
  new List<String>{'A) $48$ cm','B) $56$ cm','C) $60$ cm','D) $64$ cm','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 360" font-family="sans-serif"> <polygon points="40,330 160,330 160,270 220,270 220,330 340,330 340,210 280,210 280,150 340,150 340,30 220,30 220,90 160,90 160,30 40,30 40,150 100,150 100,210 40,210" fill="none" stroke="#000" stroke-width="2.5"/> <polygon points="100,270 280,270 280,90 100,90" fill="none" stroke="#555" stroke-width="1" stroke-dasharray="5 4"/> <line x1="40" y1="330" x2="160" y2="210" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="40" y1="210" x2="160" y2="330" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="220" y1="330" x2="340" y2="210" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="220" y1="210" x2="340" y2="330" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="220" y1="150" x2="340" y2="30" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="220" y1="30" x2="340" y2="150" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="40" y1="150" x2="160" y2="30" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> <line x1="40" y1="30" x2="160" y2="150" stroke="#555" stroke-width="1" stroke-dasharray="4 4"/> </svg>',
  'ctverce-prolnuti.svg',
  'Útvar z prolnutí čtyř malých čtverců a jednoho velkého; silná čára ohraničuje jejich sjednocení, čárkovaně jsou úhlopříčky malých čtverců a velký čtverec.',
  'Prolnutí čtyř malých a jednoho velkého čtverce',
  new List<String>{'Malý čtverec má stranu $\\sqrt{16}=4$ cm, velký stranu $\\sqrt{36}=6$ cm. Střediska malých čtverců (průsečíky úhlopříček) jsou vrcholy velkého čtverce, jsou tedy $6$ cm od sebe. Obvod silné čáry se skládá z osmi úseků délky $4$ cm a dvanácti úseků délky $2$ cm: $8\\cdot 4+12\\cdot 2=32+24=56$ cm.'},
  'B) $56$ cm',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
