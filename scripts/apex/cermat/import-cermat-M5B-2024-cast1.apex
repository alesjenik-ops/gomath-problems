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
  'CERMAT M5B 2024 – úloha 1.1',
  new List<String>{'Vypočítejte: $25+3\\cdot(75-2\\cdot 25)-(25-5)\\cdot 2-25=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$75-2\\cdot 25=25$, $3\\cdot 25=75$, $(25-5)\\cdot 2=40$. Celkem $25+75-40-25=35$.'},
  '$35$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 1.2',
  new List<String>{'Vypočítejte: $6\\cdot 7+(50+50:5):(28:7)+3\\cdot 8=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$50:5=10$, $50+10=60$, $28:7=4$, $60:4=15$. Dále $6\\cdot 7=42$, $3\\cdot 8=24$. Celkem $42+15+24=81$.'},
  '$81$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 2',
  new List<String>{'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby písemné odčítání bylo správné. Všechny hvězdičky nahradíte stejnou číslicí. Do záznamového archu uveďte pouze chybějící číslici.','$\\ast\\,4\\,5\\,\\ast \\;-\\; 1\\,\\ast\\,\\ast\\,4 \\;=\\; 2\\,119$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hvězdičky nahradíme číslicí $3$: $3453-1334=2119$. Chybějící číslice je $3$.'},
  '$3$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 3',
  new List<String>{'Provedeme-li postupně všechny početní operace uvedené nad šipkami, výsledné číslo bude 12 (viz obrázek).','Vypočítejte neznámé číslo $x$ z prvního rámečku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 130" font-family="sans-serif"><rect x="18" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="49" y="85" font-size="16" text-anchor="middle" font-style="italic">x</text><line x1="80" y1="79" x2="124" y2="79" stroke="#000"/><polygon points="124,79 115,74 115,84" fill="#000"/><text x="102" y="48" font-size="14" text-anchor="middle">+2</text><rect x="124" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="155" y="85" font-size="16" text-anchor="middle"></text><line x1="186" y1="79" x2="230" y2="79" stroke="#000"/><polygon points="230,79 221,74 221,84" fill="#000"/><text x="208" y="48" font-size="14" text-anchor="middle">·3</text><rect x="230" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="261" y="85" font-size="16" text-anchor="middle"></text><line x1="292" y1="79" x2="336" y2="79" stroke="#000"/><polygon points="336,79 327,74 327,84" fill="#000"/><text x="314" y="48" font-size="14" text-anchor="middle">−6</text><rect x="336" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="367" y="85" font-size="16" text-anchor="middle"></text><line x1="398" y1="79" x2="442" y2="79" stroke="#000"/><polygon points="442,79 433,74 433,84" fill="#000"/><text x="420" y="48" font-size="14" text-anchor="middle">:3</text><rect x="442" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="473" y="85" font-size="16" text-anchor="middle"></text><line x1="504" y1="79" x2="548" y2="79" stroke="#000"/><polygon points="548,79 539,74 539,84" fill="#000"/><text x="526" y="48" font-size="14" text-anchor="middle">·6</text><rect x="548" y="56" width="62" height="46" fill="none" stroke="#000"/><text x="579" y="85" font-size="16" text-anchor="middle">12</text></svg>',
  'sipky.svg',
  'Řetězec rámečků a šipek: x, potom +2, krát 3, minus 6, děleno 3, krát 6, výsledek 12.',
  'Schéma postupných operací',
  new List<String>{'Postupujeme od výsledku zpět: $12:6=2$, $2\\cdot 3=6$, $6+6=12$, $12:3=4$, $4-2=2$. Tedy $x=2$. Kontrola: $2+2=4$, $4\\cdot 3=12$, $12-6=6$, $6:3=2$, $2\\cdot 6=12$.'},
  '$x=2$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2024 – úloha 4.1',
  new List<String>{'Ve škole, kde je celkem 750 žáků, koupila paní učitelka každému svému žákovi v 5. B stejné tričko. Pokud počet těchto triček vynásobíme 5, dostaneme stejné číslo, jako když počet všech žáků školy vydělíme 6.','Kolik žáků je v 5. B?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Počet triček je roven počtu žáků v 5. B. Platí $5\\cdot(\\text{počet žáků 5. B})=750:6=125$, tedy počet žáků $=125:5=25$.'},
  '$25$ žáků',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
