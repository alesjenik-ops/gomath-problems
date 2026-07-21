String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)';
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
  'CERMAT 2024 M9B · úloha 9',
  new List<String>{'V rovině jsou dány body $A$, $B$ a $O$. Body $A$, $B$ jsou vrcholy kosočtverce $ABCD$; vrchol $C$ leží na přímce $OA$ (viz obrázek).','Sestrojte kosočtverec $ABCD$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 455"><path d="M4 4L5 4L5 451L4 451Z" style="fill:#231f20"/><path d="M456 4L458 4L458 451L456 451Z" style="fill:#231f20"/><path d="M196 218L202 212M202 218L196 212M97 245L103 239M103 245L97 239M315 246L321 240M321 246L315 240" style="fill:none;stroke:#231f20;stroke-width:1"/></svg>',
  'obr.svg',
  'Body A, B a O v rovině.',
  '',
  new List<String>{'Vrchol $C$ leží na přímce $OA$ a zároveň $|BC|=|AB|$ (strana kosočtverce), tedy $C$ je průsečík přímky $OA$ s kružnicí $(B,|AB|)$.','Vrchol $D$ dopočteme jako $D=A+C-B$ (protilehlý vrchol kosočtverce), resp. z rovnoběžnosti stran.'},
  'Vrchol $C$ je průsečík přímky $OA$ s kružnicí $(B,|AB|)$; vrchol $D$ doplníme jako čtvrtý vrchol kosočtverce.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 10',
  new List<String>{'V rovině je dána kružnice $k$ se středem $S$ a body $K$, $L$. Body $K$, $L$ jsou vrcholy rovnoramenného trojúhelníku $KLM$ se základnou $LM$ (viz obrázek).','Sestrojte rovnoramenný trojúhelník $KLM$, leží-li bod $M$ na kružnici $k$. Nalezněte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 474"><path d="M4 4L5 4L5 470L4 470Z" style="fill:#000000"/><path d="M456 4L458 4L458 470L456 470Z" style="fill:#000000"/></svg>',
  'obr.svg',
  'Kružnice k se středem S a body K, L v rovině.',
  '',
  new List<String>{'Trojúhelník $KLM$ je rovnoramenný se základnou $LM$, tedy ramena $KL=KM$; bod $M$ leží na kružnici $(K,|KL|)$.','Zároveň $M$ leží na dané kružnici $k$; vrchol $M$ je průsečík obou kružnic — dvě řešení $M_1$, $M_2$.'},
  'Vrchol $M$ je průsečík kružnice $k$ s kružnicí $(K,|KL|)$ (dvě řešení).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 11',
  new List<String>{'Hračka stála $250$ korun; nejdříve byla zdražena o $40\\ \\%$ oproti původní ceně, po měsíci zlevněna o $40\\ \\%$ z nové ceny. Kolik stála hračka po této dvojí úpravě?'},
  new List<String>{'A) $200$ Kč','B) $210$ Kč','C) $230$ Kč','D) $250$ Kč','E) $280$ Kč'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$250\\cdot1{,}4=350$ Kč, poté $350\\cdot0{,}6=210$ Kč.'},
  'B) $210$ Kč',
  2, 3, '3',
  new List<String>{'zs2','r9','procenta','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 12',
  new List<String>{'Velký koláček byl o polovinu dražší než malý a stál $30$ Kč. Velké koláčky pekař prodal všechny a utržil za ně $3\\,000$ Kč. Desetinu malých koláčků neprodal a za prodané malé utržil $3\\,600$ Kč. Kolik malých koláčků původně přivezl?'},
  new List<String>{'A) $100$','B) $180$','C) $200$','D) $240$','E) jiný počet'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Malý koláček stál $\\frac{30}{1{,}5}=20$ Kč; prodaných malých $\\frac{3\\,600}{20}=180$.','Prodaných je $\\frac{9}{10}$ přivezených, tedy přivezl $180\\cdot\\frac{10}{9}=200$ koláčků.'},
  'C) $200$',
  2, 4, '4',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
