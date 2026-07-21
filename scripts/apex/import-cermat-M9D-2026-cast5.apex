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
  'CERMAT 2026 M9D · úloha 10',
  new List<String>{'V rovině leží body $D$, $S$, $U$ (viz obrázek).','Bod $D$ je vrchol obdélníku $ABCD$. Bod $S$ je střed kružnice $k$, na níž leží všechny vrcholy tohoto obdélníku. Bodem $U$ prochází přímka $u$, na které leží vrcholy $A$, $C$ obdélníku $ABCD$.','Sestrojte kružnici $k$ a vrcholy $A$, $B$, $C$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 319"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M467 4L468 4L468 23L467 23Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M4 314L5 314L5 315L4 315Z" style="fill:#000000"/><path d="M5 314L467 314L467 315L5 315Z" style="fill:#000000"/><path d="M467 314L468 314L468 315L467 315Z" style="fill:#000000"/><path d="M467 314L468 314L468 315L467 315Z" style="fill:#000000"/><path d="M4 23L5 23L5 314L4 314Z" style="fill:#000000"/><path d="M467 23L468 23L468 314L467 314Z" style="fill:#000000"/><path d="M72 88L78 94M78 88L72 94M172 161L178 167M178 161L172 167M360 138L366 143M366 138L360 143" style="fill:none;stroke:#000000;stroke-width:2"/><text x="55" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="111" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="122" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="128" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">U</text><text x="134" y="20" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="76" y="86" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="176" y="181" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="363" y="158" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">U</text></svg>',
  'obr.svg',
  'Body D, S, U v rovině.',
  '',
  new List<String>{'Kružnice $k$ má střed $S$ a poloměr $|SD|$ (opsaná kružnice obdélníku).','Úhlopříčka $AC$ prochází středem $S$, proto přímka $u=SU$; vrcholy $A$, $C$ jsou průsečíky přímky $u$ s kružnicí $k$.','Vrchol $B$ je obraz $D$ ve středové souměrnosti podle $S$.'},
  'Kružnice $k(S,|SD|)$; $A$, $C$ jsou průsečíky přímky $SU$ s $k$; vrchol $B$ je obraz $D$ podle středu $S$.',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
