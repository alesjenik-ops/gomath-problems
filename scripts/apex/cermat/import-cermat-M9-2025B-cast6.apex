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
  'CERMAT M9B 2025 - uloha 14',
  new List<String>{'Na vyrobu dortu byly pouzity dve ruzne formy tvaru rotacniho valce. Polomer podstavy prvni formy je 8 cm a polomer podstavy druhe formy je o ctvrtinu mensi. Vyska obou forem je stejna, a to 5 cm. Dvoupatrovy dort je slozen z vetsiho a mensiho korpusu; kazdy korpus ma stejny objem jako forma, v niz byl upecen.','Jaky je celkovy objem obou korpusu dvoupatroveho dortu?'},
  new List<String>{'A) $350\\pi$ cm$^3$','B) $400\\pi$ cm$^3$','C) $450\\pi$ cm$^3$','D) $500\\pi$ cm$^3$','E) $550\\pi$ cm$^3$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 240" font-family="sans-serif"> <ellipse cx="160" cy="200" rx="120" ry="20" fill="#eee" stroke="#000"/> <path d="M 40 155 L 40 200 A 120 20 0 0 0 280 200 L 280 155" fill="#f4f4f4" stroke="#000"/> <ellipse cx="160" cy="155" rx="120" ry="20" fill="#f4f4f4" stroke="#000"/> <path d="M 70 110 L 70 155 A 90 16 0 0 0 250 155 L 250 110" fill="#fafafa" stroke="#000"/> <ellipse cx="160" cy="110" rx="90" ry="16" fill="#fafafa" stroke="#000"/> <text x="300" y="160" font-size="12">r = 8 cm</text> <text x="300" y="112" font-size="12">r = 6 cm</text> <text x="6" y="182" font-size="12">v = 5 cm</text> </svg>',
  'dort.svg',
  'Schematicky nakres dvoupatroveho dortu ze dvou valcu, spodni s polomerem 8 cm a horni s polomerem 6 cm, oba vysoke 5 cm.',
  'Schematicky nakres',
  new List<String>{'Polomer druhe formy $8-\\frac{1}{4}\\cdot 8=6$ cm. Objem vetsiho korpusu $\\pi\\cdot 8^2\\cdot 5=320\\pi$ cm$^3$, mensiho $\\pi\\cdot 6^2\\cdot 5=180\\pi$ cm$^3$. Celkem $320\\pi+180\\pi=500\\pi$ cm$^3$.'},
  'D) $500\\pi$ cm$^3$',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2025 - uloha 15',
  new List<String>{'Na tabore bylo 80 deti, 5 vedoucich a 4 instruktori. Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Vedouci si vsechny deti rozdelili do stejne pocetnych oddilu; kazdy vedouci mel na starost jeden oddil. Kolik procent vsech deti mel na starost jeden vedouci?','15.2 Na tabore bylo mladsich deti o jednu tretinu mene nez starsich deti. O kolik procent bylo starsich deti vice nez mladsich?','15.3 Deti z tabora se vydaly do lesa na boruvky. Sla ctvrtina vsech chlapcu a polovina vsech divek, tedy chlapcu slo do lesa o 4 mene nez divek. Kolik procent vsech deti na tabore tvorily divky?'},
  new List<String>{'A) $20\\,\\%$','B) $25\\,\\%$','C) $33\\,\\%$','D) $40\\,\\%$','E) $45\\,\\%$','F) $50\\,\\%$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Na jednoho z 5 vedoucich pripada $\\frac{80}{5}=16$ deti, tj. $\\frac{16}{80}=20\\,\\%$ -> A.','15.2 Mladsich je $\\frac{2}{3}$ poctu starsich, takze starsich je oproti mladsim $\\frac{3}{2}$, tj. o $50\\,\\%$ vice -> F.','15.3 Chlapcu $b$, divek $g$, $b+g=80$. Do lesa $\\frac{b}{4}=\\frac{g}{2}-4$, tj. $b=2g-16$. Dosazenim $2g-16+g=80$, $g=32$. Divky tvori $\\frac{32}{80}=40\\,\\%$ -> D.'},
  '15.1: A ($20\\,\\%$); 15.2: F ($50\\,\\%$); 15.3: D ($40\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2025 - uloha 16',
  new List<String>{'Mirek postupne odrikaval vsechna po sobe jdouci prirozena cisla od 1 do 1000. Za kazdym druhym cislem udelal kratkou pauzu, behem niz Zuzka rekla soucet poslednich dvou cisel, ktera vyslovil Mirek. Na zacatku tedy zaznela cisla: 1, 2, 3, 3, 4, 7, 5, 6, 11, ... (tucne vyslovila Zuzka cisla 3, 7, 11, ostatni Mirek).','16.1 Urcete cislo, ktere zaznelo mezi cisly 24 a 25.','16.2 Jako 90. v poradi bylo vysloveno cislo $C$, ktere pozdeji zaznelo jeste jednou. Urcete cislo, ktere bylo vysloveno bezprostredne predtim, nez podruhe zaznelo cislo $C$.','16.3 Urcete nejvetsi cislo, ktere mezi prvnimi 150 vyslovenymi cisly zaznelo dvakrat.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Cisla se odrikavaji po trojicich: v $k$-te trojici rekne Mirek cisla $2k-1$ a $2k$ a Zuzka jejich soucet $4k-1$.','16.1 Cisla 24 a 25 jsou dve sousedni Mirkova cisla z ruznych trojic: $24=2\\cdot 12$ (konec 12. trojice), $25=2\\cdot 13-1$ (zacatek 13. trojice). Mezi nimi zazni Zuzcin soucet 12. trojice $4\\cdot 12-1=47$.','16.2 Na 90. miste ($90=3\\cdot 30$) je Zuzcin soucet 30. trojice, tedy $C=4\\cdot 30-1=119$. Cislo 119 rekne pozdeji Mirek jako $2k-1=119$, tj. $k=60$ (prvni cislo 60. trojice). Bezprostredne predtim zazni Zuzcin soucet 59. trojice $4\\cdot 59-1=235$.','16.3 Prvnich 150 cisel tvori 50 trojic. Dvakrat zazni cislo, ktere je zaroven Mirkovo (1 az 100) i Zuzcino ($4k-1$). Nejvetsi takove nejvyse 100 je $99=4\\cdot 25-1$ (Zuzka v 25. trojici) a zaroven $99=2\\cdot 50-1$ (Mirek v 50. trojici). Hledane cislo je $99$.'},
  '16.1: $47$; 16.2: $235$; 16.3: $99$',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
