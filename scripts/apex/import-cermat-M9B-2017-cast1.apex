String SRC   = 'CERMAT – Jednotná přijímací zkouška 2017, 2. řádný termín (M9B)';
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
  'CERMAT 2017 M9B · úloha 1',
  new List<String>{'Určete číslo, které musíme odečíst od výrazu $\\sqrt{1+\\dfrac{9}{16}}$, abychom získali výsledek $0{,}5$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{1+\\frac{9}{16}}=\\sqrt{\\frac{25}{16}}=\\frac{5}{4}=1{,}25$; hledané číslo je $1{,}25-0{,}5=0{,}75=\\frac{3}{4}$.'},
  '$\\frac{3}{4}$ (tj. $0{,}75$)',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','zlomky','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $0{,}5:0{,}5^2=$','2.2 \\quad $6\\cdot\\dfrac{-15-6\\cdot(-2)}{2}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $0{,}5:0{,}25=2$.','2.2: čitatel $-15-6\\cdot(-2)=-15+12=-3$; $6\\cdot\\frac{-3}{2}=6\\cdot(-1{,}5)=-9$.'},
  '2.1: $2$; 2.2: $-9$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $2-\\dfrac{1}{3}-\\dfrac{1}{6}\\cdot\\dfrac{16}{3}=$','3.2 \\quad $\\dfrac{\\frac{7}{10}-\\frac{2}{5}:\\frac{1}{10}}{20\\cdot\\frac{3}{10}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{1}{6}\\cdot\\frac{16}{3}=\\frac{16}{18}=\\frac{8}{9}$; $2-\\frac{1}{3}-\\frac{8}{9}=\\frac{18-3-8}{9}=\\frac{7}{9}$.','3.2: čitatel $\\frac{7}{10}-\\frac{2}{5}:\\frac{1}{10}=\\frac{7}{10}-\\frac{2}{5}\\cdot10=\\frac{7}{10}-4=-\\frac{33}{10}$; jmenovatel $20\\cdot\\frac{3}{10}=6$; $-\\frac{33}{10}:6=-\\frac{33}{60}=-\\frac{11}{20}$.'},
  '3.1: $\\frac{7}{9}$; 3.2: $-\\frac{11}{20}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $(x-4)^2+(8-2x)\\cdot2x=$','4.2 \\quad $(a+2a)\\cdot(a-2a)-(a-2a)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(x-4)^2=x^2-8x+16$; $(8-2x)\\cdot2x=16x-4x^2$; součet $x^2-8x+16+16x-4x^2=-3x^2+8x+16$.','4.2: $(a+2a)=3a$, $(a-2a)=-a$; $3a\\cdot(-a)-(-a)=-3a^2+a=a-3a^2$.'},
  '4.1: $-3x^2+8x+16$; 4.2: $a-3a^2$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $4x+1=4\\cdot(4x+0{,}25)$','5.2 \\quad $\\dfrac{x-5}{2}+x=\\dfrac{2x}{3}-\\dfrac{5}{6}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $4x+1=16x+1\\Rightarrow4x=16x\\Rightarrow12x=0\\Rightarrow x=0$.','5.2: vynásobíme $6$: $3(x-5)+6x=4x-5\\Rightarrow3x-15+6x=4x-5\\Rightarrow9x-15=4x-5\\Rightarrow5x=10\\Rightarrow x=2$.'},
  '5.1: $x=0$; 5.2: $x=2$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD17C0T02', 2017
);
c.add(
  'CERMAT 2017 M9B · úloha 6',
  new List<String>{'V promítacím sále bylo přítomno $100$ platících osob. Cena vstupenky pro dospělého je $200$ Kč, pro dítě $150$ Kč. V pokladně vybrali za vstupenky $16\\,000$ Kč.','6.1 Vypočtěte, o kolik procent je vstupenka pro dítě levnější než vstupenka pro dospělého.','6.2 Vypočtěte, kolik dětí bylo v promítacím sále.','6.3 Vypočtěte, kolik Kč vybrali v pokladně za vstupné pro dospělé.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: $\\frac{200-150}{200}=\\frac{50}{200}=0{,}25=25\\ \\%$.','6.2: je-li $d$ počet dětí, pak $200\\cdot(100-d)+150d=16\\,000\\Rightarrow20\\,000-50d=16\\,000\\Rightarrow50d=4\\,000\\Rightarrow d=80$ dětí.','6.3: dospělých bylo $100-80=20$; za dospělé vybrali $20\\cdot200=4\\,000$ Kč.'},
  '6.1: o $25\\ \\%$; 6.2: $80$ dětí; 6.3: $4\\,000$ Kč',
  4, 6, '3',
  new List<String>{'zs2','r9','procenta','rovnice','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PBD17C0T02', 2017
);

System.debug('Vytvořeno úloh: '+c.created);
