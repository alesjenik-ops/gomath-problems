String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
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
  'CERMAT 2024 M9C · úloha 7',
  new List<String>{'V parku jsou $3$ okrasné záhony: první a třetí (stejné) mají tvar čtvrtkruhu, druhý tvar kruhu. Každý záhon má obsah $314\\ \\mathrm{dm}^2$ (počítejte s $\\pi\\doteq3{,}14$).','7.1 Vypočítejte obvod druhého (kruhového) záhonu (v celých metrech).','7.2 Vypočítejte poloměr $r$ jednoho čtvrtkruhového záhonu (v celých metrech).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 464 147"><path d="M34 143C5 114 4 67 33 37C33 37 34 36 34 36L86 89L34 143M252 143C281 114 282 67 253 37C253 37 253 36 252 36L200 89L252 143" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M103 89C103 68 120 50 142 50C163 50 180 68 180 89C180 111 163 128 142 128C120 128 103 111 103 89Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M243 98L247 98L247 105L243 105Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M85 100L89 100L89 107L85 107Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M61 100L65 100L65 106L61 106Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M220 98L223 98L223 105L220 105Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><text x="88" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">druhý záhon má tvar kruhu. Každý ze tří záhonů má obsah 314 dm</text><text x="258" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">.</text><text x="45" y="96" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. záhon</text><text x="64" y="129" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">r</text><text x="221" y="130" font-size="14" fill="#000" text-anchor="middle" font-family="sans-serif">r</text><text x="146" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. záhon</text><text x="244" y="96" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. záhon</text></svg>',
  'obr.svg',
  'Tři okrasné záhony: první a třetí ve tvaru čtvrtkruhu o poloměru r a druhý ve tvaru kruhu.',
  '',
  new List<String>{'7.1: $\\pi r_2^2=314\\Rightarrow r_2^2=100\\Rightarrow r_2=10\\ \\mathrm{dm}$; obvod $2\\pi r_2=62{,}8\\ \\mathrm{dm}\\doteq6\\ \\mathrm{m}$.','7.2: $\\frac{1}{4}\\pi r^2=314\\Rightarrow r^2=400\\Rightarrow r=20\\ \\mathrm{dm}=2\\ \\mathrm{m}$.'},
  '7.1: $6\\ \\mathrm{m}$; 7.2: $2\\ \\mathrm{m}$',
  4, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
