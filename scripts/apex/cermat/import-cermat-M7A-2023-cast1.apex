String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD23C0T01';
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
  'CERMAT M7A 2023 - uloha 1',
  new List<String>{'Vypoctete, o kolik litru se lisi tri ctvrtiny z 24 litru a tretina z 12 litru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Tri ctvrtiny z $24$ litru: $\\frac{3}{4}\\cdot 24=18$ litru. Tretina z $12$ litru: $\\frac{1}{3}\\cdot 12=4$ litry. Rozdil $18-4=14$ litru.'},
  'o $14$ litru',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru (uvedte postup reseni):','$\\frac{42}{5}\\cdot\\left(\\frac{3}{14}-\\frac{5}{21}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve zavorka: $\\frac{3}{14}-\\frac{5}{21}=\\frac{9}{42}-\\frac{10}{42}=-\\frac{1}{42}$. Pak $\\frac{42}{5}\\cdot\\left(-\\frac{1}{42}\\right)=-\\frac{1}{5}$.'},
  '$-\\frac{1}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru (uvedte postup reseni):','$\\frac{\\left(\\frac{3}{4}-\\frac{1}{2}\\right):\\frac{3}{2}}{2\\cdot\\frac{5}{8}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $\\left(\\frac{3}{4}-\\frac{1}{2}\\right):\\frac{3}{2}=\\frac{1}{4}\\cdot\\frac{2}{3}=\\frac{1}{6}$. Jmenovatel: $2\\cdot\\frac{5}{8}=\\frac{5}{4}$. Celkem $\\frac{1}{6}:\\frac{5}{4}=\\frac{1}{6}\\cdot\\frac{4}{5}=\\frac{4}{30}=\\frac{2}{15}$.'},
  '$\\frac{2}{15}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2023 - uloha 3',
  new List<String>{'V rote je jeden kapitan a ma pod sebou 4 poruciky. Kazdy porucik ma pod sebou 3 sve cetare a kazdy cetar ma pod sebou 10 svych vojinu. (Dalsi osoby v rote nejsou.) Kapitan se rozhodl svolat celou rotu k nastupu. Rozkaz k nastupu se predaval tak, ze kapitan vydal rozkaz vsem porucikum, z nichz kazdy vydal tento rozkaz svym cetarum a kazdy cetar jej vydal svym vojinum. Pote cela rota nastoupila.','3.1 Vypoctete, kolik je v rote vojinu.','3.2 Vypoctete, kolik osob v rote vydalo rozkaz k nastupu.','3.3 Vypoctete, kolik osob v rote dostalo rozkaz k nastupu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Vojinu: $4\\cdot 3\\cdot 10=120$.','3.2 Rozkaz vydal kapitan, 4 porucici a $4\\cdot 3=12$ cetaru: $1+4+12=17$ osob.','3.3 Rozkaz dostali porucici, cetari a vojini: $4+12+120=136$ osob.'},
  '3.1: $120$ vojinu; 3.2: $17$ osob; 3.3: $136$ osob',
  3, 4, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2023 - uloha 4',
  new List<String>{'Zaci mohli behem sportovniho dne bud plavat, nebo hrat jednu ze tri micovych her - volejbal, fotbal ci vybijenou. Nektere udaje jsou v tabulce: volejbal hralo 28 zaku, fotbal 16 zaku, vybijenou neznamy pocet zaku a plavani zvolilo 30 zaku.','4.1 Aritmeticky prumer poctu zaku, kteri hrali jednotlive micove hry, byl 21. Vypoctete, kolik zaku hralo vybijenou.','4.2 Na plavani bylo 1,5krat vice chlapcu nez divek. Urcete, jaky byl na plavani pomer poctu divek ku poctu chlapcu. Pomer uvedte v zakladnim tvaru.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 $\\frac{28+16+x}{3}=21\\Rightarrow 44+x=63\\Rightarrow x=19$ zaku.','4.2 Chlapcu bylo $1{,}5$krat vice nez divek, tedy divky : chlapci $=1:1{,}5=2:3$.'},
  '4.1: $19$ zaku; 4.2: $2:3$',
  4, 6, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2023 - uloha 5',
  new List<String>{'Jana koupila v papirnictvi nekolik stejnych linkovanych sesitu, nekolik stejnych ctvereckovanych sesitu a nekolik stejnych kruzitek.','5.1 Dva linkovane sesity a dva ctvereckovane sesity stoji dohromady 180 korun. Dva ctvereckovane sesity stoji stejne jako tri linkovane. Vypoctete, kolik korun stoji jeden ctvereckovany sesit.','5.2 K nakupu sesti kruzitek chybelo Jane 160 korun, proto koupila jen ctyri kruzitka a zbylo ji 100 korun. Vypoctete, kolik korun zaplatila za 4 kruzitka.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Oznacme $l$ cenu linkovaneho a $c$ cenu ctvereckovaneho sesitu. Plati $2l+2c=180$ a $2c=3l$. Dosazenim $2l+3l=180$, tj. $5l=180$, $l=36$. Pak $2c=108$, $c=54$ korun.','5.2 Oznacme $k$ cenu kruzitka a $p$ Janiny penize. $6k=p+160$ a $4k=p-100$. Odectenim $2k=260$, $k=130$. Za ctyri kruzitka $4k=520$ korun.'},
  '5.1: $54$ korun; 5.2: $520$ korun',
  4, 7, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
