String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M9D 2025 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Pan Zdeněk bydlí posledních pět osmin svého dosavadního života v Plzni, kam se přestěhoval, když mu bylo $27$ let. Kolik let bydlí pan Zdeněk v Plzni?','15.2 Ze tří škol v obci je nejstarší základní škola, která je v provozu již $84$ let. Funguje tedy o $75\\,\\%$ delší dobu než gymnázium. Nejmladší školou je lyceum. Poměr doby fungování lycea a gymnázia je $2:3$. Kolik let funguje v obci lyceum?','15.3 Součet věků dvojčat a jejich staršího bratra je $99$ let. Každému z dvojčat je o $40\\,\\%$ méně let než jejich bratrovi. Kolik let je každému z dvojčat?'},
  new List<String>{'A) $22$ let','B) $27$ let','C) $32$ let','D) $45$ let','E) $48$ let','F) více než $48$ let'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Prvních $\\dfrac{3}{8}$ života (před stěhováním) je $27$ let, celý dosavadní život $27:\\dfrac{3}{8}=72$ let; v Plzni $\\dfrac{5}{8}\\cdot 72=45$ let → D.','15.2 Gymnázium $84:1{,}75=48$ let. Lyceum $\\dfrac{2}{3}\\cdot 48=32$ let → C.','15.3 Bratr $b$, každé dvojče $0{,}6b$. Součet $2\\cdot 0{,}6b+b=2{,}2b=99$, $b=45$; dvojče $0{,}6\\cdot 45=27$ let → B.'},
  '15.1: D ($45$ let); 15.2: C ($32$ let); 15.3: B ($27$ let)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2025 – úloha 16',
  new List<String>{'Hřiště má tvar obdélníku $KLMN$. Po jeho obvodu vede soutěžní trasa se stanovišti $A$, $B$, $C$, $D$ (viz obrázek). Úsečky $AC$ a $BD$ jsou rovnoběžné se stranami hřiště a vyznačený šedý obrazec je čtverec. Úsek $AKB$ soutěžní trasy (ze stanoviště $A$ přes vrchol $K$ na stanoviště $B$) měří $45$ m, úsek $BLC$ měří $39$ m a poslední úsek $CMD$ měří $30$ m.','Vypočtěte v metrech:','16.1 rozdíl mezi délkami úseček $BK$ a $BL$,','16.2 délku kratší strany hřiště,','16.3 obvod hřiště,','16.4 vzdálenost stanoviště $D$ od vrcholu $N$.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 230" font-family="sans-serif"> <rect x="240" y="40" width="120" height="90" fill="#cfcfcf" stroke="none"/> <rect x="60" y="40" width="300" height="150" fill="none" stroke="#000" stroke-width="2"/> <line x1="240" y1="40" x2="240" y2="190" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="60" y1="130" x2="360" y2="130" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <circle cx="240" cy="40" r="3.5" fill="#000"/> <circle cx="60" cy="130" r="3.5" fill="#000"/> <circle cx="240" cy="190" r="3.5" fill="#000"/> <circle cx="360" cy="130" r="3.5" fill="#000"/> <text x="48" y="34" font-size="14" font-style="italic">K</text> <text x="364" y="34" font-size="14" font-style="italic">N</text> <text x="46" y="203" font-size="14" font-style="italic">L</text> <text x="364" y="205" font-size="14" font-style="italic">M</text> <text x="236" y="30" font-size="14" font-style="italic">A</text> <text x="44" y="128" font-size="14" font-style="italic">B</text> <text x="230" y="206" font-size="14" font-style="italic">C</text> <text x="368" y="128" font-size="14" font-style="italic">D</text> </svg>',
  'hriste-KLMN.svg',
  'Obdélník KLMN se stanovišti A (na horní straně), B (na levé straně), C (na dolní straně), D (na pravé straně); úsečky AC a BD a šedý čtverec u vrcholu N.',
  'Hřiště se soutěžní trasou (šedý obrazec je čtverec)',
  new List<String>{'Značme $AK=a$, $KB=b$; z $AK+KB=45$ je $a+b=45$. Kratší strana $KL=h$, delší $KN=w$. Protože $AC$ je svislá, je $LC=AK=a$; protože $BD$ je vodorovná, je $MD=BL=h-b$. Šedý čtverec u vrcholu $N$ má vodorovnou stranu $AN=w-a$ a svislou stranu $b$, takže $w-a=b$.','Z úseku $BLC$: $(h-b)+a=39$; z úseku $CMD$: $(w-a)+(h-b)=30$. Po dosazení $w-a=b$ vyjde $h=30$, dále $a-b=9$, tedy $a=27$, $b=18$ a $w=45$.','16.1 $BK-BL=18-(30-18)=6$ m. 16.2 Kratší strana hřiště $=30$ m. 16.3 Obvod $=2\\cdot(45+30)=150$ m. 16.4 $DN=b=18$ m.'},
  '16.1: $6$ m; 16.2: $30$ m; 16.3: $150$ m; 16.4: $18$ m',
  4, 8, '4',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
