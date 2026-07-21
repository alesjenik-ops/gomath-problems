String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)';
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
  'CERMAT 2023 M9A · úloha 12',
  new List<String>{'Vnitřní prostor haly má tvar kvádru $ABCDEFGH$ s výškou $6\\ \\mathrm{m}$ a délkou $15\\ \\mathrm{m}$. Uvnitř je vyznačena uzavřená lomená čára $ACFHA$ (po podlaze, stropě a dvou stěnách). Úhlopříčka na podlaze $AC$ měří $17\\ \\mathrm{m}$ (viz obrázek).','Jaká je délka lomené čáry $ACFHA$?'},
  new List<String>{'A) $46\\ \\mathrm{m}$','B) $50\\ \\mathrm{m}$','C) $54\\ \\mathrm{m}$','D) $68\\ \\mathrm{m}$','E) jiná délka'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Šířka haly: $AC^2=15^2+\\text{š}^2\\Rightarrow 17^2=225+\\text{š}^2\\Rightarrow \\text{š}=8\\ \\mathrm{m}$.','$AC=17$, $CF=\\sqrt{8^2+6^2}=10$, $FH=17$, $HA=\\sqrt{8^2+6^2}=10$; délka $17+10+17+10=54\\ \\mathrm{m}$.'},
  'C) $54\\ \\mathrm{m}$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 13',
  new List<String>{'Obsah pláště rotačního válce je třikrát větší než obsah jedné podstavy. Poloměr podstavy je $10\\ \\mathrm{cm}$.','Jaký je povrch válce? (Zaokrouhleno na desítky $\\mathrm{cm}^2$, $\\pi\\doteq3{,}14$.)'},
  new List<String>{'A) menší než $930\\ \\mathrm{cm}^2$','B) $940\\ \\mathrm{cm}^2$','C) $1\\,260\\ \\mathrm{cm}^2$','D) $1\\,570\\ \\mathrm{cm}^2$','E) větší než $1\\,580\\ \\mathrm{cm}^2$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Plášť $=3\\times$ podstava: $2\\pi r v=3\\pi r^2\\Rightarrow v=\\frac{3r}{2}=15\\ \\mathrm{cm}$.','Povrch $=2\\pi r^2+3\\pi r^2=5\\pi r^2=5\\pi\\cdot100=500\\pi\\doteq1\\,570\\ \\mathrm{cm}^2$.'},
  'D) $1\\,570\\ \\mathrm{cm}^2$',
  2, 4, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 14',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné. V obrázku jsou vyznačeny úhly $4\\alpha$, $4\\alpha$, $2\\alpha$ a hledaný úhel $\\beta$ (viz obrázek).','Jaká je velikost úhlu $\\beta$? (Velikosti neměřte, ale vypočtěte.)'},
  new List<String>{'A) $100^\\circ$','B) $108^\\circ$','C) $116^\\circ$','D) $120^\\circ$','E) jiná velikost'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Z rovnoběžnosti dvou přímek a vztahů mezi vyznačenými úhly ($4\\alpha$, $4\\alpha$, $2\\alpha$) se určí $\\alpha$ a dopočte $\\beta=108^\\circ$.'},
  'B) $108^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V roce 2020 firma vyrobila $250$ výrobků; v letech 2021 a 2022 vždy o $20\\ \\%$ více než v předchozím roce. Kolik výrobků vyrobila v roce 2022?','15.2 Roman ujel $400\\ \\mathrm{km}$, což bylo o čtvrtinu více, než ujela Jana. Kolik km ujela Jana?','15.3 Firma měla na konci krize o $40\\ \\%$ méně zaměstnanců než před krizí; po přijetí $42$ nových jich měla o $25\\ \\%$ více než na konci krize. Kolik zaměstnanců měla před krizí?'},
  new List<String>{'A) $280$','B) $300$','C) $320$','D) $350$','E) $360$','F) jiný počet'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $250\\cdot1{,}2\\cdot1{,}2=360$ — E.','15.2: $\\frac{400}{1{,}25}=320\\ \\mathrm{km}$ — C.','15.3: před krizí $P$, na konci $0{,}6P$; $0{,}6P+42=1{,}25\\cdot0{,}6P\\Rightarrow 42=0{,}15P\\Rightarrow P=280$ — A.'},
  '15.1: E ($360$); 15.2: C ($320$); 15.3: A ($280$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
