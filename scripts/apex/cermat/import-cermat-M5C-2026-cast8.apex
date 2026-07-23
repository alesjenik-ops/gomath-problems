String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
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
  'CERMAT M5C 2026 – úloha 10',
  new List<String>{'V tiskárně stojí vytisknutí 100 stránek 252 korun (cena za tisk každé stránky je stejná). Pro společný projekt si žáci nechali vytisknout celkem 150 stránek. Na projektu se podílelo 6 žáků a na zaplacení tisku se složili rovným dílem.','Kolika korunami přispěl na tisk jeden žák?'},
  new List<String>{'A) 42 korunami','B) 63 korunami','C) 67 korunami','D) 84 korunami','E) jiným počtem korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Cena za $1$ stránku: $252:100 = 2{,}52$ Kč. Za $150$ stránek: $150\\cdot 2{,}52 = 378$ Kč. Na $6$ žáků rovným dílem: $378:6 = 63$ Kč.'},
  'B) 63 korunami',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5C 2026 – úloha 11',
  new List<String>{'Matěj postavil stavbu ze stejně velkých krychliček (viz obrázek). Stavba má čtyři patra a v každém patře jsou krychličky naskládány v 5 řadách. V každém vyšším patře má kterákoli řada vždy o 2 krychličky méně než řada pod ní.','Kolik krychliček celkem obsahuje Matějova stavba?'},
  new List<String>{'A) 124 krychliček','B) 120 krychliček','C) 116 krychliček','D) 108 krychliček','E) méně než 108 krychliček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 120" font-family="sans-serif"> <text x="280" y="55" font-size="13" text-anchor="middle">Stavba ze stejných krychliček – 4 patra po 5 řadách (viz testový sešit).</text> <text x="280" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle originálu.</text> </svg>',
  'stavba.svg',
  'Prostorová stavba ze stejných krychliček o čtyřech patrech (schematická poznámka).',
  'Prostorová stavba – viz testový sešit',
  new List<String>{'V 1. patře je $42$ krychliček. V každém vyšším patře má každá z 5 řad o 2 krychličky méně, tedy celé patro o $10$ krychliček méně: $42$, $32$, $22$, $12$.','Celkem $42+32+22+12 = 108$ krychliček.'},
  'D) 108 krychliček',
  2, 4, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 12',
  new List<String>{'Alena vytvořila ze stejných sirek trojúhelníky a čtverce. Na každý trojúhelník použila 3 sirky a na každý čtverec 4 sirky, přitom žádná sirka nebyla společná pro dva útvary. Na všechny útvary použila celkem 90 sirek. Čtverců Alena vytvořila o dva méně než trojúhelníků.','Kolik útvarů (trojúhelníků a čtverců) Alena celkem vytvořila?'},
  new List<String>{'A) 24 útvarů','B) 25 útvarů','C) 26 útvarů','D) 28 útvarů','E) jiný počet útvarů'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet trojúhelníků $t$ a čtverců $s = t-2$. Sirek je $3t+4s = 90$, tedy $3t+4(t-2) = 90$, $7t = 98$, $t = 14$ a $s = 12$.','Celkem $14+12 = 26$ útvarů.'},
  'C) 26 útvarů',
  2, 4, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 13',
  new List<String>{'Sourozenci Jitka, Klára a Max dostali od babičky po 40 čokoládových mincích. Jitka snědla jen 8 svých mincí. Klára snědla už 16 svých mincí. Max má ještě všech 40 mincí.','Přiřaďte ke každé nedokončené větě (13.1–13.3) chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.','13.1 Jitka má…','13.2 Klára má…','13.3 Max má…'},
  new List<String>{'A) dvakrát více mincí, než má jeden ze zbývajících sourozenců.','B) o čtvrtinu více mincí, než má jeden ze zbývajících sourozenců.','C) méně mincí, než snědli všichni tři sourozenci dohromady.','D) o třetinu méně mincí, než snědl jeden ze zbývajících sourozenců.','E) třikrát více mincí, než snědli dohromady oba zbývající sourozenci.','F) o polovinu méně mincí, než mají zbývající dva sourozenci dohromady.'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jitka má $40-8 = 32$ mincí, Klára $40-16 = 24$ mincí, Max $40$ mincí.','13.1 Klára a Max mají dohromady $24+40 = 64$; polovina je $32$, tj. Jitka má o polovinu méně → F.','13.2 Jitka a Max snědli dohromady $8+0 = 8$; trojnásobek je $24$ = počet Klářiných mincí → E.','13.3 Jitka má $32$ mincí; o čtvrtinu více je $32+8 = 40$ = počet Maxových mincí → B.'},
  '13.1: F; 13.2: E; 13.3: B',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
