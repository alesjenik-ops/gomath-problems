String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 1. náhradní termín (M9C)';
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
  'CERMAT 2024 M9C · úloha 11',
  new List<String>{'Krychle má hranu $3\\ \\mathrm{dm}$. Krychli rozdělíme vodorovným řezem na dva shodné hranoly a vytvoříme nové těleso (viz obrázek).','O kolik $\\mathrm{dm}^2$ se zvětší povrch nového tělesa?'},
  new List<String>{'A) o $4{,}5\\ \\mathrm{dm}^2$','B) o $9\\ \\mathrm{dm}^2$','C) o $18\\ \\mathrm{dm}^2$','D) oba povrchy jsou stejné','E) jiný výsledek'},
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 303 124"><path d="M4 44L29 19L103 19L103 95L78 120L4 120L4 44L78 44L103 19M78 44L78 120M4 120L29 95M29 19L29 95M29 95L103 95M4 83L29 58M29 58L103 58M4 83L78 83M78 83L103 58M199 83L274 83M273 83L299 58M199 83L224 58M224 58L299 58M199 82L199 119M273 83L273 119M298 58L298 95M224 58L224 94M199 119L274 119M224 94L299 94M273 120L299 95M199 119L224 94M199 82L199 44M199 44L224 19M224 60L224 19M200 119L163 119M199 44L162 44M224 19L186 19M224 94L185 94M163 119L163 44M187 94L187 19M162 44L187 19M163 119L187 94" style="fill:none;stroke:#000000;stroke-width:2"/><text x="56" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">krychle</text><text x="232" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">nové těleso</text></svg>',
  'obr.svg',
  'Krychle o hraně 3 dm a nové těleso vzniklé rozdělením krychle vodorovným řezem na dva hranoly.',
  '',
  new List<String>{'Řezem vzniknou dvě nové čtvercové plochy o obsahu $3\\cdot3=9\\ \\mathrm{dm}^2$.','Povrch se zvětší o $2\\cdot9=18\\ \\mathrm{dm}^2$.'},
  'C) o $18\\ \\mathrm{dm}^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 12',
  new List<String>{'Eva a Michal šetří na dárek. Eva našetřila $40\\ \\%$ potřebné částky, Michal o $24$ korun více než Eva. Zbývá našetřit $72$ korun.','Kolik korun stojí dárek?'},
  new List<String>{'A) $96$ Kč','B) $120$ Kč','C) $480$ Kč','D) $1\\,920$ Kč','E) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Cena $C$: Eva $0{,}4C$, Michal $0{,}4C+24$; $0{,}4C+(0{,}4C+24)+72=C\\Rightarrow 0{,}2C=96\\Rightarrow C=480$ Kč.'},
  'C) $480$ Kč',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 13',
  new List<String>{'Těsně před představením bylo obsazeno $70\\ \\%$ sedadel. Po začátku přišlo dalších $11$ lidí a obsazenost se zvýšila na $75\\ \\%$.','Jaká je kapacita sálu?'},
  new List<String>{'A) méně než $200$','B) $200$','C) $210$','D) $220$','E) více než $220$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl $75\\ \\%-70\\ \\%=5\\ \\%$ odpovídá $11$ lidem; kapacita $\\frac{11}{0{,}05}=220$.'},
  'D) $220$',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD24C0T03', 2024
);
c.add(
  'CERMAT 2024 M9C · úloha 14',
  new List<String>{'Petr přečetl o $3$ komiksy více než Cyril, Honza o osminu komiksů více než Cyril. Petr a Honza přečetli stejný počet komiksů.','Kolik komiksů přečetl Petr?'},
  new List<String>{'A) $22$','B) $24$','C) $25$','D) $26$','E) $27$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Cyril $c$: Petr $c+3$, Honza $\\frac{9}{8}c$; $c+3=\\frac{9}{8}c\\Rightarrow 3=\\frac{1}{8}c\\Rightarrow c=24$; Petr $27$.'},
  'E) $27$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','zlomky','slovni','modelovani','bez-kalkulacky','bez-kontextu'},
  'M9PCD24C0T03', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
