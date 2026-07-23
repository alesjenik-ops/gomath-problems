String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
Integer YEAR = 2021;

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
  'CERMAT M5A 2021 – úloha 3',
  new List<String>{'Závod mladších žáků v běhu na lyžích absolvovalo $6$ závodníků (A–F). První závodník vyběhl na trať v $9$ hodin $20$ minut, další vybíhali v půlminutových intervalech. Zvítězil závodník, který strávil na trati nejkratší dobu, tedy má nejlepší výsledný čas. (Všechny časy v tabulce jsou ve tvaru h:min:s.)','3.1 Vypočtěte výsledný čas vítěze závodu (v minutách a sekundách).','3.2 Určete, na kolikátém místě se umístil závodník, který proběhl cílem jako první.','3.3 Uveďte písmena všech závodníků, kteří proběhli cílem později než závodník D.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 628 152" font-family="sans-serif"><line x1="8" y1="8" x2="620" y2="8" stroke="#000"/><line x1="8" y1="42" x2="620" y2="42" stroke="#000"/><line x1="8" y1="76" x2="620" y2="76" stroke="#000"/><line x1="8" y1="110" x2="620" y2="110" stroke="#000"/><line x1="8" y1="144" x2="620" y2="144" stroke="#000"/><line x1="8" y1="8" x2="8" y2="144" stroke="#000"/><line x1="140" y1="8" x2="140" y2="144" stroke="#000"/><line x1="220" y1="8" x2="220" y2="144" stroke="#000"/><line x1="300" y1="8" x2="300" y2="144" stroke="#000"/><line x1="380" y1="8" x2="380" y2="144" stroke="#000"/><line x1="460" y1="8" x2="460" y2="144" stroke="#000"/><line x1="540" y1="8" x2="540" y2="144" stroke="#000"/><line x1="620" y1="8" x2="620" y2="144" stroke="#000"/><text x="16" y="29.0" font-size="13">Závodník</text><text x="180.0" y="29.0" font-size="12" text-anchor="middle">A</text><text x="260.0" y="29.0" font-size="12" text-anchor="middle">B</text><text x="340.0" y="29.0" font-size="12" text-anchor="middle">C</text><text x="420.0" y="29.0" font-size="12" text-anchor="middle">D</text><text x="500.0" y="29.0" font-size="12" text-anchor="middle">E</text><text x="580.0" y="29.0" font-size="12" text-anchor="middle">F</text><text x="16" y="63.0" font-size="13">Čas při startu</text><text x="180.0" y="63.0" font-size="12" text-anchor="middle">9:20:00</text><text x="260.0" y="63.0" font-size="12" text-anchor="middle">9:20:30</text><text x="340.0" y="63.0" font-size="12" text-anchor="middle">9:21:00</text><text x="420.0" y="63.0" font-size="12" text-anchor="middle">9:21:30</text><text x="500.0" y="63.0" font-size="12" text-anchor="middle">9:22:00</text><text x="580.0" y="63.0" font-size="12" text-anchor="middle">9:22:30</text><text x="16" y="97.0" font-size="13">Čas v cíli</text><text x="180.0" y="97.0" font-size="12" text-anchor="middle">9:43:15</text><text x="260.0" y="97.0" font-size="12" text-anchor="middle">9:43:05</text><text x="340.0" y="97.0" font-size="12" text-anchor="middle">9:43:25</text><text x="420.0" y="97.0" font-size="12" text-anchor="middle">9:43:20</text><text x="16" y="131.0" font-size="13">Výsledný čas</text><text x="180.0" y="131.0" font-size="12" text-anchor="middle">0:23:15</text><text x="340.0" y="131.0" font-size="12" text-anchor="middle">0:22:25</text><text x="500.0" y="131.0" font-size="12" text-anchor="middle">0:23:05</text><text x="580.0" y="131.0" font-size="12" text-anchor="middle">0:22:30</text></svg>',
  'zavod-tabulka.svg',
  'Tabulka časů závodníků A až F: čas při startu, čas v cíli a výsledný čas; některé buňky jsou prázdné.',
  'Časy závodníků (h:min:s)',
  new List<String>{'Výsledný čas = čas v cíli - čas při startu. Doplněné výsledné časy: A 23:15, B 22:35, C 22:25, D 21:50, E 23:05, F 22:30.','3.1 Nejkratší čas má D: 9:43:20 - 9:21:30 = 21 min 50 s.','3.2 Cílem proběhl jako první B (čas v cíli 9:43:05); jeho výsledný čas 22:35 je čtvrtý nejlepší, umístil se na 4. místě.','3.3 Později než D (9:43:20) proběhli cílem C (9:43:25), F (9:45:00) a E (9:45:05).'},
  '3.1: $21$ min $50$ s; 3.2: na 4. místě; 3.3: C, E, F',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2021 – úloha 4',
  new List<String>{'V cukrárně mají zabaleno celkem $80$ zákusků buď na táccích po $2$ zákuscích, nebo v krabičkách po $3$ zákuscích. Počet tácků se zákusky je o $10$ větší než počet krabiček se zákusky.','4.1 Určete počet všech krabiček se zákusky.','4.2 Určete celkový počet zákusků na táccích.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Počet krabiček $k$, počet tácků $k+10$. Zákusky: $3k+2(k+10)=80$, tj. $5k+20=80$, $5k=60$, $k=12$.','4.1 Krabiček se zákusky je $12$.','4.2 Tácků je $12+10=22$, na nich je $2\\cdot 22=44$ zákusků.'},
  '4.1: $12$ krabiček; 4.2: $44$ zákusků',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
