String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
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
  'CERMAT M5C 2026 – úloha 1.1',
  new List<String>{'Vypočtěte: $84:4-4\\cdot 5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $84:4-4\\cdot 5 = 21-20 = 1$.'},
  '$1$',
  1, 1, '1',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 1.2',
  new List<String>{'Vypočtěte: $2\\,000:40-(4\\cdot 13):4=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\,000:40-(4\\cdot 13):4 = 50-52:4 = 50-13 = 37$.'},
  '$37$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 1.3',
  new List<String>{'Vypočtěte: $384:16-(6+30:6)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$384:16-(6+30:6) = 24-(6+5) = 24-11 = 13$.'},
  '$13$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2026 – úloha 2',
  new List<String>{'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.','Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Před obědem jel od 7:44 do 12:02, tj. 4 hodiny 18 minut. Pauza trvala 38 minut, do auta se vrátil ve 12:40.','Zbývalo odjet ještě 7 hodin − 4 hodiny 18 minut = 2 hodiny 42 minut. Od 12:40 tedy dojel v 12:40 + 2:42 = 15:22.'},
  'V 15:22 (tj. ve 3:22 odpoledne)',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2026 – úloha 3',
  new List<String>{'V třídní knize je zapsán seznam všech 26 žáků 5. A. Žádní dva žáci v 5. A nemají stejné příjmení.','3.1 Počet žáků zapsaných v seznamu před Janem Novákem je čtyřikrát větší než počet žáků zapsaných za ním. Určete, kolik žáků je v seznamu zapsáno za Janem Novákem.','3.2 Počet žáků zapsaných v seznamu za Anežkou Klímovou je o 7 větší než počet žáků zapsaných před ní. Určete, na kolikátém místě je v seznamu zapsaná Anežka Klímová.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Kromě Jana Nováka je v seznamu $26-1 = 25$ žáků. Za ním je $x$ žáků, před ním $4x$: $4x+x = 25$, tedy $x = 5$. Za Janem Novákem je $5$ žáků.','3.2 Kromě Anežky Klímové je $25$ žáků: před ní $y$, za ní $y+7$. Platí $y+(y+7) = 25$, tedy $y = 9$. Před ní je $9$ žáků, je zapsaná na $10.$ místě.'},
  '3.1: $5$ žáků; 3.2: na $10.$ místě',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
