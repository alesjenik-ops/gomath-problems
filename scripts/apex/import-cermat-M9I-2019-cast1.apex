String SRC   = 'CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2019 M9I · úloha 1',
  new List<String>{'Vypočtěte, o kolik je polovina čísla $2{,}5$ větší než číslo $\\dfrac{1}{2}$.','Výsledek uveďte desetinným číslem.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Polovina čísla $2{,}5$ je $1{,}25$; číslo $\\frac{1}{2}=0{,}5$.','Rozdíl $1{,}25-0{,}5=0{,}75$.'},
  '$0{,}75$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 2',
  new List<String>{'Vypočtěte:','2.1 \\quad $25{,}6:0{,}2-10^2\\cdot 0{,}029=$','2.2 \\quad $\\dfrac{\\sqrt{1{,}2^2}}{0{,}01}-\\dfrac{\\left(\\sqrt{0{,}01}\\right)^2}{10}\\cdot 3\\,600=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $25{,}6:0{,}2=128$; $10^2\\cdot 0{,}029=100\\cdot 0{,}029=2{,}9$; $128-2{,}9=125{,}1$.','2.2: $\\sqrt{1{,}2^2}=1{,}2$, tedy $\\frac{1{,}2}{0{,}01}=120$; $\\left(\\sqrt{0{,}01}\\right)^2=0{,}01$, tedy $\\frac{0{,}01}{10}\\cdot 3\\,600=0{,}001\\cdot 3\\,600=3{,}6$; $120-3{,}6=116{,}4$.'},
  '2.1: $125{,}1$; 2.2: $116{,}4$',
  2, 4, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{\\frac{1}{4}+\\frac{2}{3}}{\\left(3-\\frac{9}{4}\\right)\\cdot\\frac{8}{3}}=$','3.2 \\quad $3:\\dfrac{2\\cdot 6}{2+6}-\\dfrac{12}{3}\\cdot\\dfrac{5}{8}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $\\frac{1}{4}+\\frac{2}{3}=\\frac{3}{12}+\\frac{8}{12}=\\frac{11}{12}$; jmenovatel $\\left(3-\\frac{9}{4}\\right)\\cdot\\frac{8}{3}=\\frac{3}{4}\\cdot\\frac{8}{3}=2$; $\\frac{11}{12}:2=\\frac{11}{24}$.','3.2: $\\frac{2\\cdot 6}{2+6}=\\frac{12}{8}=\\frac{3}{2}$, tedy $3:\\frac{3}{2}=2$; $\\frac{12}{3}\\cdot\\frac{5}{8}=4\\cdot\\frac{5}{8}=\\frac{5}{2}$; $2-\\frac{5}{2}=-\\frac{1}{2}$.'},
  '3.1: $\\frac{11}{24}$; 3.2: $-\\frac{1}{2}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 4',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','4.1 \\quad $a-a^2+2-2\\cdot(a+1)\\cdot(1-a)=$','4.2 \\quad $\\left(n-\\dfrac{5}{2}\\right):2+\\left(\\dfrac{1}{2}-n\\right)^2=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $2\\cdot(a+1)(1-a)=2\\cdot(1-a^2)=2-2a^2$; $a-a^2+2-(2-2a^2)=a-a^2+2-2+2a^2=a^2+a$.','4.2: $\\left(n-\\frac{5}{2}\\right):2=\\frac{n}{2}-\\frac{5}{4}$; $\\left(\\frac{1}{2}-n\\right)^2=\\frac{1}{4}-n+n^2$; součet $\\frac{n}{2}-\\frac{5}{4}+\\frac{1}{4}-n+n^2=n^2-\\frac{n}{2}-1$.'},
  '4.1: $a^2+a$; 4.2: $n^2-\\dfrac{n}{2}-1$',
  4, 7, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $0{,}4+\\dfrac{4x}{5}-1=0{,}2x-\\dfrac{3}{2}$','5.2 \\quad $\\dfrac{3y-1}{3}-\\dfrac{5y-2}{6}=\\dfrac{3}{4}\\,y+2$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $\\frac{4x}{5}=0{,}8x$, takže $0{,}8x-0{,}6=0{,}2x-1{,}5\\Rightarrow 0{,}6x=-0{,}9\\Rightarrow x=-1{,}5=-\\frac{3}{2}$.','5.2: levá strana $\\frac{2(3y-1)-(5y-2)}{6}=\\frac{6y-2-5y+2}{6}=\\frac{y}{6}$; $\\frac{y}{6}=\\frac{3}{4}y+2$; vynásobením $12$: $2y=9y+24\\Rightarrow -7y=24\\Rightarrow y=-\\frac{24}{7}$.'},
  '5.1: $x=-\\dfrac{3}{2}$; 5.2: $y=-\\dfrac{24}{7}$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 6',
  new List<String>{'V každém z následujících výpočtů se žádná z číslic $0,1,2,3,4,5,6,7,8,9$ nesmí vyskytnout více než jedenkrát. Do každého prázdného rámečku ($\\square$) doplňte takovou číslici, aby byl výpočet správný.','6.1 \\quad $6\\;\\;3\\;-\\;\\square\\;=\\;5\\;\\;\\square$','6.2 \\quad (další možnost) \\quad $6\\;\\;3\\;-\\;\\square\\;=\\;5\\;\\;\\square$','6.3 \\quad $8\\;\\;4\\;\\;9\\;+\\;3\\;\\;\\square\\;\\;\\square\\;=\\;\\square\\;\\;\\square\\;\\;\\square\\;\\;\\square$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: výsledek je tvaru $5\\square$, tedy $63-\\square=5\\square$; volbou $\\square=9$ dostaneme $63-9=54$ (číslice $6,3,9,5,4$ jsou různé).','6.2: jiná možnost je $63-4=59$ (číslice $6,3,4,5,9$ jsou různé).','6.3: $849+3\\square\\square$ dá čtyřciferné číslo; volbou $357$ vyjde $849+357=1\\,206$ (využity všechny číslice $0$ až $9$).','Všechna ekvivalentní řešení splňující podmínky jsou možná.'},
  '6.1: $63-9=54$; 6.2: $63-4=59$; 6.3: $849+357=1\\,206$',
  3, 6, '3',
  new List<String>{'zs2','r9','aritmetika','cisla','uvazovani','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PID19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
