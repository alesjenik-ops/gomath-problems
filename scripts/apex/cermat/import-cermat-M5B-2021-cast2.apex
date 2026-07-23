String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M5B 2021 – úloha 5',
  new List<String>{'V zelené krabičce jsou jen zelené kuličky, v bílé jen bílé a v modré jen modré. Dohromady je v nich $180$ kuliček. Modrých kuliček je o $10$ více než bílých. Aby byl ve všech třech krabičkách stejný počet kuliček, ze zelené krabičky vyndáme $40$ kuliček a rozdělíme je do zbývajících dvou krabiček.','5.1 Určete počet všech zelených kuliček.','5.2 Určete, kolik zelených kuliček přendáme do bílé krabičky.','5.3 Určete počet všech modrých kuliček.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Stejný počet ve všech třech krabičkách je $180:3=60$. Zelená krabička má po odebrání $40$ kuliček $60$, proto zelených je $60+40=100$.','Bílých $b$, modrých $b+10$; do bílé a modré se rozdělí $40$: $(60-b)+(60-(b+10))=40$, odtud $b=35$, modrých $45$.','5.1 $100$ zelených; 5.2 do bílé přendáme $60-35=25$ zelených; 5.3 modrých je $45$.'},
  '5.1: $100$ zelených kuliček; 5.2: $25$ zelených kuliček; 5.3: $45$ modrých kuliček',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2021 – úloha 6',
  new List<String>{'Každý velký obdélník má rozměry $2$ cm a $7$ cm a obsah $14$ cm². Rozstřižením velkého obdélníku vznikne buď dvojice menších obdélníků (1. dvojice), nebo dvojice shodných trojúhelníků (2. dvojice). Každý z obrazců A, B, C, D je sestaven z jednoho velkého obdélníku a z 1. nebo 2. dvojice (viz obrázek).','6.1 Vypočtěte v cm² obsah obrazce A.','6.2 Vypočtěte v cm obvod obrazce A.','6.3 Vypočtěte v cm obvod obrazce B.','6.4 Vypočtěte, o kolik cm se liší obvody obrazců C a D.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 185" font-family="sans-serif"> <rect x="20" y="30" width="46" height="26" fill="none" stroke="#000"/> <rect x="20" y="56" width="91" height="26" fill="none" stroke="#000"/> <rect x="65" y="82" width="46" height="26" fill="none" stroke="#000"/> <text x="65" y="128" font-size="14" text-anchor="middle">Obrazec A</text> <rect x="150" y="30" width="26" height="91" fill="none" stroke="#000"/> <rect x="104" y="95" width="46" height="26" fill="none" stroke="#000"/> <rect x="176" y="56" width="46" height="26" fill="none" stroke="#000"/> <text x="163" y="140" font-size="14" text-anchor="middle">Obrazec B</text> <polygon points="256,30 300,30 300,110 283,155" fill="none" stroke="#000"/> <line x1="283" y1="30" x2="283" y2="110" stroke="#000"/> <line x1="283" y1="110" x2="300" y2="110" stroke="#000"/> <text x="280" y="172" font-size="14" text-anchor="middle">Obrazec C</text> <polygon points="345,30 430,30 410,112 367,112" fill="none" stroke="#000"/> <line x1="371" y1="30" x2="379" y2="112" stroke="#000"/> <line x1="404" y1="30" x2="398" y2="112" stroke="#000"/> <text x="388" y="132" font-size="14" text-anchor="middle">Obrazec D</text> </svg>',
  'obrazce.svg',
  'Obrazce A, B, C, D sestavené z velkého obdélníku a z dvojice menších obdélníků nebo trojúhelníků.',
  'Obrazce A–D (schematicky)',
  new List<String>{'6.1 Obrazec A tvoří velký obdélník ($14$ cm²) a 1. dvojice, která má také obsah $14$ cm². Obsah $=14+14=28$ cm².','6.2 Obrazec A je schodovitý útvar z obdélníků $2$ cm × $7$ cm a dvou obdélníků $2$ cm × $3{,}5$ cm; jeho obvod je $26$ cm.','6.3 Obrazec B je složen ze stejných obdélníků v jiném uspořádání; jeho obvod je $32$ cm.','6.4 Obrazce C a D jsou sestaveny z velkého obdélníku a 2. dvojice (dvou trojúhelníků); jejich obvody se liší o $10$ cm.'},
  '6.1: $28$ cm²; 6.2: $26$ cm; 6.3: $32$ cm; 6.4: o $10$ cm',
  4, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
