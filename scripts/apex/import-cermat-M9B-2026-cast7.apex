String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. řádný termín (M9B)';
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
  'CERMAT 2026 M9B · úloha 13',
  new List<String>{'Z krychle o hraně délky $10\\ \\mathrm{cm}$ byly vyříznuty čtyři shodné malé krychličky o hraně délky $2\\ \\mathrm{cm}$. Vzniklo tak nové těleso (viz obrázek).','Jaký je povrch nového tělesa?'},
  new List<String>{'A) $552\\ \\mathrm{cm}^2$','B) $584\\ \\mathrm{cm}^2$','C) $600\\ \\mathrm{cm}^2$','D) $616\\ \\mathrm{cm}^2$','E) jiný povrch'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 228 143"><path d="M214 4L215 4L215 23L214 23Z" style="fill:#000000"/><path d="M214 23L215 23L215 39L214 39Z" style="fill:#000000"/><path d="M214 39L215 39L215 55L214 55Z" style="fill:#000000"/><path d="M214 55L215 55L215 73L214 73Z" style="fill:#000000"/><path d="M214 73L215 73L215 92L214 92Z" style="fill:#000000"/><path d="M214 92L215 92L215 111L214 111Z" style="fill:#000000"/><path d="M214 111L215 111L215 139L214 139Z" style="fill:#000000"/><path d="M72 128L96 104L96 35L72 59L72 128Z" style="fill:#d9d9d9"/><path d="M96 103L96 35M96 35L28 35M72 127L96 103M4 60L28 35M72 60L96 35M4 60L72 60L72 127L4 127ZM148 35L143 40M143 40L130 40M189 49L189 35M198 49L202 49M198 54L202 49M184 40L189 35M198 54L198 40M198 40L184 40M202 103L202 49M189 35L148 35M178 127L202 103M124 68L115 68M115 55L115 68M129 55L115 55M115 68L110 73M124 60L129 55M124 73L110 73M124 60L124 73M169 68L165 73M169 55L165 60M178 73L183 68M165 73L178 73M165 73L165 60M115 55L130 40M183 55L198 40M110 127L178 127M110 127L110 73M178 127L178 73M165 60L124 60" style="fill:none;stroke:#000000;stroke-width:2"/><path d="M184 54L189 49L189 35L184 40L184 54Z" style="fill:#d9d9d9;stroke:#ffffff;stroke-width:1"/><path d="M184 40L198 40L198 54L184 54Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M178 127L202 104L202 35L178 59L178 127Z" style="fill:#d9d9d9;stroke:#ffffff;stroke-width:1"/><path d="M198 54L202 49L202 36L198 40L198 54Z" style="fill:#ffffff;stroke:#ffffff;stroke-width:1"/><path d="M165 73L170 68L184 68L179 73L165 73Z" style="fill:#ffffff"/><path d="M165 73L170 68L170 55L165 60L165 73Z" style="fill:#d9d9d9;stroke:#ffffff;stroke-width:1"/><path d="M169 55L183 55L183 68L169 68Z" style="fill:#ffffff;stroke:#000000;stroke-width:2"/><text x="51" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Krychle</text><text x="158" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Nové těleso</text></svg>',
  'obr.svg',
  'Krychle o hraně 10 cm a nové těleso vzniklé vyříznutím čtyř malých krychliček o hraně 2 cm.',
  '',
  new List<String>{'Vyříznutím malé krychle z hrany (rohu) velké krychle ubydou z povrchu tři stěny krychličky, ale přibudou tři stejně velké stěny uvnitř výřezu.','Povrch se proto nezmění a zůstává roven povrchu původní krychle: $6\\cdot10^2=600\\ \\mathrm{cm}^2$.'},
  'C) $600\\ \\mathrm{cm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 14',
  new List<String>{'Pomocí hrnku naléváme do prázdného kanystru vodu ze studánky. Po nalití $28$ hrnků plných vody bylo zaplněno sedm osmin objemu kanystru. Když jsme přilili ještě $1$ hrnek plný vody, do úplného zaplnění kanystru chybělo $1\\,050\\ \\mathrm{ml}$ vody.','Jaký je objem hrnku?'},
  new List<String>{'A) $350\\ \\mathrm{ml}$','B) $300\\ \\mathrm{ml}$','C) $245\\ \\mathrm{ml}$','D) $210\\ \\mathrm{ml}$','E) jiný objem'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Nechť $V$ je objem kanystru. Z $28$ hrnků $=\\frac{7}{8}V$ plyne objem jednoho hrnku $\\frac{V}{32}$.','Po $29$ hrncích chybí $V-\\frac{29}{32}V=\\frac{3}{32}V=1\\,050\\ \\mathrm{ml}$, tedy $V=11\\,200\\ \\mathrm{ml}$.','Objem hrnku je $\\frac{V}{32}=350\\ \\mathrm{ml}$.'},
  'A) $350\\ \\mathrm{ml}$',
  2, 4, '4',
  new List<String>{'zs2','r9','zlomky','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD26C0T02', 2026
);
c.add(
  'CERMAT 2026 M9B · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Bedna s jablky váží $20\\ \\mathrm{kg}$ a je o $25\\ \\%$ těžší než bedna s hruškami. Kolik kg váží bedna s hruškami?','15.2 Z nasbíraných jahod jsme $65\\ \\%$ použili na výrobu džemu, $20\\ \\%$ na výrobu sirupu a zbývající $3\\ \\mathrm{kg}$ jsme zamrazili. Kolik kg jahod jsme použili na výrobu džemu?','15.3 Celková hmotnost dvou zavazadel je $42\\ \\mathrm{kg}$. Menší zavazadlo je o $60\\ \\%$ lehčí než větší zavazadlo. O kolik kg se liší hmotnosti obou zavazadel?'},
  new List<String>{'A) $12\\ \\mathrm{kg}$','B) $13\\ \\mathrm{kg}$','C) $15\\ \\mathrm{kg}$','D) $16\\ \\mathrm{kg}$','E) $18\\ \\mathrm{kg}$','F) jiný počet kg'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $20:1{,}25=16\\ \\mathrm{kg}$ — D.','15.2: zamrazená $3\\ \\mathrm{kg}$ jsou $15\\ \\%$, celkem $20\\ \\mathrm{kg}$; džem $65\\ \\%$ z $20=13\\ \\mathrm{kg}$ — B.','15.3: větší $v$, menší $0{,}4v$; $1{,}4v=42\\Rightarrow v=30$, menší $12$; rozdíl $18\\ \\mathrm{kg}$ — E.'},
  '15.1: D) $16\\ \\mathrm{kg}$; 15.2: B) $13\\ \\mathrm{kg}$; 15.3: E) $18\\ \\mathrm{kg}$',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PBD26C0T02', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
