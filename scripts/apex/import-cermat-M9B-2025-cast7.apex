String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)';
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
  'CERMAT 2025 M9B · úloha 15',
  new List<String>{'Na táboře bylo $80$ dětí, $5$ vedoucích a $4$ instruktoři.','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Vedoucí si všechny děti rozdělili do stejně početných oddílů, každý vedoucí měl jeden oddíl. Kolik procent všech dětí měl na starost jeden vedoucí?','15.2 Mladších dětí bylo o jednu třetinu méně než starších. O kolik procent bylo starších dětí více než mladších?','15.3 Do lesa šla čtvrtina všech chlapců a polovina všech dívek, přičemž chlapců šlo o $4$ méně než dívek. Kolik procent všech dětí tvořily dívky?'},
  new List<String>{'A) $20\\ \\%$','B) $25\\ \\%$','C) $33\\ \\%$','D) $40\\ \\%$','E) $45\\ \\%$','F) $50\\ \\%$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $5$ oddílů po $16$ dětech; jeden vedoucí má $\\frac{16}{80}=20\\ \\%$ — A.','15.2: mladší $=\\frac{2}{3}$ starších; $\\frac{S-\\frac{2}{3}S}{\\frac{2}{3}S}=\\frac{1}{2}=50\\ \\%$ — F.','15.3: $\\frac{1}{4}C=\\frac{1}{2}D-4$ a $C+D=80$; odtud $D=32$, tj. $\\frac{32}{80}=40\\ \\%$ — D.'},
  '15.1: A ($20\\ \\%$); 15.2: F ($50\\ \\%$); 15.3: D ($40\\ \\%$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD25C0T02', 2025
);
c.add(
  'CERMAT 2025 M9B · úloha 16',
  new List<String>{'Mirek postupně odříkával všechna přirozená čísla od $1$ do $1\\,000$. Za každým druhým číslem udělal pauzu, během níž Zuzka řekla součet posledních dvou čísel vyslovených Mirkem. Začátek: $1, 2, \\mathbf{3}, 3, 4, \\mathbf{7}, 5, 6, \\mathbf{11}, \\dots$ (tučná čísla řekla Zuzka).','16.1 Určete číslo, které zaznělo mezi čísly $24$ a $25$.','16.2 Jako $90.$ v pořadí bylo vysloveno číslo $C$, které později zaznělo ještě jednou. Určete číslo vyslovené bezprostředně předtím, než podruhé zaznělo $C$.','16.3 Určete největší číslo, které mezi prvními $150$ vyslovenými čísly zaznělo dvakrát.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Mirek říká dvojice $(2n-1,2n)$, po každé Zuzka součet $4n-1$.','16.1: mezi $24$ a $25$ zazní Zuzčin součet $23+24=47$.','16.2: $90.$ číslo je $3\\cdot30$, tedy Zuzčin součet $4\\cdot30-1=119=C$; Mirek řekne $119$ v dvojici $(119,120)$, těsně předtím zazní Zuzčino $4\\cdot59-1=235$.','16.3: mezi prvními $150$ čísly ($50$ dvojic) je největší dvakrát zaznělé číslo $99$ (Zuzčin součet $4\\cdot25-1$ i Mirkovo $99$).'},
  '16.1: $47$; 16.2: $235$; 16.3: $99$',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','aritmetika','argumentace','bez-kalkulacky','bez-kontextu'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
