String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD22C0T03';
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
  'CERMAT M5C 2022 – úloha 1.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby byl výpočet správný: $\\square : 21 + 6 = 14$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Z $\\square : 21 + 6 = 14$ plyne $\\square : 21 = 8$, tedy $\\square = 8 \\cdot 21 = 168$.'},
  '$168$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2022 – úloha 1.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby byl výpočet správný: $213 : \\square = 14$, zbytek $3$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podíl beze zbytku je $213 - 3 = 210$. Pak $210 : \\square = 14$, tedy $\\square = 210 : 14 = 15$.'},
  '$15$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2022 – úloha 2.1',
  new List<String>{'Z kabelu dlouhého $610$ centimetrů jsme uřízli pět půlmetrových kusů a zbytek jsme rozdělili na $9$ stejně dlouhých dílů.','Určete, kolik centimetrů měří jeden díl.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pět půlmetrových kusů $= 5 \\cdot 50 = 250$ cm. Zbytek $610 - 250 = 360$ cm, jeden díl $360 : 9 = 40$ cm.'},
  '$40$ centimetrů',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 2.2',
  new List<String>{'Cesta na kole z Roztok do Neratovic trvá $1$ hodinu a $50$ minut. S využitím přívozu se doba cestování zkrátí o tři čtvrtě hodiny.','Vypočtěte, kolik minut trvá cesta z Roztok do Neratovic s využitím přívozu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ hodina a $50$ minut $= 110$ minut. Tři čtvrtě hodiny $= 45$ minut. Cesta trvá $110 - 45 = 65$ minut (tj. $1$ hodinu a $5$ minut).'},
  '$65$ minut',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 3',
  new List<String>{'Kapli si během dne prohlédlo celkem $630$ návštěvníků. Na každou prohlídku šla stejně početná skupina návštěvníků, kterou doprovázel vždy jeden z $5$ průvodců. Každý průvodce provedl $4$ skupiny návštěvníků dopoledne a $2$ skupiny odpoledne.','3.1 Vypočtěte, kolik návštěvníků bylo v jedné skupině.','3.2 Vypočtěte, kolik návštěvníků si kapli prohlédlo během dopoledne.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Skupin celkem: $5 \\cdot (4 + 2) = 30$. V jedné skupině $630 : 30 = 21$ návštěvníků.','3.2 Dopoledne bylo $5 \\cdot 4 = 20$ skupin, tj. $20 \\cdot 21 = 420$ návštěvníků.'},
  '3.1: $21$ návštěvníků; 3.2: $420$ návštěvníků',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 4',
  new List<String>{'Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.','4.1 Určete počet kříd v jedné menší krabičce.','4.2 Určete počet všech větších krabiček s křídami.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Ve $3$ větších krabičkách je $3 \\cdot 10 = 30$ kříd, tolik je i v $5$ menších. Jedna menší má $30 : 5 = 6$ kříd.','4.2 V menších krabičkách je celkem $30$ kříd, ve větších tedy $300 - 30 = 270$ kříd. Větších krabiček je $270 : 10 = 27$.'},
  '4.1: $6$ kříd; 4.2: $27$ větších krabiček',
  4, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2022 – úloha 5',
  new List<String>{'Displej byl zapnutý $10$ hodin. Na počátku se na displeji zobrazilo číslo $51\\,436$ a každou další sekundu se zobrazilo číslo o $1$ větší. Číslo zobrazené na displeji bylo buď oranžové, nebo zelené. Zelená byla právě ta čísla, která čteme zleva i zprava stejně, např. $62\\,526$.','5.1 Ze všech zelených čísel, která se zobrazila na displeji, určete nejmenší.','5.2 Ze všech zelených čísel, která se zobrazila na displeji, určete největší.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Za $10$ hodin se zobrazí $10 \\cdot 3600 = 36\\,000$ čísel, tedy od $51\\,436$ do $87\\,435$. Zelená jsou pětimístná čísla tvaru $\\overline{abcba}$.','5.1 Nejmenší takové číslo nemenší než $51\\,436$ je $51\\,515$.','5.2 Největší takové číslo nejvýše $87\\,435$ je $87\\,378$.'},
  '5.1: $51\\,515$; 5.2: $87\\,378$',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
