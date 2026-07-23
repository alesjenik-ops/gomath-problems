String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
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
  'CERMAT M9D 2024 – úloha 1',
  new List<String>{'Adam a Naďa šli spolu z Heraltic do Hvězdoňovic trasou dlouhou $2{,}7$ km. Adam má délku každého kroku $75$ cm, Naďa má každý krok dlouhý $60$ cm.','O kolik kroků udělala Naďa více?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Trasa $2{,}7$ km $=270\\,000$ cm. Adam: $270\\,000:75=3600$ kroků. Naďa: $270\\,000:60=4500$ kroků. Rozdíl je $4500-3600=900$ kroků.'},
  '$900$ kroků',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2024 – úloha 2',
  new List<String>{'Reproduktory byly před Vánocemi zlevněny z původní ceny o $150$ korun, což bylo $15\\,\\%$ původní ceny. Po Vánocích je prodejce zlevnil ještě o $200$ korun z nové ceny.','O kolik procent byla konečná cena nižší než cena původní?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$150$ korun je $15\\,\\%$ původní ceny, tedy původní cena $=150:0{,}15=1000$ korun. Po prvním zlevnění $1000-150=850$ korun, po druhém $850-200=650$ korun. Konečná cena je o $1000-650=350$ korun nižší, což je $\\frac{350}{1000}=35\\,\\%$.'},
  '$35\\,\\%$',
  2, 3, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9D 2024 – úloha 3.1',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\left(\\frac{1}{6}-\\frac{1}{3}\\right):\\left(-\\frac{5}{3}\\right)}{0{,}3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{6}-\\frac{1}{3}=-\\frac{1}{6}$. Dále $\\left(-\\frac{1}{6}\\right):\\left(-\\frac{5}{3}\\right)=\\frac{1}{6}\\cdot\\frac{3}{5}=\\frac{1}{10}$. Nakonec $\\frac{1}{10}:0{,}3=\\frac{1}{10}:\\frac{3}{10}=\\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 3.2',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru.','$\\frac{1}{6}+\\frac{1}{3}\\cdot\\left(\\frac{2}{5}-1\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{5}-1=-\\frac{3}{5}$. Dále $\\frac{1}{3}\\cdot\\left(-\\frac{3}{5}\\right)=-\\frac{1}{5}$. Nakonec $\\frac{1}{6}-\\frac{1}{5}=\\frac{5}{30}-\\frac{6}{30}=-\\frac{1}{30}$.'},
  '$-\\frac{1}{30}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím:','$a\\cdot(-a)-2^2\\cdot 3a+6a^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$a\\cdot(-a)-2^2\\cdot 3a+6a^2=-a^2-12a+6a^2=5a^2-12a=a(5a-12)$.'},
  '$a(5a-12)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 4.2',
  new List<String>{'Umocněte a zjednodušte:','$\\left(\\frac{1}{3}-4b\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\frac{1}{3}-4b\\right)^2=\\left(\\frac{1}{3}\\right)^2-2\\cdot\\frac{1}{3}\\cdot 4b+(4b)^2=\\frac{1}{9}-\\frac{8}{3}b+16b^2$.'},
  '$\\frac{1}{9}-\\frac{8}{3}b+16b^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 4.3',
  new List<String>{'Upravte výraz tak, aby neobsahoval závorky, a zjednodušte:','$(2x+3)^2-x\\cdot 6-4\\cdot(x-1)^2=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(2x+3)^2=4x^2+12x+9$ a $4\\cdot(x-1)^2=4x^2-8x+4$. Dosazením: $4x^2+12x+9-6x-(4x^2-8x+4)=14x+5$.'},
  '$14x+5$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 5.1',
  new List<String>{'Řešte rovnici (zkoušku nezapisujte):','$x-\\frac{x-2}{2}=\\frac{2x}{3}-2$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme rovnici číslem $6$: $6x-3(x-2)=4x-12$, tj. $6x-3x+6=4x-12$, $3x+6=4x-12$, odtud $x=18$.'},
  '$x=18$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2024 – úloha 5.2',
  new List<String>{'Řešte rovnici (zkoušku nezapisujte):','$2\\cdot(3x-2{,}5)=-5+3\\cdot(3x-2)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$6x-5=-5+9x-6$, tj. $6x-5=9x-11$, $6=3x$, odtud $x=2$.'},
  '$x=2$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
