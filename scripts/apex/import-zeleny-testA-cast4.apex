String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený A14 – čtverec a lichoběžník',
  new List<String>{'Na obrázku je čtverec o straně $a=8$ cm a rovnoramenný lichoběžník o základnách rovných straně čtverce, resp. její jedné čtvrtině.','Jaký je poměr obsahu šedé a bílé plochy čtverce?'},
  new List<String>{'A) $3:8$','B) $5:8$','C) $3:5$','D) $5:3$','E) jiný poměr'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 370" font-family="sans-serif"> <rect x="40" y="40" width="280" height="280" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <polygon points="40,320 320,320 215,40 145,40" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <line x1="180" y1="40" x2="180" y2="320" stroke="#000" stroke-width="1.5" stroke-dasharray="7 6"/> <text x="180" y="30" font-size="18" text-anchor="middle" font-style="italic">c</text> <text x="180" y="345" font-size="18" text-anchor="middle" font-style="italic">a</text> <text x="335" y="184" font-size="18" font-style="italic">a</text> </svg>',
  'ctverec-lichobeznik.svg',
  'Čtverec o straně a se vepsaným rovnoramenným lichoběžníkem (bílým); zbytek čtverce je šedý.',
  'Čtverec se vepsaným lichoběžníkem',
  new List<String>{'Lichoběžník (bílý) má základny $a=8$ cm a $\\frac{a}{4}=2$ cm a výšku $a=8$ cm: $S_{b}=\\frac{8+2}{2}\\cdot 8=40$ cm². Čtverec má $S=64$ cm², šedá plocha $64-40=24$ cm². Poměr šedá : bílá $=24:40=3:5$.'},
  'C) $3:5$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený A15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V listopadu naše firma vyplatila na mzdách $800\\,000$ korun a v prosinci o $200\\,000$ korun víc. Současně ale v prosinci počet zaměstnanců firmy klesl ve srovnání s listopadem o jednu pětinu. O kolik $\\%$ se v prosinci zvýšila průměrná mzda ve srovnání s listopadem?','15.2 Poté, kdy obchod pana Křápka snížil cenu másla o $10\\,\\%$ a vedlejší prodejna paní Skočdopolové dokonce o celou čtvrtinu, prodávají oba máslo za stejnou cenu. O kolik $\\%$ bylo máslo před zlevněním u paní Skočdopolové dražší než u pana Křápka?','15.3 V roce 2015 se počet uchazečů o studium na naší škole meziročně snížil o desetinu. Rok na to jsme otevřeli nové obory a zájem se zvýšil proti předchozímu roku o celou polovinu. O kolik $\\%$ se zvýšil počet uchazečů v roce 2016 ve srovnání s rokem 2014?'},
  new List<String>{'A) o $20\\,\\%$','B) o $25\\,\\%$','C) o $30\\,\\%$','D) o $35\\,\\%$','E) o $50\\,\\%$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Průměrná mzda XI: $\\frac{800\\,000}{n}$; XII: $\\frac{1\\,000\\,000}{0{,}8n}=\\frac{1\\,250\\,000}{n}$. Nárůst $\\frac{1\\,250\\,000}{800\\,000}=1{,}5625$, tj. o $56{,}25\\,\\%$ → F.','15.2 $0{,}9K=0{,}75S\\Rightarrow \\frac{S}{K}=1{,}2$, máslo bylo o $20\\,\\%$ dražší → A.','15.3 $0{,}9\\cdot 1{,}5=1{,}35$, tj. nárůst o $35\\,\\%$ → D.'},
  '15.1: F (o $56{,}25\\,\\%$); 15.2: A (o $20\\,\\%$); 15.3: D (o $35\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'Zelený A16 – číselné řady',
  new List<String>{'V následujících třech příkladech 16.1–16.3 jsou čísla v číselných řadách uspořádána vždy podle nějakého pravidla. V každé řadě však dvě z čísel chybí a jsou na jejich místě symboly ■ a ■■. Nahraďte symboly ■ a ■■ čísly odpovídajícími pravidlu příslušné řady.','16.1  ■ … $5$ … $10$ … $8$ … $16$ … ■■ … $28$ … $26$ … $52$','16.2  $1$ … $1$ … $2$ … $3$ … $5$ … $8$ … ■ … ■■ … $34$ … $55$ … $89$','16.3  $123$ … $35$ … $234$ … $57$ … $345$ … ■ … $456$ … $911$ … ■■'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 Operace se pravidelně střídají $-2$ a $\\times 2$: $7\\;(-2)\\;5\\;(\\times 2)\\;10\\;(-2)\\;8\\;(\\times 2)\\;16\\;(-2)\\;14\\;(\\times 2)\\;28\\;(-2)\\;26\\;(\\times 2)\\;52$. Proto ■ $=7$ a ■■ $=14$.','16.2 Fibonacciova posloupnost: každé číslo je součtem dvou předchozích. $8+5=13$, $13+8=21$. ■ $=13$, ■■ $=21$.','16.3 Na lichých místech jsou trojice po sobě jdoucích číslic $123,\\ 234,\\ 345,\\ 456,\\ 567$ → ■■ $=567$. Na sudých místech jsou spojená po sobě jdoucí lichá čísla ($3$–$5$, $5$–$7$, $7$–$9$, $9$–$11$), tj. $35,\\ 57,\\ 79,\\ 911$ → ■ $=79$.'},
  '16.1: ■ $=7$, ■■ $=14$; 16.2: ■ $=13$, ■■ $=21$; 16.3: ■ $=79$, ■■ $=567$',
  6, 8, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
