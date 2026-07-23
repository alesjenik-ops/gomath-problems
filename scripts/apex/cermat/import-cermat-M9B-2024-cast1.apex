String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD24C0T02';
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
  'CERMAT M9B 2024 - uloha 1',
  new List<String>{'Josef ma delku kroku $75$ cm, Nada ma krok dlouhy $60$ cm. Josef i Nada kazdy usli $10\\,000$ kroku.','O kolik kilometru usel Josef vice nez Nada?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Josef: $75 \\cdot 10\\,000 = 750\\,000$ cm $=7{,}5$ km. Nada: $60 \\cdot 10\\,000 = 600\\,000$ cm $=6$ km. Rozdil: $7{,}5-6=1{,}5$ km.'},
  '$1{,}5$ km',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2024 - uloha 2',
  new List<String>{'Adam a Ota jdou z mista $A$ do mista $C$. Kazdy jde jinou cestou tak, jak je vyznaceno na obrazku. Adam jde z mista $A$ do mista $C$ po rovnych silnicich pres misto $B$, Ota jde zkratkou primo z $A$ do $C$. Strana $AB$ meri $40$ m, strana $BC$ meri $30$ m a uhel u vrcholu $B$ je pravy.','O kolik procent je Adamova cesta delsi nez cesta, kterou jde Ota?'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 380 280" font-family="sans-serif"> <rect x="70" y="50" width="240" height="160" fill="#e2e2e2" stroke="#000" stroke-width="2"/> <line x1="70" y1="210" x2="310" y2="50" stroke="#000" stroke-width="2"/> <rect x="294" y="194" width="16" height="16" fill="none" stroke="#000"/> <text x="56" y="226" font-size="16" font-style="italic">A</text> <text x="308" y="228" font-size="16" font-style="italic">B</text> <text x="314" y="46" font-size="16" font-style="italic">C</text> <text x="190" y="228" font-size="14" text-anchor="middle">40 m</text> <text x="320" y="134" font-size="14">30 m</text> <text x="150" y="120" font-size="14">Ota</text> <text x="205" y="202" font-size="14">Adam</text> </svg>',
  'cesta-adam-ota.svg',
  'Obdelnikova mapa: Adam jde z A pres B do C po stranach 40 m a 30 m s pravym uhlem u B, Ota jde primo z A do C po uhlopricce.',
  'Cesty Adama a Oty (schematicky nakres)',
  new List<String>{'Otova cesta (uhlopricka): $\\sqrt{40^2+30^2}=\\sqrt{2500}=50$ m. Adamova cesta: $40+30=70$ m. Pomer $\\frac{70}{50}=1{,}4$, Adamova cesta je tedy o $40\\,\\%$ delsi.'},
  'o $40\\,\\%$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2024 - uloha 3.1',
  new List<String>{'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru. Uvedte cely postup reseni.','$\\left(\\frac{3}{4}+\\frac{4}{3}\\right)\\cdot\\left(\\frac{2}{3}-\\frac{6}{5}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{4}+\\frac{4}{3}=\\frac{9+16}{12}=\\frac{25}{12}$, $\\frac{2}{3}-\\frac{6}{5}=\\frac{10-18}{15}=-\\frac{8}{15}$. Soucin: $\\frac{25}{12}\\cdot\\left(-\\frac{8}{15}\\right)=-\\frac{200}{180}=-\\frac{10}{9}$.'},
  '$-\\frac{10}{9}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 3.2',
  new List<String>{'Vypocitejte a vysledek zapiste zlomkem v zakladnim tvaru. Uvedte cely postup reseni.','$\\frac{\\frac{5}{9}-\\frac{3}{2}:\\frac{3}{5}}{\\frac{2}{3}+\\frac{1}{6}-\\frac{7}{12}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $\\frac{5}{9}-\\frac{3}{2}:\\frac{3}{5}=\\frac{5}{9}-\\frac{3}{2}\\cdot\\frac{5}{3}=\\frac{5}{9}-\\frac{5}{2}=\\frac{10-45}{18}=-\\frac{35}{18}$. Jmenovatel: $\\frac{2}{3}+\\frac{1}{6}-\\frac{7}{12}=\\frac{8+2-7}{12}=\\frac{3}{12}=\\frac{1}{4}$. Podil: $-\\frac{35}{18}:\\frac{1}{4}=-\\frac{35}{18}\\cdot 4=-\\frac{70}{9}$.'},
  '$-\\frac{70}{9}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 4.1',
  new List<String>{'Umocnete:','$(-3-2x)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle vzorce $(a+b)^2=a^2+2ab+b^2$ s $a=-3$ a $b=-2x$: $9+12x+4x^2$.'},
  '$9+12x+4x^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 4.2',
  new List<String>{'Upravte a rozlozte na soucin podle vzorce:','$6\\,400-(x^2-3\\,600)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$6\\,400-(x^2-3\\,600)=6\\,400-x^2+3\\,600=10\\,000-x^2=(100-x)\\cdot(100+x)$.'},
  '$(100-x)\\cdot(100+x)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2024 - uloha 4.3',
  new List<String>{'Zjednoduste (vysledny vyraz nesmi obsahovat zavorky). Uvedte cely postup reseni.','$(3x+1)^2-x\\cdot 7x-(2x-5)\\cdot(x+4)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(3x+1)^2=9x^2+6x+1$; $x\\cdot 7x=7x^2$; $(2x-5)(x+4)=2x^2+3x-20$. Celkem: $9x^2+6x+1-7x^2-(2x^2+3x-20)=3x+21$.'},
  '$3x+21$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
