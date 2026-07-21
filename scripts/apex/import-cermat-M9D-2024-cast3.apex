String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. náhradní termín (M9D)';
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
  'CERMAT 2024 M9D · úloha 10',
  new List<String>{'V rovině leží body $C$, $S$ a přímka $p$. Bod $C$ je vrchol pravoúhlého trojúhelníku $ABC$, bod $S$ je střed strany $BC$ a strana $AB$ je rovnoběžná s přímkou $p$ (viz obrázek).','Sestrojte pravoúhlý trojúhelník $ABC$. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 505 451"><path d="M4 4L5 4L5 446L4 446Z" style="fill:#000000"/><path d="M4 446L5 446L5 447L4 447Z" style="fill:#000000"/><path d="M4 446L5 446L5 447L4 447Z" style="fill:#000000"/><path d="M5 446L456 446L456 447L5 447Z" style="fill:#000000"/><path d="M456 4L458 4L458 446L456 446Z" style="fill:#000000"/><path d="M456 446L458 446L458 447L456 447Z" style="fill:#000000"/><path d="M456 446L458 446L458 447L456 447Z" style="fill:#000000"/><path d="M141 325L366 203" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M104 155L109 162M109 155L104 162M210 172L215 178M215 172L210 178" style="fill:none;stroke:#000000;stroke-width:1"/><text x="56" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="105" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="111" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="143" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="170" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="187" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">. Bod</text><text x="204" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="297" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je vrchol pravoúhlého trojúhelníku</text><text x="395" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">ABC</text><text x="409" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="21" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Bod</text><text x="35" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="76" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">je střed strany</text><text x="120" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">BC</text><text x="196" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">tohoto trojúhelníku. Strana</text><text x="273" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="337" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">tohoto trojúhelníku je</text><text x="67" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">rovnoběžná s přímkou</text><text x="128" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="134" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="363" y="220" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="214" y="169" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="106" y="154" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'Body C, S a přímka p v rovině.',
  '',
  new List<String>{'Kružnice $k$ se středem $S$ a poloměrem $|SC|$ obsahuje vrchol $B$ ($S$ je střed $BC$); $B=k\\cap$ polopřímka $CS$.','Přímka $AB$ prochází bodem $B$ rovnoběžně s $p$; pravý úhel trojúhelníku určí vrchol $A$ (dvě řešení podle umístění pravého úhlu).'},
  'Kružnice $k(S,|SC|)$ dá vrchol $B$; přímka $AB\\parallel p$ prochází $B$; vrchol $A$ dopočteme z pravého úhlu (dvě řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 11',
  new List<String>{'Ráno tvořila dámská trička $60\\ \\%$ naskladněných triček, zbytek pánská. Přes den se prodalo $45$ dámských triček, což je čtvrtina všech dámských. Pánských se prodala polovina.','Kolik triček (dámských i pánských) zůstalo na konci dne?'},
  new List<String>{'A) méně než $200$','B) $200$','C) $210$','D) $220$','E) více než $220$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Dámských bylo $45\\cdot4=180$, což je $60\\ \\%$ celku, tedy celkem $300$ triček; pánských $120$.','Zůstalo dámských $180-45=135$, pánských $\\frac{120}{2}=60$; celkem $195$.'},
  'A) méně než $200$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
