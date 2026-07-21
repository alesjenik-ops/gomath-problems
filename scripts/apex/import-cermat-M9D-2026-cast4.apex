String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 9',
  new List<String>{'V rovině leží přímka $p$ a body $B$, $D$ (viz obrázek).','Body $B$, $D$ jsou vrcholy pravoúhlého rovnoramenného trojúhelníku $BCD$ s pravým úhlem při vrcholu $C$. Bod $C$ má od přímky $p$ větší vzdálenost než bod $B$.','9.1 Sestrojte vrchol $C$ trojúhelníku $BCD$ a označte ho písmenem.','9.2 Body $B$, $C$, $D$ jsou zároveň vrcholy lichoběžníku $ABCD$; vrchol $A$ leží na přímce $p$. Sestrojte vrchol $A$, označte ho a lichoběžník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 277"><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M4 4L5 4L5 5L4 5Z" style="fill:#000000"/><path d="M5 4L467 4L467 5L5 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M467 4L468 4L468 5L467 5Z" style="fill:#000000"/><path d="M4 5L5 5L5 24L4 24Z" style="fill:#000000"/><path d="M467 5L468 5L468 24L467 24Z" style="fill:#000000"/><path d="M4 272L5 272L5 273L4 273Z" style="fill:#000000"/><path d="M4 272L5 272L5 273L4 273Z" style="fill:#000000"/><path d="M5 272L467 272L467 273L5 273Z" style="fill:#000000"/><path d="M467 272L468 272L468 273L467 273Z" style="fill:#000000"/><path d="M467 272L468 272L468 273L467 273Z" style="fill:#000000"/><path d="M4 24L5 24L5 272L4 272Z" style="fill:#000000"/><path d="M467 24L468 24L468 272L467 272Z" style="fill:#000000"/><path d="M280 204L286 210M286 204L280 210M259 81L264 87M264 81L259 87M80 41L226 254" style="fill:none;stroke:#000000;stroke-width:2"/><text x="60" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží přímka</text><text x="113" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="136" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a body</text><text x="158" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="164" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="171" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="177" y="21" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="283" y="224" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="263" y="79" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="79" y="55" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'Přímka p a body B, D v rovině.',
  '',
  new List<String>{'9.1: pravý úhel u $C$ znamená, že $C$ leží na Thaletově kružnici nad $BD$; rovnoramennost ($CB=CD$) dává $C$ na ose úsečky $BD$. Průsečík dál od $p$ je hledaný vrchol $C$.','9.2: vrchol $A$ leží na přímce $p$ tak, aby $ABCD$ byl lichoběžník (např. $AB\\parallel DC$); úloha má více řešení.'},
  'Vrchol $C$ je průsečík Thaletovy kružnice nad $BD$ a osy $BD$ (dál od $p$); vrchol $A$ leží na $p$ tak, aby $ABCD$ byl lichoběžník (více řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
