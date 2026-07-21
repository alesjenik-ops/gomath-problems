String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)';
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
  'CERMAT 2021 M9B · úloha 15',
  new List<String>{'Mezi třemi sloupy A, B, C jsou uchycena lana. Délka lana uchyceného mezi dvěma sloupy je vždy o $20\\ \\%$ větší než vzdálenost těchto sloupů. Vzdálenost sloupů A, B je $20\\ \\mathrm{m}$. Délka lana mezi sloupy A, C je $36\\ \\mathrm{m}$. Vzdálenost sloupů B, C je o $20\\ \\%$ menší než vzdálenost sloupů A, B.','Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).','15.1 \\quad Jaká je délka lana mezi sloupy A, B?','15.2 \\quad Jaká je vzdálenost sloupů A, C?','15.3 \\quad Jaká je délka lana mezi sloupy B, C?','Nabídka: A) $19{,}2\\ \\mathrm{m}$; B) $20\\ \\mathrm{m}$; C) $24\\ \\mathrm{m}$; D) $28{,}8\\ \\mathrm{m}$; E) $30\\ \\mathrm{m}$; F) jiná.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: lano AB $=1{,}2\\cdot20=24\\ \\mathrm{m}$ — \\textbf{C}.','15.2: vzdálenost AC $=\\frac{36}{1{,}2}=30\\ \\mathrm{m}$ — \\textbf{E}.','15.3: vzdálenost BC $=0{,}8\\cdot20=16\\ \\mathrm{m}$, lano BC $=1{,}2\\cdot16=19{,}2\\ \\mathrm{m}$ — \\textbf{A}.'},
  '15.1: C; 15.2: E; 15.3: A',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','prirazovani','slovni','bezny-zivot','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 16',
  new List<String>{'První čtverec má obvod $60\\ \\mathrm{cm}$. Každý další čtverec je sestaven z několika shodných obdélníků, přičemž každý z těchto obdélníků má obvod $60\\ \\mathrm{cm}$. Druhý čtverec je sestaven ze dvou shodných obdélníků, třetí ze tří shodných (užších) obdélníků, čtvrtý ze čtyř shodných (ještě užších) obdélníků atd. (viz obrázek; strana druhého čtverce měří $20\\ \\mathrm{cm}$).','16.1 \\quad Vypočtěte v cm délku strany třetího čtverce.','16.2 \\quad Vypočtěte v cm obvod devátého čtverce.','16.3 \\quad Určete, kolikátý čtverec má stranu délky $28\\ \\mathrm{cm}$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 315 117"><path d="M4 18L55 18L55 69L4 69ZM123 18L157 18L157 86L123 86ZM89 18L123 18L123 86L89 86ZM217 18L242 18L242 95L217 95ZM191 18L217 18L217 95L191 95ZM242 18L268 18L268 95L242 95Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M157 89C157 91 155 93 152 93L128 93C125 93 123 95 123 98C123 95 121 93 118 93L94 93C91 93 89 91 89 89" style="fill:none;stroke:#000000;stroke-width:1"/><text x="31" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. čtverec</text><text x="123" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. čtverec</text><text x="231" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. čtverec</text><text x="305" y="63" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="124" y="111" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">20 cm</text></svg>',
  'obr.svg',
  'Posloupnost čtverců: 1. čtverec (jeden čtverec), 2. čtverec (dva svislé obdélníky, šířka 20 cm), 3. čtverec (tři svislé obdélníky) a tři tečky naznačující pokračování.',
  '',
  new List<String>{'$n$-tý čtverec je složen z $n$ svislých obdélníků o šířce $\\frac{s_n}{n}$ a výšce $s_n$; každý má obvod $2\\left(\\frac{s_n}{n}+s_n\\right)=60$, tedy $s_n\\cdot\\frac{n+1}{n}=30$ a $s_n=\\frac{30n}{n+1}$.','16.1: $s_3=\\frac{30\\cdot3}{4}=22{,}5\\ \\mathrm{cm}$.','16.2: $s_9=\\frac{30\\cdot9}{10}=27\\ \\mathrm{cm}$, obvod $=4\\cdot27=108\\ \\mathrm{cm}$.','16.3: $\\frac{30n}{n+1}=28\\Rightarrow30n=28n+28\\Rightarrow n=14$ — čtrnáctý čtverec.'},
  '16.1: $22{,}5\\ \\mathrm{cm}$; 16.2: $108\\ \\mathrm{cm}$; 16.3: $14.$ čtverec',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','obvod','vypocet','slovni','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
