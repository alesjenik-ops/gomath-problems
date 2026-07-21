String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 15',
  new List<String>{'Tabulka udává počty žáků gymnázia, kteří se zúčastnili sportovních kurzů (některé údaje chybí): Vodácký kurz — celkem $28$; Turistický kurz — celkem $30$; Cyklistický kurz — chlapci $14$.','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Z celkového počtu účastníků vodáckého kurzu bylo $75\\ \\%$ chlapců. Kolik dívek se zúčastnilo vodáckého kurzu?','15.2 Turistického kurzu se zúčastnilo o $50\\ \\%$ více dívek než chlapců. O kolik méně chlapců než dívek se zúčastnilo turistického kurzu?','15.3 Na cyklistický kurz se přihlásilo $16$ dívek, některé se nezúčastnily; dívky nakonec tvořily $44\\ \\%$ účastníků. Kolik přihlášených dívek se kurzu nezúčastnilo?'},
  new List<String>{'A) $5$','B) $6$','C) $7$','D) $8$','E) $9$','F) jiný počet'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 257 137"><path d="M4 4L5 4L5 133L4 133Z" style="fill:#000000"/><path d="M17 14L18 14L18 18L17 18Z" style="fill:#000000"/><path d="M85 15L86 15L86 18L85 18Z" style="fill:#000000"/><path d="M238 14L239 14L239 18L238 18Z" style="fill:#000000"/><path d="M17 18L18 18L18 35L17 35Z" style="fill:#000000"/><path d="M85 18L86 18L86 35L85 35Z" style="fill:#000000"/><path d="M238 18L239 18L239 35L238 35Z" style="fill:#000000"/><path d="M17 35L18 35L18 39L17 39Z" style="fill:#000000"/><path d="M85 35L86 35L86 39L85 39Z" style="fill:#000000"/><path d="M86 35L136 35L136 36L86 36Z" style="fill:#000000"/><path d="M136 36L137 36L137 39L136 39Z" style="fill:#000000"/><path d="M136 35L137 35L137 36L136 36Z" style="fill:#000000"/><path d="M137 35L187 35L187 36L137 36Z" style="fill:#000000"/><path d="M187 36L188 36L188 39L187 39Z" style="fill:#000000"/><path d="M187 35L187 35L187 36L187 36Z" style="fill:#000000"/><path d="M187 35L238 35L238 36L187 36Z" style="fill:#000000"/><path d="M238 35L239 35L239 39L238 39Z" style="fill:#000000"/><path d="M17 39L18 39L18 56L17 56Z" style="fill:#000000"/><path d="M85 39L86 39L86 56L85 56Z" style="fill:#000000"/><path d="M136 39L137 39L137 56L136 56Z" style="fill:#000000"/><path d="M187 39L188 39L188 56L187 56Z" style="fill:#000000"/><path d="M238 39L239 39L239 56L238 56Z" style="fill:#000000"/><path d="M17 56L18 56L18 60L17 60Z" style="fill:#000000"/><path d="M18 56L85 56L85 57L18 57Z" style="fill:#000000"/><path d="M85 56L86 56L86 60L85 60Z" style="fill:#000000"/><path d="M86 56L136 56L136 57L86 57Z" style="fill:#000000"/><path d="M136 57L137 57L137 60L136 60Z" style="fill:#000000"/><path d="M136 56L137 56L137 57L136 57Z" style="fill:#000000"/><path d="M137 56L187 56L187 57L137 57Z" style="fill:#000000"/><path d="M187 56L188 56L188 60L187 60Z" style="fill:#000000"/><path d="M188 56L238 56L238 57L188 57Z" style="fill:#000000"/><path d="M238 56L239 56L239 60L238 60Z" style="fill:#000000"/><path d="M17 60L18 60L18 77L17 77Z" style="fill:#000000"/><path d="M85 60L86 60L86 77L85 77Z" style="fill:#000000"/><path d="M136 60L137 60L137 77L136 77Z" style="fill:#000000"/><path d="M187 60L188 60L188 77L187 77Z" style="fill:#000000"/><path d="M238 60L239 60L239 77L238 77Z" style="fill:#000000"/><path d="M17 77L18 77L18 81L17 81Z" style="fill:#000000"/><path d="M18 77L85 77L85 78L18 78Z" style="fill:#000000"/><path d="M85 77L86 77L86 81L85 81Z" style="fill:#000000"/><path d="M86 77L136 77L136 78L86 78Z" style="fill:#000000"/><path d="M136 77L137 77L137 81L136 81Z" style="fill:#000000"/><path d="M137 77L187 77L187 78L137 78Z" style="fill:#000000"/><path d="M187 77L188 77L188 81L187 81Z" style="fill:#000000"/><path d="M188 77L238 77L238 78L188 78Z" style="fill:#000000"/><path d="M238 77L239 77L239 81L238 81Z" style="fill:#000000"/><path d="M17 81L18 81L18 98L17 98Z" style="fill:#000000"/><path d="M85 81L86 81L86 98L85 98Z" style="fill:#000000"/><path d="M136 81L137 81L137 98L136 98Z" style="fill:#000000"/><path d="M187 81L188 81L188 98L187 98Z" style="fill:#000000"/><path d="M238 81L239 81L239 98L238 98Z" style="fill:#000000"/><path d="M17 98L18 98L18 101L17 101Z" style="fill:#000000"/><path d="M18 98L85 98L85 98L18 98Z" style="fill:#000000"/><path d="M85 98L86 98L86 101L85 101Z" style="fill:#000000"/><path d="M86 98L136 98L136 98L86 98Z" style="fill:#000000"/><path d="M136 98L137 98L137 101L136 101Z" style="fill:#000000"/><path d="M137 98L187 98L187 98L137 98Z" style="fill:#000000"/><path d="M187 98L188 98L188 101L187 101Z" style="fill:#000000"/><path d="M188 98L238 98L238 98L188 98Z" style="fill:#000000"/><path d="M238 98L239 98L239 101L238 101Z" style="fill:#000000"/><path d="M17 101L18 101L18 118L17 118Z" style="fill:#000000"/><path d="M17 118L18 118L18 119L17 119Z" style="fill:#000000"/><path d="M17 118L18 118L18 119L17 119Z" style="fill:#000000"/><path d="M18 118L85 118L85 119L18 119Z" style="fill:#000000"/><path d="M85 101L86 101L86 118L85 118Z" style="fill:#000000"/><path d="M85 118L86 118L86 119L85 119Z" style="fill:#000000"/><path d="M86 118L136 118L136 119L86 119Z" style="fill:#000000"/><path d="M136 101L137 101L137 118L136 118Z" style="fill:#000000"/><path d="M136 118L137 118L137 119L136 119Z" style="fill:#000000"/><path d="M137 118L187 118L187 119L137 119Z" style="fill:#000000"/><path d="M187 101L188 101L188 118L187 118Z" style="fill:#000000"/><path d="M187 118L188 118L188 119L187 119Z" style="fill:#000000"/><path d="M188 118L238 118L238 119L188 119Z" style="fill:#000000"/><path d="M238 101L239 101L239 118L238 118Z" style="fill:#000000"/><path d="M238 118L239 118L239 119L238 119Z" style="fill:#000000"/><path d="M238 118L239 118L239 119L238 119Z" style="fill:#000000"/><text x="32" y="42" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Kurz</text><text x="163" y="32" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Počet účastníků</text><text x="112" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Chlapci</text><text x="163" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Dívky</text><text x="214" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Celkem</text><text x="43" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Vodácký</text><text x="214" y="73" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">28</text><text x="45" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Turistický</text><text x="214" y="94" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">30</text><text x="47" y="114" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Cyklistický</text><text x="112" y="114" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">14</text></svg>',
  'obr.svg',
  'Tabulka počtu účastníků kurzů (chlapci, dívky, celkem) pro vodácký, turistický a cyklistický kurz s chybějícími údaji.',
  '',
  new List<String>{'15.1: dívky $=25\\ \\%$ z $28=7$ — C.','15.2: chlapci $c$, dívky $1{,}5c$; $2{,}5c=30\\Rightarrow c=12$, dívek $18$; rozdíl $6$ — B.','15.3: chlapci $14=56\\ \\%$ účastníků, celkem $25$, dívek $11$; přihlášeno $16$, nezúčastnilo se $5$ — A.'},
  '15.1: C ($7$); 15.2: B ($6$); 15.3: A ($5$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','statistika','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
