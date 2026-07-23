String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
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
  'CERMAT M5B 2022 – úloha 1.1',
  new List<String>{'Vypočtěte: $(1\\,100-110-90):(5-2\\cdot 2)+24=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(1\\,100-110-90):(5-2\\cdot 2)+24=900:1+24=900+24=924$.'},
  '$924$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2022 – úloha 1.2',
  new List<String>{'Vypočtěte: $60\\cdot 40-(5+5\\cdot 13):2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$60\\cdot 40-(5+5\\cdot 13):2=2\\,400-70:2=2\\,400-35=2\\,365$.'},
  '$2\\,365$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2022 – úloha 2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','2.1 $1$ hodina $=20$ minut $+$ [ ] sekund','2.2 $\\frac{1}{4}$ metru $+340$ milimetrů $=1$ metr $-$ [ ] centimetrů'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $1$ hodina $=3\\,600$ s, $20$ minut $=1\\,200$ s; do rámečku patří $3\\,600-1\\,200=2\\,400$.','2.2 $\\frac{1}{4}$ m $=25$ cm, $340$ mm $=34$ cm, levá strana $=59$ cm; $1$ m $-41$ cm $=59$ cm, do rámečku patří $41$.'},
  '2.1: $2\\,400$; 2.2: $41$',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2022 – úloha 3',
  new List<String>{'3.1 Od startovní čáry vyběhli současně 4 běžci. Každý doběhl do cíle v jiném čase. Eda nebyl první ani poslední. Leoš se umístil těsně před Adamem a Adam doběhl později než Honza. Zapište běžce ve stejném pořadí, v jakém doběhli do cíle. Každého běžce označte počátečním písmenem jeho jména.','3.2 Na výletě bylo pětkrát více dětí než dospělých. Dospělých bylo o 60 méně než dětí. Vypočtěte, kolik dětí bylo na výletě.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Z podmínek (Eda ne první ani poslední; Leoš těsně před Adamem; Honza doběhl před Adamem) plyne jediné pořadí H, E, L, A.','3.2 Dětí je pětkrát více než dospělých a zároveň o 60 více: $5d-d=60$, $4d=60$, $d=15$; dětí je $5\\cdot 15=75$.'},
  '3.1: H, E, L, A; 3.2: $75$ dětí',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2022 – úloha 4',
  new List<String>{'V kasičce bylo na začátku prázdnin 2 800 korun. Každý den prázdnin si z kasičky brala Anna 30 korun a Radka 40 korun, a to až do dne, kdy se kasička vyprázdnila.','4.1 Vypočtěte, kolikátý den prázdnin se kasička vyprázdnila.','4.2 Když si jednoho prázdninového dne obě dívky vzaly peníze z kasičky, zůstalo v ní přesně tolik korun, kolik už si z ní od začátku prázdnin vybrala Anna. Vypočtěte, kolikátý den prázdnin k tomu došlo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Za jeden den obě dívky vyberou $30+40=70$ korun; $2\\,800:70=40$, kasička se vyprázdní $40.$ den.','4.2 Po $n$ dnech v kasičce zůstane $2\\,800-70n$ korun, Anna vybrala celkem $30n$ korun. Z rovnice $2\\,800-70n=30n$ plyne $100n=2\\,800$, tedy $n=28$.'},
  '4.1: $40.$ den; 4.2: $28.$ den',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2022 – úloha 5',
  new List<String>{'V pohádkové říši se setkání draků zúčastnili pouze dvouhlaví a tříhlaví draci. Draků bylo celkem 52 a dohromady měli 134 hlav.','5.1 Vypočtěte, kolik dvouhlavých draků bylo na setkání.','5.2 Vypočtěte, o kolik hlav více měli dohromady všichni tříhlaví draci než všichni dvouhlaví draci.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Označme $d$ počet dvouhlavých a $t$ počet tříhlavých draků: $d+t=52$ a $2d+3t=134$. Odtud $t=30$ a $d=22$.','5.2 Tříhlaví draci mají $30\\cdot 3=90$ hlav, dvouhlaví $22\\cdot 2=44$ hlav; rozdíl je $90-44=46$ hlav.'},
  '5.1: $22$ dvouhlavých draků; 5.2: o $46$ hlav',
  4, 4, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
