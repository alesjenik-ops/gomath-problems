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
  'CERMAT 2019 M9B · úloha 1',
  new List<String>{'Vypočtěte, kolik procent z $20$ tun tvoří $500$ kilogramů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$20\\ \\mathrm{t}=20\\,000\\ \\mathrm{kg}$; $\\frac{500}{20\\,000}=0{,}025=2{,}5\\ \\%$.'},
  '$2{,}5\\ \\%$',
  1, 2, '2',
  new List<String>{'zs2','r9','procenta','aritmetika','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $\\sqrt{10^2\\cdot0{,}002\\,5}=$','2.2 \\quad $5:0{,}2-(-0{,}3+0{,}5)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $\\sqrt{100\\cdot0{,}002\\,5}=\\sqrt{0{,}25}=0{,}5$.','2.2: $5:0{,}2-0{,}2=25-0{,}2=24{,}8$.'},
  '2.1: $0{,}5$; 2.2: $24{,}8$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{1-\\frac{1}{3}}{-6^2}=$','3.2 \\quad $12\\cdot\\left(\\dfrac{2}{3}-\\dfrac{1}{2}\\right)-\\dfrac{5}{2}+\\dfrac{2}{3}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $1-\\frac{1}{3}=\\frac{2}{3}$; jmenovatel $-6^2=-36$; $\\frac{2}{3}:(-36)=\\frac{2}{-108}=-\\frac{1}{54}$.','3.2: $12\\cdot\\left(\\frac{4}{6}-\\frac{3}{6}\\right)-\\frac{5}{2}+\\frac{2}{3}=12\\cdot\\frac{1}{6}-\\frac{5}{2}+\\frac{2}{3}=2-\\frac{5}{2}+\\frac{2}{3}=\\frac{12-15+4}{6}=\\frac{1}{6}$.'},
  '3.1: $-\\frac{1}{54}$; 3.2: $\\frac{1}{6}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $(2a+3b)^2=$','4.2 \\quad $3e\\cdot(2-f)-2f\\cdot(e-3f)=$','4.3 \\quad $(1+3n)\\cdot(1+3n)+(1+3n)\\cdot(1-3n)-2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(2a+3b)^2=4a^2+12ab+9b^2$.','4.2: $6e-3ef-2ef+6f^2=6e-5ef+6f^2$.','4.3: $(1+3n)^2+(1-9n^2)-2=1+6n+9n^2+1-9n^2-2=6n$.'},
  '4.1: $4a^2+12ab+9b^2$; 4.2: $6e-5ef+6f^2$; 4.3: $6n$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $2\\cdot(3-0{,}75x)+x=7-\\dfrac{x}{2}$','5.2 \\quad $\\dfrac{5}{6}\\cdot(y-2)-\\dfrac{2}{3}\\cdot y=\\dfrac{y}{2}-\\dfrac{5}{4}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: levá strana $6-1{,}5x+x=6-0{,}5x$; rovnice $6-0{,}5x=7-0{,}5x\\Rightarrow6=7$, což neplatí — rovnice nemá řešení.','5.2: levá strana $\\frac{5y}{6}-\\frac{10}{6}-\\frac{2y}{3}=\\frac{y}{6}-\\frac{5}{3}$; rovnice $\\frac{y}{6}-\\frac{5}{3}=\\frac{y}{2}-\\frac{5}{4}$; vynásobíme $12$: $2y-20=6y-15\\Rightarrow-5=4y\\Rightarrow y=-\\frac{5}{4}=-1{,}25$.'},
  '5.1: rovnice nemá řešení; 5.2: $y=-1{,}25$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 6',
  new List<String>{'Zadaná práce byla rozdělena na dvě stejné části. První polovinu práce vykonal minibagr za $10$ hodin. Druhou polovinu práce pak vykonali společně $4$ dělníci.','Přitom minibagr udělá za každých $5$ hodin stejný díl práce jako $5$ dělníků za $8$hodinovou pracovní dobu. (Každý dělník vykoná za hodinu stejné množství práce.)','Za půjčení $1$ minibagru se platí jednorázový poplatek $1\\,500$ korun. Každá hodina práce minibagru (i s obsluhou) stojí $600$ korun, hodina práce $1$ dělníka $150$ korun.','6.1 Vypočtěte, kolik korun se celkem zaplatilo za půjčení a práci minibagru (i s obsluhou).','6.2 Vypočtěte, kolik korun stála práce vykonaná dělníky.','6.3 Vypočtěte, kolik hodin musel odpracovat každý ze $4$ dělníků.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: minibagr pracoval $10$ hodin; $1\\,500+10\\cdot600=1\\,500+6\\,000=7\\,500$ korun.','6.2: za $5$ hodin udělá minibagr práci $5\\cdot8=40$ dělníkohodin, tedy za $10$ hodin $80$ dělníkohodin — to je první polovina. Druhá polovina je rovněž $80$ dělníkohodin; cena $80\\cdot150=12\\,000$ korun.','6.3: $80$ dělníkohodin vykonají $4$ dělníci, každý $\\frac{80}{4}=20$ hodin.'},
  '6.1: $7\\,500$ korun; 6.2: $12\\,000$ korun; 6.3: $20$ hodin',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD19C0T02', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
