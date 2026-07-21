String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 9',
  new List<String>{'V rovině leží body P, Q, R a přímka $a$ (viz obrázek).','Na přímce $a$ leží strana AB čtverce ABCD. Dva ze tří bodů P, Q, R leží uvnitř dvou různých stran tohoto čtverce a třetí bod leží vně čtverce ABCD.','Sestrojte všechny vrcholy čtverce ABCD, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 249"><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M5 4L467 4L467 5L5 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M4 5L5 5L5 24L4 24Z" style="fill:#000000"/><path d="M467 5L468 5L468 24L467 24Z" style="fill:#000000"/><path d="M4 244L5 244L5 245L4 245Z" style="fill:#000000"/><path d="M4 244L5 244L5 245L4 245Z" style="fill:#000000"/><path d="M5 244L467 244L467 245L5 245Z" style="fill:#000000"/><path d="M467 244L468 244L468 245L467 245Z" style="fill:#000000"/><path d="M467 244L468 244L468 245L467 245Z" style="fill:#000000"/><path d="M4 24L5 24L5 244L4 244Z" style="fill:#000000"/><path d="M467 24L468 24L468 244L467 244Z" style="fill:#000000"/><path d="M155 125L150 120M150 125L155 120M183 99L177 93M177 99L183 93M299 172L293 166M293 172L299 166M66 170L364 223" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="109" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Q</text><text x="122" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="128" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="155" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="182" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="188" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="144" y="129" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="175" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Q</text><text x="306" y="175" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="72" y="184" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text></svg>',
  'obr.svg',
  'V rovině leží body P, Q, R a přímka a.',
  '',
  new List<String>{'Dvojice bodů ležících na stranách čtverce určuje polohu čtverce: strana AB leží na přímce $a$, protilehlá strana DC je s ní rovnoběžná ve vzdálenosti rovné straně čtverce, boční strany jsou k $a$ kolmé.','Vyzkoušíme, které dva z bodů P, Q, R mohou ležet uvnitř stran čtverce (jeden na některé straně, druhý na jiné) tak, aby třetí bod ležel vně; podle toho sestrojíme čtverec. Jde o konstrukční úlohu — hledáme všechna řešení; hodnotí se přesnost a úplnost.'},
  'Konstrukce čtverce ABCD (AB na přímce $a$, dva z bodů P, Q, R uvnitř dvou stran, třetí vně); nutno nalézt všechna řešení.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
