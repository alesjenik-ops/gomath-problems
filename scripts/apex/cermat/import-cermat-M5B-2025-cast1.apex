String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M5B 2025 - uloha 1.1',
  new List<String>{'Kdyz nezname cislo vydelim sedmi, pak prictu cislo 3 a vysledek zdvojnasobim, dostanu cislo 20.','Urcete nezname cislo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme nezname cislo $x$. Plati $(x:7+3)\\cdot 2=20$, tedy $x:7+3=10$, $x:7=7$, a proto $x=49$.'},
  '$49$',
  1, 2, '2',
  new List<String>{'zs1','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 1.2',
  new List<String>{'Nezname cislo zvetsene o jednu jeho polovinu se rovna 198.','Urcete nezname cislo.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nezname cislo $x$ zvetsene o polovinu je $x+\\frac{x}{2}=\\frac{3}{2}x=198$, odtud $x=198\\cdot\\frac{2}{3}=132$.'},
  '$132$',
  1, 2, '2',
  new List<String>{'zs1','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 1.3',
  new List<String>{'Soucet dvou neznamych cisel je 109 a jejich rozdil je 13.','Urcete obe neznama cisla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vetsi cislo $=\\frac{109+13}{2}=61$, mensi cislo $=\\frac{109-13}{2}=48$. Hledana cisla jsou $48$ a $61$.'},
  '$48$; $61$',
  2, 3, '2',
  new List<String>{'zs1','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 2',
  new List<String>{'Doplnte do ramecku takove cislo, aby platila rovnost.','2.1 $18$ m - $15$ dm + [ ] cm = $20$ m','2.2 $4\\cdot$ [ ] g - $3$ kg = $\\frac{1}{5}$ kg','2.3 $\\frac{1}{4}$ h + [ ] s = $20$ min'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $18$ m $=1800$ cm, $15$ dm $=150$ cm, $20$ m $=2000$ cm; doplnene cislo $=2000-1800+150=350$.','2.2 $\\frac{1}{5}$ kg $=200$ g, $3$ kg $=3000$ g; $4\\cdot$ [ ] $=3000+200=3200$, doplnene cislo $=800$.','2.3 $\\frac{1}{4}$ h $=15$ min $=900$ s, $20$ min $=1200$ s; doplnene cislo $=1200-900=300$.'},
  '2.1: $350$; 2.2: $800$; 2.3: $300$',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2025 - uloha 3',
  new List<String>{'Na snurku jsme navlekali koralky. Koralky na snurce jsme rozdelili do ctyr skupin. Na pocatku snurky i za kazdou skupinou jsme vytvorili uzlik. Prvni skupina ma nejmensi pocet koralku. Kazda dalsi skupina ma 4krat vice koralku nez skupina pred ni. Ve treti skupine je 32 koralku.','3.1 Vypoctete, kolik koralku je celkem navleceno na snurce.','3.2 Urcete, kolikrat vice koralku ma ctvrta skupina nez druha skupina.','3.3 Na cele snurce se od pocatku pravidelne stridaji 4 cerne a 1 bily koralek. Vypoctete, kolik cernych koralku je ve ctvrte skupine.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Pocty koralku ve skupinach tvori geometrickou posloupnost s kvocientem $4$. Treti skupina ma $32$ koralku, proto prvni ma $32:16=2$, druha $8$, treti $32$ a ctvrta $128$ koralku.','3.1 Celkem $2+8+32+128=170$ koralku.','3.2 Ctvrta skupina ma $128$, druha $8$; $128:8=16$krat vice.','3.3 Ctvrta skupina jsou koralky na pozicich $43$ az $170$. Bile koralky jsou na pozicich delitelnych peti, tj. $45, 50, \\dots, 170$ (celkem $26$). Cernych je proto $128-26=102$.'},
  '3.1: $170$ koralku; 3.2: $16$krat; 3.3: $102$ cernych koralku',
  5, 7, '3',
  new List<String>{'zs1','posloupnosti','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2025 - uloha 4',
  new List<String>{'V restauraci byla na cely vecer zarezervovana ctvrtina vsech stolu, coz byly 4 stoly pro ctyri hosty a 5 stolu pro dva hosty.','4.1 Urcete celkovy pocet stolu v restauraci.','4.2 Ze vsech stolu v restauraci je polovina stolu pro dva hosty, tretina stolu je pro tri hosty a ostatni stoly jsou pro ctyri hosty. Vypoctete, kolik mist pro hosty je celkem u vsech stolu v restauraci.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Zarezervovano bylo $4+5=9$ stolu, coz je ctvrtina vsech; celkem tedy $4\\cdot 9=36$ stolu.','4.2 Pro dva hosty je $\\frac{1}{2}\\cdot 36=18$ stolu, pro tri hosty $\\frac{1}{3}\\cdot 36=12$ stolu, pro ctyri hosty zbyva $36-18-12=6$ stolu. Mist celkem: $18\\cdot 2+12\\cdot 3+6\\cdot 4=36+36+24=96$.'},
  '4.1: $36$ stolu; 4.2: $96$ mist',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
