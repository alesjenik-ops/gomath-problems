String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 7',
  new List<String>{'Slepením šedé krychle s povrchem $54\\ \\mathrm{cm}^2$ a bílého hranolu vznikne velký hranol $ABCDEFGH$ (viz obrázek). Nejdelší hrana bílého hranolu je o polovinu delší než hrana šedé krychle.','7.1 Vypočtěte v cm délku hrany šedé krychle.','7.2 Vypočtěte v $\\mathrm{cm}^3$ objem velkého hranolu $ABCDEFGH$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 154"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 75L466 75Z" style="fill:#000000"/><path d="M466 75L467 75L467 91L466 91Z" style="fill:#000000"/><path d="M466 91L467 91L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 128L466 128Z" style="fill:#000000"/><path d="M466 128L467 128L467 150L466 150Z" style="fill:#000000"/><path d="M423 123L447 99L447 31L423 54L423 123Z" style="fill:#d9d9d9"/><path d="M355 54L379 31L447 31L423 54L355 54Z" style="fill:#d9d9d9"/><path d="M355 55L423 55L423 123L355 123Z" style="fill:#d9d9d9"/><path d="M277 99L253 123M379 99L355 123M447 99L277 99M277 99L277 31M379 99L379 31M447 99L447 31M447 31L277 31M423 123L447 99M253 55L277 31M355 55L379 31M423 55L447 31M253 55L423 55L423 123L253 123ZM355 123L355 55" style="fill:none;stroke:#000000;stroke-width:2"/><text x="451" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="281" y="113" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text><text x="251" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">E</text><text x="451" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">G</text><text x="275" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">H</text><text x="422" y="53" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">F</text></svg>',
  'obr.svg',
  'Velký kvádr ABCDEFGH složený ze šedé krychle a bílého hranolu.',
  '',
  new List<String>{'7.1: $6a^2=54\\Rightarrow a^2=9\\Rightarrow a=3\\ \\mathrm{cm}$.','7.2: nejdelší hrana bílého hranolu je $1{,}5\\cdot3=4{,}5\\ \\mathrm{cm}$; bílý hranol má rozměry $3\\times3\\times4{,}5$, objem $40{,}5\\ \\mathrm{cm}^3$.','Krychle má objem $27\\ \\mathrm{cm}^3$, celkem $27+40{,}5=67{,}5\\ \\mathrm{cm}^3$.'},
  '7.1: $3\\ \\mathrm{cm}$; 7.2: $67{,}5\\ \\mathrm{cm}^3$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
