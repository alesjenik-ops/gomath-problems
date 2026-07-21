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
  'CERMAT 2025 M9D · úloha 9',
  new List<String>{'V rovině leží body $A$, $A\'$ a $M$ (viz obrázek).','Bod $A$ je vrchol rovnostranného trojúhelníku $ABC$. Na přímce $AM$ leží vrchol $C$. Bod $A\'$ je vrchol trojúhelníku $A\'B\'C$, který je obrazem $ABC$ v osové souměrnosti s osou $o$. Oba trojúhelníky mají společný jen vrchol $C$.','9.1 Sestrojte osu $o$ a označte ji.','9.2 Sestrojte všechny chybějící vrcholy obou trojúhelníků, označte je a oba trojúhelníky narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 333"><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M4 18L5 18L5 19L4 19Z" style="fill:#000000"/><path d="M5 18L467 18L467 19L5 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M467 18L468 18L468 19L467 19Z" style="fill:#000000"/><path d="M4 19L5 19L5 38L4 38Z" style="fill:#000000"/><path d="M467 19L468 19L468 38L467 38Z" style="fill:#000000"/><path d="M4 38L5 38L5 329L4 329Z" style="fill:#000000"/><path d="M467 38L468 38L468 329L467 329Z" style="fill:#000000"/><path d="M208 286L214 292M214 286L208 292M110 164L115 170M115 164L110 170M235 99L240 105M240 99L235 105" style="fill:none;stroke:#000000;stroke-width:2"/><text x="111" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">VÝCHOZÍ TEXT A OBRÁZEK K ÚLOZE 9</text><text x="55" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V rovině leží body</text><text x="104" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="110" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="116" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="121" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">′</text><text x="128" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">a</text><text x="138" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="145" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="100" y="173" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="105" y="173" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">′</text><text x="249" y="108" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">M</text></svg>',
  'obr.svg',
  'Body A, A\' a M v rovině.',
  '',
  new List<String>{'Vrchol $C$ je společný oběma trojúhelníkům; leží na přímce $AM$. Osa $o$ prochází bodem $C$ a je osou úsečky $AA\'$ (souměrnost zobrazuje $A$ na $A\'$).','9.2: $C=AM\\cap o$; trojúhelník $ABC$ je rovnostranný ($|AB|=|BC|=|CA|$), $A\'B\'C$ je jeho obraz v souměrnosti podle $o$.'},
  'Osa $o$ je osou úsečky $AA\'$ a prochází bodem $C=AM\\cap o$; $ABC$ je rovnostranný a $A\'B\'C$ jeho obraz v souměrnosti podle $o$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PDD25C0T04', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
