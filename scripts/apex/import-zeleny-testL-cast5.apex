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
  'Zelený L13 – kruhová výseč a obdélník',
  new List<String>{'Na obrázku je záhon tvaru kruhové výseče a záhon tvaru obdélníku. Obsahy ploch obou záhonů jsou stejné. Počítejte s $\\pi=3{,}14$.','Jaké jsou rozměry obdélníkového záhonu, víme-li, že jedna strana je dlouhá $6{,}28$ metru?'},
  new List<String>{'A) $3$ metry','B) $5$ metrů','C) $6$ metrů','D) $8$ metrů','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif"> <polygon points="170,180 59.1,134.1 50,180 59.1,225.9 85.1,264.9 124.1,290.9 170,300 215.9,290.9 254.9,264.9 280.9,225.9 290,180 280.9,134.1" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/> <line x1="170" y1="180" x2="59.1" y2="134.1" stroke="#000" stroke-width="2.5"/> <line x1="170" y1="180" x2="280.9" y2="134.1" stroke="#000" stroke-width="2.5"/> <text x="170" y="162" font-size="15" text-anchor="middle">135°</text> <line x1="50" y1="325" x2="290" y2="325" stroke="#444" stroke-width="1"/> <text x="170" y="345" font-size="14" text-anchor="middle">8 m</text> <text x="322" y="196" font-size="26" text-anchor="middle">=</text> <rect x="375" y="90" width="110" height="170" fill="#d9d9d9" stroke="#000" stroke-width="2.5"/> <text x="500" y="180" font-size="14" transform="rotate(-90 500 180)" text-anchor="middle">6,28 m</text> <text x="430" y="285" font-size="15" text-anchor="middle" font-style="italic">x</text> </svg>',
  'zahon.svg',
  'Kruhová výseč o velikosti 225 stupňů (s výřezem 135 stupňů) a průměru 8 m má stejný obsah jako obdélník se stranou 6,28 m a neznámou stranou x.',
  'Kruhová výseč a obdélník stejného obsahu (schematický nákres)',
  new List<String>{'Výseč má velikost $360^\\circ-135^\\circ=225^\\circ$ a poloměr $4$ m (průměr $8$ m). Obsah $=\\frac{225}{360}\\cdot\\pi\\cdot 4^2=0{,}625\\cdot 3{,}14\\cdot 16=31{,}4$ m². Pro obdélník platí $6{,}28\\cdot x=31{,}4$, tedy $x=5$ m.'},
  'B) $5$ metrů',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L14 – rychlost špičky vrtule',
  new List<String>{'Na obrázku je rotor (vrtule) větrné elektrárny. Průměr rotoru je $50$ metrů, délka vrtule tedy $25$ metrů.','Jakou rychlostí se pohybuje špička vrtule, jestliže se rotor otáčí rychlostí $30$ otáček za minutu? Výsledek uveďte v m/s. Počítejte s $\\pi=3{,}14$.'},
  new List<String>{'A) $39{,}3$ m/s','B) $78{,}5$ m/s','C) $157{,}0$ m/s','D) $314{,}0$ m/s','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 380" font-family="sans-serif"> <line x1="200" y1="200" x2="200" y2="60" stroke="#333" stroke-width="6"/> <line x1="200" y1="200" x2="330" y2="275" stroke="#333" stroke-width="6"/> <line x1="200" y1="200" x2="70" y2="275" stroke="#333" stroke-width="6"/> <circle cx="200" cy="200" r="10" fill="#fff" stroke="#000" stroke-width="2"/> <line x1="200" y1="130" x2="330" y2="130" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="200" y1="120" x2="200" y2="140" stroke="#000" stroke-width="1"/> <line x1="330" y1="120" x2="330" y2="140" stroke="#000" stroke-width="1"/> <text x="265" y="122" font-size="15" text-anchor="middle">25 m</text> </svg>',
  'rotor.svg',
  'Rotor větrné elektrárny se třemi listy; délka jednoho listu (poloměr) je 25 m.',
  'Rotor větrné elektrárny (schematický nákres)',
  new List<String>{'Špička opíše kružnici o obvodu $o=2\\pi r=2\\cdot 3{,}14\\cdot 25=157$ m. Za minutu ($60$ s) urazí $30$ obvodů, tj. $30\\cdot 157=4\\,710$ m. Rychlost $=\\frac{4\\,710}{60}=78{,}5$ m/s.'},
  'B) $78{,}5$ m/s',
  2, 4, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
