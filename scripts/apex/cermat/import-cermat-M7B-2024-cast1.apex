String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M7B 2024 - uloha 1',
  new List<String>{'Vypocitejte v litrech ctyri petiny z $8$ hektolitru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$8$ hektolitru $= 800$ litru, ctyri petiny z toho: $\\frac{4}{5}\\cdot 800 = 640$ litru.'},
  '$640$ litru',
  1, 2, '1',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 2.1',
  new List<String>{'Vypocitejte (uvedte cely postup reseni): $4\\cdot(-5\\cdot 3)-24:(-0{,}2+1)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$4\\cdot(-15)-24:0{,}8 = -60-30 = -90$.'},
  '$-90$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 2.2',
  new List<String>{'Vypocitejte (uvedte cely postup reseni): $\\frac{2}{0{,}02}:100-0{,}4\\cdot 25=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$100:100-10 = 1-10 = -9$.'},
  '$-9$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 3.1',
  new List<String>{'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru: $\\left(\\frac{11}{12}-\\frac{3}{4}\\right)-\\left(\\frac{7}{8}-\\frac{5}{6}\\right)=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\frac{11}{12}-\\frac{9}{12}\\right)-\\left(\\frac{21}{24}-\\frac{20}{24}\\right)=\\frac{2}{12}-\\frac{1}{24}=\\frac{4}{24}-\\frac{1}{24}=\\frac{3}{24}=\\frac{1}{8}$.'},
  '$\\frac{1}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 3.2',
  new List<String>{'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru: $\\dfrac{3\\cdot\\frac{4}{9}-\\frac{2}{3}}{\\frac{5}{6}+\\frac{3}{4}+\\frac{1}{12}}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $3\\cdot\\frac{4}{9}-\\frac{2}{3}=\\frac{4}{3}-\\frac{2}{3}=\\frac{2}{3}$. Jmenovatel: $\\frac{5}{6}+\\frac{3}{4}+\\frac{1}{12}=\\frac{10+9+1}{12}=\\frac{20}{12}=\\frac{5}{3}$. Podil: $\\frac{2}{3}:\\frac{5}{3}=\\frac{2}{5}$.'},
  '$\\frac{2}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 4.1',
  new List<String>{'Petr, Jirka a Adam spolecne natreli cely plot kolem skolniho hriste. Petr nejprve natrel jednu ctvrtinu, Jirka dve tretiny toho, co zbylo, a nakonec Adam poslednich $150$ metru. Jak dlouhy byl plot kolem hriste v metrech?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Po Petrovi zbyvaji $\\frac{3}{4}$ plotu. Jirka natrel $\\frac{2}{3}\\cdot\\frac{3}{4}=\\frac{1}{2}$ plotu. Zbyva $\\frac{3}{4}-\\frac{1}{2}=\\frac{1}{4}$, coz natrel Adam ($150$ m). Cely plot: $4\\cdot 150 = 600$ m.'},
  '$600$ m',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2024 - uloha 4.2',
  new List<String>{'Kdyz nezname cislo vynasobime ctyrmi, dostaneme stejne cislo, jako kdyz vydelime ctyrmi cislo $256$. Urcete nezname cislo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$4x = 256:4 = 64$, tedy $x = 16$.'},
  '$16$',
  2, 2, '2',
  new List<String>{'zs2','r7','rovnice','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 5',
  new List<String>{'Pani Stastna chysta krabicky s vanocnim cukrovim. Do kazde krabicky dava $300$ g cukrovi. Uz rozdelila ctyri petiny napeceneho cukrovi a zbyva ji $1{,}2$ kg. Pani Vesela napekla o jednu polovinu vice cukrovi nez pani Stastna a chysta krabicky po $500$ g.','5.1 Kolik krabicek nachystala pani Stastna?','5.2 Kolik krabicek nachystala pani Vesela?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Zbylych $1{,}2$ kg je jedna petina cukrovi pani Stastne, celkem tedy napekla $5\\cdot 1{,}2 = 6$ kg $= 6000$ g.','5.1 Pocet krabicek: $6000:300 = 20$.','5.2 Pani Vesela napekla $6\\cdot 1{,}5 = 9$ kg $= 9000$ g, krabicek: $9000:500 = 18$.'},
  '5.1: $20$ krabicek; 5.2: $18$ krabicek',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
