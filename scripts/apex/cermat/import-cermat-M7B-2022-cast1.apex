String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD22C0T02';
Integer YEAR = 2022;

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
  'CERMAT M7B 2022 – úloha 1',
  new List<String>{'Číslo $6$ je dělitelné číslem $3$ a při dělení číslem $5$ dává zbytek $1$.','Najděte všechna čísla větší než $10$ a menší než $50$, která jsou dělitelná číslem $3$ a při dělení číslem $5$ dávají zbytek $1$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hledáme čísla dělitelná třemi, která dávají po dělení pěti zbytek $1$ (tj. tvaru $5k+1$). V rozmezí $10<x<50$ vyhovují $21$ ($=3\\cdot7=5\\cdot4+1$) a $36$ ($=3\\cdot12=5\\cdot7+1$).'},
  '$21$; $36$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 2.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$1$ hodina $= 20$ minut $+$ □ sekund'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ hodina $=3600$ s, $20$ minut $=1200$ s, do rámečku patří $3600-1200=2400$.'},
  '$2\\,400$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 2.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$26$ m² $+$ □ dm² $= 36$ m² $- 18\\,000$ cm²'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$18\\,000$ cm² $=1{,}8$ m², pravá strana je $36-1{,}8=34{,}2$ m². Do rámečku patří $34{,}2-26=8{,}2$ m² $=820$ dm².'},
  '$820$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$2\\cdot\\frac{7}{48}-\\frac{7}{8}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\cdot\\frac{7}{48}-\\frac{7}{8}=\\frac{7}{24}-\\frac{21}{24}=-\\frac{14}{24}=-\\frac{7}{12}$.'},
  '$-\\frac{7}{12}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\frac{\\frac{6}{7}\\cdot\\frac{2}{3}}{\\frac{6}{7}+\\frac{2}{3}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{12}{21}$, jmenovatel $\\frac{6}{7}+\\frac{2}{3}=\\frac{18+14}{21}=\\frac{32}{21}$. Podíl $\\frac{12}{21}:\\frac{32}{21}=\\frac{12}{32}=\\frac{3}{8}$.'},
  '$\\frac{3}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2022 – úloha 4.1',
  new List<String>{'Od startovní čáry vyběhli současně $4$ běžci. Každý doběhl do cíle v jiném čase. Eda nebyl první ani poslední. Leoš se umístil těsně před Adamem a Adam doběhl později než Honza.','Zapište běžce ve stejném pořadí, v jakém doběhli do cíle. Každého běžce označte počátečním písmenem jeho jména.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Leoš doběhl těsně před Adamem (dvojice $L$, $A$ za sebou), Adam až za Honzou a Eda nebyl první ani poslední. Vyhovuje jediné pořadí $H$, $E$, $L$, $A$.'},
  'H, E, L, A (Honza, Eda, Leoš, Adam)',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2022 – úloha 4.2',
  new List<String>{'Na výletě bylo pětkrát více dětí než dospělých. Dospělých bylo o $60$ méně než dětí.','Vypočtěte, kolik dětí bylo na výletě.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet dospělých $d$. Dětí je $5d$ a zároveň o $60$ více: $5d=d+60$, tedy $4d=60$, $d=15$ dospělých a dětí $5\\cdot15=75$.'},
  '$75$ dětí',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2022 – úloha 5',
  new List<String>{'V rekreační chatě je několik pokojů. V jednom pokoji jsou $2$ lůžka a v každém z ostatních pokojů jsou $\\frac{3}{10}$ všech lůžek, která jsou v rekreační chatě.','Určete:','5.1 počet všech lůžek v rekreační chatě,','5.2 počet pokojů v rekreační chatě.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet všech lůžek $L$ a počet pokojů $p$. Platí $2+(p-1)\\cdot\\frac{3}{10}L=L$. Pro $p=4$ vychází $2+3\\cdot\\frac{3}{10}L=L$, tj. $2=\\frac{1}{10}L$, tedy $L=20$ lůžek. Každý z ostatních pokojů má $\\frac{3}{10}\\cdot20=6$ lůžek, dohromady $2+3\\cdot6=20$; pokojů je $4$.'},
  '5.1: $20$ lůžek; 5.2: $4$ pokoje',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
