String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)';
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
  'CERMAT 2025 M9B · úloha 1',
  new List<String>{'Cena dětské vstupenky do muzea je rovna dvěma pětinám ceny vstupenky pro dospělého. Jeden dospělý se třemi dětmi zaplatil za vstupenky $330$ korun.','Vypočtěte v korunách cenu jedné dětské vstupenky.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je cena dospělé vstupenky $d$; dětská je $\\frac{2}{5}d$.','$d+3\\cdot\\frac{2}{5}d=\\frac{11}{5}d=330\\Rightarrow d=150$; dětská $\\frac{2}{5}\\cdot150=60$ korun.'},
  '$60$ korun',
  1, 2, '2',
  new List<String>{'zs2','r9','zlomky','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 2',
  new List<String>{'Vypočtěte druhou odmocninu ze součinu smíšených čísel $6\\tfrac{1}{4}$ a $2\\tfrac{7}{9}$. Výsledek zapište zlomkem v základním tvaru.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$6\\tfrac{1}{4}=\\frac{25}{4}$, $2\\tfrac{7}{9}=\\frac{25}{9}$; součin $\\frac{625}{36}$.','$\\sqrt{\\frac{625}{36}}=\\frac{25}{6}$.'},
  '$\\frac{25}{6}$',
  1, 2, '3',
  new List<String>{'zs2','r9','zlomky','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\left(\\dfrac{11}{5}-\\dfrac{11}{6}\\right):\\left(-\\dfrac{1}{3}\\right)=$','3.2 \\quad $\\dfrac{20-\\sqrt{4\\cdot3^2}}{3\\cdot\\sqrt{100-64}}:\\dfrac{4+3}{4\\cdot3}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{11}{5}-\\frac{11}{6}=\\frac{66-55}{30}=\\frac{11}{30}$; $\\frac{11}{30}:\\left(-\\frac{1}{3}\\right)=-\\frac{11}{10}$.','3.2: $\\frac{20-\\sqrt{36}}{3\\sqrt{36}}=\\frac{14}{18}=\\frac{7}{9}$; $\\frac{4+3}{4\\cdot3}=\\frac{7}{12}$; $\\frac{7}{9}:\\frac{7}{12}=\\frac{12}{9}=\\frac{4}{3}$.'},
  '3.1: $-\\frac{11}{10}$; 3.2: $\\frac{4}{3}$',
  3, 5, '3',
  new List<String>{'zs2','r9','zlomky','mocniny-odmocniny','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 4',
  new List<String>{'4.1 Upravte na co nejjednodušší tvar bez závorek: $x\\cdot3x-2x\\cdot3-(x-3)^2=$','4.2 Upravte a výsledný výraz rozložte na součin vytknutím: $(2k)^2-k\\cdot(1+2k)=$','4.3 Upravte na co nejjednodušší tvar bez závorek: $7a\\cdot(a+3)+2\\cdot(1-3a)\\cdot(a+5)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $3x^2-6x-(x^2-6x+9)=3x^2-6x-x^2+6x-9=2x^2-9$.','4.2: $4k^2-k-2k^2=2k^2-k=k\\cdot(2k-1)$.','4.3: $7a^2+21a+2(-3a^2-14a+5)=7a^2+21a-6a^2-28a+10=a^2-7a+10$.'},
  '4.1: $2x^2-9$; 4.2: $k\\cdot(2k-1)$; 4.3: $a^2-7a+10$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 5',
  new List<String>{'Řešte:','5.1 \\quad $\\dfrac{7}{12}x+2\\cdot\\left(\\dfrac{3}{8}x-1\\right)=-3\\cdot\\left(\\dfrac{x}{9}+1\\right)$','5.2 \\quad soustavu rovnic $\\begin{aligned}6x+y&=14\\\\ 3x+2y&=1\\end{aligned}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $\\frac{7}{12}x+\\frac{3}{4}x-2=-\\frac{x}{3}-3$; vynásobením $12$: $7x+9x-24=-4x-36\\Rightarrow 20x=-12\\Rightarrow x=-\\frac{3}{5}$.','5.2: z první $y=14-6x$; $3x+2(14-6x)=1\\Rightarrow -9x=-27\\Rightarrow x=3$, $y=-4$.'},
  '5.1: $x=-\\frac{3}{5}$; 5.2: $x=3$, $y=-4$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','soustava','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 6',
  new List<String>{'Číslo $231$ lze rozložit na součin tří prvočísel $a\\cdot b\\cdot c$.','6.1 Určete nejmenší z prvočísel $a$, $b$, $c$.','6.2 Určete součet všech tří prvočísel $a+b+c$.','6.3 Určete největší dvojciferné číslo, které je dělitelem čísla $231$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$231=3\\cdot7\\cdot11$.','6.1: nejmenší prvočíslo je $3$.','6.2: $3+7+11=21$.','6.3: dělitelé $231$ jsou $1,3,7,11,21,33,77,231$; největší dvojciferný je $77$.'},
  '6.1: $3$; 6.2: $21$; 6.3: $77$',
  3, 4, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
