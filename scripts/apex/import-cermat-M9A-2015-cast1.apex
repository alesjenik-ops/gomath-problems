String SRC   = 'CERMAT – Přijímací zkoušky 2015, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2015 M9 · úloha 1',
  new List<String>{'Vypočtěte:','$20-3\\cdot(30-30:2)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$30:2=15$; $30-15=15$; $3\\cdot15=45$; $20-45=-25$.'},
  '$-25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 2',
  new List<String>{'Zapište zlomkem v základním tvaru jednu šestinu rozdílu $2{,}4-1{,}5$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl $2{,}4-1{,}5=0{,}9$. Jedna šestina: $\\frac{0{,}9}{6}=0{,}15=\\frac{15}{100}=\\frac{3}{20}$.'},
  '$\\frac{3}{20}$',
  2, 3, '2',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{1}{6}+\\dfrac{2}{3}\\cdot\\dfrac{9}{8}=$','3.2 \\quad $\\dfrac{2}{3}:\\dfrac{5}{2}-\\dfrac{2}{3}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{2}{3}\\cdot\\frac{9}{8}=\\frac{18}{24}=\\frac{3}{4}$; $\\frac{1}{6}+\\frac{3}{4}=\\frac{2}{12}+\\frac{9}{12}=\\frac{11}{12}$.','3.2: $\\frac{2}{3}:\\frac{5}{2}=\\frac{2}{3}\\cdot\\frac{2}{5}=\\frac{4}{15}$; $\\frac{4}{15}-\\frac{2}{3}=\\frac{4}{15}-\\frac{10}{15}=-\\frac{6}{15}=-\\frac{2}{5}$.'},
  '3.1: $\\frac{11}{12}$; 3.2: $-\\frac{2}{5}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $2x(x-3)-(x^2+3x)=$','4.2 \\quad $(2+y)(y+2-2y)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $2x^2-6x-x^2-3x=x^2-9x$.','4.2: $(2+y)(2-y)=4-y^2$.'},
  '4.1: $x^2-9x$; 4.2: $4-y^2$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 5',
  new List<String>{'Řešte rovnici:','$\\dfrac{2-x}{2}-3=\\dfrac{2x+1}{3}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme celou rovnici $6$: $3(2-x)-18=2(2x+1)$.','$6-3x-18=4x+2$; $-12-3x=4x+2$; $-14=7x$; $x=-2$.'},
  '$x=-2$',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 6',
  new List<String>{'Turistická trasa je na mapě s měřítkem $1:50\\,000$ zobrazena čarou dlouhou $30\\ \\mathrm{cm}$.','6.1 Vypočtěte v km skutečnou délku turistické trasy.','6.2 Vypočtěte v cm délku čáry, která zobrazuje stejnou turistickou trasu na mapě s měřítkem $1:60\\,000$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: Skutečná délka $=30\\ \\mathrm{cm}\\cdot50\\,000=1\\,500\\,000\\ \\mathrm{cm}=15\\,000\\ \\mathrm{m}=15\\ \\mathrm{km}$.','6.2: $\\frac{1\\,500\\,000\\ \\mathrm{cm}}{60\\,000}=25\\ \\mathrm{cm}$.'},
  '6.1: $15\\ \\mathrm{km}$; 6.2: $25\\ \\mathrm{cm}$',
  4, 6, '3',
  new List<String>{'zs2','r9','pomer','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 7',
  new List<String>{'Vypočítejte a výsledek vyjádřete v uvedených jednotkách.','7.1 \\quad $1{,}5\\ \\mathrm{dm}^2+75\\ \\mathrm{mm}^2=\\ \\dots\\ \\mathrm{mm}^2$','7.2 \\quad $1\\ \\mathrm{m}^3-50$ litrů $=\\ \\dots$ litrů'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: $1\\ \\mathrm{dm}^2=10\\,000\\ \\mathrm{mm}^2$, tedy $1{,}5\\ \\mathrm{dm}^2=15\\,000\\ \\mathrm{mm}^2$; $15\\,000+75=15\\,075\\ \\mathrm{mm}^2$.','7.2: $1\\ \\mathrm{m}^3=1\\,000$ litrů; $1\\,000-50=950$ litrů.'},
  '7.1: $15\\,075\\ \\mathrm{mm}^2$; 7.2: $950$ litrů',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);

System.debug('Vytvořeno úloh: '+c.created);
