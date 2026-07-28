String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 15',
  new List<String>{'V prvním čtvrtletí byla cena výrobku 120 Kč. Během roku se cena výrobku třikrát snížila, a to vždy na přelomu čtvrtletí. Vývoj ceny zachycuje graf.','Kdy došlo ke snížení předchozí ceny výrobku o 20 %?'},
  new List<String>{'A) ani jednou','B) na přelomu 1. a 2. čtvrtletí','C) na přelomu 2. a 3. čtvrtletí','D) na přelomu 3. a 4. čtvrtletí','E) pokaždé'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 310" font-family="sans-serif"><text x="300" y="26" font-size="18" text-anchor="middle" font-weight="bold">Vývoj cen výrobku</text><line x1="96" y1="262" x2="510" y2="262" stroke="#bbb" stroke-width="1"/><text x="86" y="267" font-size="14" text-anchor="end">0</text><line x1="96" y1="225" x2="510" y2="225" stroke="#bbb" stroke-width="1"/><text x="86" y="230" font-size="14" text-anchor="end">20</text><line x1="96" y1="189" x2="510" y2="189" stroke="#bbb" stroke-width="1"/><text x="86" y="194" font-size="14" text-anchor="end">40</text><line x1="96" y1="152" x2="510" y2="152" stroke="#bbb" stroke-width="1"/><text x="86" y="157" font-size="14" text-anchor="end">60</text><line x1="96" y1="115" x2="510" y2="115" stroke="#bbb" stroke-width="1"/><text x="86" y="120" font-size="14" text-anchor="end">80</text><line x1="96" y1="79" x2="510" y2="79" stroke="#bbb" stroke-width="1"/><text x="86" y="84" font-size="14" text-anchor="end">100</text><line x1="96" y1="42" x2="510" y2="42" stroke="#bbb" stroke-width="1"/><text x="86" y="47" font-size="14" text-anchor="end">120</text><text x="46" y="157" font-size="15">Kč</text><line x1="96" y1="40" x2="96" y2="262" stroke="#000" stroke-width="1.5"/><line x1="96" y1="262" x2="510" y2="262" stroke="#000" stroke-width="1.5"/><rect x="116" y="42" width="60" height="220" fill="#a3a3a3" stroke="#000" stroke-width="1.5"/><text x="146" y="286" font-size="14" text-anchor="middle">1. čtvrtletí</text><rect x="220" y="79" width="60" height="183" fill="#a3a3a3" stroke="#000" stroke-width="1.5"/><text x="250" y="286" font-size="14" text-anchor="middle">2. čtvrtletí</text><rect x="324" y="115" width="60" height="147" fill="#a3a3a3" stroke="#000" stroke-width="1.5"/><text x="354" y="286" font-size="14" text-anchor="middle">3. čtvrtletí</text><rect x="428" y="152" width="60" height="110" fill="#a3a3a3" stroke="#000" stroke-width="1.5"/><text x="458" y="286" font-size="14" text-anchor="middle">4. čtvrtletí</text></svg>',
  'graf-ceny.svg',
  'Sloupcový graf Vývoj cen výrobku: 1. čtvrtletí 120 Kč, 2. čtvrtletí 100 Kč, 3. čtvrtletí 80 Kč, 4. čtvrtletí 60 Kč.',
  'Vývoj cen výrobku v jednotlivých čtvrtletích (Kč)',
  new List<String>{'Z grafu: 120 Kč, 100 Kč, 80 Kč, 60 Kč.','Snížení ze 120 na 100 Kč je o $\\frac{20}{120}$, tj. přibližně $16{,}7$ %.','Snížení ze 100 na 80 Kč je o $\\frac{20}{100}$, tj. přesně 20 %.','Snížení z 80 na 60 Kč je o $\\frac{20}{80}$, tj. 25 %. O 20 % se cena snížila na přelomu 2. a 3. čtvrtletí.'},
  'C) na přelomu 2. a 3. čtvrtletí',
  2, 4, '3',
  new List<String>{'zs2','r7','procenta','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2016 – úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Petr utratil 30 % z 30 Kč. Kolik Kč mu zbylo?','16.2 Zatím přišlo jen 12 dětí. Na zbývajících 60 % dětí se čeká. Na kolik dětí se čeká?','16.3 Výrobek zdražený o tři čtvrtiny původní ceny stojí 28 Kč. Kolik Kč by stál výrobek zdražený jen o 50 % původní ceny?'},
  new List<String>{'A) 14','B) 18','C) 20','D) 21','E) 24','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 30 % z 30 Kč je 9 Kč, zbylo tedy $30-9=21$ Kč – možnost D.','16.2 Přišlo 40 % dětí, tj. 12 dětí; celkem je $12:0{,}4=30$ dětí a čeká se na $30-12=18$ dětí – možnost B.','16.3 Původní cena $x$ splňuje $1{,}75x=28$, tedy $x=16$ Kč. Po zdražení o 50 % by výrobek stál $1{,}5\\cdot 16=24$ Kč – možnost E.'},
  '16.1: D (21); 16.2: B (18); 16.3: E (24)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
