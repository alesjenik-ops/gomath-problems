String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 2. řádný termín (M9B)';
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
  'CERMAT 2025 M9B · úloha 11',
  new List<String>{'V zahradě se pěstuje $6$ druhů rostlin; diagram udává, jakou část osázené plochy zabírá každý druh. Magnolie zabírají $20\\ \\mathrm{m}^2$. U některých výsečí je uvedena velikost úhlu.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','11.1 Jabloně zabírají o $15\\ \\mathrm{m}^2$ větší plochu než magnolie.','11.2 Levandule a bazalka dohromady zabírají $1{,}5$krát větší plochu než hortenzie.','11.3 Růže zabírají plochu menší než $30\\ \\mathrm{m}^2$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 765 246"><path d="M4 226L466 226L466 227L4 227Z" style="fill:#000000"/><path d="M8 4L334 4L334 202L8 202ZM209 59C234 101 219 155 177 180C170 183 163 186 156 188L133 103L209 59M48 126C44 111 44 95 48 80L133 103L48 126M48 80C56 50 80 26 110 18L133 103L48 80M263 70L269 70L269 76L263 76ZM263 110L269 110L269 117L263 117ZM263 130L269 130L269 137L263 137Z" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M133 15C164 15 193 32 209 59L133 103L133 15Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M156 188C109 201 60 173 48 126L133 103L156 188Z" style="fill:#a6a6a6;stroke:#000000;stroke-width:1"/><path d="M110 18C117 16 125 15 133 15L133 103L110 18Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><path d="M142 103L165 103L165 118L142 118Z" style="fill:#ffffff"/><path d="M263 49L269 49L269 56L263 56Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:1"/><path d="M263 90L269 90L269 96L263 96Z" style="fill:#a6a6a6;stroke:#000000;stroke-width:1"/><path d="M263 151L269 151L269 157L263 157Z" style="fill:#000000;stroke:#000000;stroke-width:1"/><text x="233" y="220" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">V některých výsečích diagramu je uvedena velikost úhlu, který příslušnou výseč vymezuje.</text><text x="21" y="240" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">CZVV</text><text x="34" y="240" font-size="9" fill="#000" text-anchor="middle" font-family="sans-serif">)</text><text x="143" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">60</text><text x="152" y="91" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="151" y="117" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">105</text><text x="163" y="116" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="89" y="109" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="97" y="109" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="113" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">60</text><text x="122" y="93" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">°</text><text x="296" y="58" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Magnolie</text><text x="289" y="78" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Jabloň</text><text x="284" y="99" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Růže</text><text x="297" y="119" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Hortenzie</text><text x="298" y="139" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Levandule</text><text x="291" y="159" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Bazalka</text></svg>',
  'obr.svg',
  'Kruhový diagram rozdělení plochy zahrady mezi 6 druhů rostlin (magnolie, jabloň, růže, hortenzie, levandule, bazalka) s vyznačenými úhly výsečí.',
  '',
  new List<String>{'Magnolie ($60^\\circ$) $=20\\ \\mathrm{m}^2$, tedy celá plocha $\\frac{360}{60}\\cdot20=120\\ \\mathrm{m}^2$ (na $1^\\circ$ připadá $\\frac{1}{3}\\ \\mathrm{m}^2$).','11.1: jabloně $105^\\circ=35\\ \\mathrm{m}^2$; $35-20=15$ — A.','11.2: hortenzie a součet levandule $+$ bazalka nejsou v poměru $1:1{,}5$ — N.','11.3: růže $90^\\circ=30\\ \\mathrm{m}^2$, což není méně než $30$ — N.'},
  '11.1: A; 11.2: N; 11.3: N',
  4, 5, '3',
  new List<String>{'zs2','r9','procenta','statistika','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PBD25C0T02', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
