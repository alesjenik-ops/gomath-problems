String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
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
  'CERMAT 2025 M9A · úloha 7',
  new List<String>{'V rovině leží přímky $p$, $q$, $r$, které se protínají v bodě $R$, a přímky $s$, $t$, pro které platí $s\\parallel r$, $s\\perp t$ (viz obrázek). Jsou vyznačeny úhly $30^\\circ$ a $130^\\circ$.','Vypočtěte ve stupních velikost úhlu (velikosti neměřte, ale vypočtěte):','7.1 $\\alpha$, \\quad 7.2 $\\beta$, \\quad 7.3 $\\gamma$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 471 247"><path d="M7 4L463 4L463 5L7 5Z" style="fill:#000000"/><path d="M4 36L466 36L466 37L4 37Z" style="fill:#000000"/><path d="M466 36L467 36L467 37L466 37Z" style="fill:#000000"/><path d="M466 36L467 36L467 37L466 37Z" style="fill:#000000"/><path d="M466 37L467 37L467 56L466 56Z" style="fill:#000000"/><path d="M466 56L467 56L467 72L466 72Z" style="fill:#000000"/><path d="M466 72L467 72L467 91L466 91Z" style="fill:#000000"/><path d="M466 91L467 91L467 110L466 110Z" style="fill:#000000"/><path d="M466 110L467 110L467 128L466 128Z" style="fill:#000000"/><path d="M466 128L467 128L467 147L466 147Z" style="fill:#000000"/><path d="M466 147L467 147L467 166L466 166Z" style="fill:#000000"/><path d="M466 166L467 166L467 185L466 185Z" style="fill:#000000"/><path d="M466 185L467 185L467 204L466 204Z" style="fill:#000000"/><path d="M466 204L467 204L467 223L466 223Z" style="fill:#000000"/><path d="M418 45L418 243M171 206L455 206M455 93L171 229M455 45L248 237M171 144L455 144" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M305 165C302 158 300 151 300 144M374 144C374 158 362 169 348 169C341 169 335 166 330 161M254 189C257 194 258 200 258 206M305 184C311 190 314 198 314 206M404 92C397 84 397 72 405 65C409 62 413 60 418 60M418 191C427 191 433 198 433 206M398 202L395 210M400 202L397 210M398 140L395 148M400 140L397 148" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M423 199C423 199 424 198 424 198C425 198 426 199 426 199C426 200 425 200 424 200C424 200 423 200 423 199Z" style="fill:#000000"/><text x="266" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="273" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">,</text><text x="452" y="220" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">s</text><text x="452" y="157" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">r</text><text x="346" y="142" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">R</text><text x="311" y="157" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="319" y="157" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="352" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">130</text><text x="364" y="162" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="249" y="204" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛼</text><text x="303" y="203" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛽</text><text x="409" y="80" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">𝛾</text></svg>',
  'obr.svg',
  'Přímky p, q, r protínající se v bodě R a přímky s (rovnoběžná s r) a t (kolmá na s); vyznačené úhly 30° a 130° a hledané úhly alfa, beta, gama.',
  '',
  new List<String>{'7.1: $\\alpha=30^\\circ$ (vrcholové, resp. souhlasné úhly).','7.2: $\\beta=180^\\circ-130^\\circ-... =50^\\circ$ (dopočet z přímého úhlu a daných úhlů).','7.3: $\\gamma=140^\\circ$ (vrcholový k úhlu $180^\\circ-40^\\circ$, resp. dopočet z $s\\parallel r$).'},
  '7.1: $\\alpha=30^\\circ$; 7.2: $\\beta=50^\\circ$; 7.3: $\\gamma=140^\\circ$',
  3, 5, '3',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
