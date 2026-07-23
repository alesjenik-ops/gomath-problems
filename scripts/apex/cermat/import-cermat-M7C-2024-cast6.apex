String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M7C 2024 – úloha 10',
  new List<String>{'Petr postavil ze sedmi stejných kostek stavbu. Nakreslil si tři pohledy na stavbu: zepředu, zleva a shora (viz obrázek).','Kterou z uvedených staveb (A–E) Petr viděl tak, jak je uvedeno ve výchozím textu? Prostorové stavby A–E jsou v testovém sešitě.'},
  new List<String>{'A) stavba A','B) stavba B','C) stavba C','D) stavba D','E) stavba E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif"><text x="76" y="62" font-size="12" text-anchor="middle">pohled zepředu</text><rect x="40" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="64" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="88" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="40" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="88" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><text x="246" y="62" font-size="12" text-anchor="middle">pohled zleva</text><rect x="210" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="234" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="258" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="210" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="234" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><text x="426" y="62" font-size="12" text-anchor="middle">pohled shora</text><rect x="390" y="118" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="414" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="438" y="94" width="24" height="24" fill="#cccccc" stroke="#000"/><rect x="438" y="70" width="24" height="24" fill="#cccccc" stroke="#000"/><text x="260" y="192" font-size="11" text-anchor="middle" fill="#666">Prostorové stavby A–E viz testový sešit.</text></svg>',
  'pohledy.svg',
  'Tři pohledy na stavbu ze sedmi kostek: zepředu, zleva a shora.',
  'Pohledy na stavbu (prostorové varianty A–E viz testový sešit)',
  new List<String>{'Porovnáním tří pohledů (zepředu, zleva, shora) se stavbou ze sedmi kostek odpovídá těleso $C$. Prostorová tělesa $A$–$E$ nelze věrně přenést do náčrtu; posuzuje se podle originálu v testovém sešitě.'},
  'C) stavba C',
  2, 3, '3',
  new List<String>{'zs2','r7','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2024 – úloha 11',
  new List<String>{'Přímky $m$, $n$ jsou rovnoběžné. Přímky $k$, $n$ a $p$ se protínají v bodě $B$ (viz obrázek).','Jaký je součet velikostí úhlů $\\alpha$ a $\\beta$? Velikosti úhlů neměřte, ale vypočítejte (obrázek je ilustrační).'},
  new List<String>{'A) $101^\\circ$','B) $121^\\circ$','C) $132^\\circ$','D) $137^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 300" font-family="sans-serif"> <line x1="50" y1="170" x2="570" y2="170" stroke="#000" stroke-width="2"/> <line x1="300" y1="70" x2="170" y2="260" stroke="#000" stroke-width="2"/> <line x1="450" y1="70" x2="320" y2="260" stroke="#000" stroke-width="2"/> <line x1="382" y1="170" x2="545" y2="80" stroke="#000" stroke-width="2"/> <text x="298" y="62" font-size="15" font-style="italic">m</text> <text x="448" y="62" font-size="15" font-style="italic">n</text> <text x="548" y="82" font-size="15" font-style="italic">k</text> <text x="558" y="184" font-size="15" font-style="italic">p</text> <text x="252" y="160" font-size="15">α</text> <text x="180" y="212" font-size="14">135°</text> <text x="404" y="160" font-size="14">31°</text> <text x="356" y="200" font-size="15">β</text> <text x="388" y="188" font-size="14" font-style="italic">B</text> </svg>',
  'uhly-mnkp.svg',
  'Rovnoběžky m a n proťaté přímkou p, přímka k v bodě B; vyznačené úhly alfa, beta, 135° a 31°.',
  'Ilustrační obrázek k úloze 11',
  new List<String>{'Přímka $p$ je příčkou rovnoběžek $m$ a $n$. Úhel $\\alpha$ je vedlejší k úhlu $135^\\circ$, proto $\\alpha=180^\\circ-135^\\circ=45^\\circ$; stejný úhel svírají s přímkou $p$ i rovnoběžky $m$, $n$.','V bodě $B$ svírá přímka $k$ s přímkou $p$ úhel $31^\\circ$. Úhel $\\beta$ pak má velikost $45^\\circ+31^\\circ=76^\\circ$.','Součet je $\\alpha+\\beta=45^\\circ+76^\\circ=121^\\circ$.'},
  'B) $121^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
