String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, náhradní termín (M9C)';
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
  'CERMAT 2021 M9C · úloha 9',
  new List<String>{'V rovině leží body $A$, $B$, $M$ (viz obrázek).','Body $A$, $B$ jsou vrcholy obdélníku $ABCD$. Bod $M$ leží na téže kružnici $k$ jako všechny vrcholy obdélníku $ABCD$.','9.1 Sestrojte střed kružnice $k$ a označte ho písmenem $S$.','9.2 Sestrojte vrcholy $C$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 357"><path d="M4 352L5 352L5 353L4 353Z" style="fill:#000000"/><path d="M4 352L5 352L5 353L4 353Z" style="fill:#000000"/><path d="M5 352L467 352L467 353L5 353Z" style="fill:#000000"/><path d="M467 352L468 352L468 353L467 353Z" style="fill:#000000"/><path d="M467 352L468 352L468 353L467 353Z" style="fill:#000000"/><path d="M4 4L5 4L5 352L4 352Z" style="fill:#000000"/><path d="M467 4L468 4L468 352L467 352Z" style="fill:#000000"/><path d="M98 194L104 200M98 200L104 194M312 303L317 309M312 309L317 303M219 42L225 47M219 47L225 42" style="fill:none;stroke:#000000;stroke-width:2"/><text x="97" y="214" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="315" y="323" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="224" y="40" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text></svg>',
  'obr.svg',
  'V rovině leží body A, B a M; A a B jsou vrcholy hledaného obdélníku ABCD, bod M leží na kružnici opsané obdélníku.',
  '',
  new List<String>{'Vrcholy obdélníku i bod $M$ leží na kružnici $k$. Její střed $S$ je průsečíkem os stran trojúhelníku $ABM$ (os úseček $AB$ a $BM$, resp. $AM$); $S$ je zároveň středem obdélníku.','Kružnice $k$ má střed $S$ a poloměr $|SA|$. Vrchol $C$ je obrazem $A$ ve středové souměrnosti podle $S$, vrchol $D$ obrazem $B$ podle $S$; oba leží na $k$. Obdélník $ABCD$ narýsujeme.'},
  'Konstrukce: střed $S$ (průsečík os stran trojúhelníku $ABM$) a obdélník $ABCD$ vepsaný do kružnice $k$ (max. $3$ body).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 10',
  new List<String>{'V rovině leží body $A$, $B$, $L$ (viz obrázek).','Body $A$, $B$ jsou vrcholy trojúhelníku $ABC$. Osy vnitřních úhlů $BAC$ a $ABC$ tohoto trojúhelníku procházejí bodem $L$.','Sestrojte vrchol $C$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 342"><path d="M4 338L5 338L5 338L4 338Z" style="fill:#000000"/><path d="M4 338L5 338L5 338L4 338Z" style="fill:#000000"/><path d="M5 338L467 338L467 338L5 338Z" style="fill:#000000"/><path d="M467 338L468 338L468 338L467 338Z" style="fill:#000000"/><path d="M467 338L468 338L468 338L467 338Z" style="fill:#000000"/><path d="M4 4L5 4L5 338L4 338Z" style="fill:#000000"/><path d="M467 4L468 4L468 338L467 338Z" style="fill:#000000"/><path d="M154 286L159 292M154 292L159 286M415 207L420 213M415 213L420 207M191 207L197 213M191 213L197 207" style="fill:none;stroke:#000000;stroke-width:2"/><text x="157" y="306" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="420" y="227" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="196" y="227" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">L</text></svg>',
  'obr.svg',
  'V rovině leží body A, B a L; A a B jsou vrcholy trojúhelníku ABC, bod L je průsečíkem os vnitřních úhlů u A a B.',
  '',
  new List<String>{'Bod $L$ je průsečíkem os vnitřních úhlů při vrcholech $A$ a $B$. Osu úhlu při $A$ určuje polopřímka $AL$, osu úhlu při $B$ polopřímka $BL$.','Rameno $AC$ získáme osovou souměrností polopřímky $AB$ podle přímky $AL$, rameno $BC$ osovou souměrností polopřímky $BA$ podle přímky $BL$. Vrchol $C$ je průsečíkem polopřímek $AC$ a $BC$.'},
  'Konstrukce vrcholu $C$ jako průsečíku ramen $AC$ a $BC$ souměrných s přímkou $AB$ podle os $AL$ a $BL$ (max. $2$ body).',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PCD21C0T03', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
