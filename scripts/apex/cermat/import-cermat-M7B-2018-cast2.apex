String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M7B 2018 – úloha 6',
  new List<String>{'Těleso bylo sestaveno ze dvou krychlí ze stejného materiálu. Ke krychli s délkou hrany 8 cm je přilepena krychle s délkou hrany 4 cm. Přilepená stěna menší krychle nepřečnívá přes větší krychli. Menší krychle váží 400 g.','Vypočtěte','6.1 v gramech hmotnost tělesa;','6.2 v cm² povrch tělesa (včetně dolní stěny větší krychle).'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif"> <polygon points="60,120 200,120 245,75 105,75" fill="#f2f2f2" stroke="#000" stroke-width="2"/> <polygon points="200,120 245,75 245,215 200,260" fill="#e2e2e2" stroke="#000" stroke-width="2"/> <rect x="60" y="120" width="140" height="140" fill="#fafafa" stroke="#000" stroke-width="2"/> <polygon points="150,55 220,55 245,32 175,32" fill="#f2f2f2" stroke="#000" stroke-width="2"/> <polygon points="220,55 245,32 245,97 220,120" fill="#e2e2e2" stroke="#000" stroke-width="2"/> <rect x="150" y="55" width="70" height="65" fill="#ffffff" stroke="#000" stroke-width="2"/> <text x="130" y="285" font-size="15">8 cm</text> <text x="163" y="47" font-size="14">4 cm</text> </svg>',
  'teleso-krychle.svg',
  'Velká krychle s hranou 8 cm, na jejíž horní stěně je přilepena menší krychle s hranou 4 cm.',
  'Těleso ze dvou krychlí (schematicky)',
  new List<String>{'6.1 Objem menší krychle $4^3=64$ cm³ váží 400 g, hustota je $400:64=6{,}25$ g/cm³. Větší krychle má objem $8^3=512$ cm³ a váží $512\\cdot 6{,}25=3200$ g. Celkem $3200+400=3600$ g.','6.2 Povrch větší krychle $6\\cdot 8^2=384$ cm². Menší krychle přidá 5 stěn $5\\cdot 4^2=80$ cm² a zakryje $4^2=16$ cm² horní stěny větší krychle: $384-16+80=448$ cm².'},
  '6.1: $3\\,600$ g; 6.2: $448$ cm²',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 7',
  new List<String>{'Dvě housky váží o 10 gramů více než dvě topinky. Jedna houska a dvě topinky váží celkem 110 gramů (viz obrázek).','Vypočtěte,','7.1 o kolik gramů méně váží jedna topinka než jedna houska;','7.2 kolik gramů váží tři topinky;','7.3 kolik gramů váží jedna houska.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 200" font-family="sans-serif"> <text x="30" y="30" font-size="15">Dvě housky váží o 10 gramů více než dvě topinky.</text> <circle cx="230" cy="70" r="20" fill="#d9d9d9" stroke="#000"/><line x1="212" y1="62" x2="248" y2="78" stroke="#000"/><line x1="212" y1="78" x2="248" y2="62" stroke="#000"/> <circle cx="285" cy="70" r="20" fill="#d9d9d9" stroke="#000"/><line x1="267" y1="62" x2="303" y2="78" stroke="#000"/><line x1="267" y1="78" x2="303" y2="62" stroke="#000"/> <text x="320" y="76" font-size="18">=</text><text x="345" y="76" font-size="16">10 g</text><text x="400" y="76" font-size="18">+</text> <rect x="425" y="50" width="40" height="40" rx="6" fill="#ffffff" stroke="#000"/> <rect x="480" y="50" width="40" height="40" rx="6" fill="#ffffff" stroke="#000"/> <text x="30" y="125" font-size="15">Jedna houska a dvě topinky váží celkem 110 gramů.</text> <circle cx="245" cy="160" r="20" fill="#d9d9d9" stroke="#000"/><line x1="227" y1="152" x2="263" y2="168" stroke="#000"/><line x1="227" y1="168" x2="263" y2="152" stroke="#000"/> <text x="285" y="166" font-size="18">+</text> <rect x="315" y="140" width="40" height="40" rx="6" fill="#ffffff" stroke="#000"/> <rect x="370" y="140" width="40" height="40" rx="6" fill="#ffffff" stroke="#000"/> <text x="425" y="166" font-size="18">=</text><text x="450" y="166" font-size="16">110 g</text> </svg>',
  'housky-topinky.svg',
  'Dvě housky se rovnají 10 g plus dvě topinky; jedna houska plus dvě topinky se rovnají 110 g.',
  'Vztahy mezi hmotnostmi housek a topinek',
  new List<String>{'Označme hmotnost housky $h$ a topinky $t$. Z $2h=2t+10$ plyne $h-t=5$.','7.1 Jedna topinka váží o $5$ g méně než jedna houska.','7.2 Z $h+2t=110$ a $h=t+5$: $(t+5)+2t=110$, $3t=105$, tedy tři topinky váží $105$ g (a $t=35$ g).','7.3 Houska váží $t+5=35+5=40$ g.'},
  '7.1: o $5$ g; 7.2: $105$ g; 7.3: $40$ g',
  5, 7, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
