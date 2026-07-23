String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD24C0T01';
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
  'CERMAT M7A 2024 – úloha 4',
  new List<String>{'Na obrázku je částečně vyplněný tzv. magický čtverec, pro který platí: součet všech tří zlomků je stejný v každém řádku, sloupci i v každé úhlopříčce a rovná se $1$.','Jaký zlomek se nachází v šedém poli?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 226 226" font-family="sans-serif"><rect x="142" y="84" width="58" height="58" fill="#b9b9b9"/><line x1="26" y1="26" x2="26" y2="200" stroke="#000" stroke-width="2"/><line x1="26" y1="26" x2="200" y2="26" stroke="#000" stroke-width="2"/><line x1="84" y1="26" x2="84" y2="200" stroke="#000" stroke-width="2"/><line x1="26" y1="84" x2="200" y2="84" stroke="#000" stroke-width="2"/><line x1="142" y1="26" x2="142" y2="200" stroke="#000" stroke-width="2"/><line x1="26" y1="142" x2="200" y2="142" stroke="#000" stroke-width="2"/><line x1="200" y1="26" x2="200" y2="200" stroke="#000" stroke-width="2"/><line x1="26" y1="200" x2="200" y2="200" stroke="#000" stroke-width="2"/><text x="113.0" y="51.0" font-size="17" text-anchor="middle">1</text><line x1="99.0" y1="55.0" x2="127.0" y2="55.0" stroke="#000" stroke-width="1.5"/><text x="113.0" y="72.0" font-size="17" text-anchor="middle">15</text><text x="171.0" y="51.0" font-size="17" text-anchor="middle">2</text><line x1="157.0" y1="55.0" x2="185.0" y2="55.0" stroke="#000" stroke-width="1.5"/><text x="171.0" y="72.0" font-size="17" text-anchor="middle">5</text><text x="113.0" y="109.0" font-size="17" text-anchor="middle">1</text><line x1="99.0" y1="113.0" x2="127.0" y2="113.0" stroke="#000" stroke-width="1.5"/><text x="113.0" y="130.0" font-size="17" text-anchor="middle">3</text><text x="171.0" y="120.0" font-size="24" text-anchor="middle">?</text></svg>',
  'magicky-ctverec.svg',
  'Magicky ctverec 3x3; vyplneno 1/15 a 2/5 v hornim radku, 1/3 uprostred; sede pole vpravo uprostred.',
  'Částečně vyplněný magický čtverec',
  new List<String>{'Levý horní roh (řádek 1): $y+\\frac{1}{15}+\\frac{2}{5}=1\\Rightarrow y=\\frac{8}{15}$. Z úhlopříčky $\\frac{8}{15}+\\frac{1}{3}+z=1\\Rightarrow z=\\frac{2}{15}$ (pravý dolní roh). Pravý sloupec: $\\frac{2}{5}+x+\\frac{2}{15}=1\\Rightarrow x=1-\\frac{8}{15}=\\frac{7}{15}$.'},
  '$\\frac{7}{15}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2024 – úloha 5',
  new List<String>{'V kruhovém diagramu je vyznačeno, kolik dětí z jedné základní školy navštěvuje jednotlivé kroužky a kolik dětí této školy nechodí do žádného kroužku. Víme, že na florbal chodí $114$ dětí a každé dítě navštěvuje nejvýše jeden kroužek.','5.1 Kolik dětí navštěvuje nějaký kroužek?','5.2 Kolik dětí chodí na basketbal?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 360" font-family="sans-serif"><path d="M 210 175 L 210.0 55.0 A 120 120 0 0 1 254.2 63.4 Z" fill="#eeeeee" stroke="#000" stroke-width="1.5"/><text x="223.9" y="96.9" font-size="12" text-anchor="middle">zadny</text><text x="223.9" y="112.9" font-size="12" text-anchor="middle">6 %</text><path d="M 210 175 L 254.2 63.4 A 120 120 0 0 1 327.9 152.5 Z" fill="#ffffff" stroke="#000" stroke-width="1.5"/><text x="267.3" y="122.6" font-size="12" text-anchor="middle">basketbal</text><text x="267.3" y="138.6" font-size="12" text-anchor="middle">16 %</text><path d="M 210 175 L 327.9 152.5 A 120 120 0 0 1 297.5 257.1 Z" fill="#9a9a9a" stroke="#000" stroke-width="1.5"/><text x="281.4" y="190.8" font-size="12" text-anchor="middle">tanecni</text><text x="281.4" y="206.8" font-size="12" text-anchor="middle">15 %</text><path d="M 210 175 L 297.5 257.1 A 120 120 0 0 1 127.9 262.5 Z" fill="#cccccc" stroke="#000" stroke-width="1.5"/><text x="212.3" y="244.4" font-size="12" text-anchor="middle">lezecka stena</text><text x="212.3" y="260.4" font-size="12" text-anchor="middle">25 %</text><path d="M 210 175 L 127.9 262.5 A 120 120 0 0 1 210.0 55.0 Z" fill="#dddddd" stroke="#000" stroke-width="1.5"/><text x="140.8" y="147.6" font-size="14" text-anchor="middle" font-weight="bold">florbal</text></svg>',
  'kruhovy-diagram.svg',
  'Kruhovy diagram: florbal, zadny 6 %, basketbal 16 %, tanecni 15 %, lezecka stena 25 %.',
  'Kruhový diagram návštěvnosti kroužků',
  new List<String>{'Na florbal připadá $100\\,\\%-(6+16+15+25)\\,\\%=38\\,\\%$, což je $114$ dětí, tedy $1\\,\\%=3$ děti a celkem $300$ dětí.','5.1 Do žádného kroužku nechodí $6\\,\\%$, tj. $18$ dětí; nějaký kroužek navštěvuje $300-18=282$ dětí.','5.2 Basketbal $16\\,\\%$ z $300$ je $48$ dětí.'},
  '5.1: $282$ dětí; 5.2: $48$ dětí',
  4, 5, '2',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
