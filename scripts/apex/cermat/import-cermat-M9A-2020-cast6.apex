String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M9A 2020 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Roční čtenářský poplatek již zaplatilo $40\\,\\%$ všech čtenářů knihovny, a poplatek tak musí zaplatit ještě zbývajících $264$ čtenářů. Kolik čtenářů má knihovna?','15.2 Do školní družiny se přihlásilo $540$ žáků, což je o pětinu více, než činí kapacita družiny. Kolik žáků činí kapacita družiny?','15.3 Do školního tanečního kroužku chodí $25$ žáků, což je $5\\,\\%$ všech žáků školy. Kroužek juda navštěvuje $20$ žáků školy, přičemž čtvrtina z nich chodí navíc do tanečního kroužku. Kolik žáků školy nechodí ani do tanečního kroužku, ani do kroužku juda?'},
  new List<String>{'A) $400$','B) $420$','C) $440$','D) $450$','E) $460$','F) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Zbývajících $264$ čtenářů odpovídá $60\\,\\%$; $100\\,\\% = \\frac{264}{0{,}6} = 440$ → C.','15.2 $540$ je $120\\,\\%$ kapacity; kapacita $= \\frac{540}{1{,}2} = 450$ → D.','15.3 Celkem žáků $\\frac{25}{0{,}05} = 500$. Do juda chodí $20$, z toho $\\frac{1}{4}\\cdot 20 = 5$ i do tance. Aspoň jeden kroužek: $25 + 20 - 5 = 40$. Ani jeden: $500 - 40 = 460$ → E.'},
  '15.1: C ($440$); 15.2: D ($450$); 15.3: E ($460$)',
  6, 8, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2020 – úloha 16',
  new List<String>{'V počítačové hře má každé čtvercové město tyto vlastnosti: čtverečky představují domy a ve všech řadách i sloupcích je jich stejný počet; mezi každými dvěma sousedními domy prochází jedna přímá ulice spojující protější okraje města; každé dvě navzájem kolmé ulice mají společnou křižovatku. Nejmenší města (viz obrázek): $4$ domy – $2$ ulice – $1$ křižovatka; $9$ domů – $4$ ulice – $4$ křižovatky.','16.1 Určete, kolik křižovatek je ve městě se $36$ domy.','16.2 Určete, kolik ulic je ve městě se $36$ křižovatkami.','16.3 Určete, kolik domů je ve městě se $36$ ulicemi.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif"> <rect x="70" y="30" width="12" height="94" fill="#c8c8c8"/> <rect x="30" y="70" width="94" height="12" fill="#c8c8c8"/> <rect x="40" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="82" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="40" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="82" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/> <text x="77" y="150" font-size="12" text-anchor="middle">4 domy</text> <text x="77" y="166" font-size="12" text-anchor="middle">2 ulice</text> <text x="77" y="182" font-size="12" text-anchor="middle">1 křižovatka</text> <rect x="300" y="30" width="12" height="136" fill="#c8c8c8"/> <rect x="342" y="30" width="12" height="136" fill="#c8c8c8"/> <rect x="260" y="70" width="136" height="12" fill="#c8c8c8"/> <rect x="260" y="112" width="136" height="12" fill="#c8c8c8"/> <rect x="270" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="312" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="354" y="40" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="270" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="312" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="354" y="82" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="270" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="312" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="354" y="124" width="30" height="30" fill="#ffffff" stroke="#000"/> <text x="327" y="180" font-size="12" text-anchor="middle">9 domů</text> <text x="327" y="196" font-size="12" text-anchor="middle">4 ulice, 4 křižovatky</text> </svg>',
  'ctvercova-mesta.svg',
  'Dvě nejmenší čtvercová města: 2 krát 2 domy (2 ulice, 1 křižovatka) a 3 krát 3 domy (4 ulice, 4 křižovatky).',
  'Dvě nejmenší čtvercová města',
  new List<String>{'Má-li město $n$ domů v řadě, je domů $n^2$, ulic $2(n-1)$ a křižovatek $(n-1)^2$.','16.1 $36$ domů $\\Rightarrow n = 6$; křižovatek $(6-1)^2 = 25$.','16.2 $36$ křižovatek $\\Rightarrow (n-1)^2 = 36$, tedy $n = 7$; ulic $2\\cdot(7-1) = 12$.','16.3 $36$ ulic $\\Rightarrow 2(n-1) = 36$, tedy $n = 19$; domů $19^2 = 361$.'},
  '16.1: $25$ křižovatek; 16.2: $12$ ulic; 16.3: $361$ domů',
  4, 6, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
