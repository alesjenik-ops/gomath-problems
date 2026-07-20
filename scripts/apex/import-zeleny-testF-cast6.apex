String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený F15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Přijímačky z češtiny neudělal každý pátý uchazeč, z matematiky propadl každý čtvrtý. Desetina uchazečů neuspěla v obou předmětech. Kolik $\\%$ uchazečů složilo obě zkoušky úspěšně?','15.2 Kdyby Strana smutných občanů v letošních volbách získala o $200$ hlasů víc, mohla vyhrát volby se ziskem $50\\,\\%$ hlasů. Takhle se musela spokojit jen se $40\\,\\%$ hlasů. Kolik $\\%$ z celkem $5$ tisíc oprávněných voličů v obci přišlo letos k volbám?','15.3 Proti loňsku jsme museli při sklizni snížit rychlost kombajnu v průměru o třetinu. O kolik $\\%$ se prodloužila délka sklizně?'},
  new List<String>{'A) 33,3 %','B) 40,0 %','C) 45,0 %','D) 50,0 %','E) 65,0 %','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Neuspěl z ČJ $\\frac{1}{5} = 20\\,\\%$, z M $\\frac{1}{4} = 25\\,\\%$, v obou $\\frac{1}{10} = 10\\,\\%$. Aspoň v jednom neuspělo $20+25-10 = 35\\,\\%$, obě zkoušky složilo $100-35 = 65\\,\\%$ → E.','15.2 Nechť přišlo $V$ voličů; strana má $40\\,\\%$, tj. $0{,}4V$. Kdyby o $200$ víc, měla by $50\\,\\%$: $0{,}4V+200 = 0{,}5V$, odtud $V = 2000$. To je $\\frac{2000}{5000} = 40\\,\\%$ → B.','15.3 Rychlost klesla na $\\frac{2}{3}$, čas je nepřímo úměrný, vzrostl tedy na $\\frac{3}{2}$, tj. o $50\\,\\%$ → D.'},
  '15.1: E (65,0 %); 15.2: B (40,0 %); 15.3: D (50,0 %)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený F16 – pyramida z kostek',
  new List<String>{'Pyramida z kostek se zdá být v poměrně havarijním stavu. V jejím plášti chybí spousta kostek.','16.1 Určete minimální počet kostek, které chybí k tomu, aby plášť pyramidy byl kompletní.','16.2 Určete minimální počet kostek, které chybí k tomu, aby pyramida včetně jejího vnitřku byla kompletní (tj. že pyramida nebude dutá).','16.3 Vypočtěte, kolik kostek bude potřeba k sestavení obdobné pyramidy o $10$ patrech tak, aby pyramida byla plná.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 320" font-family="sans-serif"> <polygon points="210,128 224,114 284,114 270,128" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="210" y="128" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <polygon points="150,188 164,174 224,174 210,188" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="150" y="188" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <polygon points="270,188 284,174 344,174 330,188" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="270" y="188" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <polygon points="90,248 104,234 164,234 150,248" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="90" y="248" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <polygon points="150,248 164,234 224,234 210,248" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="150" y="248" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <rect x="270" y="248" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> <polygon points="330,248 344,234 404,234 390,248" fill="#d0d0d0" stroke="#000" stroke-width="1.2"/> <rect x="330" y="248" width="60" height="60" fill="#efefef" stroke="#000" stroke-width="1.6"/> </svg>',
  'pyramida-kostky.svg',
  'Stupňovitá pyramida složená z krychlových kostek, v jejím plášti chybí několik kostek.',
  'Schematický nákres pyramidy z kostek',
  new List<String>{'16.1 Doplněním chybějících kostek ve viditelném plášti pyramidy zjistíme, že chybí $11$ kostek.','16.2 Aby byla pyramida plná i uvnitř (nedutá), je třeba doplnit celkem $25$ kostek.','16.3 Plná pyramida má v jednotlivých patrech čtvercové vrstvy $1^2, 2^2, \\ldots, 10^2$ kostek. Celkem $1^2+2^2+\\cdots+10^2 = \\frac{10\\cdot 11\\cdot 21}{6} = 385$ kostek.'},
  '16.1: $11$; 16.2: $25$; 16.3: $385$',
  6, 9, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
