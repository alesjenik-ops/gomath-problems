String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD26C0T02';
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
  'CERMAT M5B 2026 – úloha 1.1',
  new List<String>{'Vypočtěte: $(2\\cdot 2\\,000 + 50\\cdot 50):10 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2\\cdot 2\\,000 + 50\\cdot 50):10 = (4\\,000+2\\,500):10 = 6\\,500:10 = 650$.'},
  '$650$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2026 – úloha 1.2',
  new List<String>{'Vypočtěte: $2\\,010:(3\\cdot 15 - 45:3) - 28:7 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\,010:(3\\cdot 15 - 45:3) - 28:7 = 2\\,010:(45-15) - 4 = 2\\,010:30 - 4 = 67 - 4 = 63$.'},
  '$63$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2026 – úloha 2',
  new List<String>{'Vypočtěte:','2.1 kolikrát je jeden metr kratší než jedna desetina kilometru,','2.2 o kolik gramů je půlkilogramové závaží těžší než 50gramové závaží,','2.3 kolik nejvíce celých 25minutových dílů seriálu (přehrávaných původní rychlostí) lze zhlédnout za 3 hodiny.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 Jedna desetina kilometru je $100$ m, jeden metr je tedy $100:1 = 100$krát kratší.','2.2 $500\\text{ g} - 50\\text{ g} = 450$ g.','2.3 $3$ hodiny $= 180$ minut, $180:25 = 7$ celých dílů (a zbývá $5$ minut).'},
  '2.1: 100krát; 2.2: o $450$ gramů; 2.3: $7$ dílů seriálu',
  5, 5, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2026 – úloha 3',
  new List<String>{'Každému z celých čísel od 0 do 9 přiřadíme jiný symbol a některé z těchto symbolů umístíme do tabulky. V šedých polích tabulky je zapsán součet odpovídajících čísel v příslušném sloupci nebo řádku, dva součty chybí.','Určete chybějící součet:','3.1 v 1. sloupci dole,','3.2 ve 3. řádku vpravo.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 210" font-family="sans-serif"><rect x="10" y="10" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="56" y="10" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="102" y="10" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="10" y="56" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="56" y="56" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="102" y="56" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="10" y="102" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="56" y="102" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="102" y="102" width="46" height="46" fill="#ffffff" stroke="#000"/><rect x="148" y="10" width="46" height="46" fill="#e2e2e2" stroke="#000"/><rect x="148" y="56" width="46" height="46" fill="#e2e2e2" stroke="#000"/><rect x="148" y="102" width="46" height="46" fill="#e2e2e2" stroke="#000"/><rect x="10" y="148" width="46" height="46" fill="#e2e2e2" stroke="#000"/><rect x="56" y="148" width="46" height="46" fill="#e2e2e2" stroke="#000"/><rect x="102" y="148" width="46" height="46" fill="#e2e2e2" stroke="#000"/><text x="33.0" y="40.0" font-size="20" text-anchor="middle">♥</text><text x="79.0" y="40.0" font-size="20" text-anchor="middle">♣</text><circle cx="125.0" cy="33.0" r="9" fill="#000"/><circle cx="33.0" cy="79.0" r="9" fill="#000"/><rect x="71.0" y="71.0" width="16" height="16" fill="#000"/><rect x="117.0" y="71.0" width="16" height="16" fill="#000"/><circle cx="33.0" cy="125.0" r="9" fill="#000"/><text x="79.0" y="132.0" font-size="20" text-anchor="middle">♣</text><text x="125.0" y="132.0" font-size="20" text-anchor="middle">♣</text><text x="171.0" y="40.0" font-size="20" text-anchor="middle">4</text><text x="171.0" y="86.0" font-size="20" text-anchor="middle">5</text><text x="171.0" y="132.0" font-size="20" text-anchor="middle">?</text><text x="33.0" y="178.0" font-size="20" text-anchor="middle">?</text><text x="79.0" y="178.0" font-size="20" text-anchor="middle">8</text><text x="125.0" y="178.0" font-size="20" text-anchor="middle">6</text></svg>',
  'tabulka-symboly.svg',
  'Tabulka 3 krát 3 se symboly srdce, kříž, kolečko, čtvereček; vpravo součty řádků 4 a 5, dole součty sloupců 8 a 6, dva součty chybí.',
  'Schematický nákres tabulky se symboly a součty',
  new List<String>{'Ze známých součtů plyne hodnota symbolů: kolečko $=1$, kříž $=3$, čtvereček $=2$, srdce $=0$.','3.1 Součet v 1. sloupci dole: $0+1+1 = 2$.','3.2 Součet ve 3. řádku vpravo: $1+3+3 = 7$.'},
  '3.1: $2$; 3.2: $7$',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
