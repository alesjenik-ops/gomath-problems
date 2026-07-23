String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
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
  'CERMAT M7C 2023 - uloha 1',
  new List<String>{'Vypoctete, kolikrat je soucet cisel $0{,}2$ a $0{,}5$ vetsi nez jejich soucin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Soucet: $0{,}2+0{,}5=0{,}7$. Soucin: $0{,}2\\cdot 0{,}5=0{,}1$. Podil $0{,}7:0{,}1=7$, soucet je tedy $7$krat vetsi nez soucin.'},
  '$7$krat',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2023 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\left(\\dfrac{2}{7}-\\dfrac{4}{7}\\cdot 2\\right):2=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{4}{7}\\cdot 2=\\dfrac{8}{7}$, tedy $\\dfrac{2}{7}-\\dfrac{8}{7}=-\\dfrac{6}{7}$. Po deleni dvema: $-\\dfrac{6}{7}:2=-\\dfrac{6}{14}=-\\dfrac{3}{7}$.'},
  '$-\\dfrac{3}{7}$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2023 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\dfrac{\\frac{3}{4}+\\frac{4}{3}}{\\frac{5}{7}\\cdot\\frac{14}{3}}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $\\dfrac{3}{4}+\\dfrac{4}{3}=\\dfrac{9+16}{12}=\\dfrac{25}{12}$. Jmenovatel: $\\dfrac{5}{7}\\cdot\\dfrac{14}{3}=\\dfrac{10}{3}$. Podil: $\\dfrac{25}{12}:\\dfrac{10}{3}=\\dfrac{25}{12}\\cdot\\dfrac{3}{10}=\\dfrac{75}{120}=\\dfrac{5}{8}$.'},
  '$\\dfrac{5}{8}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2023 - uloha 3.1',
  new List<String>{'Adam, Beta i Cyril sbiraji karticky s pokemony. Adam jich ma o $50$ vice nez Beta a Cyril jich ma o $20$ mene nez Beta. Adam jich ma dvakrat vice nez Cyril.','Vypoctete, kolik karticek s pokemony ma Beta.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme pocet Betinych karticek $b$. Pak Adam ma $b+50$ a Cyril ma $b-20$. Z podminky $b+50=2\\cdot(b-20)$ dostaneme $b+50=2b-40$, tedy $b=90$.'},
  '$90$ karticek',
  2, 3, '2',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2023 - uloha 3.2',
  new List<String>{'V obchode prodavaji sberatelske karticky v baleních jednak po ctyrech, jednak po sedmi kartickach. Behem tydne prodali celkem $224$ karticek, pricemz baleni po ctyrech kartickach prodali o $10$ mene nez baleni po sedmi kartickach.','Vypoctete, kolik baleni sberatelskych karticek behem tydne celkem prodali.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Oznacme pocet baleni po sedmi $x$; baleni po ctyrech je pak $x-10$. Plati $7x+4(x-10)=224$, tedy $11x-40=224$, $11x=264$, $x=24$. Baleni po ctyrech je $14$. Celkem $24+14=38$ baleni.'},
  '$38$ baleni',
  2, 4, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2023 - uloha 4',
  new List<String>{'Vitek, Ondra a Rudolf jeli spolecne autem k mori. Kazdy z nich odridil cast trasy. Vitek odridil tretinu cele trasy, Ondra dve petiny cele trasy a zbytek trasy odridil Rudolf.','4.1 Vyjadrete zlomkem, jakou cast trasy odridil Rudolf.','4.2 Rudolf odridil o $60$ km mene nez Vitek. Vypoctete, kolik km merila cela trasa.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Rudolf odridil $1-\\dfrac{1}{3}-\\dfrac{2}{5}=\\dfrac{15-5-6}{15}=\\dfrac{4}{15}$ cele trasy.','4.2 Vitek odridil $\\dfrac{1}{3}=\\dfrac{5}{15}$, Rudolf $\\dfrac{4}{15}$; rozdil je $\\dfrac{1}{15}$ trasy a odpovida $60$ km. Cela trasa meri $15\\cdot 60=900$ km.'},
  '4.1: $\\dfrac{4}{15}$; 4.2: $900$ km',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2023 - uloha 5.1',
  new List<String>{'Zavodnik ubehl celou trasu za $3$ hodiny. Behem prvni hodiny ubehl tretinu cele trasy. Behem posledni hodiny ubehl jen $9$ km, coz byla ctvrtina cele trasy.','Vypoctete, kolik km ubehl zavodnik behem druhe hodiny.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Posledni hodina ($9$ km) je ctvrtina trasy, cela trasa meri $4\\cdot 9=36$ km. Prvni hodina: $\\dfrac{1}{3}\\cdot 36=12$ km. Druha hodina: $36-12-9=15$ km.'},
  '$15$ km',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
