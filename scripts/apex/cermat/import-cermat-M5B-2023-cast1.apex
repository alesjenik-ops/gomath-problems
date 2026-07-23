String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M5B 2023 – úloha 1.1',
  new List<String>{'Vypočtěte: $28-3\\cdot 2+18:2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $28-6+9=31$.'},
  '$31$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 1.2',
  new List<String>{'Vypočtěte: $(8\\cdot 125+25)\\cdot(440:20-5\\cdot 4)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(1000+25)\\cdot(22-20)=1025\\cdot 2=2050$.'},
  '$2\\,050$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 2.1',
  new List<String>{'Vypočtěte v centimetrech: $2$ m $72$ cm $-\\,520$ mm $+\\,100$ cm $=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2$ m $72$ cm $=272$ cm, $520$ mm $=52$ cm. Potom $272-52+100=320$ cm.'},
  '$320$ cm',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 2.2',
  new List<String>{'Hodiny, které jdou přesně, ukazují čas 21:42. Vypočtěte, jaký čas budou ukazovat za 212 minut.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'212 minut = 3 hodiny 32 minut. Čas 21:42 + 3:32 = 25:14; po překročení půlnoci (odečtení 24 hodin) ukazují hodiny 1:14.'},
  '1:14',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2023 – úloha 3',
  new List<String>{'Přečteme-li číslo 2 073 zprava, získáme číslo 3 702. Kladné celé číslo, které čteme zleva i zprava stejně, se nazývá palindromické číslo, např. 73 937. Určete:','3.1 nejmenší pěticiferné palindromické číslo, ve kterém se vyskytují tři různé číslice,','3.2 počet všech palindromických čísel větších než 34 643 a zároveň menších než 35 253,','3.3 nejmenší kladné číslo, jehož přičtením k palindromickému číslu 73 937 získáme opět palindromické číslo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Menší čísla $10\\,001$ a $10\\,101$ mají jen dvě různé číslice; nejmenší se třemi různými číslicemi je $10\\,201$.','3.2 Vyhovují čísla $34\\,743$, $34\\,843$, $34\\,943$, $35\\,053$, $35\\,153$, tedy $5$ čísel.','3.3 Nejbližší větší palindromické číslo za $73\\,937$ je $74\\,047$; $74\\,047-73\\,937=110$.'},
  '3.1: $10\\,201$; 3.2: $5$ palindromických čísel; 3.3: $110$',
  4, 5, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2023 – úloha 4.1',
  new List<String>{'V aquaparku je zapůjčení županu o 30 korun dražší než zapůjčení osušky. Zapůjčení 5 osušek stojí stejně jako zapůjčení 3 županů.','Vypočtěte, kolik korun stojí v aquaparku zapůjčení jednoho županu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Zapůjčení osušky $o$, županu $o+30$. Z rovnice $5o=3(o+30)$ plyne $2o=90$, tedy $o=45$. Zapůjčení jednoho županu stojí $45+30=75$ korun.'},
  '$75$ korun',
  2, 3, '3',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5B 2023 – úloha 4.2',
  new List<String>{'Na plaveckém tréninku uplavali Jirka, Míša a Pavla dohromady 60 bazénů. Míša uplavala stejný počet bazénů jako Jirka, ale dvakrát více bazénů než Pavla.','Vypočtěte, kolik bazénů uplavala na tréninku Míša.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Pavla uplavala $p$ bazénů, Míša $2p$ a Jirka také $2p$. Dohromady $2p+2p+p=5p=60$, tedy $p=12$. Míša uplavala $2\\cdot 12=24$ bazénů.'},
  '$24$ bazénů',
  2, 3, '2',
  new List<String>{'zs1','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2023 – úloha 5',
  new List<String>{'Šest kamarádů si v mobilní aplikaci posílalo různé vzkazy. Vytvořili si mezi sebou jednak všechny možné pětičlenné skupiny, jednak všechny možné dvoučlenné skupiny. Určete, kolik vytvořili:','5.1 pětičlenných skupin,','5.2 dvoučlenných skupin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Pětičlenná skupina vznikne vynecháním jednoho ze šesti kamarádů, tedy $6$ skupin.','5.2 Dvoučlenných skupin (dvojic) je $\\frac{6\\cdot 5}{2}=15$.'},
  '5.1: $6$ pětičlenných skupin; 5.2: $15$ dvoučlenných skupin',
  3, 3, '2',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
