String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. náhradní termín (M9C)';
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
  'CERMAT 2025 M9C · úloha 12',
  new List<String>{'Na hřišti je uzavřený okruh z $5$ rovných úseků, některé sousední úseky jsou na sebe kolmé (viz obrázek). Jirka prošel okruh stejně dlouhými kroky; do plánku zaznamenal počty kroků na prvních čtyřech úsecích ($30$, $35$, $50$, $100$).','Kolika kroky prošel Jirka poslední úsek okruhu?'},
  new List<String>{'A) méně než $85$ kroky','B) $85$ kroky','C) $90$ kroky','D) $95$ kroky','E) $100$ kroky'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 154 170"><path d="M149 4L150 4L150 23L149 23Z" style="fill:#000000"/><path d="M149 23L150 23L150 39L149 39Z" style="fill:#000000"/><path d="M149 39L150 39L150 55L149 55Z" style="fill:#000000"/><path d="M149 55L150 55L150 73L149 73Z" style="fill:#000000"/><path d="M149 73L150 73L150 89L149 89Z" style="fill:#000000"/><path d="M149 89L150 89L150 108L149 108Z" style="fill:#000000"/><path d="M149 108L150 108L150 127L149 127Z" style="fill:#000000"/><path d="M27 25C27 30 26 34 23 37C20 39 16 41 12 41M41 26C41 30 43 34 46 37C49 40 53 41 57 41M73 79C73 71 66 64 57 64" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M17 32C17 32 18 31 18 31C19 31 19 32 19 32C19 33 19 33 18 33C18 33 17 33 17 32Z" style="fill:#000000"/><path d="M49 32C49 32 50 31 50 31C51 31 51 32 51 32C51 33 51 33 50 33C50 33 49 33 49 32Z" style="fill:#000000"/><path d="M62 73C62 72 63 72 63 72C64 72 65 72 65 73C65 73 64 74 63 74C63 74 62 73 62 73Z" style="fill:#000000"/><path d="M12 166L138 79M138 79L57 79M57 26L57 79M57 26L12 26M12 166L12 26" style="fill:none;stroke:#000000;stroke-width:2"/><text x="99" y="77" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">50</text><text x="68" y="59" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">35</text><text x="36" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="7" y="101" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">?</text></svg>',
  'obr.svg',
  'Plánek uzavřeného okruhu z pěti rovných úseků s vyznačenými kolmostmi a délkami 30, 35, 50, 100 kroků a neznámým posledním úsekem.',
  '',
  new List<String>{'Okruh je uzavřený; z vyznačených kolmostí a Pythagorovy věty (úsek délky $100$ kroků je přeponou pravoúhlého trojúhelníku s odvěsnami danými zbývajícími úseky) vychází poslední úsek $95$ kroků.'},
  'D) $95$ kroky',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','bez-kalkulacky','bezny-zivot'},
  'M9PCD25C0T03', 2025
);
c.add(
  'CERMAT 2025 M9C · úloha 13',
  new List<String>{'Na každé stěně krychle je úhlopříčka přelepena pěti shodnými šedými čtverci tak, že sousední čtverce mají právě jeden společný vrchol (viz obrázek). Nepolepená část každé stěny je bílá. Součet obsahů všech bílých ploch na povrchu krychle je $480\\ \\mathrm{cm}^2$.','Jakou délku má hrana krychle?'},
  new List<String>{'A) méně než $10\\ \\mathrm{cm}$','B) $10\\ \\mathrm{cm}$','C) $12\\ \\mathrm{cm}$','D) $15\\ \\mathrm{cm}$','E) $20\\ \\mathrm{cm}$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 464 9"><path d="M4 4L460 4L460 5L4 5Z" style="fill:#000000"/></svg>',
  'obr.svg',
  'Krychle, na každé stěně je úhlopříčka přelepena pěti šedými čtverci spojenými vrcholy.',
  '',
  new List<String>{'Pět čtverců o straně $s$ podél úhlopříčky stěny (spojených vrcholy) dává úhlopříčku stěny $5s\\sqrt{2}$, tedy hrana $a=5s$.','Šedá plocha stěny $5s^2$, bílá $a^2-5s^2=25s^2-5s^2=20s^2$. Za $6$ stěn $120s^2=480\\Rightarrow s=2$, tedy $a=5\\cdot2=10\\ \\mathrm{cm}$.'},
  'B) $10\\ \\mathrm{cm}$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD25C0T03', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
