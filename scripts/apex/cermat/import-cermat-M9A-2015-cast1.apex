String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M9A 2015 – úloha 1',
  new List<String>{'Vypočtěte: $20-3\\cdot (30-30:2)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve závorka: $30-30:2=30-15=15$.','Potom $20-3\\cdot 15=20-45=-25$.'},
  '$-25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 2',
  new List<String>{'Zapište zlomkem v základním tvaru jednu šestinu rozdílu $2{,}4-1{,}5$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl je $2{,}4-1{,}5=0{,}9$.','Jedna šestina: $0{,}9:6=0{,}15=\\frac{15}{100}=\\frac{3}{20}$.'},
  '$\\frac{3}{20}$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{1}{6}+\\frac{2}{3}\\cdot\\frac{9}{8}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve násobení: $\\frac{2}{3}\\cdot\\frac{9}{8}=\\frac{18}{24}=\\frac{3}{4}$.','Potom sčítání: $\\frac{1}{6}+\\frac{3}{4}=\\frac{2}{12}+\\frac{9}{12}=\\frac{11}{12}$.'},
  '$\\frac{11}{12}$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{2}{3}:\\frac{5}{2}-\\frac{2}{3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve dělení: $\\frac{2}{3}:\\frac{5}{2}=\\frac{2}{3}\\cdot\\frac{2}{5}=\\frac{4}{15}$.','Potom odčítání: $\\frac{4}{15}-\\frac{2}{3}=\\frac{4}{15}-\\frac{10}{15}=-\\frac{6}{15}=-\\frac{2}{5}$.'},
  '$-\\frac{2}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 4.1',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$2x(x-3)-(x^2+3x)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Roznásobíme: $2x(x-3)=2x^2-6x$ a odstraníme závorku se znaménkem minus: $-(x^2+3x)=-x^2-3x$.','Sečteme podobné členy: $2x^2-6x-x^2-3x=x^2-9x$.'},
  '$x^2-9x$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(2+y)(y+2-2y)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'V druhé závorce sečteme členy s $y$: $y+2-2y=2-y$.','Podle vzorce pro rozdíl druhých mocnin: $(2+y)(2-y)=4-y^2$.'},
  '$4-y^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 5',
  new List<String>{'Řešte rovnici:','$\\frac{2-x}{2}-3=\\frac{2x+1}{3}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Obě strany vynásobíme šesti: $3(2-x)-18=2(2x+1)$.','$6-3x-18=4x+2$, tedy $-3x-12=4x+2$.','$-14=7x$, odtud $x=-2$.'},
  '$x=-2$',
  3, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 6',
  new List<String>{'Turistická trasa je na mapě s měřítkem $1:50\\,000$ zobrazena čarou dlouhou $30$ cm.','6.1 Vypočtěte v km skutečnou délku turistické trasy.','6.2 Vypočtěte v cm délku čáry, která zobrazuje stejnou turistickou trasu na mapě s měřítkem $1:60\\,000$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Skutečná délka je $30\\cdot 50\\,000=1\\,500\\,000$ cm $=15\\,000$ m $=15$ km.','6.2 Na mapě $1:60\\,000$ je délka čáry $1\\,500\\,000:60\\,000=25$ cm.'},
  '6.1: $15$ km; 6.2: $25$ cm',
  4, 5, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2015 – úloha 7.1',
  new List<String>{'Vypočítejte a výsledek vyjádřete v uvedených jednotkách.','$1{,}5$ dm² $+\\,75$ mm² $=$ __________ mm²'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $1$ dm² $=10\\,000$ mm², tedy $1{,}5$ dm² $=15\\,000$ mm².','$15\\,000+75=15\\,075$ mm².'},
  '$15\\,075$ mm²',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2015 – úloha 7.2',
  new List<String>{'Vypočítejte a výsledek vyjádřete v uvedených jednotkách.','$1$ m³ $-\\,50$ litrů $=$ __________ litrů'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $1$ m³ $=1\\,000$ litrů.','$1\\,000-50=950$ litrů.'},
  '$950$ litrů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
