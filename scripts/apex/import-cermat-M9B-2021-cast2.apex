String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)';
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
  'CERMAT 2021 M9B · úloha 6',
  new List<String>{'Přímá trasa z místa A do místa B měří $4\\ \\mathrm{km}$. Přesně v polovině této trasy je místo S. Z místa A vystartovali současně 3 kamarádi a za stejný čas zdolali na této trase úseky různých délek: Soňa došla pěšky pouze do místa S (trasa A→S), Barbora doběhla až do místa B (trasa A→S→B) a Karel na kole dojel nejprve do místa B, pak se vrátil zpět do A a nakonec zamířil do místa S (trasa A→S→B→S→A→S). Každý z kamarádů se pohyboval stálou rychlostí.','6.1 \\quad Vypočtěte, kolikrát větší byla rychlost Karla než rychlost Barbory.','6.2 \\quad Vypočtěte, kolik km od místa A byl vzdálen Karel v okamžiku, kdy Barbora míjela místo S.','6.3 \\quad Vypočtěte, kolik m od sebe byli vzdáleni Karel s Barborou v okamžiku, kdy Soňa urazila prvních $400\\ \\mathrm{m}$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Za stejný čas urazí Soňa $2\\ \\mathrm{km}$, Barbora $4\\ \\mathrm{km}$ a Karel $2+2+2+2+2=10\\ \\mathrm{km}$; rychlosti jsou v poměru drah.','6.1: $\\frac{v_K}{v_B}=\\frac{10}{4}=2{,}5$krát.','6.2: Barbora míjí S po uražení $2\\ \\mathrm{km}$, tj. v polovině celkového času; Karel za tu dobu urazí $5\\ \\mathrm{km}$ své trasy, což je $1\\ \\mathrm{km}$ za bodem B na cestě zpět, tedy je $4-1=3\\ \\mathrm{km}$ od A.','6.3: Soňa urazí $400\\ \\mathrm{m}$ za pětinu svého času; za tu dobu Barbora urazí $0{,}8\\ \\mathrm{km}$ (je $0{,}8\\ \\mathrm{km}$ od A) a Karel $2\\ \\mathrm{km}$ (je právě v S, tj. $2\\ \\mathrm{km}$ od A); jejich vzdálenost $=2-0{,}8=1{,}2\\ \\mathrm{km}=1\\,200\\ \\mathrm{m}$.'},
  '6.1: $2{,}5$krát; 6.2: $3\\ \\mathrm{km}$; 6.3: $1\\,200\\ \\mathrm{m}$',
  3, 6, '4',
  new List<String>{'zs2','r9','pomer','slovni','uvazovani','bezny-zivot','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 7',
  new List<String>{'Každý účastník soutěže mohl získat $0$, $1$, $2$, $3$, nebo $4$ body. Výsledky jsou v tabulce (některá pole nejsou vyplněna). Dívky získaly: $0$ bodů — $7$ dívek, $1$ bod — nevyplněno, $2$ body — $4$ dívky, $3$ body — $0$ dívek, $4$ body — $5$ dívek. Chlapci získali: $2$ body — $5$ chlapců, $3$ body — $4$ chlapci, $4$ body — $2$ chlapci; celkový počet bodů chlapců je $36$ (počty chlapců s $0$ a s $1$ bodem nejsou vyplněny).','7.1 \\quad Dívek, které získaly pouze $1$ bod, bylo dvakrát více než dívek bez bodu. Vypočtěte průměrný bodový zisk dívek.','7.2 \\quad Chlapců, kteří získali pouze $1$ bod, bylo dvakrát více než chlapců bez bodu. Všichni chlapci dohromady získali $36$ bodů. Vypočtěte průměrný bodový zisk chlapců.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: dívek bez bodu je $7$, tedy s $1$ bodem $2\\cdot7=14$; celkem dívek $7+14+4+0+5=30$; celkem bodů $7\\cdot0+14\\cdot1+4\\cdot2+0\\cdot3+5\\cdot4=42$; průměr $\\frac{42}{30}=1{,}4$ bodu.','7.2: nechť chlapců bez bodu je $c$, s $1$ bodem $2c$; body celkem $0\\cdot c+1\\cdot2c+2\\cdot5+3\\cdot4+4\\cdot2=2c+30=36\\Rightarrow c=3$; celkem chlapců $3+6+5+4+2=20$; průměr $\\frac{36}{20}=1{,}8$ bodu.'},
  '7.1: $1{,}4$ bodu; 7.2: $1{,}8$ bodu',
  3, 6, '4',
  new List<String>{'zs2','r9','aritmetika','slovni','uvazovani','bezny-zivot','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
