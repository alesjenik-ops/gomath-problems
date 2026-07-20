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
  'Zelený C6 – jablka pana Ngo',
  new List<String>{'Vietnamský obchodník Ngo nabízí stabilně 3 druhy jablek A, B a C. V uplynulém měsíci neměnil jejich ceny, ale připravuje změnu pro následující měsíc. Horovi v minulém měsíci nakoupili $2$ kg jablek A, $3$ kg jablek B a $2$ kg jablek C a za jablka utratili $175$ korun. Puštíkovi minulý měsíc koupili $3$ kg jablek A, $1$ kg jablek B a $3$ kg jablek C a zaplatili stejnou částku. Jablka C jsou o polovinu dražší než druh A.','6.1 Vypočtěte, kolik minulý měsíc za nákup jablek u pana Ngo utratili Čížkovi, když nakoupili po dvou kilogramech od každého druhu.','6.2 Vypočtěte, o kolik procent bude příští měsíc dražší druh C ve srovnání s druhem A, jestliže odrůda C podraží o pětinu, zatímco odrůda A o desetinu zlevní.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Označíme ceny za kg $a$, $b$, $c$; $c = 1{,}5a$. Rovnice: $2a + 3b + 2c = 175$ a $3a + b + 3c = 175$.','Dosazením $c = 1{,}5a$: $5a + 3b = 175$ a $7{,}5a + b = 175$. Řešením $a = 20$, $b = 25$, $c = 30$ (Kč/kg).','6.1 Čížkovi zaplatili $2(a+b+c) = 2 \\cdot (20+25+30) = 2 \\cdot 75 = 150$ Kč.','6.2 Nová cena C: $30 \\cdot 1{,}2 = 36$; nová cena A: $20 \\cdot 0{,}9 = 18$. C je proti A dražší $\\dfrac{36}{18} = 2$krát, tj. o $100\\,\\%$.'},
  '6.1: $150$ Kč; 6.2: o $100\\,\\%$',
  4, 8, '3',
  new List<String>{'zs2','r9','soustava','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený C7.1 – pytle brambor',
  new List<String>{'Kolik půlmetrákových pytlů brambor naplníme z hromady brambor o hmotnosti $22{,}3$ tuny?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Půlmetrákový pytel má $50$ kg. $22{,}3$ tuny $= 22\\,300$ kg. $22\\,300 : 50 = 446$ pytlů.'},
  '$446$ pytlů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený C7.2 – sloupec vody nad ponorkou',
  new List<String>{'Jakou hmotnost má sloupec vody nad uzávěrem vchodu do ponorky o obsahu plochy $1$ m², víme-li, že se ponorka nachází v hloubce $1200$ metrů a litr vody má hmotnost $1$ kg? Výsledek uveďte v tunách.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Objem sloupce: $1 \\cdot 1200 = 1200$ m³ $= 1\\,200\\,000$ litrů $= 1\\,200\\,000$ kg $= 1200$ tun.'},
  '$1200$ tun',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený C7.3 – stahy srdce',
  new List<String>{'Kolik stahů provede za jeden den srdce člověka, jehož průměrná tepová frekvence je $80$ stahů za minutu?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Za den je $60 \\cdot 24 = 1440$ minut. $80 \\cdot 1440 = 115\\,200$ stahů.'},
  '$115\\,200$ stahů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený C8 – čtyřúhelník vepsaný do kruhu',
  new List<String>{'Do kruhu o průměru $10$ cm je vepsán čtyřúhelník osově souměrný podle průměru kruhu, jehož dvě strany označené písmenem $a$ jsou každá dlouhá $8$ cm.','8.1 Vypočtěte obvod čtyřúhelníku vepsaného do kruhu.','8.2 Vypočtěte obsah šedé části kruhu. ($\\pi = 3{,}14$)'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 400" font-family="sans-serif"> <circle cx="200" cy="200" r="150" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <polygon points="50,200 158,56 350,200 158,344" fill="#ffffff" stroke="#000" stroke-width="2"/> <line x1="50" y1="200" x2="350" y2="200" stroke="#000" stroke-width="1" stroke-dasharray="6 5"/> <text x="262" y="118" font-size="16" font-style="italic">a = 8 cm</text> <text x="252" y="360" font-size="16" font-style="italic">a</text> <text x="205" y="218" font-size="14" text-anchor="middle">průměr = 10 cm</text> </svg>',
  'ctyruhelnik-kruh.svg',
  'Kruh o průměru 10 cm s vepsaným deltoidem souměrným podle vodorovného průměru; dvě pravé strany jsou dlouhé 8 cm, zbytek kruhu je šedý.',
  'Čtyřúhelník vepsaný do kruhu',
  new List<String>{'Poloměr $r = 5$ cm. Vrcholy na koncích průměru a dva vrcholy souměrné podle průměru. Ze zbývajících stran: pomocí Pythagorovy věty vychází druhá dvojice stran $6$ cm.','8.1 Obvod $= 6 + 6 + 8 + 8 = 28$ cm.','8.2 Obsah kruhu $= 3{,}14 \\cdot 5^2 = 78{,}5$ cm². Čtyřúhelník (deltoid) má úhlopříčky $10$ cm a $9{,}6$ cm, obsah $= \\dfrac{10 \\cdot 9{,}6}{2} = 48$ cm². Šedá část $= 78{,}5 - 48 = 30{,}5$ cm².'},
  '8.1: $28$ cm; 8.2: $30{,}5$ cm²',
  4, 8, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
