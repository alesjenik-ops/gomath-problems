String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M5A 2017 – úloha 1.1',
  new List<String>{'Vypočtěte: $(112-112:7):6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve dělení v závorce: $112:7=16$, tedy $112-16=96$. Potom $96:6=16$.'},
  '$16$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2017 – úloha 1.2',
  new List<String>{'Vypočtěte: $9\\cdot 20-10\\cdot(6\\cdot 4-3\\cdot 8)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce: $6\\cdot 4-3\\cdot 8=24-24=0$. Dále $9\\cdot 20-10\\cdot 0=180-0=180$.'},
  '$180$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2017 – úloha 2',
  new List<String>{'Neznámé číslo zvětšené o 4 stovky a 5 desítek je rovno číslu vytvořenému ze 4 tisíců a 5 jednotek.','2.1 Vypočtěte neznámé číslo.','2.2 Číslo vytvořené ze 4 tisíců a 5 jednotek zaokrouhlete na desítky.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Číslo ze 4 tisíců a 5 jednotek je $4\\,005$. Zvětšení o 4 stovky a 5 desítek znamená přičtení $400+50=450$.','2.1 Neznámé číslo $=4\\,005-450=3\\,555$.','2.2 Číslo $4\\,005$ má na místě jednotek číslici 5, zaokrouhlujeme nahoru: $4\\,010$.'},
  '2.1: $3\\,555$; 2.2: $4\\,010$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2017 – úloha 3',
  new List<String>{'Děti hledaly inspiraci v písničkách a sestavily úlohu: Babka s dědkem sbírali jablka. Babka nasbírala 35 jablek. Kdyby z nich dala pětinu dědkovi, měli by oba stejný počet jablek.','3.1 Vypočtěte, kolik jablek by měla dát babka dědkovi, aby měli oba stejně.','3.2 Vypočtěte, kolik jablek nasbíral dědek.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Pětina z 35 je $35:5=7$ jablek.','3.2 Po darování má babka $35-7=28$ jablek a dědek jich má stejně, tedy 28. Sedm jablek ale dostal od babky, sám tedy nasbíral $28-7=21$ jablek.'},
  '3.1: $7$ jablek; 3.2: $21$ jablek',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2017 – úloha 4',
  new List<String>{'Běžec udržuje stejné tempo. První kilometr uběhl za 3 minuty a 40 sekund. Určete v minutách a sekundách dobu, za kterou by měl uběhnout vzdálenost:','4.1 $2$ km','4.2 $1\\,600$ m','Upozornění: Sekundy uvedené za minutami smí vyjadřovat pouze dobu kratší než minutu (např. zápis „7 min 110 s“ je nepřípustný).'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Jeden kilometr uběhne za $3$ min $40$ s $=220$ s.','4.1 $2$ km: $2\\cdot 220=440$ s $=7$ min $20$ s.','4.2 $1\\,600$ m $=1{,}6$ km: $220:5=44$ s na $200$ m, tedy $8\\cdot 44=352$ s $=5$ min $52$ s.'},
  '4.1: $7$ min $20$ s; 4.2: $5$ min $52$ s',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2017 – úloha 5',
  new List<String>{'Všech 29 žáků třídy je zapsáno v třídní knize podle abecedy.','5.1 Počet žáků zapsaných před Pavlem je 3krát větší než počet žáků za ním. Vypočtěte, kolik žáků je zapsáno za Pavlem.','5.2 Počet žáků zapsaných před Emou je o 6 menší než počet žáků za ní. Vypočtěte, na kolikátém místě je zapsána Ema.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Kromě sledovaného žáka zbývá $29-1=28$ žáků.','5.1 Je-li za Pavlem $x$ žáků, před ním $3x$: $x+3x=28$, tedy $4x=28$ a $x=7$.','5.2 Je-li za Emou $y$ žáků, před ní $y-6$: $y+(y-6)=28$, tedy $2y=34$ a $y=17$. Před Emou je $11$ žáků, Ema je zapsána na 12. místě.'},
  '5.1: $7$ žáků; 5.2: na $12.$ místě',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
