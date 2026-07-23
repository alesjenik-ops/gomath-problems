String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M9B 2019 – úloha 14',
  new List<String>{'Kryštof, Lenka a Marek sbírali do čtvrtlitrových hrnků borůvky. Kryštof naplnil borůvkami třikrát více hrnků než Marek. Lenka naplnila borůvkami o $50\\,\\%$ méně hrnků než Kryštof. Kryštof naplnil borůvkami o $2$ hrnky více než Lenka s Markem dohromady.','Označme $m$ neznámý počet hrnků, které naplnil borůvkami Marek. Ze které z následujících rovnic lze v souladu se zadáním vypočítat $m$?'},
  new List<String>{'A) $3m=2{,}5m+2$','B) $3m+2=2{,}5m$','C) $3m-2=2m+0{,}5$','D) $3m=2{,}5m+2{,}5$','E) $3m-2=2m+50$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Kryštof $3m$, Lenka $0{,}5\\cdot 3m=1{,}5m$. Kryštof je o $2$ větší než Lenka s Markem: $3m=1{,}5m+m+2=2{,}5m+2$.'},
  'A) $3m=2{,}5m+2$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2019 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V obchodě, v němž byla $20\\,\\%$ sleva na veškeré zboží, Kamila zaplatila $400$ korun. Kolik korun by zaplatila, kdyby nedostala žádnou slevu?','15.2 Svetr zdražili o $25\\,\\%$ a po čase jej zlevnili na $600$ korun, tedy na $80\\,\\%$ ceny svetru po zdražení. Kolik korun stál svetr ještě před zdražením?','15.3 V obou kapsách mám stejné množství peněz. Nejprve polovinu částky z levé kapsy přendám do pravé kapsy. Když pak dám $50\\,\\%$ částky z pravé kapsy opět do levé kapsy, v levé kapse budu mít $300$ korun. Kolik korun mám dohromady v obou kapsách?'},
  new List<String>{'A) $320$ korun','B) $480$ korun','C) $500$ korun','D) $540$ korun','E) $600$ korun','F) jiný počet korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 $400$ Kč je $80\\,\\%$ ceny, plná cena $\\frac{400}{0{,}8}=500$ korun → C.','15.2 Cena po zdražení: $600=80\\,\\%$, tedy $750$ Kč. Před zdražením $\\frac{750}{1{,}25}=600$ korun → E.','15.3 Nechť v každé kapse $a$. Levá: $a\\to\\frac{a}{2}$; pravá $\\frac{3a}{2}$, z ní $\\frac{3a}{4}$ zpět do levé: levá $\\frac{a}{2}+\\frac{3a}{4}=\\frac{5a}{4}=300\\Rightarrow a=240$; dohromady $2a=480$ korun → B.'},
  '15.1: C ($500$ korun); 15.2: E ($600$ korun); 15.3: B ($480$ korun)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2019 – úloha 16',
  new List<String>{'Při spuštění programu je obrazovka prázdná. Při každém lichém pípnutí (1., 3., …) se objeví $2$ nové čárky, při každém sudém pípnutí (2., 4., …) se objeví $2$ nové pomlčky. Při každém čtvrtém pípnutí však jedna nová pomlčka překříží jednu čárku a místo nich vidíme plus. Na obrazovce tak mohou být tři symboly: čárka, pomlčka a plus. (Např. při 5. pípnutí je $9$ symbolů: $5$ čárek, $3$ pomlčky a $1$ plus.)','Určete, jaký je na obrazovce počet','16.1 symbolů „pomlčka" při 10. pípnutí,','16.2 všech symbolů při 60. pípnutí,','16.3 symbolů „čárka" právě ve chvíli, kdy se objevil 7. symbol „plus".'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 Do 10. pípnutí přibylo na $5$ sudých pípnutích $5\\cdot 2=10$ pomlček, na $2$ čtvrtých pípnutích ($4.$ a $8.$) se $2$ pomlčky změnily v plus. Pomlček je $10-2=8$.','16.2 Do 60. pípnutí: $30$ lichých pípnutí dá $60$ čárek, $30$ sudých dá $60$ pomlček, na $15$ čtvrtých pípnutích vznikne $15$ plus (a ubyde $15$ čárek i $15$ pomlček). Čárky $45$, pomlčky $45$, plus $15$; všech symbolů $45+45+15=105$.','16.3 $7.$ plus vznikne při $7\\cdot 4=28.$ pípnutí. Do 28. pípnutí je $14$ lichých pípnutí ($28$ čárek) a $7$ čtvrtých pípnutí ($7$ čárek se změní v plus): čárek $28-7=21$.'},
  '16.1: $8$ pomlček; 16.2: $105$ symbolů; 16.3: $21$ čárek',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
