String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD26C0T01';
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
  'CERMAT M5A 2026 – úloha 5',
  new List<String>{'Čtvercová síť se skládá z 30 malých čtverečků a jsou v ní zakresleny tři obrazce – bílý, šedý a černý. Vrcholy všech těchto obrazců leží v mřížových bodech. Obsah bílého obrazce je $60$ cm².','5.1 Vypočtěte v cm² obsah jednoho malého čtverečku čtvercové sítě.','5.2 Vypočtěte v cm² obsah šedého obrazce.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 244 210" font-family="sans-serif"><polygon points="20,20 88,20 20,156" fill="#111"/><polygon points="20,156 224,156 224,88" fill="#b9b9b9"/><line x1="20" y1="20" x2="20" y2="190" stroke="#666" stroke-width="1"/><line x1="54" y1="20" x2="54" y2="190" stroke="#666" stroke-width="1"/><line x1="88" y1="20" x2="88" y2="190" stroke="#666" stroke-width="1"/><line x1="122" y1="20" x2="122" y2="190" stroke="#666" stroke-width="1"/><line x1="156" y1="20" x2="156" y2="190" stroke="#666" stroke-width="1"/><line x1="190" y1="20" x2="190" y2="190" stroke="#666" stroke-width="1"/><line x1="224" y1="20" x2="224" y2="190" stroke="#666" stroke-width="1"/><line x1="20" y1="20" x2="224" y2="20" stroke="#666" stroke-width="1"/><line x1="20" y1="54" x2="224" y2="54" stroke="#666" stroke-width="1"/><line x1="20" y1="88" x2="224" y2="88" stroke="#666" stroke-width="1"/><line x1="20" y1="122" x2="224" y2="122" stroke="#666" stroke-width="1"/><line x1="20" y1="156" x2="224" y2="156" stroke="#666" stroke-width="1"/><line x1="20" y1="190" x2="224" y2="190" stroke="#666" stroke-width="1"/></svg>',
  'sit.svg',
  'Čtvercová síť 6 krát 5 (30 čtverečků) s černým, šedým a bílým obrazcem.',
  'Schematický nákres (obsahy dle zadání)',
  new List<String>{'5.1 Bílý obrazec zabírá 15 čtverečků a má obsah $60$ cm², tedy $1$ čtvereček $=60:15=4$ cm².','5.2 Šedý obrazec zabírá 11 čtverečků, tj. $11\\cdot 4=44$ cm².'},
  '5.1: $4$ cm²; 5.2: $44$ cm²',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2026 – úloha 6',
  new List<String>{'Jednu stranu papírového čtverce rozdělíme na tři stejně dlouhé úsečky a ke každé z nich narýsujeme rovnostranný trojúhelník. Když trojúhelníky odstřihneme, vznikne druhý obrazec. Když odstřižené trojúhelníky přesuneme k protější straně čtverce, vznikne třetí obrazec. Obvod čtverce a obvod druhého obrazce se liší o 18 cm.','6.1 Vypočtěte v cm délku strany rovnostranného trojúhelníku.','6.2 Vypočtěte v cm obvod čtverce.','6.3 Vypočtěte v cm rozdíl mezi obvodem třetího obrazce a obvodem čtverce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 170" font-family="sans-serif"> <rect x="20" y="30" width="90" height="90" fill="#d8d8d8" stroke="#000"/> <text x="65" y="150" font-size="12" text-anchor="middle">čtverec</text> <rect x="160" y="30" width="90" height="90" fill="#d8d8d8" stroke="#000"/> <polygon points="160,120 175,95 190,120 205,95 220,120 235,95 250,120" fill="#fff" stroke="#000"/> <text x="205" y="150" font-size="12" text-anchor="middle">druhý obrazec</text> <rect x="300" y="30" width="90" height="90" fill="#d8d8d8" stroke="#000"/> <polygon points="300,30 315,55 330,30 345,55 360,30 375,55 390,30" fill="#d8d8d8" stroke="#000"/> <polygon points="300,120 315,95 330,120 345,95 360,120 375,95 390,120" fill="#fff" stroke="#000"/> <text x="345" y="150" font-size="12" text-anchor="middle">třetí obrazec</text> </svg>',
  'ctverec-troj.svg',
  'Čtverec, druhý obrazec se třemi zářezy a třetí obrazec se zuby (schematicky).',
  'Schematický nákres tří obrazců',
  new List<String>{'6.1 Strana trojúhelníku $=$ třetina strany čtverce $=a/3$. Druhý obrazec má o dvě strany trojúhelníku na jedné straně navíc: rozdíl obvodů $=2\\cdot\\frac{a}{3}=18\\Rightarrow \\frac{a}{3}=6$ cm.','6.2 Strana čtverce $a=3\\cdot 6=18$ cm, obvod $=4\\cdot 18=72$ cm.','6.3 Třetí obrazec má oproti čtverci navíc zuby nahoře i dole: rozdíl $=2\\cdot(2\\cdot 6)+ \\ldots =36$ cm.'},
  '6.1: $6$ cm; 6.2: $72$ cm; 6.3: $36$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
