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
  'CERMAT 2026 M9D · úloha 6',
  new List<String>{'Obdélník $ABCD$ je složen z bílého a šedého obdélníku jako na obrázku. Obvod obdélníku $ABCD$ je $68\\ \\mathrm{cm}$ a délka strany $BC$ je $10\\ \\mathrm{cm}$. Obvod šedého obdélníku je o $12\\ \\mathrm{cm}$ větší než obvod bílého obdélníku.','6.1 Vypočtěte v cm délku strany $AB$ obdélníku $ABCD$.','6.2 Vypočtěte v $\\mathrm{cm}^2$ obsah šedého obdélníku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 135"><path d="M4 4L466 4L466 5L4 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 4L467 4L467 5L466 5Z" style="fill:#000000"/><path d="M466 5L467 5L467 24L466 24Z" style="fill:#000000"/><path d="M466 24L467 24L467 40L466 40Z" style="fill:#000000"/><path d="M466 40L467 40L467 58L466 58Z" style="fill:#000000"/><path d="M466 58L467 58L467 74L466 74Z" style="fill:#000000"/><path d="M466 74L467 74L467 93L466 93Z" style="fill:#000000"/><path d="M466 93L467 93L467 109L466 109Z" style="fill:#000000"/><path d="M466 109L467 109L467 131L466 131Z" style="fill:#000000"/><path d="M304 31L355 31L355 104L304 104Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><path d="M355 31L448 31L448 104L355 104Z" style="fill:#b2b2b2;stroke:#000000;stroke-width:2"/><text x="302" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="451" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="451" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="303" y="29" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">D</text></svg>',
  'obr.svg',
  'Obdélník ABCD složený z bílého a šedého obdélníku.',
  '',
  new List<String>{'6.1: $2(AB+10)=68\\Rightarrow AB=24\\ \\mathrm{cm}$.','6.2: šířky bílého $w$ a šedého $24-w$ (výška $10$). Rozdíl obvodů $2\\big((24-w)-w\\big)=12\\Rightarrow w=9$; šedý má šířku $15$, obsah $15\\cdot10=150\\ \\mathrm{cm}^2$.'},
  '6.1: $24\\ \\mathrm{cm}$; 6.2: $150\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
