String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M5D 2025 - uloha 4',
  new List<String>{'Vedomostni souteze, ktera mela dve kola, se zucastnil deseticlenny tym. V kazdem kole ziskali jednotlivi soutezici $8$, $9$, nebo $10$ bodu. Nektere udaje jsou v tabulce (v 1. kole ziskalo $9$ bodu $5$ soutezicich; soucet bodu celeho tymu ve 2. kole je $95$).','4.1 V 1. kole bylo soutezicich, kteri ziskali $8$ bodu, o jednoho mene nez tech, kteri ziskali $10$ bodu. Urcete soucet bodu celeho tymu v 1. kole.','4.2 Urcete, kolik soutezicich mohlo ve 2. kole ziskat $9$ bodu. Najdete vsechna reseni.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif" font-size="12"> <rect x="10" y="10" width="500" height="130" fill="none" stroke="#000"/> <line x1="110" y1="10" x2="110" y2="140" stroke="#000"/> <line x1="350" y1="10" x2="350" y2="140" stroke="#000"/> <line x1="190" y1="45" x2="190" y2="140" stroke="#000"/> <line x1="270" y1="45" x2="270" y2="140" stroke="#000"/> <line x1="110" y1="45" x2="350" y2="45" stroke="#000"/> <line x1="10" y1="70" x2="510" y2="70" stroke="#000"/> <line x1="10" y1="105" x2="510" y2="105" stroke="#000"/> <text x="230" y="32" font-size="11" text-anchor="middle">Pocet soutezicich, kteri ziskali</text> <text x="430" y="34" text-anchor="middle">Soucet bodu</text> <text x="430" y="52" text-anchor="middle">celeho tymu</text> <text x="150" y="62" text-anchor="middle">8 bodu</text> <text x="230" y="62" text-anchor="middle">9 bodu</text> <text x="310" y="62" text-anchor="middle">10 bodu</text> <text x="20" y="92">1. kolo</text> <text x="230" y="92" text-anchor="middle">5</text> <text x="20" y="127">2. kolo</text> <text x="430" y="127" text-anchor="middle">95</text> </svg>',
  'tabulka-souteze.svg',
  'Tabulka poctu soutezicich se ziskem 8, 9 a 10 bodu ve dvou kolech; v 1. kole 9 bodu ziskalo 5 soutezicich, soucet ve 2. kole je 95.',
  'Vychozi tabulka k uloze 4',
  new List<String>{'4.1 V 1. kole $9$ bodu ziskalo $5$ soutezicich, zbyva $5$ soutezicich se ziskem $8$ nebo $10$ bodu. Oznacime pocet desitkovych $c$ a osmickovych $c-1$: $(c-1)+c=5$, tedy $c=3$ a osmicek $2$. Soucet $=2\\cdot 8+5\\cdot 9+3\\cdot 10=16+45+30=91$ bodu.','4.2 Ve 2. kole plati $x+y+z=10$ a $8x+9y+10z=95$, kde $y$ je pocet devitkovych. Odtud $y+2z=15$ a $x=z-5$, takze $z\\in\\{5,6,7\\}$ a $y\\in\\{5,3,1\\}$. Devitkovych mohlo byt $1$, $3$, nebo $5$ soutezicich.'},
  '4.1: $91$ bodu; 4.2: $1$ soutezici, $3$ soutezici, nebo $5$ soutezicich',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2025 - uloha 5',
  new List<String>{'Na odvoz beden ze skladu se pouzivaji dva ruzni roboti $A$, $B$. Ve skladu bylo $140$ beden. Bedny nejprve odvazel robot $A$, a to po $5$ kusech; jezdil v pravidelnych intervalech a odvezl ze skladu za $2$ hodiny celkem $50$ beden. Pak pokracoval robot $B$, ktery vozil bedny jen po $3$ kusech, avsak v kratsich pravidelnych intervalech; odvezl tak ze skladu za $3$ hodiny zbyvajicich $90$ beden.','5.1 Vypoctete, o kolik kusu se lisi pocet beden odvezenych ze skladu za $1$ hodinu robotem $A$ a pocet beden odvezenych za $1$ hodinu robotem $B$.','5.2 Vypoctete, kolikrat mene jizd vykona za $1$ hodinu robot $A$ nez robot $B$.','5.3 Vypoctete, kolik beden by ze skladu odvezli za $36$ minut oba roboti dohromady pri spolecnem provozu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Robot $A$: $50$ beden za $2$ h, tj. $25$ beden/h a $25:5=5$ jizd/h. Robot $B$: $90$ beden za $3$ h, tj. $30$ beden/h a $30:3=10$ jizd/h.','5.1 Rozdil beden za hodinu: $30-25=5$ kusu.','5.2 Jizd za hodinu: $A$ pet, $B$ deset, tedy $A$ jezdi $2$krat mene.','5.3 Dohromady $25+30=55$ beden/h; za $36$ min $=\\frac{36}{60}$ h odvezou $55\\cdot\\frac{36}{60}=33$ beden.'},
  '5.1: o $5$ kusu; 5.2: $2$krat; 5.3: $33$ beden',
  6, 8, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
