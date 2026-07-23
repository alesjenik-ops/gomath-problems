String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M9C 2023 – úloha 6',
  new List<String>{'Vítek, Rudolf a Ondra jeli společně autem k moři. Každý z nich odřídil část trasy. Vítek odřídil třetinu celé trasy, Rudolf odřídil o $60$ km méně než Vítek a Ondra odřídil zbývající dvě pětiny celé trasy. Celá trasa měřila $x$ km.','6.1 Vyjádřete výrazem s proměnnou $x$, kolik km trasy odřídil Rudolf.','6.2 Vypočtěte, kolik km měřila celá trasa.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Vítek odřídil $\\frac{x}{3}$ km, Rudolf o $60$ km méně, tedy $\\frac{x}{3}-60$ km. (Totéž je zbytek trasy $x-\\frac{x}{3}-\\frac{2x}{5}=\\frac{4}{15}x$.)','6.2 Z rovnosti $\\frac{x}{3}-60=\\frac{4}{15}x$ po vynásobení patnácti dostaneme $5x-900=4x$, tedy $x=900$. Celá trasa měřila $900$ km.'},
  '6.1: $\\frac{x}{3}-60$ (tj. $\\frac{4}{15}x$); 6.2: $900$ km',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2023 – úloha 7',
  new List<String>{'Rotační válec má výšku $12$ cm. Odstraněním čtyř částí vytvoříme z tohoto válce kvádr s rozměry $8$ cm, $6$ cm a $12$ cm. Všechny hrany kvádru leží na povrchu válce (viz obrázek).','Pro výpočet použijte hodnotu $\\pi\\doteq 3{,}14$.','7.1 Vypočtěte v cm poloměr podstavy válce.','7.2 Vypočtěte v cm³ objem válce. Výsledek zaokrouhlete na desítky cm³.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 230" font-family="sans-serif"> <ellipse cx="80" cy="120" rx="26" ry="72" fill="#eef4fa" stroke="#000"/> <line x1="80" y1="48" x2="250" y2="48" stroke="#000"/> <line x1="80" y1="192" x2="250" y2="192" stroke="#000"/> <path d="M250 48 A26 72 0 0 1 250 192" fill="none" stroke="#000"/> <rect x="66" y="82" width="150" height="78" fill="none" stroke="#000" stroke-dasharray="5 3"/> <text x="160" y="216" font-size="12" text-anchor="middle">rotacni valec, vyska 12 cm</text> <polygon points="330,92 430,92 430,168 330,168" fill="#eef4fa" stroke="#000"/> <polygon points="330,92 365,64 465,64 430,92" fill="#eef4fa" stroke="#000"/> <polygon points="430,92 465,64 465,140 430,168" fill="#eef4fa" stroke="#000"/> <text x="318" y="134" font-size="12" text-anchor="end">6 cm</text> <text x="380" y="186" font-size="12" text-anchor="middle">8 cm</text> <text x="470" y="112" font-size="12">12 cm</text> </svg>',
  'valec-kvadr.svg',
  'Rotační válec s výškou 12 cm a vepsaným kvádrem, vedle samostatný kvádr s rozměry 8 cm, 6 cm a 12 cm.',
  'Válec a z něj vytvořený kvádr (schematický nákres)',
  new List<String>{'7.1 Podstavou kvádru je obdélník o stranách $8$ cm a $6$ cm vepsaný do podstavy válce; jeho úhlopříčka je průměrem kruhu: $\\sqrt{8^2+6^2}=\\sqrt{100}=10$ cm. Poloměr je tedy $r=5$ cm.','7.2 Objem válce $V=\\pi r^2 h=3{,}14\\cdot 5^2\\cdot 12=3{,}14\\cdot 300=942\\doteq 940$ cm³.'},
  '7.1: $r=5$ cm; 7.2: $V\\doteq 940$ cm³',
  3, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 8',
  new List<String>{'V obchodě s oříšky prodávají různé směsi. Jejich cena závisí pouze na hmotnosti a ceně použitých surovin. Ceny surovin za $1$ kg: arašídy $80$ korun, kešu $280$ korun, mandle $200$ korun. (Např. $200$gramové balení směsi obsahující $50$ g kešu a $150$ g mandlí stojí $44$ korun, tedy $1$ kg této směsi stojí $220$ korun.)','8.1 Dvoukilogramové balení směsi arašídů a mandlí obsahuje $800$ gramů arašídů a $1\\,200$ gramů mandlí. Vypočtěte, kolik korun stojí jeden kilogram této směsi.','8.2 Jiná směs obsahuje pouze arašídy a kešu, přičemž $1$ kg této směsi stojí $200$ korun. Velké balení této směsi obsahuje $500$ gramů arašídů. Vypočtěte, kolik gramů kešu obsahuje velké balení této směsi.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'8.1 Dvoukilogramové balení stojí $0{,}8\\cdot 80+1{,}2\\cdot 200=64+240=304$ korun. Jeden kilogram tedy stojí $304:2=152$ korun.','8.2 Ať balení obsahuje $a$ kg arašídů a $k$ kg kešu. Z ceny $\\frac{80a+280k}{a+k}=200$ plyne $80a+280k=200a+200k$, tj. $80k=120a$, tedy $k=1{,}5a$. Pro $a=500$ g je $k=750$ g.'},
  '8.1: $152$ korun; 8.2: $750$ gramů',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
