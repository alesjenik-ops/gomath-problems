String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, náhradní termín (M9C)';
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
  'CERMAT 2023 M9C · úloha 9',
  new List<String>{'V rovině leží přímka AB a přímka $p$ procházející bodem B (viz obrázek).','Úsečka AB je strana pravoúhlého lichoběžníku ABCD. Vrchol C tohoto lichoběžníku leží na přímce $p$, úhlopříčka AC má stejnou délku jako strana AB lichoběžníku ABCD.','Sestrojte vrcholy C, D lichoběžníku ABCD, označte je písmeny a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 305"><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M5 4L467 4L467 5L5 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M4 5L5 5L5 24L4 24Z" style="fill:#000000"/><path d="M467 5L468 5L468 24L467 24Z" style="fill:#000000"/><path d="M4 24L5 24L5 301L4 301Z" style="fill:#000000"/><path d="M467 24L468 24L468 301L467 301Z" style="fill:#000000"/><path d="M359 163L99 282M375 216L165 41" style="fill:none;stroke:#000000;stroke-width:2"/><text x="60" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží přímka</text><text x="116" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">AB</text><text x="147" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="174" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="229" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">procházející bodem</text><text x="284" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="290" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="327" y="194" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text></svg>',
  'obr.svg',
  'V rovině leží úsečka AB a přímka p procházející bodem B.',
  '',
  new List<String>{'Vrchol C leží na přímce $p$ a zároveň na kružnici se středem A a poloměrem $|AB|$ (podmínka $|AC|=|AB|$) — sestrojíme průsečík. V pravoúhlém lichoběžníku jsou pravé úhly při vrcholech A a D; vrchol D získáme jako patu kolmice z C na přímku AB (resp. sestrojením strany DA kolmé k AB). Podle počtu průsečíků přímky $p$ s kružnicí může úloha mít jedno nebo dvě řešení.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce pravoúhlého lichoběžníku ABCD (C na přímce $p$, $|AC|=|AB|$); nutno nalézt všechna řešení.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PCD23C0T03', 2023
);
c.add(
  'CERMAT 2023 M9C · úloha 10',
  new List<String>{'V rovině leží body A, C a přímka $p$ procházející bodem C (viz obrázek).','Úsečka AC je základna rovnoramenného trojúhelníku ABC. Na přímce $p$ leží jedna ze tří výšek tohoto trojúhelníku.','10.1 Sestrojte osu souměrnosti trojúhelníku ABC a označte ji písmenem $o$.','10.2 Sestrojte vrchol B trojúhelníku ABC, označte ho písmenem a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 256"><path d="M4 4L5 4L5 252L4 252Z" style="fill:#000000"/><path d="M467 4L468 4L468 252L467 252Z" style="fill:#000000"/><path d="M131 211L125 205M131 205L125 211M200 227L67 23M91 52L84 56" style="fill:none;stroke:#000000;stroke-width:2"/><text x="128" y="226" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="78" y="65" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'V rovině leží body A, C a přímka p procházející bodem C.',
  '',
  new List<String>{'Osa souměrnosti $o$ rovnoramenného trojúhelníku se základnou AC je osa úsečky AC (prochází středem AC kolmo k AC). Výška na přímce $p$ prochází bodem C; vrchol B najdeme jako průsečík přímky $p$ (resp. odpovídající konstrukce výšky) s osou $o$ tak, aby ABC byl rovnoramenný se základnou AC.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce osy $o$ (osa úsečky AC) a vrcholu B rovnoramenného trojúhelníku ABC.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PCD23C0T03', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
