String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M5B 2024 – úloha 4.2',
  new List<String>{'Za 6 stejných židlí a dvě stejná křesla zaplatí rodina 23 200 Kč. Křeslo je o 400 Kč dražší než židle.','Kolik stojí jedna židle?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Židle stojí $z$, křeslo $z+400$. Platí $6z+2\\cdot(z+400)=23\\,200$, tj. $8z+800=23\\,200$, $8z=22\\,400$, $z=2\\,800$ Kč.'},
  '$2\\,800$ Kč',
  2, 3, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5B 2024 – úloha 4.3',
  new List<String>{'Do nákladního automobilu ráno naložili pracovníci přepravní firmy stejné balíky se zbožím. Prvnímu zákazníkovi pak z nákladního automobilu vydali jednu šestinu balíků. Druhému zákazníkovi vydali 30 balíků a na třetího zákazníka jim v nákladním automobilu zbyla druhá polovina nákladu.','Kolik celkem balíků bylo ráno naloženo do nákladního automobilu?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $c$ balíků. Prvnímu $\\frac{c}{6}$, třetímu (druhá polovina) $\\frac{c}{2}$, druhému $30$. Platí $\\frac{c}{6}+30+\\frac{c}{2}=c$, odtud $\\frac{c}{3}=30$, $c=90$ balíků. Rozvezeno bylo $15$, $30$ a $45$ balíků.'},
  '$90$ balíků',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2024 – úloha 5.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$\\square$ sekund $-\\;\\frac{1}{4}$ hodiny $=25$ minut'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{4}$ hodiny $=15$ minut. Hledaný počet sekund odpovídá $25+15=40$ minutám, tj. $40\\cdot 60=2\\,400$ sekund.'},
  '$2\\,400$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 5.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$\\square$ milimetrů $+\\;1$ metr $=\\frac{1}{5}$ metru $+\\;96$ centimetrů'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{5}$ metru $=20$ cm, pravá strana je $20+96=116$ cm $=1\\,160$ mm. Protože $1$ metr $=1\\,000$ mm, doplníme $1\\,160-1\\,000=160$ milimetrů.'},
  '$160$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 6',
  new List<String>{'Tyč je rozdělena na 10 stejných úseků. Na tyči jsou vyznačeny dvě značky. První je 39 cm od levého okraje tyče a druhá je označena písmenem A (viz obrázek).','6.1 Jak dlouhá je tyč?','6.2 V jaké vzdálenosti od pravého okraje tyče je značka A?'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif"><rect x="40" y="66" width="480" height="34" fill="#c9c9c9" stroke="#000"/><line x1="88" y1="66" x2="88" y2="100" stroke="#000"/><line x1="136" y1="66" x2="136" y2="100" stroke="#000"/><line x1="184" y1="66" x2="184" y2="100" stroke="#000"/><line x1="232" y1="66" x2="232" y2="100" stroke="#000"/><line x1="280" y1="66" x2="280" y2="100" stroke="#000"/><line x1="328" y1="66" x2="328" y2="100" stroke="#000"/><line x1="376" y1="66" x2="376" y2="100" stroke="#000"/><line x1="424" y1="66" x2="424" y2="100" stroke="#000"/><line x1="472" y1="66" x2="472" y2="100" stroke="#000"/><line x1="184" y1="54" x2="184" y2="112" stroke="#000" stroke-width="2"/><text x="184" y="48" font-size="14" text-anchor="middle">1.</text><text x="184" y="128" font-size="14" text-anchor="middle">39 cm</text><line x1="328" y1="54" x2="328" y2="112" stroke="#000" stroke-width="2"/><text x="328" y="48" font-size="14" text-anchor="middle">2.</text><text x="328" y="128" font-size="14" text-anchor="middle">A</text></svg>',
  'tyc.svg',
  'Tyč rozdělená na 10 stejných dílků; první značka je u 3. dílku (39 cm), druhá značka A je u 6. dílku.',
  'Tyč se dvěma značkami',
  new List<String>{'První značka je u 3. dílku, tedy $3$ dílky $=39$ cm a jeden dílek $=13$ cm.','6.1 Tyč má $10$ dílků: $10\\cdot 13=130$ cm.','6.2 Značka A je u 6. dílku, od pravého okraje zbývají $4$ dílky: $4\\cdot 13=52$ cm.'},
  '6.1: $130$ cm; 6.2: $52$ cm',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
