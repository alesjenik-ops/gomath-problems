String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 2. řádný termín (M9B)';
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
  'CERMAT 2023 M9B · úloha 1',
  new List<String>{'Vypočtěte: $\\sqrt{(-5)^2}-3^2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{25}-9=5-9=-4$.'},
  '$-4$',
  1, 2, '3',
  new List<String>{'zs2','r9','mocniny-odmocniny','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 2',
  new List<String>{'Třídenní lyžařská permanentka je o $150\\ \\%$ dražší než jednodenní; jednodenní stojí $600$ korun.','2.1 Kolikrát více se zaplatí za třídenní permanentku než za jednodenní?','2.2 O kolik korun jsou $3$ jednodenní permanentky dražší než $1$ třídenní?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Třídenní $=600\\cdot(1+1{,}5)=600\\cdot2{,}5=1\\,500$ korun.','2.1: $2{,}5$krát více.','2.2: $3\\cdot600-1\\,500=1\\,800-1\\,500=300$ korun.'},
  '2.1: $2{,}5$krát; 2.2: o $300$ korun',
  2, 3, '3',
  new List<String>{'zs2','r9','procenta','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{1}{3}\\cdot\\dfrac{1}{2}-\\dfrac{8}{9}=$','3.2 \\quad $\\left(2-\\dfrac{5}{6}\\right):\\dfrac{5}{3}=$','3.3 \\quad $\\dfrac{\\frac{2}{3}+\\frac{2}{7}}{\\left(\\frac{9}{14}+\\frac{3}{2}\\right)\\cdot2}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{1}{6}-\\frac{8}{9}=\\frac{3}{18}-\\frac{16}{18}=-\\frac{13}{18}$.','3.2: $\\frac{7}{6}:\\frac{5}{3}=\\frac{7}{6}\\cdot\\frac{3}{5}=\\frac{7}{10}$.','3.3: čitatel $\\frac{2}{3}+\\frac{2}{7}=\\frac{20}{21}$; jmenovatel $\\left(\\frac{9}{14}+\\frac{21}{14}\\right)\\cdot2=\\frac{30}{7}$; $\\frac{20}{21}:\\frac{30}{7}=\\frac{2}{9}$.'},
  '3.1: $-\\frac{13}{18}$; 3.2: $\\frac{7}{10}$; 3.3: $\\frac{2}{9}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 4',
  new List<String>{'4.1 Upravte a rozložte na součin vytknutím: $x\\cdot(y-3)+3\\cdot(x-2y)=$','4.2 Určete výraz, kterým je třeba vynásobit výraz $3a-4$, abychom získali $9a^2-16$.','4.3 Zjednodušte (bez závorek): $(3n+2)^2-n\\cdot(3n+4)+(2n-n)\\cdot n=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $xy-3x+3x-6y=xy-6y=y\\cdot(x-6)$.','4.2: $9a^2-16=(3a-4)(3a+4)$, tedy hledaný výraz je $3a+4$.','4.3: $(9n^2+12n+4)-(3n^2+4n)+n^2=7n^2+8n+4$.'},
  '4.1: $y\\cdot(x-6)$; 4.2: $3a+4$; 4.3: $7n^2+8n+4$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $2+0{,}5\\cdot(x-3)=0{,}4\\cdot(1{,}5x+2)$','5.2 \\quad $\\dfrac{3\\cdot(2y-1)}{6}=\\dfrac{3y+2}{8}+\\dfrac{3}{4}\\cdot\\dfrac{y-1}{6}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $2+0{,}5x-1{,}5=0{,}6x+0{,}8\\Rightarrow 0{,}5x+0{,}5=0{,}6x+0{,}8\\Rightarrow -0{,}3=0{,}1x\\Rightarrow x=-3$.','5.2: úpravou obou stran (společný jmenovatel) vychází $y=\\frac{5}{4}$.'},
  '5.1: $x=-3$; 5.2: $y=\\frac{5}{4}$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 6',
  new List<String>{'V chatě jsou zásoby masa pro $12$člennou expedici přesně na $30$ dní (každý člen spotřebuje denně stejné množství).','6.1 Za kolik dní by $12$členná expedice spotřebovala pět šestin zásob?','6.2 Kolikačlenná expedice by všechny zásoby spotřebovala za $45$ dní?','6.3 Dvě expedice společně spotřebovaly vše: první pobývala $4$ dny, druhá měla dvakrát více členů a pobývala $8$ dní. Kolik členů měla první expedice?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $12\\cdot30=360$ členodní zásob.','6.1: $\\frac{5}{6}\\cdot30=25$ dní.','6.2: $\\frac{360}{45}=8$členná expedice.','6.3: první $c$ členů: $c\\cdot4+2c\\cdot8=20c=360\\Rightarrow c=18$ členů (druhá $36$).'},
  '6.1: za $25$ dní; 6.2: $8$členná; 6.3: $18$ členů',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD23C0T02', 2023
);
c.add(
  'CERMAT 2023 M9B · úloha 7',
  new List<String>{'Cesta autobusem trvá Ondrovi dvakrát déle než rychlíkem; osobním vlakem o čtvrtinu déle než autobusem. Dobu cesty autobusem označíme $x$.','7.1 Vyjádřete výrazem, jak dlouho trvá cesta rychlíkem.','7.2 Vyjádřete výrazem, jak dlouho trvá cesta osobním vlakem.','7.3 Rychlíkem trvá cesta o $15$ minut méně než osobním vlakem. Kolik minut trvá cesta autobusem?'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: rychlík $\\frac{x}{2}$.','7.2: osobní vlak $\\frac{5}{4}x$.','7.3: $\\frac{5}{4}x-\\frac{x}{2}=\\frac{3}{4}x=15\\Rightarrow x=20$ minut.'},
  '7.1: $\\frac{1}{2}x$; 7.2: $\\frac{5}{4}x$; 7.3: $20$ minut',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD23C0T02', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
