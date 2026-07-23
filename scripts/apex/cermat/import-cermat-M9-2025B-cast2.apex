String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD25C0T02';
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
  'CERMAT M9B 2025 - uloha 6',
  new List<String>{'Cislo 231 lze rozlozit na soucin tri prvocisel $a\\cdot b\\cdot c$.','Urcete:','6.1 nejmensi z prvocisel $a$, $b$, $c$,','6.2 soucet vsech tri prvocisel $a+b+c$,','6.3 nejvetsi dvojciferne cislo, ktere je delitelem cisla 231.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Rozklad $231=3\\cdot 7\\cdot 11$.','6.1 Nejmensi prvocislo je $3$.','6.2 Soucet $3+7+11=21$.','6.3 Delitele cisla 231 jsou $1,3,7,11,21,33,77,231$; nejvetsi dvojciferny je $77$.'},
  '6.1: $3$; 6.2: $21$; 6.3: $77$',
  3, 4, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2025 - uloha 7',
  new List<String>{'Farmar prodaval salaty za jednotnou cenu za kus a v prubehu tri dnu vsechny salaty prodal. Prvni den prodal tretinu vsech salatu, druhy den prodal o tretinu mene salatu nez prvni den a treti den prodal zbytek salatu.','7.1 Za vsechny prodane salaty utrzil farmar celkem 5 400 korun. Vypoctete, kolik korun utrzil farmar za salaty prodane druhy den.','7.2 Pocet vsech salatu, ktere farmar prodal, oznacime $x$. Vyjadrete vyrazem s promennou $x$, kolik salatu prodal farmar druhy den.','7.3 Treti den prodal farmar 120 salatu. Urcete pocet vsech salatu, ktere farmar prodal.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Prvni den $\\frac{1}{3}$ vsech, druhy den o tretinu mene, tj. $\\frac{2}{3}\\cdot\\frac{1}{3}=\\frac{2}{9}$ vsech, treti den zbytek $1-\\frac{1}{3}-\\frac{2}{9}=\\frac{4}{9}$ vsech.','7.1 Na druhy den pripada $\\frac{2}{9}$ trzby: $\\frac{2}{9}\\cdot 5400=1200$ korun.','7.2 Druhy den $\\frac{2}{9}x$ salatu.','7.3 Treti den $\\frac{4}{9}x=120$, odtud $x=270$ salatu.'},
  '7.1: $1200$ korun; 7.2: $\\frac{2}{9}x$; 7.3: $270$ salatu',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2025 - uloha 8',
  new List<String>{'Velky pravouhly lichobeznik, jehoz rozmery jsou uvedeny na obrazku vlevo, jsme jednou useckou rozdelili na mensi lichobeznik a rovnobeznik (obrazek vpravo). Oba tyto nove utvary (mensi lichobeznik a rovnobeznik) maji stejny obvod. Rozmery velkeho lichobezniku: kratsi zakladna $100$ cm, delsi zakladna $140$ cm, vyska (kolme rameno) $30$ cm.','8.1 Vypoctete v cm^2 obsah velkeho pravouhleho lichobezniku.','8.2 Vypoctete v cm obvod velkeho pravouhleho lichobezniku.','8.3 Vypoctete v cm obvod rovnobezniku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 180" font-family="sans-serif"> <polygon points="20,140 188,140 140,86 20,86" fill="none" stroke="#000" stroke-width="2"/> <text x="80" y="78" font-size="13" text-anchor="middle">100 cm</text> <text x="104" y="158" font-size="13" text-anchor="middle">140 cm</text> <text x="14" y="118" font-size="13" text-anchor="end">30 cm</text> <rect x="20" y="128" width="12" height="12" fill="none" stroke="#000"/> <polygon points="280,140 448,140 400,86 280,86" fill="none" stroke="#000" stroke-width="2"/> <line x1="382" y1="140" x2="334" y2="86" stroke="#000" stroke-width="1.6"/> <text x="303" y="78" font-size="11" text-anchor="middle">mensi lichobeznik</text> <text x="405" y="132" font-size="11" text-anchor="middle">rovnobeznik</text> <rect x="280" y="128" width="12" height="12" fill="none" stroke="#000"/> </svg>',
  'lichobeznik.svg',
  'Vlevo velky pravouhly lichobeznik s rozmery 100 cm, 140 cm a 30 cm; vpravo jeho rozdeleni na mensi lichobeznik a rovnobeznik.',
  'Schematicky nakres (rozmery dle zadani)',
  new List<String>{'8.1 Obsah $\\frac{100+140}{2}\\cdot 30=120\\cdot 30=3600$ cm$^2$.','8.2 Sikme rameno: vodorovny rozdil zakladen $140-100=40$ cm, svisly $30$ cm, tedy $\\sqrt{40^2+30^2}=50$ cm. Obvod $100+140+30+50=320$ cm.','8.3 Rovnobeznik ma dve strany shodne se sikmym ramenem ($50$ cm) a dve strany delky $s$ (casti zakladen); mensi lichobeznik ma strany $30$ cm, $50$ cm a casti zakladen $100-s$ a $140-s$. Z rovnosti obvodu $2s+2\\cdot 50=30+50+(100-s)+(140-s)$, tj. $2s+100=320-2s$, plyne $s=55$ cm. Obvod rovnobezniku $2\\cdot 55+2\\cdot 50=210$ cm.'},
  '8.1: $3600$ cm$^2$; 8.2: $320$ cm; 8.3: $210$ cm',
  4, 7, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
