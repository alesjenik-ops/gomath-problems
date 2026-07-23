String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M5D 2026 – úloha 9',
  new List<String>{'Lucka si myslela kladné číslo menší než $100$ a chlapci se ho snažili uhodnout. Jakub hádal číslo $15$, Lukáš číslo $87$ a oba svá čísla vyznačili na číselné ose. Lucka pak řekla: „Kdyby jeden z vás přičetl ke svému číslu $5$, druhý od svého čísla odečetl $3$ a oba výsledky jste pak sečetli, dostanete dvojnásobek mého čísla." Zvítězil chlapec, jehož číslo bylo na číselné ose blíže Lucčinu číslu.','O kolik se vítězovo číslo lišilo od Lucčina čísla?'},
  new List<String>{'A) o $35$','B) o $34$','C) o $33$','D) o $32$','E) o $31$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Součet $(15+5)+(87-3)=20+84=104$ (stejně vyjde i při opačném přiřazení) je dvojnásobek Lucčina čísla, tedy Lucčino číslo je $52$. Vzdálenosti: $|52-15|=37$, $|87-52|=35$; blíže je Lukáš s číslem $87$. Vítězovo číslo se od Lucčina liší o $35$.'},
  'A) o $35$',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 10',
  new List<String>{'Pozemek má tvar obdélníku, jehož jedna strana je o třetinu delší než sousední strana. Bára obešla celý pozemek po jeho obvodu stejně dlouhými kroky, přitom delší stranu pozemku přešla $120$ kroky.','Kolika kroky obešla Bára celý pozemek po jeho obvodu?'},
  new List<String>{'A) $300$ kroky','B) $320$ kroky','C) $360$ kroky','D) $400$ kroky','E) $420$ kroky'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Delší strana $=120$ kroků je o třetinu delší než kratší, takže kratší $=120\\cdot\\frac{3}{4}=90$ kroků. Obvod $=2\\cdot(120+90)=420$ kroků.'},
  'E) $420$ kroky',
  2, 3, '2',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2026 – úloha 11',
  new List<String>{'Ze stejných krychliček, které mají na každé své stěně po jedné tečce, jsme slepili $5$ různých těles (viz obrázek). Každé těleso obsahuje $6$ těchto krychliček. Každé slepené těleso jsme si prohlédli ze všech stran (i zespodu) a spočítali počet všech teček na jeho povrchu.','Které těleso má na svém povrchu nejvíce teček?'},
  new List<String>{'A) těleso A','B) těleso B','C) těleso C','D) těleso D','E) těleso E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif"> <text x="280" y="45" font-size="13" text-anchor="middle">Pět těles A–E, každé ze 6 krychliček s jednou tečkou na každé stěně (viz testový sešit).</text> <text x="280" y="75" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa nelze věrně přenést do SVG; posuzuje se podle originálu.</text> </svg>',
  'krychlicky-tecky.svg',
  'Pět prostorových těles A–E slepených ze šesti krychliček s tečkami (schematická poznámka).',
  'Prostorová tělesa – viz testový sešit',
  new List<String>{'Každá krychlička má na povrchu $6$ teček. Slepením dvou stěn zmizí $2$ tečky, proto má na povrchu nejvíce teček to těleso, které má nejmenší počet slepených stěn (nejméně dotyků krychliček). Podle klíče je to těleso D.'},
  'D) těleso D',
  2, 3, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 12',
  new List<String>{'Filip se učil házet oštěpem. Délka jeho prvního hodu byla $700$ cm. Jeho druhý hod byl o desetinu delší než první a třetí hod byl o desetinu kratší než druhý.','Jak se lišily délky třetího a prvního Filipova hodu? Třetí hod byl…'},
  new List<String>{'A) o $77$ cm kratší než první.','B) o $7$ cm kratší než první.','C) stejně dlouhý jako první.','D) o $7$ cm delší než první.','E) o $63$ cm delší než první.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Druhý hod $700\\cdot 1{,}1=770$ cm, třetí hod $770\\cdot 0{,}9=693$ cm. Třetí byl o $700-693=7$ cm kratší než první.'},
  'B) o $7$ cm kratší než první.',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
