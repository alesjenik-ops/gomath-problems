String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD23C0T01';
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
  'CERMAT M5A 2023 – úloha 10',
  new List<String>{'V kasičce je celkem 78 mincí – některé jsou pětikorunové a zbývající desetikorunové. Hodnota všech pětikorunových mincí v kasičce je stejná jako hodnota všech desetikorunových mincí v kasičce.','Jaká je hodnota všech mincí v kasičce?'},
  new List<String>{'A) 390 korun','B) 520 korun','C) 585 korun','D) 780 korun','E) jiná hodnota'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť je $p$ pětikorunových a $d$ desetikorunových mincí: $p+d=78$ a $5p=10d$, tedy $p=2d$. Pak $3d=78$, $d=26$, $p=52$. Hodnota je $5\\cdot 52+10\\cdot 26=260+260=520$ korun.'},
  'B) 520 korun',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5A 2023 – úloha 11',
  new List<String>{'Stavebnice obsahuje samé stejné dílky. Každý dílek má tvar kvádru s rozměry 6 cm, 4 cm a 4 cm (viz obrázek).','Kolik dílků stavebnice je třeba ke složení kvádru s rozměry 8 cm, 12 cm a 16 cm?'},
  new List<String>{'A) méně než 12 dílků','B) 12 dílků','C) 16 dílků','D) 32 dílků','E) více než 32 dílků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 180" font-family="sans-serif"> <rect x="40" y="60" width="120" height="80" fill="#f5f5f5" stroke="#000"/> <polygon points="40,60 80,30 200,30 160,60" fill="#eeeeee" stroke="#000"/> <polygon points="160,60 200,30 200,110 160,140" fill="#e0e0e0" stroke="#000"/> <text x="100" y="158" font-size="13" text-anchor="middle">6 cm</text> <text x="205" y="80" font-size="13">4 cm</text> <text x="168" y="28" font-size="13">4 cm</text> </svg>',
  'dilek.svg',
  'Dílek stavebnice ve tvaru kvádru s rozměry 6 cm, 4 cm a 4 cm.',
  'Dílek stavebnice (kvádr 6 cm krát 4 cm krát 4 cm)',
  new List<String>{'Objem skládaného kvádru je $8\\cdot 12\\cdot 16=1536$ cm³, objem dílku $6\\cdot 4\\cdot 4=96$ cm³. Počet dílků $1536:96=16$. Dílky lze skutečně poskládat (hrana 6 cm podél strany 12 cm, stěny 4 cm krát 4 cm vyplní 8 cm krát 16 cm), takže stačí $16$ dílků.'},
  'C) 16 dílků',
  2, 4, '3',
  new List<String>{'zs1','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 12',
  new List<String>{'Stavebnice obsahuje samé stejné dílky. Každý dílek má tvar kvádru s rozměry 6 cm, 4 cm a 4 cm (viz obrázek).','Kolik dílků stavebnice je třeba ke složení nejmenší možné krychle?'},
  new List<String>{'A) méně než 6 dílků','B) 6 dílků','C) 12 dílků','D) 18 dílků','E) více než 24 dílků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 180" font-family="sans-serif"> <rect x="40" y="60" width="120" height="80" fill="#f5f5f5" stroke="#000"/> <polygon points="40,60 80,30 200,30 160,60" fill="#eeeeee" stroke="#000"/> <polygon points="160,60 200,30 200,110 160,140" fill="#e0e0e0" stroke="#000"/> <text x="100" y="158" font-size="13" text-anchor="middle">6 cm</text> <text x="205" y="80" font-size="13">4 cm</text> <text x="168" y="28" font-size="13">4 cm</text> </svg>',
  'dilek.svg',
  'Dílek stavebnice ve tvaru kvádru s rozměry 6 cm, 4 cm a 4 cm.',
  'Dílek stavebnice (kvádr 6 cm krát 4 cm krát 4 cm)',
  new List<String>{'Hrana krychle musí být dělitelná délkami $6$ i $4$; nejmenší taková je nejmenší společný násobek $12$ cm. Objem krychle $12^3=1728$ cm³, objem dílku $96$ cm³, počet dílků $1728:96=18$. Krychli s hranou $12$ cm lze z dílků složit, takže je třeba $18$ dílků.'},
  'D) 18 dílků',
  2, 4, '3',
  new List<String>{'zs1','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
