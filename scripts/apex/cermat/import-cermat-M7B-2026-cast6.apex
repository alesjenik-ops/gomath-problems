String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD26C0T02';
Integer YEAR = 2026;

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
  'CERMAT M7B 2026 – úloha 11',
  new List<String>{'Na výrobu jednoho trička z recyklovaného materiálu je potřeba 5 plastových lahví. Při školní sběrové akci se podařilo nasbírat 1 200 plastových lahví, z nichž bylo pro výrobu triček 15 % nepoužitelných. Ze všech použitelných lahví se vyrobila trička.','Kolik triček se vyrobilo z nasbíraných lahví?'},
  new List<String>{'A) více než 204 triček','B) 204 triček','C) 180 triček','D) 104 triček','E) méně než 104 triček'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Použitelných lahví je $85\\,\\%$ z $1\\,200$, tj. $0{,}85 \\cdot 1\\,200 = 1\\,020$. Z nich se vyrobilo $1\\,020 : 5 = 204$ triček.'},
  'B) 204 triček',
  2, 3, '2',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 12',
  new List<String>{'Podlaha komory má tvar obdélníku o rozměrech 1,25 m a 2 m. Celá podlaha je vydlážděna dlaždičkami tvaru čtverce o obsahu 25 cm². Mezery mezi dlaždičkami neuvažujte.','Kolik dlaždiček je na podlaze komory?'},
  new List<String>{'A) 1000 dlaždiček','B) 500 dlaždiček','C) 400 dlaždiček','D) 100 dlaždiček','E) jiný počet dlaždiček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 250" font-family="sans-serif"> <rect x="40" y="40" width="280" height="175" fill="none" stroke="#000" stroke-width="2"/> <rect x="40" y="40" width="20" height="20" fill="none" stroke="#000"/> <rect x="60" y="40" width="20" height="20" fill="none" stroke="#000"/> <rect x="40" y="60" width="20" height="20" fill="none" stroke="#000"/> <rect x="60" y="60" width="20" height="20" fill="none" stroke="#000"/> <rect x="40" y="80" width="20" height="20" fill="none" stroke="#000"/> <line x1="40" y1="232" x2="320" y2="232" stroke="#000"/> <polygon points="40,232 50,228 50,236" fill="#000"/><polygon points="320,232 310,228 310,236" fill="#000"/> <text x="180" y="248" font-size="14" text-anchor="middle">2 m</text> <line x1="335" y1="40" x2="335" y2="215" stroke="#000"/> <polygon points="335,40 331,50 339,50" fill="#000"/><polygon points="335,215 331,205 339,205" fill="#000"/> <text x="343" y="132" font-size="14">1,25 m</text> </svg>',
  'podlaha.svg',
  'Obdélníková podlaha o rozměrech 2 m krát 1,25 m vydlážděná čtvercovými dlaždičkami.',
  'Schematický nákres podlahy komory',
  new List<String>{'Podlaha má rozměry $125$ cm $\\times 200$ cm, tj. obsah $25\\,000$ cm². Jedna dlaždička má obsah $25$ cm². Počet dlaždiček $= 25\\,000 : 25 = 1\\,000$.'},
  'A) 1000 dlaždiček',
  2, 3, '2',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 13',
  new List<String>{'Tři nádrže A, B, C mají stejný objem. K naplnění jednotlivých nádrží se používá různý počet čerpadel, která vždy pracují po celou dobu společně. Všechna čerpadla mají stejný výkon a ten se během jejich práce nemění. Prázdnou nádrž A zcela naplnilo 6 takových čerpadel za 40 minut.','Prázdná nádrž B se zcela naplnila za dobu o polovinu delší než nádrž A. Kolik čerpadel bylo použito k naplnění nádrže B?'},
  new List<String>{'A) 2 čerpadla','B) 3 čerpadla','C) 4 čerpadla','D) 9 čerpadel','E) 12 čerpadel'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Objem nádrže je stejný, proto součin počtu čerpadel a doby je konstantní: $6 \\cdot 40 = 240$. Nádrž B se plnila $40 + 20 = 60$ minut, čerpadel bylo $240 : 60 = 4$.'},
  'C) 4 čerpadla',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2026 – úloha 14',
  new List<String>{'Tři nádrže A, B, C mají stejný objem. K naplnění se používá různý počet čerpadel se stejným neměnným výkonem, která pracují společně. Prázdnou nádrž A zcela naplnilo 6 čerpadel za 40 minut.','Prázdná nádrž C se zcela naplnila za dobu o 25 % kratší než nádrž A. Kolik procent objemu nádrže C se zaplnilo během prvních 18 minut?'},
  new List<String>{'A) $36\\,\\%$','B) $54\\,\\%$','C) $60\\,\\%$','D) $72\\,\\%$','E) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nádrž C se plnila o $25\\,\\%$ kratší dobu, tj. $40 \\cdot 0{,}75 = 30$ minut. Za prvních $18$ minut se zaplnilo $\\frac{18}{30} = 0{,}6 = 60\\,\\%$ objemu.'},
  'C) $60\\,\\%$',
  2, 4, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
