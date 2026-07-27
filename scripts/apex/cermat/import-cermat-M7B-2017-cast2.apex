String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M7B 2017 – úloha 6',
  new List<String>{'Na plánku lyžařské běžecké trati jsou vyznačena stanoviště $A$, $B$, stánek a místo, v němž je start i cíl. Od startu běží závodníci ke stanovišti $B$, od něhož se stejnou cestou vrací do cíle. U stánku dostávají závodníci při cestě tam i zpět občerstvení. Vzdálenost stanovišť $A$ a $B$ je $8$ km.','6.1 Stánek je o $2$ km blíž ke stanovišti $A$ než ke stanovišti $B$. Určete, kolik km musí závodníci uběhnout mezi prvním a druhým občerstvením.','6.2 V okamžiku, kdy závodníci míjí místo $A$ poprvé, mají za sebou šestinu celého závodu. Určete v km délku celého závodu.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150" font-family="sans-serif"> <line x1="20" y1="60" x2="540" y2="60" stroke="#000" stroke-width="3"/> <line x1="120" y1="46" x2="120" y2="74" stroke="#000" stroke-width="2"/> <line x1="280" y1="46" x2="280" y2="74" stroke="#000" stroke-width="2"/> <line x1="380" y1="46" x2="380" y2="74" stroke="#000" stroke-width="2"/> <line x1="470" y1="46" x2="470" y2="74" stroke="#000" stroke-width="2"/> <text x="120" y="36" font-size="15" text-anchor="middle" font-weight="bold">B</text> <text x="280" y="36" font-size="15" text-anchor="middle">Stánek</text> <text x="380" y="36" font-size="15" text-anchor="middle" font-weight="bold">A</text> <line x1="520" y1="32" x2="496" y2="32" stroke="#000" stroke-width="2"/> <polygon points="490,32 500,28 500,36" fill="#000"/> <text x="526" y="37" font-size="14">Start</text> <line x1="496" y1="90" x2="518" y2="90" stroke="#000" stroke-width="2"/> <polygon points="524,90 514,86 514,94" fill="#000"/> <text x="530" y="95" font-size="14">Cíl</text> <path d="M120 84 L120 98 L380 98 L380 84" fill="none" stroke="#000"/> <text x="250" y="120" font-size="14" text-anchor="middle">8 km</text> </svg>',
  'planek-trati.svg',
  'Plánek trati: na přímce leží zleva stanoviště B, stánek, stanoviště A a místo startu i cíle; vzdálenost B a A je 8 km.',
  'Plánek lyžařské běžecké trati',
  new List<String>{'6.1 Je-li vzdálenost stánku od $A$ rovna $x$, pak od $B$ je $x+2$ a platí $x+(x+2)=8$, tedy $x=3$ km.','Od stánku k $B$ je to $5$ km; mezi občerstvením závodník uběhne tam i zpět, tj. $2\\cdot 5=10$ km.','6.2 Je-li vzdálenost startu od $A$ rovna $s$, je celý závod dlouhý $2\\cdot(s+8)$ km.','Podle zadání $s=\\frac{1}{6}\\cdot 2\\cdot(s+8)$, tj. $3s=s+8$, odtud $s=4$ km.','Délka závodu je $2\\cdot(4+8)=24$ km.'},
  '6.1: $10$ km; 6.2: $24$ km',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2017 – úloha 7',
  new List<String>{'Tři stejně těžké bedny váží tolik jako pět stejných krabic. Nejtěžší náklad, který se smí naložit do výtahu, váží tolik jako 35 krabic.','7.1 Určete největší počet beden, které se smí naložit do prázdného výtahu.','7.2 Určete největší počet krabic, které se smí do výtahu přidat k 11 bednám.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Tři bedny odpovídají pěti krabicím, tedy $35$ krabic odpovídá $35:5\\cdot 3=21$ bednám.','7.2 $11$ beden váží jako $\\frac{11\\cdot 5}{3}=\\frac{55}{3}$ krabice.','Zbývá $35-\\frac{55}{3}=\\frac{50}{3}=16\\frac{2}{3}$ krabice, celých krabic tedy nejvýše $16$.'},
  '7.1: $21$ beden; 7.2: $16$ krabic',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
