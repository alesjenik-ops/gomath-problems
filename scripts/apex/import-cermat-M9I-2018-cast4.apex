String SRC   = 'CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2018 M9I · úloha 12',
  new List<String>{'Model vozidla má na každé straně za sebou tři kolečka s poloměrem $1\\ \\mathrm{cm}$, přes která je natažen pás. Vzdálenost středů každých dvou sousedních koleček na téže straně vozidla je $3\\ \\mathrm{cm}$.','Jaká je délka jednoho pásu? Výsledek v mm je zaokrouhlen na celé číslo.'},
  new List<String>{'A) větší než $180\\ \\mathrm{mm}$','B) $180\\ \\mathrm{mm}$','C) $176\\ \\mathrm{mm}$','D) $163\\ \\mathrm{mm}$','E) $151\\ \\mathrm{mm}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Pás tvoří dvě přímé části (nahoře a dole), každá délky rovné vzdálenosti krajních středů $2\\cdot3=6\\ \\mathrm{cm}$, a dva půlkruhové oblouky kolem krajních koleček, které dohromady tvoří celou kružnici o poloměru $1\\ \\mathrm{cm}$.','Délka $=2\\cdot6+2\\pi\\cdot1=12+2\\pi\\doteq12+6{,}28=18{,}28\\ \\mathrm{cm}=182{,}8\\ \\mathrm{mm}\\doteq183\\ \\mathrm{mm}$, což je více než $180\\ \\mathrm{mm}$.'},
  'A) větší než $180\\ \\mathrm{mm}$',
  2, 3, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','vyber','bezny-zivot'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 13',
  new List<String>{'Dřevěný kvádr s rozměry $5\\ \\mathrm{cm}$, $4\\ \\mathrm{cm}$ a $5\\ \\mathrm{cm}$ má hmotnost $50\\ \\mathrm{g}$. V kvádru byl vytvořen skrz naskrz otvor tvaru krychle s hranou délky $4\\ \\mathrm{cm}$ (otvor prochází kvádrem ve směru hrany délky $4\\ \\mathrm{cm}$).','Jaký objem má nově vytvořené těleso?'},
  new List<String>{'A) $25\\ \\mathrm{cm}^3$','B) $30\\ \\mathrm{cm}^3$','C) $32\\ \\mathrm{cm}^3$','D) $36\\ \\mathrm{cm}^3$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Objem kvádru $=5\\cdot4\\cdot5=100\\ \\mathrm{cm}^3$. Odebraný otvor je krychle o hraně $4\\ \\mathrm{cm}$, tj. $4\\cdot4\\cdot4=64\\ \\mathrm{cm}^3$. Nové těleso má objem $100-64=36\\ \\mathrm{cm}^3$.'},
  'D) $36\\ \\mathrm{cm}^3$',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bez-kalkulacky'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 14',
  new List<String>{'Dřevěný kvádr s rozměry $5\\ \\mathrm{cm}$, $4\\ \\mathrm{cm}$ a $5\\ \\mathrm{cm}$ má hmotnost $50\\ \\mathrm{g}$. Skrz naskrz je v něm vytvořen otvor tvaru krychle s hranou délky $4\\ \\mathrm{cm}$ (objem otvoru $64\\ \\mathrm{cm}^3$).','O kolik gramů se snížila hmotnost kvádru po vytvoření otvoru?'},
  new List<String>{'A) o $16\\ \\mathrm{g}$','B) o $20\\ \\mathrm{g}$','C) o $25\\ \\mathrm{g}$','D) o $32\\ \\mathrm{g}$','E) o $36\\ \\mathrm{g}$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Hustota dřeva $=\\frac{50\\ \\mathrm{g}}{100\\ \\mathrm{cm}^3}=0{,}5\\ \\mathrm{g/cm}^3$. Odebraný objem je $64\\ \\mathrm{cm}^3$, úbytek hmotnosti $=64\\cdot0{,}5=32\\ \\mathrm{g}$.'},
  'D) o $32\\ \\mathrm{g}$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','vyber','bezny-zivot'},
  'M9PID18C0T01', 2018
);
c.add(
  'CERMAT 2018 M9I · úloha 15',
  new List<String>{'Pavel za hodinu vydělal $300\\ \\mathrm{Kč}$, Václav o třetinu více než Pavel. Václav odpracoval celkem $60$ hodin, což je o třetinu méně hodin, než odpracoval Pavel.','Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).','15.1 O kolik procent méně vydělal za hodinu Pavel než Václav?','15.2 O kolik procent více hodin odpracoval Pavel než Václav?','15.3 O kolik procent více si celkem vydělal Pavel než Václav?','Nabídka: A) o $0\\ \\%$; B) o $12{,}5\\ \\%$; C) o $25\\ \\%$; D) o $33{,}\\overline{3}\\ \\%$; E) o $50\\ \\%$; F) o jiný počet procent.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Pavel za hodinu $300\\ \\mathrm{Kč}$, Václav $300\\cdot\\frac{4}{3}=400\\ \\mathrm{Kč}$. Václav odpracoval $60$ h, což jsou dvě třetiny Pavlových hodin, tedy Pavel $=90$ h. Celkem: Pavel $300\\cdot90=27\\,000\\ \\mathrm{Kč}$, Václav $400\\cdot60=24\\,000\\ \\mathrm{Kč}$.','15.1: $\\frac{400-300}{400}=0{,}25=25\\ \\%$ — \\textbf{C}.','15.2: $\\frac{90-60}{60}=0{,}5=50\\ \\%$ — \\textbf{E}.','15.3: $\\frac{27\\,000-24\\,000}{24\\,000}=0{,}125=12{,}5\\ \\%$ — \\textbf{B}.'},
  '15.1: C; 15.2: E; 15.3: B',
  6, 7, '4',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PID18C0T01', 2018
);

System.debug('Vytvořeno úloh: '+c.created);
