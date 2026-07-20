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
  'Zelený A6 – matematická olympiáda',
  new List<String>{'V krajském kole matematické olympiády naše škola nedopadla nejhůř. Petr Mazánek z 8. A a ještě s jedním dalším účastníkem skončili na třetím sdíleném místě, a za sebou tak nechali čtyři pětiny soutěžících. Lepších než Petr bylo jen $15\\,\\%$ účastníků.','6.1 Neznámý počet všech účastníků krajského kola matematické olympiády označte $x$ a sestavte rovnici pro jeho výpočet. Počet účastníků vypočtěte.','6.2 Vypočtěte, kolik účastníků se umístilo lépe než Mazánek z 8. A.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Lepších je $15\\,\\%$, horších $\\frac{4}{5}=80\\,\\%$, na třetím místě jsou 2 účastníci. Rovnice: $x=0{,}15x+\\frac{4}{5}x+2$, odtud $0{,}05x=2$, tedy $x=40$.','6.2 Lépe se umístilo $15\\,\\%$ ze $40$, tj. $6$ účastníků.'},
  '6.1: $x=0{,}15x+\\frac{4}{5}x+2$, $x=40$; 6.2: $6$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený A7.1 – Dan na kole',
  new List<String>{'Kolik km ujede Dan na kole za $2$ hodiny nepřetržité jízdy, pokud jeho průměrná rychlost dosahuje $5$ m/s?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5$ m/s $=18$ km/h. Za $2$ hodiny ujede $2\\cdot 18=36$ km.'},
  '$36$ km',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený A7.2 – lahve piva',
  new List<String>{'Kolik půllitrových lahví piva lze naplnit z tanku o objemu $20$ m³, který je naplněn z jedné čtvrtiny?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Naplněná část: $\\frac{1}{4}\\cdot 20 = 5$ m³ $=5000$ litrů. Půllitrových lahví: $5000:0{,}5=10\\,000$.'},
  '$10\\,000$ lahví',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený A7.3 – uhlí kolečkem',
  new List<String>{'Kolik km ujde Petr s kolečkem, než složí $42$ metráků uhlí, víme-li, že v průměru se na jedno kolečko vejde $40$ kg uhlí a otvor do uhelného sklepa je od hromady uhlí vzdálen $50$ m?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$42$ q $=4200$ kg $\\Rightarrow 4200:40=105$ koleček. Každé kolečko tam a zpět $2\\cdot 50=100$ m, celkem $105\\cdot 100=10\\,500$ m $=10{,}5$ km.'},
  '$10{,}5$ km',
  1, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený A8 – zkratka přes park',
  new List<String>{'Na obrázku je vidět obdélníkový park pokrytý trávníkem o rozměrech $300$ m $\\times$ $400$ m. Okolo něj vede chodník. Mnozí včetně Pepy si však cestu do školy okolo parku zkracují po diagonále pěšinou vyšlapanou v trávníku. Pepa tudy chodí 2krát denně $200$ dnů v roce.','8.1 Vypočtěte, jak dlouhou trasu Pepa ušetří používáním této zkratky za $1$ rok.','8.2 Vypočtěte, kolik času ušetří Pepa touto zkratkou za $1$ rok, chodí-li průměrnou rychlostí $4$ km/h.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <text x="250" y="30" font-size="18" text-anchor="middle">400 metrů</text> <line x1="70" y1="45" x2="430" y2="45" stroke="#444" stroke-width="1"/> <polygon points="70,45 78,41 78,49" fill="#444"/><polygon points="430,45 422,41 422,49" fill="#444"/> <text x="30" y="205" font-size="18" text-anchor="middle" transform="rotate(-90 30 205)">300 metrů</text> <line x1="45" y1="70" x2="45" y2="340" stroke="#444" stroke-width="1"/> <polygon points="45,70 41,78 49,78" fill="#444"/><polygon points="45,340 41,332 49,332" fill="#444"/> <rect x="70" y="70" width="360" height="270" fill="#e9efe6" stroke="#000" stroke-width="2.5"/> <line x1="70" y1="70" x2="430" y2="340" stroke="#000" stroke-width="2" stroke-dasharray="3 6"/> <text x="250" y="212" font-size="22" text-anchor="middle" font-style="italic">?</text> <text x="250" y="330" font-size="16" text-anchor="middle" fill="#333">trávník</text> <text x="360" y="250" font-size="15" text-anchor="middle" fill="#333">chodník</text> </svg>',
  'park.svg',
  'Obdélníkový park 400 m krát 300 m s úhlopříčnou vyšlapanou cestou a obvodovým chodníkem.',
  'Obdélníkový park s úhlopříčnou zkratkou',
  new List<String>{'8.1 Chodník okolo dvou stran: $300+400=700$ m. Úhlopříčka: $\\sqrt{300^2+400^2}=500$ m. Úspora na jednu cestu $700-500=200$ m. Za rok: $200\\cdot 2\\cdot 200=80\\,000$ m $=80$ km.','8.2 $80$ km při $4$ km/h trvá $80:4=20$ hodin.'},
  '8.1: $80$ km; 8.2: $20$ hodin',
  4, 8, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
