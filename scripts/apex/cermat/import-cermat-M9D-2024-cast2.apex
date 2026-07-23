String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M9D 2024 – úloha 6',
  new List<String>{'Ve vnitrostátním rychlíku jsou řazeny vagóny 1. a 2. třídy. Vagónů 2. třídy je dvakrát více než vagónů 1. třídy. V každém vagónu je $10$ kupé (oddílů pro cestující). Ve vagónech 1. třídy je v každém kupé šest míst k sezení, ve vagónech 2. třídy osm míst k sezení. Ve všech kupé rychlíku je dohromady $440$ míst k sezení.','6.1 Kolik vagónů 2. třídy je součástí rychlíku?','6.2 Kolik míst k sezení je dohromady ve vagónech 1. třídy?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet vagónů 1. třídy $v$, pak vagónů 2. třídy je $2v$. V jednom vagónu 1. třídy je $10\\cdot 6=60$ míst, ve vagónu 2. třídy $10\\cdot 8=80$ míst. Rovnice: $60v+80\\cdot 2v=440$, tj. $220v=440$, odtud $v=2$.','6.1 Vagónů 2. třídy je $2v=4$.','6.2 Míst k sezení ve vagónech 1. třídy je $2\\cdot 60=120$.'},
  '6.1: $4$ vagóny; 6.2: $120$ míst',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2024 – úloha 7',
  new List<String>{'V restauraci nabízejí tři různá obědová menu (polévku, hlavní jídlo a nápoj) označená písmeny A, B a C. Do restaurace přijely tři skupiny turistů po dvaceti lidech. V tabulce jsou uvedeny obědy, které si jednotlivé skupiny objednaly, a kolik za ně zaplatily.','7.1 Jaká byla cena oběda B?','7.2 Jaká byla cena oběda C?'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 490 155" font-family="sans-serif"><line x1="20" y1="15" x2="20" y2="140" stroke="#000" stroke-width="1"/><line x1="150" y1="15" x2="150" y2="140" stroke="#000" stroke-width="1"/><line x1="205" y1="40" x2="205" y2="140" stroke="#000" stroke-width="1"/><line x1="260" y1="40" x2="260" y2="140" stroke="#000" stroke-width="1"/><line x1="315" y1="15" x2="315" y2="140" stroke="#000" stroke-width="1"/><line x1="470" y1="15" x2="470" y2="140" stroke="#000" stroke-width="1"/><line x1="20" y1="15" x2="470" y2="15" stroke="#000" stroke-width="1"/><line x1="150" y1="40" x2="315" y2="40" stroke="#000" stroke-width="1"/><line x1="20" y1="65" x2="470" y2="65" stroke="#000" stroke-width="1"/><line x1="20" y1="90" x2="470" y2="90" stroke="#000" stroke-width="1"/><line x1="20" y1="115" x2="470" y2="115" stroke="#000" stroke-width="1"/><line x1="20" y1="140" x2="470" y2="140" stroke="#000" stroke-width="1"/><text x="232" y="32" font-size="12" text-anchor="middle">Pocet obedu</text><text x="392" y="30" font-size="12" text-anchor="middle">Celkova cena</text><text x="392" y="56" font-size="12" text-anchor="middle">za obedy</text><text x="177" y="58" font-size="12" text-anchor="middle">A</text><text x="232" y="58" font-size="12" text-anchor="middle">B</text><text x="287" y="58" font-size="12" text-anchor="middle">C</text><text x="85" y="82" font-size="12" text-anchor="middle">skupina 1</text><text x="177" y="82" font-size="12" text-anchor="middle">20</text><text x="232" y="82" font-size="12" text-anchor="middle">0</text><text x="287" y="82" font-size="12" text-anchor="middle">0</text><text x="392" y="82" font-size="12" text-anchor="middle">4 000 Kc</text><text x="85" y="107" font-size="12" text-anchor="middle">skupina 2</text><text x="177" y="107" font-size="12" text-anchor="middle">10</text><text x="232" y="107" font-size="12" text-anchor="middle">10</text><text x="287" y="107" font-size="12" text-anchor="middle">0</text><text x="392" y="107" font-size="12" text-anchor="middle">4 800 Kc</text><text x="85" y="132" font-size="12" text-anchor="middle">skupina 3</text><text x="177" y="132" font-size="12" text-anchor="middle">5</text><text x="232" y="132" font-size="12" text-anchor="middle">5</text><text x="287" y="132" font-size="12" text-anchor="middle">10</text><text x="392" y="132" font-size="12" text-anchor="middle">5 400 Kc</text></svg>',
  'obedy-tabulka.svg',
  'Tabulka poctu objednanych obedu A, B, C u tri skupin a celkove ceny: skupina 1 (20, 0, 0) za 4 000 Kc, skupina 2 (10, 10, 0) za 4 800 Kc, skupina 3 (5, 5, 10) za 5 400 Kc.',
  'Počty objednaných obědů a zaplacené částky',
  new List<String>{'Skupina 1: $20$ obědů A za $4\\,000$ Kč, cena oběda A je $4\\,000:20=200$ Kč.','7.1 Skupina 2: $10\\cdot 200+10\\cdot B=4\\,800$, tj. $2\\,000+10B=4\\,800$, odtud $B=280$ Kč.','7.2 Skupina 3: $5\\cdot 200+5\\cdot 280+10\\cdot C=5\\,400$, tj. $2\\,400+10C=5\\,400$, odtud $C=300$ Kč.'},
  '7.1: $280$ Kč; 7.2: $300$ Kč',
  4, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
