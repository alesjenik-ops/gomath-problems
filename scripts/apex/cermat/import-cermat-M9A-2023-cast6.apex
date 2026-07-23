String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M9A 2023 – úloha 12',
  new List<String>{'Vnitřní prostor haly má tvar kvádru $ABCDEFGH$, jehož výška je $6$ m a délka $15$ m. Uvnitř haly je na podlaze, stropě a dvou stěnách vyznačena uzavřená lomená čára $ACFHA$. Úhlopříčka vyznačená na podlaze haly měří $17$ m a tvoří úsek $AC$ této lomené čáry.','Jaká je délka lomené čáry $ACFHA$?'},
  new List<String>{'A) $46$ m','B) $50$ m','C) $54$ m','D) $68$ m','E) jiná délka'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif"> <line x1="60" y1="240" x2="300" y2="240" stroke="#000"/> <line x1="300" y1="240" x2="360" y2="200" stroke="#000"/> <line x1="360" y1="200" x2="120" y2="200" stroke="#000" stroke-dasharray="5 4"/> <line x1="120" y1="200" x2="60" y2="240" stroke="#000" stroke-dasharray="5 4"/> <line x1="60" y1="140" x2="300" y2="140" stroke="#000"/> <line x1="300" y1="140" x2="360" y2="100" stroke="#000"/> <line x1="360" y1="100" x2="120" y2="100" stroke="#000"/> <line x1="120" y1="100" x2="60" y2="140" stroke="#000"/> <line x1="60" y1="240" x2="60" y2="140" stroke="#000"/> <line x1="300" y1="240" x2="300" y2="140" stroke="#000"/> <line x1="360" y1="200" x2="360" y2="100" stroke="#000"/> <line x1="120" y1="200" x2="120" y2="100" stroke="#000" stroke-dasharray="5 4"/> <polyline points="60,240 360,200 300,140 120,100 60,240" fill="none" stroke="#111" stroke-width="3"/> <text x="48" y="256" font-size="14" font-style="italic">A</text> <text x="304" y="256" font-size="14" font-style="italic">B</text> <text x="366" y="206" font-size="14" font-style="italic">C</text> <text x="102" y="214" font-size="14" font-style="italic">D</text> <text x="44" y="138" font-size="14" font-style="italic">E</text> <text x="304" y="136" font-size="14" font-style="italic">F</text> <text x="366" y="98" font-size="14" font-style="italic">G</text> <text x="102" y="98" font-size="14" font-style="italic">H</text> <text x="170" y="258" font-size="13">15 m</text> <text x="366" y="176" font-size="13">6 m</text> <text x="196" y="230" font-size="13">17 m</text> </svg>',
  'kvadr-ACFHA.svg',
  'Kvádr ABCDEFGH s vyznačenou uzavřenou lomenou čarou ACFHA přes podlahu, stěnu, strop a druhou stěnu.',
  'Kvádr s lomenou čarou ACFHA',
  new List<String>{'Podlaha $ABCD$ je obdélník s délkou $AB=15$ m a úhlopříčkou $AC=17$ m; šířka je $BC=\\sqrt{17^2-15^2}=\\sqrt{64}=8$ m. Úseky lomené čáry: $AC=17$ m (úhlopříčka podlahy). $CF$ je úhlopříčka stěny s rozměry $8$ m a $6$ m: $CF=\\sqrt{8^2+6^2}=10$ m. $FH$ je úhlopříčka stropu, shodná s $AC$: $FH=17$ m. $HA$ je úhlopříčka druhé stěny, shodná s $CF$: $HA=10$ m. Celkem $17+10+17+10=54$ m.'},
  'C) $54$ m',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 13',
  new List<String>{'Obsah pláště rotačního válce je třikrát větší než obsah jedné podstavy tohoto válce. Poloměr podstavy válce je $10$ cm.','Jaký je povrch válce? Výsledek je zaokrouhlen na desítky cm².'},
  new List<String>{'A) menší než $930$ cm²','B) $940$ cm²','C) $1\\,260$ cm²','D) $1\\,570$ cm²','E) větší než $1\\,580$ cm²'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Plášť $S_{pl}=2\\pi r v$, podstava $S_{p}=\\pi r^2$. Z podmínky $2\\pi r v=3\\pi r^2$ plyne $2v=3r$, tj. $v=1{,}5\\cdot 10=15$ cm. Povrch: $S=2S_{p}+S_{pl}=2\\pi r^2+3\\pi r^2=5\\pi r^2=5\\cdot 3{,}14\\cdot 100=1570$ cm².'},
  'D) $1\\,570$ cm²',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
