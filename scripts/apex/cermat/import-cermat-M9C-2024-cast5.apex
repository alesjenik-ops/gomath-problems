String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
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
  'CERMAT M9C 2024 – úloha 11',
  new List<String>{'Krychle má délku hrany $3$ dm. Krychli rozdělíme vodorovným řezem na dva shodné hranoly a vytvoříme nové těleso (viz obrázek).','O kolik dm² se zvětší povrch nového tělesa?'},
  new List<String>{'A) o $4{,}5$ dm²','B) o $9$ dm²','C) o $18$ dm²','D) oba povrchy jsou stejné','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 210" font-family="sans-serif"> <polygon points="60,90 140,90 140,170 60,170" fill="#ffffff" stroke="#000"/> <polygon points="60,90 90,68 170,68 140,90" fill="#ffffff" stroke="#000"/> <polygon points="140,90 170,68 170,148 140,170" fill="#ffffff" stroke="#000"/> <line x1="60" y1="130" x2="140" y2="130" stroke="#000" stroke-dasharray="4 3"/> <line x1="140" y1="130" x2="170" y2="108" stroke="#000" stroke-dasharray="4 3"/> <text x="115" y="192" font-size="12" text-anchor="middle">krychle</text> <polygon points="250,120 390,120 390,160 250,160" fill="#ffffff" stroke="#000"/> <polygon points="250,120 280,100 420,100 390,120" fill="#ffffff" stroke="#000"/> <polygon points="390,120 420,100 420,140 390,160" fill="#ffffff" stroke="#000"/> <polygon points="250,80 320,80 320,120 250,120" fill="#ffffff" stroke="#000"/> <polygon points="250,80 280,60 350,60 320,80" fill="#ffffff" stroke="#000"/> <polygon points="320,80 350,60 350,100 320,120" fill="#ffffff" stroke="#000"/> <text x="330" y="188" font-size="12" text-anchor="middle">nové těleso</text> </svg>',
  'krychle-teleso.svg',
  'Krychle o hraně 3 dm rozdělená vodorovným řezem a nové schodovité těleso vzniklé posunutím horního hranolu.',
  'Schematický nákres krychle a nového tělesa',
  new List<String>{'Řez rozdělí krychli na dva shodné kvádry $3\\times 3\\times 1{,}5$ dm; řezná plocha má obsah $3\\cdot 3=9$ dm². Nové těleso vznikne posunutím horního kvádru o polovinu, takže se odkryje polovina řezné plochy na dolním i na horním kvádru: $\\frac{9}{2}+\\frac{9}{2}=9$ dm². O tuto plochu se povrch zvětší.'},
  'B) o $9$ dm²',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 12',
  new List<String>{'Dva sourozenci Eva a Michal šetří společně na dárek pro rodiče. Eva našetřila $40\\,\\%$ potřebné částky, Michal o $24$ korun více než Eva. Sourozencům zbývá našetřit $72$ korun.','Kolik korun stojí dárek?'},
  new List<String>{'A) $96$ Kč','B) $120$ Kč','C) $480$ Kč','D) $1\\,920$ Kč','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme cenu dárku $x$. Eva našetřila $0{,}4x$, Michal $0{,}4x+24$. Platí $0{,}4x+(0{,}4x+24)+72=x$, tj. $0{,}8x+96=x$, odtud $0{,}2x=96$ a $x=480$ Kč.'},
  'C) $480$ Kč',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9C 2024 – úloha 13',
  new List<String>{'V divadle bylo těsně před začátkem představení v sále obsazeno $70\\,\\%$ sedadel. Po začátku představení přišlo se zpožděním ještě $11$ lidí a obsazenost sálu se tím zvýšila na $75\\,\\%$.','Jaká je kapacita sálu?'},
  new List<String>{'A) méně než $200$','B) $200$','C) $210$','D) $220$','E) více než $220$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Příchod $11$ lidí zvýšil obsazenost o $75\\,\\%-70\\,\\%=5\\,\\%$. Tedy $5\\,\\%$ kapacity sálu odpovídá $11$ sedadlům, kapacita je $11:0{,}05=220$ sedadel.'},
  'D) $220$',
  2, 3, '2',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2024 – úloha 14',
  new List<String>{'Tři kamarádi Petr, Cyril a Honza čtou komiksy. Petr přečetl o $3$ komiksy více než Cyril, Honza přečetl o osminu komiksů více než Cyril. Petr a Honza přečetli stejný počet komiksů.','Kolik komiksů přečetl Petr?'},
  new List<String>{'A) $22$','B) $24$','C) $25$','D) $26$','E) $27$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet Cyrilových komiksů $c$. Petr přečetl $c+3$, Honza $c+\\frac{1}{8}c=\\frac{9}{8}c$. Z rovnosti $c+3=\\frac{9}{8}c$ plyne $8c+24=9c$, tedy $c=24$. Petr přečetl $24+3=27$ komiksů.'},
  'E) $27$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
