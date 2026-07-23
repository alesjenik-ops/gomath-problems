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
  'CERMAT M5B 2026 – úloha 13',
  new List<String>{'Tomáš postavil krychli z 27 malých krychliček, z nichž některé jsou šedé a ostatní jsou bílé. Krychličky poskládal do krychle tak, že v každém ze tří pater je stejný počet šedých krychliček a žádné dvě šedé krychličky nejsou položeny na sobě. Potom z krychle odstranil zadní vrstvu malých krychliček a vytvořil tak kvádr.','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Kolik bílých krychliček obsahovala krychle?','13.2 Kolik bílých krychliček bylo v odstraněné zadní vrstvě krychle?','13.3 Kolik šedých krychliček zůstalo v kvádru?'},
  new List<String>{'A) 5','B) 6','C) 8','D) 9','E) 12','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 110" font-family="sans-serif"> <text x="280" y="48" font-size="13" text-anchor="middle">Krychle 3x3x3 z 27 krychliček (šedé a bílé); odstraněním zadní vrstvy vznikne kvádr 3x3x2.</text> <text x="280" y="74" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle testového sešitu.</text> </svg>',
  'krychle-3x3.svg',
  'Krychle 3 krát 3 krát 3 ze 27 krychliček (šedé a bílé) a kvádr po odstranění zadní vrstvy (schematická poznámka).',
  'Prostorové těleso – viz testový sešit',
  new List<String>{'V kvádru (3x3x2) zůstalo 9 šedých krychliček (13.3 → D), v zadní vrstvě (3x3) bylo 6 bílých, tj. 3 šedé (13.2 → B). Celkem šedých $9+3 = 12$, tedy 4 v každém ze tří pater. Bílých v celé krychli je $27 - 12 = 15$ (13.1 → F, jiný počet).'},
  '13.1: F (15 bílých); 13.2: B (6 bílých); 13.3: D (9 šedých)',
  5, 6, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2026 – úloha 14',
  new List<String>{'V počítačové hře se vyměňují desky, prkna a tyče pouze podle pravidel: jednu desku lze vyměnit za 4 prkna; libovolnou dvojici prken lze vyměnit za 5 tyčí. Z vyměněných dílů vytváříme ohradu: na 1 kus ohrady potřebujeme 3 prkna a 2 tyče. K dispozici máme pouze desky a postupně je měníme za díly k ohradě.','14.1 Určete, kolik nejméně desek potřebujeme na 3 kusy ohrady.','14.2 Celkem 6 desek použijeme k vytvoření co největšího počtu kusů ohrady. Určete, které nepoužité díly nám zbudou a v jakém počtu.','14.3 Máme k dispozici 19 desek. Určete, kolik nejvíce kusů ohrady můžeme vytvořit.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 140" font-family="sans-serif"> <rect x="20" y="18" width="58" height="34" fill="#d9d9d9" stroke="#000"/><text x="92" y="40" font-size="13">1 deska = 4 prkna</text> <rect x="20" y="62" width="58" height="20" fill="#d9d9d9" stroke="#000"/><text x="92" y="77" font-size="13">2 prkna = 5 tyčí</text> <text x="20" y="115" font-size="13">1 kus ohrady = 3 prkna + 2 tyče</text> </svg>',
  'vymena-dilu.svg',
  'Schéma pravidel: 1 deska za 4 prkna, 2 prkna za 5 tyčí, 1 kus ohrady za 3 prkna a 2 tyče.',
  'Schematický nákres pravidel výměny',
  new List<String>{'14.1 Na 3 kusy potřebujeme $9$ prken a $6$ tyčí. Šest tyčí získáme ze dvou dvojic prken ($4$ prkna → $10$ tyčí). Celkem $9+4 = 13$ prken, tj. $\\lceil 13:4\\rceil = 4$ desky (3 desky dají jen 12 prken).','14.2 Šest desek $= 24$ prken. Nejvíce lze vytvořit 6 kusů: $18$ prken na ohrady a $6$ prken vyměníme za $15$ tyčí (potřeba $12$). Zbudou $3$ tyče.','14.3 Devatenáct desek $= 76$ prken. Lze vytvořit 20 kusů: $60$ prken na ohrady a $16$ prken vyměníme za $40$ tyčí (potřeba $40$).'},
  '14.1: 4 desky; 14.2: zbudou 3 tyče; 14.3: 20 kusů ohrady',
  4, 7, '4',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
