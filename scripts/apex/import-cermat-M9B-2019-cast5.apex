String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2019 M9B · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V obchodě, v němž byla $20\\ \\%$ sleva na veškeré zboží, Kamila zaplatila $400$ korun. Kolik korun by zaplatila, kdyby nedostala žádnou slevu?','15.2 Svetr zdražili o $25\\ \\%$ a po čase jej zlevnili na $600$ korun, tedy na $80\\ \\%$ ceny svetru po zdražení. Kolik korun stál svetr ještě před zdražením?','15.3 V obou kapsách mám stejné množství peněz. Nejprve polovinu částky z levé kapsy přendám do pravé kapsy. Když pak dám $50\\ \\%$ částky z pravé kapsy opět do levé kapsy, v levé kapse budu mít $300$ korun. Kolik korun mám dohromady v obou kapsách?','Nabídka: A) $320$ korun; B) $480$ korun; C) $500$ korun; D) $540$ korun; E) $600$ korun; F) jiný počet korun.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $400$ je $80\\ \\%$ původní ceny; $400:0{,}8=500$ korun — \\textbf{C}.','15.2: cena po zdražení $600:0{,}8=750$ korun; před zdražením $750:1{,}25=600$ korun — \\textbf{E}.','15.3: každá kapsa $x$. Přesun: levá $\\frac{x}{2}$, pravá $\\frac{3x}{2}$; poté z pravé $50\\ \\%$ zpět: levá $\\frac{x}{2}+\\frac{3x}{4}=\\frac{5x}{4}=300\\Rightarrow x=240$; dohromady $2x=480$ korun — \\textbf{B}.'},
  '15.1: C; 15.2: E; 15.3: B',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 16',
  new List<String>{'Při spuštění programu je obrazovka prázdná. Při každém pípnutí se situace mění: při každém lichém pípnutí se objeví $2$ nové svislé čárky, při každém sudém pípnutí se objeví $2$ nové pomlčky. Při každém čtvrtém pípnutí však jedna nová pomlčka překříží jednu čárku na obrazovce a místo nich vidíme jeden symbol „plus“.','Na obrazovce tak mohou být tři různé symboly: „čárka“, „pomlčka“ a „plus“. Počty symbolů: po 1. pípnutí $2$ čárky; po 2. pípnutí $2$ čárky a $2$ pomlčky; po 3. pípnutí $4$ čárky a $2$ pomlčky; po 4. pípnutí $3$ čárky, $3$ pomlčky a $1$ plus (celkem $7$); po 5. pípnutí $5$ čárek, $3$ pomlčky a $1$ plus (celkem $9$); atd.','Určete, jaký je na obrazovce počet','16.1 symbolů „pomlčka“ při 10. pípnutí,','16.2 všech symbolů při 60. pípnutí,','16.3 symbolů „čárka“ právě ve chvíli, kdy se objevil 7. symbol „plus“.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: pomlčky přibývají při sudých pípnutích; do 10. pípnutí jsou sudá $2,4,6,8,10$. U čtvrtých ($4,8$) se jedna pomlčka spotřebuje na plus (net $+1$), u ostatních ($2,6,10$) je $+2$. Pomlček $3\\cdot2+2\\cdot1=8$.','16.2: každé pípnutí přidá $2$ symboly, ale každé čtvrté jen $1$ (dva vzniknou, ale čárka s pomlčkou se sloučí v plus). Do $60$: čtvrtých je $15$, ostatních $45$; celkem $45\\cdot2+15\\cdot1=105$ symbolů.','16.3: $7$. plus vznikne při $4\\cdot7=28$. pípnutí. Čárky: lichá pípnutí $1..27$ (jich $14$) dají $+2$, každé čtvrté ($4,8,\\dots,28$, jich $7$) ubere $1$ čárku: $14\\cdot2-7=21$.'},
  '16.1: $8$ symbolů „pomlčka“; 16.2: $105$ symbolů; 16.3: $21$ symbolů „čárka“',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','uvazovani','vypocet','slovni','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
