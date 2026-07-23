String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
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
  'CERMAT M7D 2024 – úloha 1',
  new List<String>{'Zapište zlomkem v základním tvaru, jakou část metru tvoří $40\\,\\%$ z poloviny metru.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$40\\,\\%$ z poloviny metru je $0{,}4\\cdot\\frac{1}{2}\\text{ m}=\\frac{2}{5}\\cdot\\frac{1}{2}\\text{ m}=\\frac{1}{5}\\text{ m}$. Hledaná část metru je $\\frac{1}{5}$.'},
  '$\\frac{1}{5}$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 2.1',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\left(\\frac{2}{3}-\\frac{2}{5}\\right)\\cdot\\left(-\\frac{7}{8}-1\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{3}-\\frac{2}{5}=\\frac{10-6}{15}=\\frac{4}{15}$ a $-\\frac{7}{8}-1=-\\frac{15}{8}$.','Součin $\\frac{4}{15}\\cdot\\left(-\\frac{15}{8}\\right)=-\\frac{4}{8}=-\\frac{1}{2}$.'},
  '$-\\frac{1}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 2.2',
  new List<String>{'Vypočítejte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\dfrac{\\frac{3}{4}\\cdot 5-\\frac{5}{6}\\cdot 3}{5}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{3}{4}\\cdot 5-\\frac{5}{6}\\cdot 3=\\frac{15}{4}-\\frac{15}{6}=\\frac{15}{4}-\\frac{5}{2}=\\frac{15-10}{4}=\\frac{5}{4}$.','Poté $\\frac{5}{4}:5=\\frac{5}{4}\\cdot\\frac{1}{5}=\\frac{1}{4}$.'},
  '$\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 3.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$6\\cdot 1{,}2+1{,}8:3=\\square$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$6\\cdot 1{,}2=7{,}2$ a $1{,}8:3=0{,}6$. Součet je $7{,}2+0{,}6=7{,}8$.'},
  '$7{,}8$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 3.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$\\square\\cdot 4=0{,}6\\cdot 50+28\\cdot 0{,}8$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pravá strana: $0{,}6\\cdot 50+28\\cdot 0{,}8=30+22{,}4=52{,}4$. Hledané číslo je $52{,}4:4=13{,}1$.'},
  '$13{,}1$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 4',
  new List<String>{'V září přivezli do skladu brambory. V říjnu je skladníci třídili. Jednu osminu z přivezených brambor vyhodili, jednu čtvrtinu z přivezených brambor vybrali na sadbu, což bylo $400$ kg, a zbytek brambor byl určen k prodeji.','4.1 Kolik kilogramů brambor přivezli v září do skladu?','4.2 Kolik kilogramů brambor skladníci vyhodili?','4.3 Kolik kilogramů brambor bylo určeno k prodeji?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Čtvrtina přivezených brambor je $400$ kg, celkem tedy přivezli $4\\cdot 400=1600$ kg.','4.2 Vyhodili osminu, tj. $\\frac{1}{8}\\cdot 1600=200$ kg.','4.3 K prodeji zbylo $1600-200-400=1000$ kg.'},
  '4.1: $1600$ kg; 4.2: $200$ kg; 4.3: $1000$ kg',
  6, 7, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2024 – úloha 5',
  new List<String>{'Sadař měl v chladírně $1$ tunu jablek určených k moštování a k prodeji do obchodů. Jablek určených k prodeji bylo třikrát více než jablek určených k moštování. Jablka určená k prodeji sadař prodával za cenu $14$ Kč za jeden kilogram a prodalo se jich $70\\,\\%$. Jablka určená k moštování sadař prodával za cenu $8$ Kč za jeden kilogram a prodalo se jich $80\\,\\%$. Neprodaná jablka se odvezla s dopravou zdarma ke zkrmení. Uveďte u obou podúloh celý postup řešení.','5.1 Kolik korun utržil sadař za svá prodaná jablka?','5.2 Kolik korun by sadař utržil za jablka odvezená ke zkrmení, kdyby je prodal?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ tuna $=1000$ kg. Poměr prodej : moštování $=3:1$, tedy k prodeji je $750$ kg a k moštování $250$ kg.','5.1 Prodáno: $70\\,\\%$ ze $750$ kg $=525$ kg za $14$ Kč $=7350$ Kč; $80\\,\\%$ z $250$ kg $=200$ kg za $8$ Kč $=1600$ Kč. Celkem $7350+1600=8950$ Kč.','5.2 Ke zkrmení: $30\\,\\%$ ze $750$ kg $=225$ kg (za $14$ Kč) $=3150$ Kč; $20\\,\\%$ z $250$ kg $=50$ kg (za $8$ Kč) $=400$ Kč. Celkem $3150+400=3550$ Kč.'},
  '5.1: $8950$ Kč; 5.2: $3550$ Kč',
  4, 8, '3',
  new List<String>{'zs2','r7','procenta','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
