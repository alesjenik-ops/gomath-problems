String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
Integer YEAR = 2021;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5A 2021 – úloha 11',
  new List<String>{'Stejná trička a stejné mikiny se prodávaly ve $3$ různých obchodech (A–C) za různé ceny. Graf udává počty prodaných kusů (mikiny bílé, trička šedé).','Z ceníku: cena jednoho trička v obchodě B je $180$ Kč; za prodaná trička utržili v A $1\\,000$ Kč; cena jedné mikiny v A je $500$ Kč; za prodané mikiny utržili v A $6\\,000$ Kč a v C $7\\,200$ Kč. (Ostatní údaje tabulky nejsou zadány.)','Tričko se v obchodě C prodávalo o $40$ Kč levněji než v obchodě A. V obchodě B utržili za prodaná trička dohromady tolik korun jako za prodané mikiny.','Kolik korun utržili v obchodě C za všechna prodaná trička?'},
  new List<String>{'A) $960$ Kč','B) $1\\,050$ Kč','C) $1\\,260$ Kč','D) $1\\,740$ Kč','E) více než $1\\,740$ Kč'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 340" font-family="sans-serif"><line x1="64" y1="44" x2="64" y2="300" stroke="#000"/><line x1="64" y1="300" x2="430" y2="300" stroke="#000"/><line x1="60" y1="300" x2="64" y2="300" stroke="#000"/><text x="56" y="304" font-size="11" text-anchor="end">0</text><line x1="64" y1="268" x2="410" y2="268" stroke="#dddddd"/><line x1="60" y1="268" x2="64" y2="268" stroke="#000"/><text x="56" y="272" font-size="11" text-anchor="end">4</text><line x1="64" y1="236" x2="410" y2="236" stroke="#dddddd"/><line x1="60" y1="236" x2="64" y2="236" stroke="#000"/><text x="56" y="240" font-size="11" text-anchor="end">8</text><line x1="64" y1="204" x2="410" y2="204" stroke="#dddddd"/><line x1="60" y1="204" x2="64" y2="204" stroke="#000"/><text x="56" y="208" font-size="11" text-anchor="end">12</text><line x1="64" y1="172" x2="410" y2="172" stroke="#dddddd"/><line x1="60" y1="172" x2="64" y2="172" stroke="#000"/><text x="56" y="176" font-size="11" text-anchor="end">16</text><line x1="64" y1="140" x2="410" y2="140" stroke="#dddddd"/><line x1="60" y1="140" x2="64" y2="140" stroke="#000"/><text x="56" y="144" font-size="11" text-anchor="end">20</text><line x1="64" y1="108" x2="410" y2="108" stroke="#dddddd"/><line x1="60" y1="108" x2="64" y2="108" stroke="#000"/><text x="56" y="112" font-size="11" text-anchor="end">24</text><line x1="64" y1="76" x2="410" y2="76" stroke="#dddddd"/><line x1="60" y1="76" x2="64" y2="76" stroke="#000"/><text x="56" y="80" font-size="11" text-anchor="end">28</text><line x1="64" y1="44" x2="410" y2="44" stroke="#dddddd"/><line x1="60" y1="44" x2="64" y2="44" stroke="#000"/><text x="56" y="48" font-size="11" text-anchor="end">32</text><text x="18" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 18 170)">Počet prodaných kusů</text><rect x="110" y="204" width="58" height="96" fill="#ffffff" stroke="#000"/><rect x="110" y="172" width="58" height="32" fill="#a9a9a9" stroke="#000"/><text x="139.0" y="316" font-size="12" text-anchor="middle">A</text><rect x="200" y="220" width="58" height="80" fill="#ffffff" stroke="#000"/><rect x="200" y="60" width="58" height="160" fill="#a9a9a9" stroke="#000"/><text x="229.0" y="316" font-size="12" text-anchor="middle">B</text><rect x="290" y="140" width="58" height="160" fill="#ffffff" stroke="#000"/><rect x="290" y="92" width="58" height="48" fill="#a9a9a9" stroke="#000"/><text x="319.0" y="316" font-size="12" text-anchor="middle">C</text><text x="200" y="332" font-size="12" text-anchor="middle">Obchod</text><rect x="360" y="70" width="14" height="14" fill="#a9a9a9" stroke="#000"/><text x="380" y="82" font-size="12">Trička</text><rect x="360" y="92" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="380" y="104" font-size="12">Mikiny</text></svg>',
  'graf-tricka-mikiny.svg',
  'Skládaný sloupcový graf počtu prodaných kusů v obchodech A, B, C: A mikiny 12 a trička 4, B mikiny 10 a trička 20, C mikiny 20 a trička 6.',
  'Počet prodaných kusů v obchodech A–C',
  new List<String>{'V obchodě A se prodala $4$ trička za $1\\,000$ Kč, cena trička v A je tedy $250$ Kč. V obchodě C bylo tričko o $40$ Kč levnější, tj. $210$ Kč. Z grafu se v C prodalo $6$ triček, tržba $6\\cdot 210=1\\,260$ Kč.'},
  'C) $1\\,260$ Kč',
  2, 4, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
