String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M7C 2021 – úloha 10',
  new List<String>{'Na vytvoření obrazce můžeme použít velké a malé čtverce a trojúhelníky. Malý čtverec má stranu délky $2$ cm. Velký čtverec lze složit z $9$ malých čtverců. Malý (velký) trojúhelník získáme rozstřižením malého (velkého) čtverce na dvě poloviny.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obrazec A lze beze zbytku rozstříhat na $41$ malých trojúhelníků.','10.2 Obsah obrazce B je o $4$ cm² větší než obsah obrazce A.','10.3 Obsah obrazce B je o $50$ cm² větší než obsah velkého čtverce.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 250" font-family="sans-serif"> <text x="150" y="28" font-size="14" text-anchor="middle">Obrazec A</text> <polygon points="55,110 150,45 245,110" fill="none" stroke="#000" stroke-width="2"/> <polygon points="80,110 220,110 220,150 175,150 175,225 125,225 125,150 80,150" fill="none" stroke="#000" stroke-width="2"/> <rect x="196" y="52" width="16" height="18" fill="none" stroke="#000" stroke-width="1.5"/> <rect x="196" y="70" width="16" height="18" fill="none" stroke="#000" stroke-width="1.5"/> <text x="400" y="28" font-size="14" text-anchor="middle">Obrazec B</text> <polygon points="300,225 322,185 322,150 340,150 340,130 358,130 358,150 376,150 376,130 394,130 394,150 470,150 470,225" fill="none" stroke="#000" stroke-width="2"/> </svg>',
  'obrazce-A-B.svg',
  'Obrazec A ve tvaru domu se šipkou a komínem a obrazec B ve tvaru hradby s cimbuřím.',
  'Obrazec A a obrazec B',
  new List<String>{'Malý čtverec má obsah $2\\cdot 2=4$ cm², malý trojúhelník tedy $2$ cm². Velký čtverec má obsah $9\\cdot 4=36$ cm². Sečtením dílů má obrazec A obsah $82$ cm² a obrazec B obsah $86$ cm².','10.1 $82:2=41$ malých trojúhelníků – obrazec A na ně lze rozstříhat → Ano.','10.2 $86-82=4$ cm² → Ano.','10.3 $86-36=50$ cm² → Ano.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2021 – úloha 11',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné (viz obrázek). Ve vyznačených místech jsou úhly $\\alpha$, $2\\alpha$ a $36^\\circ$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) $18^\\circ$','B) $36^\\circ$','C) $44^\\circ$','D) $48^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif"> <line x1="50" y1="135" x2="385" y2="90" stroke="#000" stroke-width="2"/> <line x1="50" y1="248" x2="385" y2="203" stroke="#000" stroke-width="2"/> <line x1="352" y1="98" x2="360" y2="106" stroke="#000" stroke-width="1.5"/> <line x1="360" y1="96" x2="368" y2="104" stroke="#000" stroke-width="1.5"/> <line x1="352" y1="211" x2="360" y2="219" stroke="#000" stroke-width="1.5"/> <line x1="360" y1="209" x2="368" y2="217" stroke="#000" stroke-width="1.5"/> <line x1="95" y1="60" x2="335" y2="258" stroke="#000" stroke-width="2"/> <line x1="335" y1="72" x2="150" y2="292" stroke="#000" stroke-width="2"/> <text x="150" y="118" font-size="16" font-style="italic">α</text> <text x="228" y="172" font-size="16" font-style="italic">2α</text> <text x="188" y="238" font-size="15">36°</text> </svg>',
  'ctyri-primky-uhly.svg',
  'Dvě rovnoběžné přímky protnuté dvěma různoběžkami; vyznačené úhly alfa, dvojnásobek alfa a 36 stupňů.',
  'Čtyři přímky, dvě z nich rovnoběžné',
  new List<String>{'Přímka svírající s horní rovnoběžkou úhel $\\alpha$ svírá stejný úhel $\\alpha$ i s dolní rovnoběžkou (střídavé úhly). Trojúhelník ohraničený dolní rovnoběžkou a oběma různoběžkami má vnitřní úhly $\\alpha$, $36^\\circ$ a $2\\alpha$ (vrcholový k vyznačenému úhlu). Jejich součet je $180^\\circ$: $\\alpha+36^\\circ+2\\alpha=180^\\circ$, tedy $3\\alpha=144^\\circ$ a $\\alpha=48^\\circ$.'},
  'D) $48^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
