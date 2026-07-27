String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 1',
  new List<String>{'Vypočtěte:','$20-0{,}6\\cdot(-0{,}8)-20+(-0{,}6\\cdot 8)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$20-0{,}6\\cdot(-0{,}8)=20+0{,}48=20{,}48$.','$20{,}48-20=0{,}48$ a $-0{,}6\\cdot 8=-4{,}8$.','Celkem $0{,}48+(-4{,}8)=-4{,}32$.'},
  '$-4{,}32$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 2',
  new List<String>{'V zápisu výpočtu chybí poslední číslice u prvního čísla (tj. u dělence).','Doplňte číslici tak, aby dělení vyšlo beze zbytku, a příklad vypočtěte:','$490\\square : 12 =$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Číslo $490\\square$ musí být dělitelné 12, tedy 4 i 3 zároveň.','Dělitelnost 4: poslední dvojčíslí $0\\square$ dělitelné 4, tj. číslice $0$, $4$ nebo $8$.','Dělitelnost 3: ciferný součet $4+9+0+\\square=13+\\square$ dělitelný 3, tj. číslice $2$, $5$ nebo $8$.','Vyhovuje jediná číslice $8$: $4\\,908:12=409$.'},
  '$4\\,908:12=409$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru.','$\\frac{9}{16}:\\left(\\frac{1}{2}+\\frac{3}{4}+\\frac{5}{8}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce převedeme na osminy: $\\frac{4}{8}+\\frac{6}{8}+\\frac{5}{8}=\\frac{15}{8}$.','Dělení zlomkem: $\\frac{9}{16}:\\frac{15}{8}=\\frac{9}{16}\\cdot\\frac{8}{15}=\\frac{72}{240}=\\frac{3}{10}$.'},
  '$\\frac{3}{10}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru.','$\\frac{9\\cdot 5}{10\\cdot 6}-\\frac{9+5}{10+6}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{9\\cdot 5}{10\\cdot 6}=\\frac{45}{60}=\\frac{3}{4}$ a $\\frac{9+5}{10+6}=\\frac{14}{16}=\\frac{7}{8}$.','$\\frac{3}{4}-\\frac{7}{8}=\\frac{6}{8}-\\frac{7}{8}=-\\frac{1}{8}$.'},
  '$-\\frac{1}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 4.1',
  new List<String>{'Vypočtěte, o kolik mm více je $1{,}8$ dm než $15$ mm.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}8$ dm $=180$ mm.','$180-15=165$ mm.'},
  'o $165$ mm',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 4.2',
  new List<String>{'V cm² vypočtěte $\\frac{5}{6}$ z $0{,}48$ dm².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{6}$ z $0{,}48$ dm² $=0{,}48:6\\cdot 5=0{,}08\\cdot 5=0{,}4$ dm².','$1$ dm² $=100$ cm², tedy $0{,}4$ dm² $=40$ cm².'},
  '$40$ cm²',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2017 – úloha 5',
  new List<String>{'Kuličky v sáčku se mohou rozdělit beze zbytku rovným dílem mezi 3 děti, 4 děti a také mezi 6 dětí. Kdyby se kuličky rozdělily rovným dílem mezi 5 dětí, tři kuličky by zbyly. Do sáčku se nevejde více než 100 kuliček.','5.1 Určete počet kuliček v sáčku.','5.2 Do sáčku přidáme tolik dalších kuliček, aby se kuličky v sáčku mohly rozdělit beze zbytku rovným dílem mezi 5 dětí a také 6 dětí, nikoli však mezi 4 děti. Určete nový počet kuliček v sáčku.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Počet musí být dělitelný 3, 4 i 6, tedy je násobkem 12: $12, 24, 36, 48, 60, 72, 84, 96$.','Zbytek po dělení pěti má být 3; to splňuje jen $48$ (a $48\\le 100$).','5.2 Nový počet je dělitelný 5 i 6, tedy je násobkem 30 a je větší než 48: přichází v úvahu $60$ a $90$.','$60$ je dělitelné 4, proto nevyhovuje; $90$ dělitelné 4 není a $90\\le 100$.'},
  '5.1: $48$ kuliček; 5.2: $90$ kuliček',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
