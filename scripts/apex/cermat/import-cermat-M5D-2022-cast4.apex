String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M5D 2022 – úloha 5',
  new List<String>{'Z nádvoří se chodí nahoru na ochoz věže po $120$ stejných vyšších schodech, zpět na nádvoří se chodí dolů jiným schodištěm po $180$ stejných nižších schodech. Obě schodiště jsou ve dvou místech propojena odpočívadly.','Mezi 1. odpočívadlem a ochozem je třikrát více vyšších schodů než mezi nádvořím a 1. odpočívadlem. (Totéž platí o nižších schodech.) Z nádvoří na 2. odpočívadlo vede směrem nahoru $96$ vyšších schodů.','Vypočtěte,','5.1 kolik vyšších schodů vede směrem nahoru z nádvoří na 1. odpočívadlo,','5.2 kolik nižších schodů vede směrem dolů z ochozu na 1. odpočívadlo,','5.3 kolik nižších schodů vede směrem dolů z 2. odpočívadla na nádvoří.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 445 300" font-family="sans-serif"> <line x1="150" y1="40" x2="300" y2="40" stroke="#000" stroke-width="2"/> <line x1="150" y1="86" x2="300" y2="86" stroke="#000" stroke-width="2"/> <line x1="150" y1="212" x2="300" y2="212" stroke="#000" stroke-width="2"/> <line x1="150" y1="270" x2="300" y2="270" stroke="#000" stroke-width="2"/> <text x="144" y="44" font-size="12" text-anchor="end">ochoz</text> <text x="144" y="90" font-size="12" text-anchor="end">2. odpočívadlo</text> <text x="144" y="216" font-size="12" text-anchor="end">1. odpočívadlo</text> <text x="144" y="274" font-size="12" text-anchor="end">nádvoří</text> <line x1="200" y1="270" x2="200" y2="40" stroke="#888" stroke-width="1" stroke-dasharray="3 3"/> <line x1="250" y1="40" x2="250" y2="270" stroke="#888" stroke-width="1" stroke-dasharray="3 3"/> <text x="200" y="30" font-size="11" text-anchor="middle">vyšší</text> <text x="250" y="30" font-size="11" text-anchor="middle">nižší</text> <line x1="345" y1="270" x2="345" y2="212" stroke="#000" stroke-width="1.5"/> <polygon points="345,212 341,220 349,220" fill="#000"/> <text x="352" y="245" font-size="12">5.1</text> <line x1="382" y1="40" x2="382" y2="212" stroke="#000" stroke-width="1.5"/> <polygon points="382,212 378,204 386,204" fill="#000"/> <text x="389" y="128" font-size="12">5.2</text> <line x1="418" y1="86" x2="418" y2="270" stroke="#000" stroke-width="1.5"/> <polygon points="418,270 414,262 422,262" fill="#000"/> <text x="425" y="182" font-size="12">5.3</text> </svg>',
  'schodiste.svg',
  'Schéma věže se čtyřmi úrovněmi (nádvoří, 1. odpočívadlo, 2. odpočívadlo, ochoz) a dvěma schodišti (vyšší a nižší) s vyznačenými úseky 5.1, 5.2 a 5.3.',
  'Schéma schodišť s odpočívadly',
  new List<String>{'5.1 Vyšších schodů z nádvoří na 1. odpočívadlo je $x$, na úsek k ochozu $3x$; dohromady $x + 3x = 120$, tedy $x = 30$.','5.2 U nižších schodů platí stejný poměr: z nádvoří na 1. odpočívadlo $y$, dále $3y$, celkem $4y = 180$, tedy $y = 45$. Z ochozu dolů na 1. odpočívadlo je $180 - 45 = 135$ nižších schodů.','5.3 2. odpočívadlo je ve výšce $96$ vyšších schodů, tj. $\\frac{96}{120} = \\frac{4}{5}$ celkové výšky. Nižších schodů z 2. odpočívadla na nádvoří je $\\frac{4}{5} \\cdot 180 = 144$.'},
  '5.1: $30$ vyšších schodů; 5.2: $135$ nižších schodů; 5.3: $144$ nižších schodů',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2022 – úloha 6',
  new List<String>{'Stejné zahradní dlaždice se skládají na stejné dřevěné palety. Plná paleta obsahuje $10$ kusů dlaždic. Dvě plné palety s dlaždicemi váží dohromady $340$ kg. Jedna paleta se $4$ dlaždicemi váží $80$ kg.','Vypočtěte, kolik kg váží','6.1 jedna dlaždice,','6.2 jedna prázdná paleta.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Jedna plná paleta (10 dlaždic) váží $340 : 2 = 170$ kg. Rozdíl oproti paletě se 4 dlaždicemi je $170 - 80 = 90$ kg a připadá na $10 - 4 = 6$ dlaždic, takže jedna dlaždice váží $90 : 6 = 15$ kg.','6.2 Prázdná paleta váží $80 - 4 \\cdot 15 = 80 - 60 = 20$ kg.'},
  '6.1: $15$ kg; 6.2: $20$ kg',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
