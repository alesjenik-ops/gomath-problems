String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M5B 2018 – úloha 1.1',
  new List<String>{'Vypočtěte: $16 \\cdot (100 + 20 + 3) - (3 + 20 + 100) \\cdot 10 + 6 \\cdot (3 + 20 + 100) - (100 + 20 + 3) \\cdot 0 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Ve všech součinech vystupuje číslo $100 + 20 + 3 = 123$. Výraz je $123 \\cdot 16 - 123 \\cdot 10 + 123 \\cdot 6 - 123 \\cdot 0 = 123 \\cdot (16 - 10 + 6) = 123 \\cdot 12 = 1\\,476$.'},
  '$1\\,476$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 1.2',
  new List<String>{'Vypočtěte: $8\\,000 : [400 : (200 : 8)] =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Postupně zevnitř: $200 : 8 = 25$, pak $400 : 25 = 16$ a nakonec $8\\,000 : 16 = 500$.'},
  '$500$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 2.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$\\frac{1}{4}$ hodiny $+\\ 300$ sekund $=\\ \\square\\ $ minut'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{4}$ hodiny $= 15$ minut a $300$ sekund $= 5$ minut; dohromady $15 + 5 = 20$ minut.'},
  '$20$',
  1, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 2.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$\\frac{1}{2}$ km $=\\ \\square\\ \\cdot\\ 20$ m'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}$ km $= 500$ m; protože $500 : 20 = 25$, je $\\frac{1}{2}$ km $= 25 \\cdot 20$ m.'},
  '$25$',
  1, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 2.3',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$1\\,500$ mm $+\\ \\square\\ $ cm $=\\ 15$ m'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1\\,500$ mm $= 150$ cm a $15$ m $= 1\\,500$ cm; do rámečku patří $1\\,500 - 150 = 1\\,350$ cm.'},
  '$1\\,350$',
  1, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2018 – úloha 3',
  new List<String>{'Jana si nahrála na několik CD všechny lekce němčiny, a to postupně od první lekce do poslední. Jednotlivá CD zaplňovala rovněž v pořadí od prvního do posledního CD. Na každém CD je stejný počet lekcí – nejméně $5$, ale nejvíce $10$. Jen jediná dvojice ze čtyř lekcí $11$, $13$, $31$ a $33$ je nahrána na stejném CD.','Určete, kolik lekcí může být na jednom CD. Uveďte všechna možná řešení.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Je-li na každém CD $n$ lekcí, leží lekce číslo $k$ na CD s pořadím $\\lceil k : n \\rceil$. Pro $n = 6$ jsou lekce $11$ a $13$ na 2. a 3. CD, ale lekce $31$ a $33$ jsou obě na 6. CD – jediná společná dvojice. Pro $n = 8$ jsou lekce $11$ a $13$ obě na 2. CD, zatímco $31$ a $33$ na 4. a 5. CD – opět jediná dvojice. Pro $n = 5, 7, 9, 10$ vyjdou pokaždé dvě společné dvojice, což zadání nevyhovuje.'},
  '$6$ lekcí; $8$ lekcí',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
