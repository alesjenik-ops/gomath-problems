String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 2. řádný termín (M9B)';
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
  'CERMAT 2023 M9B · úloha 16',
  new List<String>{'Vybarvováním polí čtvercové sítě vytváříme obrazce. Prvním obrazcem je jedno světle vybarvené pole. Každý další obrazec vytvoříme vybarvením všech prázdných polí, která mají s předchozím obrazcem společné pouze vrcholy; nová pole jsou u sudých obrazců tmavá a u lichých světlá. (Druhý obrazec $+4$ tmavá, třetí $+8$ světlá; třetí má $9$ světlých a $4$ tmavá pole.)','16.1 Vybarvením kolika dalších polí jsme z $8.$ obrazce vytvořili $9.$ obrazec?','16.2 O kolik se liší počet tmavých a světlých polí v $10.$ obrazci?','16.3 Kolik světlých polí může mít obrazec, který má $400$ tmavých polí? (Najděte všechna řešení.)'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 762 176"><path d="M4 4L5 4L5 23L4 23Z" style="fill:#000000"/><path d="M4 23L5 23L5 39L4 39Z" style="fill:#000000"/><path d="M4 39L5 39L5 55L4 55Z" style="fill:#000000"/><path d="M4 55L5 55L5 172L4 172Z" style="fill:#000000"/><path d="M22 65L22 147M36 65L36 147M50 65L50 147M65 65L65 147M79 65L79 147M93 65L93 147M16 70L99 70M16 84L99 84M16 99L99 99M16 113L99 113M16 127L99 127M16 141L99 141M121 65L121 147M136 65L136 147M150 65L150 147M164 65L164 147M178 65L178 147M192 65L192 147M116 70L198 70M116 84L198 84M116 99L198 99M116 113L198 113M116 127L198 127M116 141L198 141M221 65L221 147M235 65L235 147M249 65L249 147M263 65L263 147M277 65L277 147M291 65L291 147M215 70L297 70M215 84L297 84M215 99L297 99M215 113L297 113M215 127L297 127M215 141L297 141" style="fill:none;stroke:#bfbfbf;stroke-width:1"/><path d="M50 99L65 99L65 113L50 113Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M150 99L164 99L164 113L150 113Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M164 84L178 84L178 99L164 99Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M136 84L150 84L150 99L136 99Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M136 113L150 113L150 127L136 127Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M164 113L178 113L178 127L164 127Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M249 99L263 99L263 113L249 113Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M235 84L249 84L249 99L235 99Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M263 84L277 84L277 99L263 99Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M235 113L249 113L249 127L235 127Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M263 113L277 113L277 127L263 127Z" style="fill:#595959;stroke:#000000;stroke-width:2"/><path d="M221 70L235 70L235 84L221 84Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M249 70L263 70L263 84L249 84Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M277 70L291 70L291 84L277 84Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M277 99L291 99L291 113L277 113Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M277 127L291 127L291 141L277 141Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M249 127L263 127L263 141L249 141Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M221 127L235 127L235 141L221 141Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><path d="M221 99L235 99L235 113L221 113Z" style="fill:#d9d9d9;stroke:#000000;stroke-width:2"/><text x="236" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">pole, která mají s předchozím obrazcem společné pouze vrcholy. Tato nově vybarvená pole</text><text x="149" y="52" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">jsou u sudých obrazců tmavá a u lichých obrazců světlá.</text><text x="332" y="112" font-size="24" fill="#000" text-anchor="middle" font-family="sans-serif">…</text><text x="58" y="163" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1. obrazec</text><text x="158" y="163" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2. obrazec</text><text x="257" y="163" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3. obrazec</text></svg>',
  'obr.svg',
  'Posloupnost obrazců vytvářených vybarvováním polí čtvercové sítě (1., 2. a 3. obrazec) tmavými a světlými poli.',
  '',
  new List<String>{'Do $n$-tého obrazce ($n\\ge2$) přibude $4(n-1)$ polí. Světlých polí je v $n$-tém obrazci (pro liché $n$) $n^2$, tmavých (pro sudé $n$) $n^2$.','16.1: $4\\cdot8=32$ polí.','16.2: v $10.$ obrazci tmavých $100$, světlých $81$; rozdíl $19$.','16.3: $400=20^2$ tmavých má obrazec $20.$ (světlých $19^2=361$) i obrazec $21.$ (světlých $21^2=441$), tedy $361$ nebo $441$ světlých polí.'},
  '16.1: $32$ polí; 16.2: o $19$; 16.3: $361$ nebo $441$ světlých polí',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD23C0T02', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
