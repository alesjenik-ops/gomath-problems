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
  'CERMAT 2024 M9B · úloha 15',
  new List<String>{'Žáci 9. ročníku volili svůj nejoblíbenější předmět (každý právě jeden). Z grafu: matematika (M) chlapci $7$, dívky $4$; český jazyk (Čj) chlapci $2$, dívky $6$; angličtina (Aj) chlapci $5$, dívky $8$; tělocvik (Tv) chlapci $7$, dívky $5$; výtvarná (Vv) chlapci $4$, dívky $2$.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','15.1 V 9. ročníku je stejný počet dívek jako chlapců.','15.2 Český jazyk volilo více než $16\\ \\%$ všech žáků.','15.3 Počet chlapců, kteří volili matematiku, je o $75\\ \\%$ větší než počet děvčat, která volila matematiku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 345"><path d="M4 340L455 340L455 341L4 341Z" style="fill:#231f20"/><path d="M455 4L456 4L456 340L455 340Z" style="fill:#231f20"/><path d="M455 340L456 340L456 341L455 341Z" style="fill:#231f20"/><path d="M455 340L456 340L456 341L455 341Z" style="fill:#231f20"/><path d="M13 64L445 64L445 316L13 316ZM34 270L434 270M34 249L434 249M34 227L434 227M34 206L434 206M34 185L434 185M34 163L434 163M34 142L434 142M34 121L434 121M34 100L434 100M54 142L72 142L72 291L54 291ZM134 249L152 249L152 291L134 291ZM214 185L232 185L232 291L214 291ZM294 142L312 142L312 291L294 291ZM374 206L392 206L392 291L374 291ZM76 206L94 206L94 291L76 291ZM156 163L174 163L174 291L156 291ZM237 121L254 121L254 291L237 291ZM317 185L335 185L335 291L317 291ZM397 249L415 249L415 291L397 291ZM34 291L434 291M13 64L445 64L445 316L13 316Z" style="fill:none;stroke:#231f20;stroke-width:1"/><path d="M13 64L445 64L445 316L13 316Z" style="fill:#ffffff"/><path d="M76 206L94 206L94 291L76 291ZM156 163L174 163L174 291L156 291ZM237 121L254 121L254 291L237 291ZM317 185L335 185L335 291L317 291ZM397 249L415 249L415 291L397 291Z" style="fill:#b2b4b6"/><text x="74" y="309" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">M</text><text x="154" y="309" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">Čj</text><text x="234" y="309" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">Aj</text><text x="314" y="309" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">Tv</text><text x="394" y="309" font-size="11" fill="#000" text-anchor="middle" font-family="sans-serif">Vv</text></svg>',
  'obr.svg',
  'Sloupcový graf nejoblíbenějších předmětů (M, Čj, Aj, Tv, Vv) zvlášť pro chlapce a dívky.',
  '',
  new List<String>{'Chlapců $7+2+5+7+4=25$, dívek $4+6+8+5+2=25$; celkem $50$ žáků.','15.1: $25=25$ — A.','15.2: Čj celkem $8$ z $50$, tj. přesně $16\\ \\%$, nikoli více — N.','15.3: M chlapci $7$, dívky $4$; $\\frac{7-4}{4}=75\\ \\%$ — A.'},
  '15.1: A; 15.2: N; 15.3: A',
  3, 5, '3',
  new List<String>{'zs2','r9','statistika','procenta','porozumeni','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Lyžařský pobyt stál $7\\,000$ Kč (doprava, ubytování, lístek na vlek). Doprava tvořila desetinu ceny, ubytování $60\\ \\%$. Kolik procent tvořila cena lístku na vlek?','16.2 Cena učebnice se snížila na $1\\,500$ Kč z původních $2\\,000$ Kč. Kolik procent činila sleva?','16.3 Dárek stál $40$ EUR, celkem bylo vyměněno $200$ EUR. Kolik procent z vyměněných EUR tvořila cena dárku?'},
  new List<String>{'A) $15\\ \\%$','B) $20\\ \\%$','C) $25\\ \\%$','D) $30\\ \\%$','E) $40\\ \\%$','F) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: $100\\ \\%-10\\ \\%-60\\ \\%=30\\ \\%$ — D.','16.2: $\\frac{2\\,000-1\\,500}{2\\,000}=25\\ \\%$ — C.','16.3: $\\frac{40}{200}=20\\ \\%$ — B.'},
  '16.1: D ($30\\ \\%$); 16.2: C ($25\\ \\%$); 16.3: B ($20\\ \\%$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
