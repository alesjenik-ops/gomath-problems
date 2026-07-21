String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. náhradní termín (M9D)';
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
  'CERMAT 2025 M9D · úloha 10',
  new List<String>{'V rovině leží body $L$, $M$ a přímka $p$ procházející bodem $M$ (viz obrázek).','Body $L$, $M$ jsou vrcholy rovnoběžníku $KLMN$. Na přímce $p$ leží střed souměrnosti $S$ rovnoběžníku. Délka strany $LM$ je stejná jako délka úhlopříčky $LN$.','Sestrojte střed $S$ a vrcholy $K$, $N$, označte je a rovnoběžník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 502 308"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 243L5 243L5 244L4 244Z" style="fill:#000000"/><path d="M4 243L5 243L5 244L4 244Z" style="fill:#000000"/><path d="M5 243L467 243L467 244L5 244Z" style="fill:#000000"/><path d="M467 243L468 243L468 244L467 244Z" style="fill:#000000"/><path d="M467 243L468 243L468 244L467 244Z" style="fill:#000000"/><path d="M4 23L5 23L5 243L4 243Z" style="fill:#000000"/><path d="M467 23L468 23L468 243L467 243Z" style="fill:#000000"/><path d="M254 199L259 205M259 199L254 205M406 120L24 169M380 118L381 127" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="103" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="108" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="144" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a přímka</text><text x="172" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="227" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">procházející bodem</text><text x="284" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="291" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="11" y="257" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">(</text><text x="22" y="257" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="35" y="257" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="432" y="272" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">max. 3 body</text><text x="16" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10</text><text x="59" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Body</text><text x="75" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="81" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="88" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="161" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">jsou vrcholy rovnoběžníku</text><text x="244" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">KLMN</text><text x="262" y="286" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="72" y="302" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Na přímce</text><text x="102" y="302" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="130" y="302" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">leží střed</text><text x="157" y="302" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="251" y="302" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">souměrnosti tohoto rovnoběžníku.</text><text x="257" y="219" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text><text x="402" y="134" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="388" y="118" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text></svg>',
  'obr.svg',
  'Body L, M a přímka p procházející bodem M.',
  '',
  new List<String>{'Střed $S$ je střed úhlopříčky $KM$ i $LN$; leží na přímce $p$ a zároveň je středem úsečky $LN$ s $|LN|=|LM|$.','Bod $N$ leží na kružnici se středem $L$ a poloměrem $|LM|$; jeho střed s $L$ (tj. $S$) leží na $p$. Odtud $S$, pak $N$ jako obraz $L$ podle $S$ a $K$ jako obraz $M$ podle $S$ (dvě řešení).'},
  'Střed $S$ leží na $p$ a je středem úsečky $LN$ s $|LN|=|LM|$; $N$ je obraz $L$ a $K$ obraz $M$ podle $S$ (dvě řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
