String SRC   = 'CERMAT – Ilustrační test 2020, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2020 M9I · úloha 7',
  new List<String>{'Při 1. vyučovací hodině bylo v aule čtyřikrát více chlapců než dívek. O přestávce před 2. vyučovací hodinou z auly odešlo $10$ dívek a $20$ chlapců.','Počet dívek, které byly v aule při 1. vyučovací hodině, označte $d$.','7.1 V závislosti na veličině $d$ vyjádřete počet chlapců, kteří v aule zůstali na 2. vyučovací hodinu.','7.2 Určete počet dívek v aule při 1. vyučovací hodině, jestliže po přestávce zůstalo v aule pětkrát více chlapců než dívek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: chlapců bylo $4d$; po odchodu $20$ jich zůstalo $4d-20$.','7.2: dívek zůstalo $d-10$; z podmínky $4d-20=5\\cdot(d-10)$ plyne $4d-20=5d-50$, tedy $d=30$.'},
  '7.1: $4d-20$; 7.2: $30$ dívek',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 8',
  new List<String>{'V krychli mají každé dvě sousední stěny jednu společnou hranu. V síti krychle mohou být některé sousední stěny krychle odděleny. Pak tutéž hranu krychle představují dvě různé úsečky sítě (označené tmavými kolečky).','V každé ze tří sítí krychle (8.1, 8.2, 8.3) je tmavým kolečkem označena jedna z obou úseček představujících tutéž hranu krychle.','Dalším kolečkem označte druhou z těchto úseček.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 425 85"><path d="M81 55L106 55L106 81L81 81ZM30 29L55 29L55 55L30 55ZM55 29L80 29L80 55L55 55ZM4 4L29 4L29 30L4 30ZM55 55L80 55L80 81L55 81ZM30 4L55 4L55 30L30 30ZM236 4L262 4L262 29L236 29ZM186 29L211 29L211 55L186 55ZM211 29L236 29L236 55L211 55ZM160 29L185 29L185 55L160 55ZM211 55L236 55L236 80L211 80ZM211 4L236 4L236 29L211 29ZM392 30L418 30L418 55L392 55ZM341 30L367 30L367 55L341 55ZM367 30L392 30L392 55L367 55ZM316 4L341 4L341 29L316 29ZM367 55L392 55L392 80L367 80ZM341 4L367 4L367 29L341 29Z" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M14 29C14 28 15 27 17 27C18 27 20 28 20 29C20 31 18 32 17 32C15 32 14 31 14 29Z" style="fill:#000000;stroke:#000000;stroke-width:2"/><path d="M170 29C170 28 171 27 173 27C174 27 176 28 176 29C176 31 174 32 173 32C171 32 170 31 170 29Z" style="fill:#000000;stroke:#000000;stroke-width:2"/><path d="M415 42C415 41 416 39 418 39C419 39 421 41 421 42C421 44 419 45 418 45C416 45 415 44 415 42Z" style="fill:#000000;stroke:#000000;stroke-width:2"/></svg>',
  'obr.svg',
  'Tři sítě krychle (8.1, 8.2, 8.3) složené ze čtverců; v každé je jedna hraniční úsečka označena tmavým kolečkem.',
  '',
  new List<String>{'Síť v představě složíme do krychle. Hraniční úsečka označená kolečkem se při složení ztotožní s jinou hraniční úsečkou sítě — obě dvě představují tutéž hranu krychle. Právě tuto druhou úsečku v každé síti označíme dalším kolečkem.','Jde o úlohu s nákresovým řešením; hodnotí se správné vyznačení druhé úsečky ve všech třech sítích (8.1–8.3).'},
  'V každé ze tří sítí (8.1–8.3) se dalším kolečkem vyznačí druhá úsečka představující tutéž hranu krychle (nákresové řešení).',
  3, 6, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','soumernost','uvazovani','rysovani'},
  'M9PID20C0T01', 2020
);
c.add(
  'CERMAT 2020 M9I · úloha 9',
  new List<String>{'V rovině leží trojúhelník $AXY$ (viz obrázek).','Bod $A$ je vrchol kosočtverce $ABCD$. Strany $AB$ a $AD$ tohoto kosočtverce leží na polopřímkách $AX$ a $AY$. Výška kosočtverce $ABCD$ je rovna délce úsečky $AY$.','Sestrojte vrcholy $B$, $C$, $D$ kosočtverce $ABCD$, označte je písmeny a kosočtverec narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 125 121"><path d="M10 101L91 14L112 101L10 101" style="fill:none;stroke:#000000;stroke-width:2"/><text x="7" y="115" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="93" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Y</text><text x="115" y="115" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text></svg>',
  'obr.svg',
  'Trojúhelník AXY: vrchol A vlevo dole, X vpravo dole, Y nahoře.',
  '',
  new List<String>{'Kosočtverec má všechny strany shodné a jeho výška (vzdálenost dvojice rovnoběžných stran) je rovna $|AY|$.','Vrchol $B$ leží na polopřímce $AX$, vrchol $D$ na polopřímce $AY$. Strana $DC$ je rovnoběžná se stranou $AB$ ve vzdálenosti $|AY|$ a strana $BC$ je rovnoběžná se stranou $AD$; jejich průsečíkem je vrchol $C$. Podmínka $|AB|=|AD|$ zajistí, že $ABCD$ je kosočtverec.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce kosočtverce $ABCD$ se stranami na polopřímkách $AX$, $AY$ a výškou $|AY|$ (nákresové řešení).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani'},
  'M9PID20C0T01', 2020
);

System.debug('Vytvořeno úloh: '+c.created);
