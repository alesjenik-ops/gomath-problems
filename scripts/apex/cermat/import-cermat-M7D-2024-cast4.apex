String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
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
  'CERMAT M7D 2024 – úloha 11',
  new List<String>{'Klára vystřihla z papíru $3$ shodné obdélníky, $4$ shodné čtverce a $5$ shodných rovnoramenných trojúhelníků. Sestavila z nich tři obrazce. Obvod $1.$ obrazce je $40$ cm. (V žádném obrazci se útvary nepřekrývají.)','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Obvod $2.$ obrazce je větší než obvod $1.$ obrazce.','11.2 Obsah každého z obdélníků je roven $32$ cm².','11.3 Obvod $3.$ obrazce je $48$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 260" font-family="sans-serif"> <text x="72" y="40" font-size="12" text-anchor="middle">1. obrazec</text> <rect x="24" y="195" width="96" height="48" fill="none" stroke="#000"/> <polygon points="24,195 72,195 48,141" fill="none" stroke="#000"/> <polygon points="72,195 120,195 96,141" fill="none" stroke="#000"/> <text x="290" y="40" font-size="12" text-anchor="middle">2. obrazec</text> <rect x="266" y="147" width="48" height="96" fill="none" stroke="#000"/> <rect x="266" y="99" width="48" height="48" fill="none" stroke="#000"/> <polygon points="266,99 314,99 290,55" fill="none" stroke="#000"/> <text x="470" y="40" font-size="12" text-anchor="middle">3. obrazec</text> <rect x="422" y="195" width="96" height="48" fill="none" stroke="#000"/> <rect x="422" y="147" width="48" height="48" fill="none" stroke="#000"/> <rect x="470" y="147" width="48" height="48" fill="none" stroke="#000"/> <polygon points="422,147 470,147 446,103" fill="none" stroke="#000"/> <polygon points="470,147 518,147 494,103" fill="none" stroke="#000"/> </svg>',
  'tri-obrazce.svg',
  'Tři obrazce složené z obdélníků, čtverců a rovnoramenných trojúhelníků (schematický nákres).',
  'Schematický nákres tří obrazců (1., 2. a 3. obrazec)',
  new List<String>{'Z rozměrů útvarů a daného obvodu $1.$ obrazce ($40$ cm) plyne, že čtverec má stranu $4$ cm, obdélník rozměry $8$ cm $\\times$ $4$ cm a rovnoramenný trojúhelník rameno $6$ cm.','11.1 Obvod $2.$ obrazce je také $40$ cm, není tedy větší → N.','11.2 Obsah obdélníku je $8\\cdot 4=32$ cm² → A.','11.3 Obvod $3.$ obrazce je $48$ cm → A.'},
  '11.1: N; 11.2: A; 11.3: A',
  3, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2024 – úloha 12',
  new List<String>{'Petr a Pavel četli stejnou knihu. Petr přečetl za každý den kromě posledního $28$ stránek. Pavel přečetl za každý den kromě posledního $35$ stránek. Na poslední den oběma zbylo $5$ stránek.','Kolik stránek nejméně musí kniha mít?'},
  new List<String>{'A) $70$','B) $75$','C) $140$','D) $145$','E) $155$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet stránek zmenšený o posledních $5$ musí být dělitelný $28$ i $35$. Nejmenší společný násobek je $\\mathrm{nsn}(28,35)=140$. Kniha má tedy nejméně $140+5=145$ stránek.'},
  'D) $145$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
