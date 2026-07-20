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
  'Zelený E8 – krov střechy',
  new List<String>{'Na obrázku vidíte schéma krovu nové střechy, kterou právě staví tesaři. Pohledem na štít má střecha tvar rovnoramenného trojúhelníku s vyznačenými rozměry (výška $4$ m, základna $6$ m), pohledem z boku je dlouhá $10$ metrů. Krov je sestaven z $9$ párů krokví.','8.1 Vypočtěte celkovou délku trámů, ze kterých jsou sestaveny krokve na celé střeše.','8.2 Vypočtěte, kolik kubických metrů prken je třeba na zakrytí střechy (tzv. poklop), víme-li, že tloušťka prken je $2{,}5$ cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 300" font-family="sans-serif"> <text x="140" y="28" font-size="15" text-anchor="middle" font-weight="bold">Pohled na štít</text> <polygon points="140,90 50,210 230,210" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="30" y1="90" x2="30" y2="210" stroke="#444" stroke-width="1"/> <polygon points="30,90 26,98 34,98" fill="#444"/><polygon points="30,210 26,202 34,202" fill="#444"/> <text x="18" y="153" font-size="14" text-anchor="middle" transform="rotate(-90 18 153)">4 m</text> <line x1="50" y1="228" x2="230" y2="228" stroke="#444" stroke-width="1"/> <polygon points="50,228 58,224 58,232" fill="#444"/><polygon points="230,228 222,224 222,232" fill="#444"/> <text x="140" y="246" font-size="14" text-anchor="middle">6 m</text> <text x="242" y="118" font-size="13">krokve</text> <line x1="240" y1="114" x2="192" y2="150" stroke="#000" stroke-width="0.8"/> <text x="390" y="28" font-size="15" text-anchor="middle" font-weight="bold">Pohled z boku</text> <rect x="300" y="90" width="180" height="120" fill="none" stroke="#000" stroke-width="2"/> <line x1="322" y1="90" x2="322" y2="210" stroke="#000" stroke-width="1"/> <line x1="344" y1="90" x2="344" y2="210" stroke="#000" stroke-width="1"/> <line x1="366" y1="90" x2="366" y2="210" stroke="#000" stroke-width="1"/> <line x1="410" y1="90" x2="410" y2="210" stroke="#000" stroke-width="1"/> <line x1="432" y1="90" x2="432" y2="210" stroke="#000" stroke-width="1"/> <line x1="454" y1="90" x2="454" y2="210" stroke="#000" stroke-width="1"/> <line x1="300" y1="118" x2="480" y2="118" stroke="#000" stroke-width="0.7"/> <line x1="300" y1="146" x2="480" y2="146" stroke="#000" stroke-width="0.7"/> <line x1="300" y1="174" x2="480" y2="174" stroke="#000" stroke-width="0.7"/> <text x="470" y="80" font-size="13" text-anchor="end">prkna</text> <line x1="452" y1="84" x2="420" y2="118" stroke="#000" stroke-width="0.8"/> <line x1="300" y1="228" x2="480" y2="228" stroke="#444" stroke-width="1"/> <polygon points="300,228 308,224 308,232" fill="#444"/><polygon points="480,228 472,224 472,232" fill="#444"/> <text x="390" y="246" font-size="14" text-anchor="middle">10 m</text> </svg>',
  'krov.svg',
  'Vlevo pohled na štít: rovnoramenný trojúhelník s výškou 4 m a základnou 6 m. Vpravo pohled z boku: obdélník dlouhý 10 m s krokvemi a prkny.',
  'Schéma krovu střechy',
  new List<String>{'8.1 Krokev je rameno trojúhelníku: $\\sqrt{3^2+4^2}=5$ m. Jeden pár krokví má $2\\cdot5=10$ m, celkem $9\\cdot10=90$ m trámů.','8.2 Střecha má dvě obdélníkové plochy $5\\times10=50$ m², dohromady $100$ m². Objem prken $100\\cdot0{,}025=2{,}5$ m³.'},
  '8.1: $90$ m trámů; 8.2: $2{,}5$ m³ prken',
  4, 8, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený E9 – množina bodů kolem úsečky',
  new List<String>{'V rovině leží úsečka $AB$ o délce $6$ cm.','Vyznačte množinu všech bodů, jejichž vzdálenost od úsečky $AB$ není menší než $2$ cm a není větší než $4$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 210" font-family="sans-serif"> <line x1="90" y1="60" x2="330" y2="150" stroke="#000" stroke-width="2.5"/> <line x1="83" y1="48" x2="97" y2="72" stroke="#000" stroke-width="2"/> <line x1="323" y1="138" x2="337" y2="162" stroke="#000" stroke-width="2"/> <text x="76" y="58" font-size="18" font-weight="bold">A</text> <text x="338" y="162" font-size="18" font-weight="bold">B</text> <text x="196" y="98" font-size="15">6 cm</text> </svg>',
  'usecka-ab-6.svg',
  'Úsečka AB o délce 6 cm v rovině, šikmo orientovaná.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Množina všech bodů ve vzdálenosti přesně $r$ od úsečky $AB$ je obrys „obdélníku se zaoblenými rohy" (dvě úsečky rovnoběžné s $AB$ ve vzdálenosti $r$ a dva půlkruhové oblouky se středy $A$ a $B$ o poloměru $r$). Hledaná množina je uzavřená plocha mezi takovými obrysy pro $r=2$ cm a $r=4$ cm.'},
  'Uzavřená plocha (mezikruží kolem úsečky) mezi dvěma soustřednými obrysy tvořenými úsečkami rovnoběžnými s $AB$ a oblouky se středy $A$, $B$, a to ve vzdálenostech $2$ cm a $4$ cm od úsečky $AB$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
