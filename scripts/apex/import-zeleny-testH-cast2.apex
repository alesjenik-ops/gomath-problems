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
  'Zelený H6 – houpačka a rovnováha',
  new List<String>{'Na houpačku o délce $240$ cm jsme na obou jejích koncích zavěsili $20$ kilogramových závaží (tj. $20$ závaží po $1$ kg). Vzpěra houpačky je umístěna v polovině houpačky, tj. ve vzdálenosti $120$ cm od jejího levého okraje. Uděláme dvě na sebe navazující změny počtu závaží a budeme sledovat, kam musí být umístěna vzpěra houpačky, aby zůstala po změnách v rovnováze.','6.1 Vypočtěte, kolik cm od levého okraje musí být umístěna vzpěra houpačky, aby zůstala v rovnovážné poloze poté, kdy přemístíme $10$ závaží z jejího levého konce na pravý.','6.2 Vypočtěte, o kolik cm a jakým směrem musíme poté přesunout vzpěru houpačky, aby zůstala v rovnovážné poloze po odebrání pěti závaží z obou jejích konců.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 300" font-family="sans-serif"> <line x1="70" y1="40" x2="430" y2="40" stroke="#444"/> <polygon points="70,40 78,36 78,44" fill="#444"/><polygon points="430,40 422,36 422,44" fill="#444"/> <text x="250" y="32" font-size="16" text-anchor="middle">240 cm</text> <line x1="70" y1="72" x2="250" y2="72" stroke="#444"/> <polygon points="70,72 78,68 78,76" fill="#444"/><polygon points="250,72 242,68 242,76" fill="#444"/> <text x="160" y="64" font-size="16" text-anchor="middle">120 cm</text> <rect x="70" y="118" width="360" height="14" fill="#dddddd" stroke="#000"/> <polygon points="250,132 232,215 268,215" fill="#333"/> <rect x="80" y="132" width="26" height="72" fill="none" stroke="#000"/> <rect x="394" y="132" width="26" height="72" fill="none" stroke="#000"/> <text x="93" y="228" font-size="13" text-anchor="middle">20 kg</text> <text x="407" y="228" font-size="13" text-anchor="middle">20 kg</text> <text x="250" y="255" font-size="14" text-anchor="middle">vzpěra v polovině</text> </svg>',
  'houpacka.svg',
  'Houpačka dlouhá 240 cm se vzpěrou v polovině (120 cm od levého okraje) a se závažími na obou koncích.',
  'Výchozí obrázek k úloze 6',
  new List<String>{'6.1 Po přemístění je vlevo $10$ závaží, vpravo $30$. Pro vzdálenost $d$ vzpěry od levého konce platí $10\\cdot d=30\\cdot(240-d)$, tj. $40d=7200$, $d=180$ cm.','6.2 Nyní je vlevo $5$ a vpravo $25$ závaží: $5\\cdot d=25\\cdot(240-d)$, tj. $30d=6000$, $d=200$ cm. Vzpěru posuneme z $180$ cm na $200$ cm, tedy o $20$ cm doprava.'},
  '6.1: $180$ cm; 6.2: o $20$ cm doprava',
  4, 8, '4',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený H7.1 – poměr objemů nádob',
  new List<String>{'Vypočtěte: Kolikrát větší je nádoba o objemu $0{,}25$ m³ než nádoba o objemu $250$ ml?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}25$ m³ $=250$ litrů $=250\\,000$ ml; $250\\,000:250=1000$.'},
  '$1000$ krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený H7.2 – část pole zabraná cestou',
  new List<String>{'Vypočtěte: Jakou část dvouhektarového pole představuje cesta vedoucí přes pole, dlouhá čtvrt kilometru a široká $4$ metry? Výsledek zapište zlomkem v základním tvaru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pole $2$ ha $=20\\,000$ m²; cesta $250\\cdot4=1000$ m²; podíl $\\frac{1000}{20\\,000}=\\frac{1}{20}$.'},
  '$\\frac{1}{20}$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený H7.3 – staročeské jednotky délky',
  new List<String>{'Vypočtěte: Kolik kilometrů od zdroje zápachu musel stát člověk, který prohlásil, že „to páchne na sto honů", víme-li, že staročeská jednotka délky $1$ hon se rovnala $210$ loktům a $1$ loket zhruba $60$ cm?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$100$ honů $=100\\cdot210=21\\,000$ loktů; $21\\,000\\cdot60$ cm $=1\\,260\\,000$ cm $=12\\,600$ m $=12{,}6$ km.'},
  '$12{,}6$ km',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
