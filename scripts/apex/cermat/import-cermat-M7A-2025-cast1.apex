String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
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
  'CERMAT M7A 2025 - uloha 1',
  new List<String>{'Vecerni ceremonial zacal ve tri ctvrte na sest a starosta ho ukoncil pet minut po pul osme. Presne v polovine ceremonialu zacalo promitani a zabralo petinu celkove doby ceremonialu.','1.1 Urcete v hodinach a minutach presny cas zacatku promitani.','1.2 Vypoctete, kolik minut uplynulo od konce promitani do ukonceni ceremonialu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Ceremonial zacal v 17:45 a skoncil v 19:35, trval tedy 110 minut.','1.1 Polovina doby je 55 minut; promitani zacalo v 17:45 + 55 min = 18:40.','1.2 Promitani trvalo petinu doby, tj. 110 : 5 = 22 minut, a skoncilo v 19:02. Do konce ceremonialu (19:35) zbyvalo 33 minut.'},
  '1.1: 18:40; 1.2: 33 minut',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2025 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $1-1:\\frac{3}{5}+\\frac{5}{3}:10=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$1-\\frac{5}{3}+\\frac{5}{3}\\cdot\\frac{1}{10}=1-\\frac{5}{3}+\\frac{1}{6}=\\frac{6-10+1}{6}=-\\frac{1}{2}$.'},
  '$-\\frac{1}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2025 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\frac{5\\cdot\\frac{7}{100}+0{,}01}{\\frac{2}{5}+\\frac{2}{25}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $5\\cdot\\frac{7}{100}+0{,}01=\\frac{35}{100}+\\frac{1}{100}=\\frac{36}{100}=\\frac{9}{25}$. Jmenovatel: $\\frac{2}{5}+\\frac{2}{25}=\\frac{12}{25}$. Podil: $\\frac{9}{25}:\\frac{12}{25}=\\frac{9}{12}=\\frac{3}{4}$.'},
  '$\\frac{3}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2025 - uloha 3',
  new List<String>{'V kazdem diagramu se do prazdnych krouzku doplni takova cisla, aby byly vsechny vypocty provedene ve smeru sipek spravne. Pro kazdy diagram urcete cislo, ktere patri do silne ohraniceneho krouzku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif"> <text x="120" y="20" font-size="13" text-anchor="middle" font-weight="bold">3.1</text> <circle cx="70" cy="120" r="26" fill="#eee" stroke="#999" stroke-width="1.5"/> <circle cx="210" cy="120" r="26" fill="none" stroke="#000" stroke-width="3"/> <path d="M92 106 Q140 74 188 106" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="188,106 178,101 181,112" fill="#000"/> <text x="140" y="72" font-size="13" text-anchor="middle">+ 80</text> <path d="M188 134 Q140 166 92 134" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="92,134 102,129 99,140" fill="#000"/> <text x="140" y="178" font-size="13" text-anchor="middle">: 3</text> <text x="410" y="20" font-size="13" text-anchor="middle" font-weight="bold">3.2</text> <circle cx="410" cy="55" r="23" fill="#eee" stroke="#999" stroke-width="1.5"/> <circle cx="345" cy="150" r="23" fill="#eee" stroke="#999" stroke-width="1.5"/> <circle cx="475" cy="150" r="23" fill="none" stroke="#000" stroke-width="3"/> <path d="M347 128 Q360 78 388 62" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="388,62 377,63 383,72" fill="#000"/> <text x="345" y="92" font-size="13" text-anchor="middle">+ 10</text> <path d="M432 62 Q460 78 473 128" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="473,128 474,117 465,124" fill="#000"/> <text x="478" y="92" font-size="13" text-anchor="middle">&#183; 2</text> <path d="M452 156 Q410 182 368 156" fill="none" stroke="#000" stroke-width="1.5"/> <polygon points="368,156 378,151 375,162" fill="#000"/> <text x="410" y="196" font-size="13" text-anchor="middle">&#8722; 34</text> </svg>',
  'diagramy.svg',
  'Dva diagramy s krouzky a sipkami: 3.1 dva krouzky (+ 80 a : 3), 3.2 tri krouzky (+ 10, krat 2, minus 34).',
  'Schematicky nakres diagramu 3.1 a 3.2',
  new List<String>{'3.1 Oznacme cislo v sedem krouzku $x$. Plati $(x+80):3=x$, tedy $x+80=3x$, $x=40$. V silne ohranicenem krouzku je $40+80=120$.','3.2 Oznacme sedy krouzek vlevo dole $x$. Postupne: $x+10$ (horni), $(x+10)\\cdot 2$ (silne ohraniceny), po odecteni 34 zpet $x$: $2(x+10)-34=x$, $x=14$. Horni krouzek $24$, silne ohraniceny $24\\cdot 2=48$.'},
  '3.1: 120; 3.2: 48',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
