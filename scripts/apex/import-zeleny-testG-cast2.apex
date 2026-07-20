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
  'Zelený G6 – ředění lihu ve válcové nádobě',
  new List<String>{'Do skleněné nádoby tvaru válce jsme nalili $500$ ml lihu o koncentraci $80\\,\\%$. Hladina dosáhla výšky $10$ cm. Postupně budeme do nádoby přilévat destilovanou vodu tak, abychom snížili koncentraci lihu na $10\\,\\%$.','6.1 Vypočtěte, jak vysokou nádobu musíme zvolit, abychom ředění na $10\\,\\%$ mohli provést.','6.2 Vypočtěte, jaké koncentrace lihu dosáhneme, budeme-li mít k dispozici pouze nádobu o výšce $40$ cm.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Čistého lihu je $500\\cdot 0{,}8=400$ ml a jeho množství se nemění. Pro koncentraci $10\\,\\%$ je celkový objem $400:0{,}1=4000$ ml. Protože $500$ ml odpovídá $10$ cm (tedy $50$ ml na $1$ cm), je potřebná výška $4000:50=80$ cm.','6.2 V nádobě vysoké $40$ cm je nejvýše $40\\cdot 50=2000$ ml roztoku. Koncentrace lihu je $\\frac{400}{2000}=0{,}2=20\\,\\%$.'},
  '6.1: nejméně $80$ cm; 6.2: $20\\,\\%$',
  4, 8, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený G7.1 – hladina vody v nádrži',
  new List<String>{'V jaké výšce bude hladina vody v nádrži, jestliže zmenšíme šířku a délku původní nádrže na čtvrtinu a v původní nádrži dosahovala voda do výšky $10$ cm? Výsledek uveďte v cm.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Obsah dna se zmenší na $\\frac{1}{4}\\cdot\\frac{1}{4}=\\frac{1}{16}$. Při stejném objemu vody vzroste výška $16$krát: $10\\cdot 16=160$ cm.'},
  '$160$ cm',
  1, 3, '2',
  new List<String>{'zs2','r9','stereometrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený G7.2 – žitná mouka na chleba',
  new List<String>{'Kolik tun žitné mouky je potřeba k výrobě $6000$ dvoukilogramových bochníků chleba, víme-li, že na výrobu $1$ kg chleba je třeba $600$ g pšeničné a o polovinu méně žitné mouky? Výsledek uveďte v metrických centech.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Chleba celkem: $6000\\cdot 2=12\\,000$ kg. Na $1$ kg chleba je žitné mouky $\\frac{1}{2}\\cdot 600=300$ g. Celkem $12\\,000\\cdot 0{,}3=3600$ kg $=36$ q (metrických centů).'},
  '$36$ q',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený G7.3 – čas u toaletního stolku',
  new List<String>{'Kolik dnů celkově stráví paní Ptáčková u toaletního stolku za $40$ let svého života, jestliže u něj denně sedí v průměru $15$ minut ráno a $5$ minut večer? Počítejte s délkou roku $360$ dnů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Denně $15+5=20$ minut. Za $40$ let: $20\\cdot 360\\cdot 40=288\\,000$ minut. To je $288\\,000:1440=200$ dnů (den má $1440$ minut).'},
  '$200$ dnů',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený G8 – pozemek ze tří trojúhelníků',
  new List<String>{'Na obrázku je pozemek složený ze $3$ stejných parcel tvaru rovnoramenného trojúhelníku (základna $60$ m, ramena $50$ m). Majitel pozemku se rozhodl pozemek oplotit.','8.1 Vypočtěte výměru pozemku v hektarech.','8.2 Vypočtěte počet plotových sloupků, které bude třeba nainstalovat k montáži plotu okolo celého pozemku, víme-li, že vzdálenost mezi sousedními sloupky je $1$ metr.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif"> <polygon points="40,280 160,120 347,50 467,210 280,280" fill="#eef3ea" stroke="#000000" stroke-width="2"/> <line x1="280" y1="280" x2="160" y2="120" stroke="#000000" stroke-width="1.2"/> <line x1="280" y1="280" x2="347" y2="50" stroke="#000000" stroke-width="1.2"/> <text x="92" y="192" font-size="17" text-anchor="middle" transform="rotate(-53 92 192)">50 m</text> <text x="160" y="303" font-size="17" text-anchor="middle">60 m</text> </svg>',
  'pozemek.svg',
  'Pozemek složený ze tří shodných rovnoramenných trojúhelníků se základnou 60 m a rameny 50 m.',
  'Pozemek ze tří shodných trojúhelníkových parcel',
  new List<String>{'8.1 Výška trojúhelníku k základně $60$ m je $\\sqrt{50^2-30^2}=40$ m, obsah jednoho $\\frac{1}{2}\\cdot 60\\cdot 40=1200$ m². Tři parcely mají $3\\cdot 1200=3600$ m² $=0{,}36$ ha.','8.2 Obvod pozemku tvoří jedna základna $60$ m a čtyři ramena po $50$ m: $60+4\\cdot 50=260$ m. Při rozteči $1$ m je potřeba $260$ sloupků.'},
  '8.1: $0{,}36$ ha; 8.2: $260$ sloupků',
  4, 8, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
