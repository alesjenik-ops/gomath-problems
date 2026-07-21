String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 12',
  new List<String>{'V rovině leží přímka AB a rovnoběžník ABCD. Rovnoběžník má vnitřní úhly o velikostech $\\alpha$, $\\delta$ (viz obrázek). Při vrcholu A svírá strana AD s přímkou AB na jedné straně úhel $\\alpha$ (vnitřní úhel rovnoběžníku) a na druhé straně úhel $4\\alpha$.','Jaká je velikost úhlu $\\delta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $108^\\circ$','B) $108^\\circ$','C) $135^\\circ$','D) $144^\\circ$','E) větší než $144^\\circ$'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 118"><path d="M4 4L467 4L467 5L4 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 5L468 5L468 24L467 24Z" style="fill:#000000"/><path d="M467 24L468 24L468 43L467 43Z" style="fill:#000000"/><path d="M467 43L468 43L468 62L467 62Z" style="fill:#000000"/><path d="M467 62L468 62L468 87L467 87Z" style="fill:#000000"/><path d="M467 87L468 87L468 114L467 114Z" style="fill:#000000"/><path d="M431 93L267 93M324 93L394 25L446 25L376 93L324 93" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M344 72C350 78 353 85 353 93M412 25C412 32 407 39 400 42C394 44 386 43 381 37M303 93C303 84 308 76 316 73C324 70 333 72 339 78" style="fill:none;stroke:#000000;stroke-width:1"/><text x="322" y="107" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="379" y="107" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="451" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="393" y="23" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="344" y="90" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="397" y="39" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛿</text><text x="315" y="89" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="322" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text></svg>',
  'obr.svg',
  'Přímka AB a rovnoběžník ABCD; při vrcholu A jsou vyznačeny úhly 4α a α, při vrcholu D úhel δ.',
  '',
  new List<String>{'Úhly $4\\alpha$ a $\\alpha$ leží u vrcholu A na přímce AB, dohromady tvoří přímý úhel: $4\\alpha+\\alpha=180^\\circ\\Rightarrow5\\alpha=180^\\circ\\Rightarrow\\alpha=36^\\circ$.','V rovnoběžníku jsou sousední úhly doplňkové: $\\delta=180^\\circ-\\alpha=180^\\circ-36^\\circ=144^\\circ$.'},
  'D) $144^\\circ$',
  2, 3, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','vypocet','vyber','bez-kalkulacky'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
