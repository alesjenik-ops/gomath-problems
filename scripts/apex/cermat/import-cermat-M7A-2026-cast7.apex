String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD26C0T01';
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
  'CERMAT M7A 2026 - uloha 15',
  new List<String>{'Brigadnici presadili v zahradnictvi vsechny sazenice rajcat za tri dny. Po prvnim dni zbyvalo k presazeni jeste 60 % vsech sazenic rajcat. Po druhem dni byl celkovy pocet presazenych sazenic rajcat o polovinu vetsi nez po prvnim dni. Treti den bylo presazeno zbyvajicich 216 sazenic rajcat. Brigadnice Jarka presadila za uvedene tri dny celkem 162 sazenic rajcat.','Priradte ke kazde otazce (15.1-15.3) spravnou odpoved (A-F). Kolik procent z celkoveho poctu sazenic rajcat...','15.1 bylo presazeno druhy den?','15.2 bylo presazeno treti den?','15.3 presadila brigadnice Jarka?'},
  new List<String>{'A) 20 %','B) 25 %','C) 30 %','D) 35 %','E) 40 %','F) jiny pocet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Po 1. dni presazeno $100\\,\\%-60\\,\\%=40\\,\\%$. Po 2. dni celkem $1{,}5\\cdot 40\\,\\%=60\\,\\%$.','15.1 Druhy den $60\\,\\%-40\\,\\%=20\\,\\%$ -> A.','15.2 Treti den zbyvajicich $100\\,\\%-60\\,\\%=40\\,\\%$ -> E. (Odpovida $216$ sazenicim, celkem $216:0{,}4=540$ sazenic.)','15.3 Jarka $\\frac{162}{540}=0{,}3=30\\,\\%$ -> C.'},
  '15.1: A (20 %); 15.2: E (40 %); 15.3: C (30 %)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2026 - uloha 16',
  new List<String>{'V prvnim obrazci je nakreslena jedna kruznice a jedna primka, ktera ma s touto kruznici prave jeden spolecny bod. V kazdem dalsim obrazci pribude jedna kruznice a jedna primka. Vsechny kruznice maji stred ve stejnem bode, ale kazda nova kruznice ma vetsi polomer nez ta predchozi. Vsechny primky jsou navzajem rovnobezne a kazda nova primka ma prave jeden spolecny bod s novou kruznici. V kazdem spolecnem bode primky a kruznice je puntik (viz obrazek). Napr. ve tretim obrazci je 9 puntiku.','16.1 Urcete, kolik puntiku je v 5. obrazci.','16.2 Urcete, o kolik se lisi pocet vsech puntiku v 8. obrazci a v 9. obrazci.','16.3 Urcete, v kolikatem obrazci je o 171 puntiku vice nez v predchozim obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 240" font-family="sans-serif"><circle cx="90" cy="130" r="18" fill="none" stroke="#000"/><line x1="108" y1="58" x2="108" y2="202" stroke="#000"/><circle cx="108" cy="130" r="3" fill="#000"/><text x="90" y="24" font-size="12" text-anchor="middle">1. obrazec</text><circle cx="250" cy="130" r="18" fill="none" stroke="#000"/><circle cx="250" cy="130" r="36" fill="none" stroke="#000"/><line x1="268" y1="58" x2="268" y2="202" stroke="#000"/><circle cx="268" cy="130" r="3" fill="#000"/><circle cx="268" cy="98.8" r="3" fill="#000"/><circle cx="268" cy="161.2" r="3" fill="#000"/><line x1="286" y1="58" x2="286" y2="202" stroke="#000"/><circle cx="286" cy="130" r="3" fill="#000"/><text x="250" y="24" font-size="12" text-anchor="middle">2. obrazec</text><circle cx="430" cy="130" r="18" fill="none" stroke="#000"/><circle cx="430" cy="130" r="36" fill="none" stroke="#000"/><circle cx="430" cy="130" r="54" fill="none" stroke="#000"/><line x1="448" y1="58" x2="448" y2="202" stroke="#000"/><circle cx="448" cy="130" r="3" fill="#000"/><circle cx="448" cy="98.8" r="3" fill="#000"/><circle cx="448" cy="161.2" r="3" fill="#000"/><circle cx="448" cy="79.1" r="3" fill="#000"/><circle cx="448" cy="180.9" r="3" fill="#000"/><line x1="466" y1="58" x2="466" y2="202" stroke="#000"/><circle cx="466" cy="130" r="3" fill="#000"/><circle cx="466" cy="89.8" r="3" fill="#000"/><circle cx="466" cy="170.2" r="3" fill="#000"/><line x1="484" y1="58" x2="484" y2="202" stroke="#000"/><circle cx="484" cy="130" r="3" fill="#000"/><text x="430" y="24" font-size="12" text-anchor="middle">3. obrazec</text><text x="558" y="136" font-size="20">&#8230;</text></svg>',
  'obrazce-puntiky.svg',
  '1., 2. a 3. obrazec: soustredne kruznice a rovnobezne primky s puntiky ve spolecnych bodech.',
  '1., 2. a 3. obrazec',
  new List<String>{'V $n$-tem obrazci je puntiku $1+3+5+\\dots+(2n-1)=n^2$ (3. obrazec: $9=3^2$).','16.1 $5^2=25$ puntiku.','16.2 $9^2-8^2=81-64=17$ puntiku.','16.3 $n^2-(n-1)^2=2n-1=171\\Rightarrow n=86$; v 86. obrazci.'},
  '16.1: $25$ puntiku; 16.2: o $17$ puntiku; 16.3: v $86.$ obrazci',
  4, 6, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
