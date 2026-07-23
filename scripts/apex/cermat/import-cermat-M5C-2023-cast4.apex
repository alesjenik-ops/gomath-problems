String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M5C 2023 – úloha 8',
  new List<String>{'Na táboře je každé dítě zařazeno do jednoho ze tří oddílů A, B a C. V oddíle A je dvakrát více dětí než v oddíle C. Graf udává počty chlapců a dívek v jednotlivých oddílech, jeden údaj však chybí. Oddíl A: 9 chlapců a 7 dívek. Oddíl B: 8 chlapců a 4 dívky. Oddíl C: 3 chlapci a neznámý počet dívek.','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), či nikoli (N).','8.1 V oddíle C je 5 dívek.','8.2 V oddíle B je chlapců o polovinu více než dívek.','8.3 Na táboře je dívek o pětinu méně než chlapců.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 275" font-family="sans-serif"><path d="M150.0 69.0 A66 66 0 0 1 172.6 197.0 L161.6 166.9 A34 34 0 0 0 150.0 101.0 Z" fill="#ededed" stroke="#000" stroke-width="1"/><text x="199.2" y="130.3" font-size="15" text-anchor="middle">A</text><path d="M172.6 197.0 A66 66 0 0 1 85.0 123.5 L116.5 129.1 A34 34 0 0 0 161.6 166.9 Z" fill="#c9c9c9" stroke="#000" stroke-width="1"/><text x="117.9" y="177.3" font-size="15" text-anchor="middle">B</text><path d="M85.0 123.5 A66 66 0 0 1 150.0 69.0 L150.0 101.0 A34 34 0 0 0 116.5 129.1 Z" fill="#dedede" stroke="#000" stroke-width="1"/><text x="117.9" y="100.7" font-size="15" text-anchor="middle">C</text><path d="M150.0 39.0 A96 96 0 0 1 246.0 135.0 L216.0 135.0 A66 66 0 0 0 150.0 69.0 Z" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="207.3" y="81.7" font-size="12" text-anchor="middle">9</text><path d="M246.0 135.0 A96 96 0 0 1 182.8 225.2 L172.6 197.0 A66 66 0 0 0 216.0 135.0 Z" fill="#e0e0e0" stroke="#000" stroke-width="1"/><text x="216.4" y="185.5" font-size="12" text-anchor="middle">7</text><path d="M182.8 225.2 A96 96 0 0 1 66.9 183.0 L92.8 168.0 A66 66 0 0 0 172.6 197.0 Z" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="122.3" y="215.1" font-size="12" text-anchor="middle">8</text><path d="M66.9 183.0 A96 96 0 0 1 55.5 118.3 L85.0 123.5 A66 66 0 0 0 92.8 168.0 Z" fill="#e0e0e0" stroke="#000" stroke-width="1"/><text x="70.2" y="153.1" font-size="12" text-anchor="middle">4</text><path d="M55.5 118.3 A96 96 0 0 1 76.5 73.3 L99.4 92.6 A66 66 0 0 0 85.0 123.5 Z" fill="#9a9a9a" stroke="#000" stroke-width="1"/><text x="76.6" y="104.8" font-size="12" text-anchor="middle">3</text><path d="M76.5 73.3 A96 96 0 0 1 150.0 39.0 L150.0 69.0 A66 66 0 0 0 99.4 92.6 Z" fill="#e0e0e0" stroke="#000" stroke-width="1"/><text x="115.8" y="65.6" font-size="12" text-anchor="middle">?</text><rect x="30" y="250" width="12" height="12" fill="#9a9a9a" stroke="#000"/><text x="48" y="260" font-size="11">chlapci</text><rect x="160" y="250" width="12" height="12" fill="#e0e0e0" stroke="#000"/><text x="178" y="260" font-size="11">dívky</text></svg>',
  'graf-tabor.svg',
  'Kruhový graf: oddíly A, B, C a počty chlapců a dívek; údaj pro dívky v oddíle C chybí.',
  'Počty chlapců a dívek v oddílech (jeden údaj chybí)',
  new List<String>{'Oddíl A má $9+7=16$ dětí, oddíl C tedy $16:2=8$ dětí; v oddíle C je $8-3=5$ dívek.','8.1 V oddíle C je $5$ dívek → Ano (A).','8.2 V oddíle B je $8$ chlapců a $4$ dívky; o polovinu více než 4 je 6, nikoli 8 → Ne (N).','8.3 Dívek je $7+4+5=16$, chlapců $9+8+3=20$; $16$ je o pětinu (o 4) méně než $20$ → Ano (A).'},
  '8.1: A (ano); 8.2: N (ne); 8.3: A (ano)',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2023 – úloha 9',
  new List<String>{'V obchodě s oříšky míchají směs arašídů a mandlí a prodávají ji v různě velkých baleních. Sto gramů této směsi se prodává za 20 korun, přičemž sto gramů arašídů stojí 10 korun. Tereza si koupila 800gramové balení této směsi. V takovém balení je vždy 300 g arašídů. Cena směsi závisí pouze na hmotnosti a ceně použitých surovin.','Kolik korun stojí sto gramů mandlí?'},
  new List<String>{'A) 26 korun','B) 27 korun','C) 28 korun','D) 29 korun','E) jiný počet korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'800 g směsi stojí $8\\cdot 20=160$ korun. Arašídy: $300$ g $=3\\cdot 10=30$ korun. Mandle ($500$ g) stojí $160-30=130$ korun, tj. $100$ g mandlí $=130:5=26$ korun.'},
  'A) 26 korun',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
