String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M9A 2015 – úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Výrobek stojí $600$ korun. Kolik korun bude stát výrobek zdražený o $20\\,\\%$?','16.2 Kalhoty byly zlevněny o $20\\,\\%$ na $560$ korun. Kolik korun stály kalhoty před zlevněním?','16.3 Zájezd byl zdražen o pětinu na $3\\,600$ korun. O kolik korun byl zájezd zdražen?'},
  new List<String>{'A) $600$','B) $650$','C) $672$','D) $700$','E) $720$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 Nová cena je $120\\,\\%$ původní: $600\\cdot 1{,}2=720$ korun → E.','16.2 Cena po zlevnění je $80\\,\\%$ původní: $560:0{,}8=700$ korun → D.','16.3 Cena po zdražení je $120\\,\\%$ původní: $3\\,600:1{,}2=3\\,000$ korun; zdraženo bylo o $3\\,600-3\\,000=600$ korun → A.'},
  '16.1: E ($720$); 16.2: D ($700$); 16.3: A ($600$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2015 – úloha 17',
  new List<String>{'V motorestu se podávají tři různé večeře A, B, C. Do motorestu přijely tři 20členné skupiny. V tabulce je uvedeno, které večeře si jednotlivé skupiny objednaly a na kolik korun vyšla průměrná cena večeře v jednotlivých skupinách.','17.1 Vypočtěte cenu večeře B.','17.2 Vypočtěte cenu večeře C.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 250" font-family="sans-serif" font-size="13"> <rect x="20" y="15" width="520" height="145" fill="none" stroke="#000" stroke-width="2"/> <line x1="150" y1="15" x2="150" y2="160" stroke="#000" stroke-width="2"/> <line x1="220" y1="43" x2="220" y2="160" stroke="#000"/> <line x1="290" y1="43" x2="290" y2="160" stroke="#000"/> <line x1="360" y1="15" x2="360" y2="160" stroke="#000" stroke-width="2"/> <line x1="150" y1="43" x2="360" y2="43" stroke="#000"/> <line x1="20" y1="71" x2="540" y2="71" stroke="#000" stroke-width="2"/> <line x1="20" y1="101" x2="540" y2="101" stroke="#000"/> <line x1="20" y1="131" x2="540" y2="131" stroke="#000"/> <text x="255" y="35" text-anchor="middle" font-weight="bold">Počet večeří</text> <text x="450" y="31" text-anchor="middle">Průměrná cena večeře</text> <text x="450" y="53" text-anchor="middle">ve skupině</text> <text x="185" y="64" text-anchor="middle" font-weight="bold">A</text> <text x="255" y="64" text-anchor="middle" font-weight="bold">B</text> <text x="325" y="64" text-anchor="middle" font-weight="bold">C</text> <text x="85" y="92" text-anchor="middle" font-weight="bold">Skupina 1</text> <text x="185" y="92" text-anchor="middle">20</text><text x="255" y="92" text-anchor="middle">0</text><text x="325" y="92" text-anchor="middle">0</text> <text x="450" y="92" text-anchor="middle">200 Kč</text> <text x="85" y="122" text-anchor="middle" font-weight="bold">Skupina 2</text> <text x="185" y="122" text-anchor="middle">10</text><text x="255" y="122" text-anchor="middle">10</text><text x="325" y="122" text-anchor="middle">0</text> <text x="450" y="122" text-anchor="middle">240 Kč</text> <text x="85" y="152" text-anchor="middle" font-weight="bold">Skupina 3</text> <text x="185" y="152" text-anchor="middle">5</text><text x="255" y="152" text-anchor="middle">5</text><text x="325" y="152" text-anchor="middle">10</text> <text x="450" y="152" text-anchor="middle">270 Kč</text> <rect x="20" y="180" width="340" height="60" fill="none" stroke="#000" stroke-width="2"/> <line x1="150" y1="180" x2="150" y2="240" stroke="#000" stroke-width="2"/> <line x1="220" y1="180" x2="220" y2="240" stroke="#000"/> <line x1="290" y1="180" x2="290" y2="240" stroke="#000"/> <line x1="20" y1="210" x2="360" y2="210" stroke="#000" stroke-width="2"/> <text x="185" y="202" text-anchor="middle" font-weight="bold">A</text> <text x="255" y="202" text-anchor="middle" font-weight="bold">B</text> <text x="325" y="202" text-anchor="middle" font-weight="bold">C</text> <text x="85" y="231" text-anchor="middle" font-weight="bold">Cena večeře</text> </svg>',
  'tabulka-vecere.svg',
  'Tabulka s počty večeří A, B, C ve třech dvacetičlenných skupinách a průměrnou cenou večeře ve skupině; druhá tabulka pro doplnění cen večeří A, B, C.',
  'Počty večeří a průměrné ceny ve skupinách',
  new List<String>{'Skupina 1 si objednala pouze večeře A a průměrná cena je $200$ Kč, tedy večeře A stojí $200$ Kč.','17.1 Skupina 2: $\\frac{10\\cdot 200+10\\cdot B}{20}=240$, tedy $2\\,000+10B=4\\,800$ a $B=280$ Kč.','17.2 Skupina 3: $\\frac{5\\cdot 200+5\\cdot 280+10\\cdot C}{20}=270$, tedy $1\\,000+1\\,400+10C=5\\,400$ a $C=300$ Kč.'},
  '17.1: $280$ Kč; 17.2: $300$ Kč',
  4, 6, '4',
  new List<String>{'zs2','r9','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
