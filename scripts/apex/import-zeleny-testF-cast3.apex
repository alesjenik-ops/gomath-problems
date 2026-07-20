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
  'Zelený F8 – krabička tvaru kvádru',
  new List<String>{'Na obrázku je zobrazena krabička tvaru kvádru. Nejdelší tyčka, kterou je možné do prázdné krabičky vložit tak, aby se krabička dala zavřít, má délku $25$ cm. Výška krabičky je $15$ cm a délka a šířka její podstavy jsou v poměru $4:3$.','8.1 Vypočtěte rozměry podstavy krabičky.','8.2 Vypočtěte maximální počet těchto krabiček, který se vejde do krabice o vnitřních rozměrech 60 × 60 × 90 cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 420" font-family="sans-serif"> <polygon points="110,150 360,150 360,350 110,350" fill="#eef2ec" stroke="#000" stroke-width="2"/> <polygon points="110,150 185,95 435,95 360,150" fill="#f6f8f4" stroke="#000" stroke-width="2"/> <polygon points="360,150 435,95 435,295 360,350" fill="#e2e8de" stroke="#000" stroke-width="2"/> <line x1="110" y1="350" x2="185" y2="295" stroke="#000" stroke-width="1.2" stroke-dasharray="5 5"/> <line x1="185" y1="295" x2="435" y2="295" stroke="#000" stroke-width="1.2" stroke-dasharray="5 5"/> <line x1="185" y1="295" x2="185" y2="95" stroke="#000" stroke-width="1.2" stroke-dasharray="5 5"/> <line x1="185" y1="95" x2="360" y2="350" stroke="#000" stroke-width="2.4"/> <text x="298" y="205" font-size="18" font-style="italic">25 cm</text> <text x="58" y="255" font-size="18">15 cm</text> <text x="235" y="374" font-size="18" font-style="italic">a</text> <text x="406" y="240" font-size="18" font-style="italic">b</text> <rect x="340" y="378" width="128" height="30" fill="none" stroke="#000" stroke-width="1"/> <text x="350" y="398" font-size="15">a : b = 4 : 3</text> </svg>',
  'krabicka-kvadr.svg',
  'Kvádr s vyznačenou tělesovou úhlopříčkou 25 cm, výškou 15 cm a stranami podstavy a, b v poměru 4:3.',
  'Krabička tvaru kvádru s tělesovou úhlopříčkou',
  new List<String>{'8.1 Tělesová úhlopříčka kvádru je $25$ cm, výška $15$ cm, takže úhlopříčka podstavy je $\\sqrt{25^2-15^2} = \\sqrt{400} = 20$ cm. Při poměru stran $4:3$ platí $\\sqrt{(4k)^2+(3k)^2} = 5k = 20$, tedy $k = 4$. Rozměry podstavy jsou $16$ cm a $12$ cm.','8.2 Krabička má rozměry 16 × 12 × 15 cm. Do krabice 60 × 60 × 90 cm se vejde $5$ krabiček po $12$ cm ($60:12=5$), $4$ krabičky po $15$ cm ($60:15=4$) a $5$ krabiček po $16$ cm ($90:16$ je $5$ celých). Celkem $5\\cdot 4\\cdot 5 = 100$ krabiček.'},
  '8.1: 16 cm × 12 cm; 8.2: 100 ks',
  5, 8, '4',
  new List<String>{'zs2','r9','stereometrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F9 – množina bodů u kolmých úseček',
  new List<String>{'V rovině jsou vzájemně kolmé úsečky $AB$ o délce $10$ cm a $CD$ o délce $8$ cm.','Vyznačte množinu bodů, které nejsou vzdáleny zároveň od úseček $AB$ a $CD$ více než $2$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 380" font-family="sans-serif"> <line x1="60" y1="230" x2="400" y2="230" stroke="#000" stroke-width="2.5"/> <line x1="60" y1="221" x2="60" y2="239" stroke="#000" stroke-width="2.5"/> <line x1="400" y1="221" x2="400" y2="239" stroke="#000" stroke-width="2.5"/> <line x1="340" y1="70" x2="340" y2="330" stroke="#000" stroke-width="2.5"/> <line x1="331" y1="70" x2="349" y2="70" stroke="#000" stroke-width="2.5"/> <line x1="331" y1="330" x2="349" y2="330" stroke="#000" stroke-width="2.5"/> <text x="40" y="236" font-size="20" font-weight="bold" font-style="italic">A</text> <text x="408" y="224" font-size="20" font-weight="bold" font-style="italic">B</text> <text x="352" y="64" font-size="20" font-weight="bold" font-style="italic">C</text> <text x="352" y="348" font-size="20" font-weight="bold" font-style="italic">D</text> </svg>',
  'kolme-usecky.svg',
  'Dvě vzájemně kolmé úsečky: vodorovná AB délky 10 cm a svislá CD délky 8 cm, které se protínají.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Množina bodů do vzdálenosti $2$ cm od úsečky je pás široký $4$ cm (s půlkruhy na koncích). Hledáme body ležící současně v pásu okolo $AB$ i v pásu okolo $CD$. V okolí průsečíku obou úseček je průnikem těchto pásů čtverec o straně $4$ cm (viz obrázek v klíči).'},
  'Zvýrazněný čtverec o straně $4$ cm (a jeho vnitřek) v okolí průsečíku úseček — průnik pásů širokých $4$ cm okolo úseček $AB$ a $CD$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
