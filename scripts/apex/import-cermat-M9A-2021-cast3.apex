String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 1. řádný termín (M9A)';
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
  'CERMAT 2021 M9A · úloha 9',
  new List<String>{'V rovině leží polopřímka BX a přímka $o$ (viz obrázek).','Bod B je vrchol trojúhelníku ABC. Přímka $o$ je osou strany AB. Velikost vnitřního úhlu BAC je $60^\\circ$ a vrchol C leží na polopřímce BX.','Sestrojte vrcholy A, C trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 313 209"><path d="M6 184L309 138M7 188L6 181M260 149L259 141M4 11L205 189" style="fill:none;stroke:#000000;stroke-width:2"/><text x="7" y="203" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="261" y="164" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">X</text><text x="14" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text></svg>',
  'obr.svg',
  'V rovině leží polopřímka BX (s vyznačeným bodem X) a přímka o.',
  '',
  new List<String>{'Přímka $o$ je osou úsečky AB, takže vrchol A je obrazem bodu B v osové souměrnosti podle $o$ (A leží na kolmici k $o$ vedené bodem B, ve stejné vzdálenosti od $o$ jako B).','Vrchol C leží na polopřímce BX a zároveň na rameni úhlu o velikosti $60^\\circ$ sestrojeného při vrcholu A k úsečce AB; jejich průsečíkem je bod C.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce trojúhelníku ABC: A je souměrný s B podle osy $o$, C je průsečík polopřímky BX s ramenem úhlu $60^\\circ$ při vrcholu A.',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 10',
  new List<String>{'V rovině leží body B, P a přímka $q$ procházející bodem B (viz obrázek).','Bod B je vrchol rovnoramenného lichoběžníku ABCD se základnou AB, rameno BC leží na přímce $q$. Úhlopříčky AC a BD se protínají v bodě P a jsou na sebe kolmé.','Sestrojte vrcholy A, C, D lichoběžníku ABCD, označte je písmeny a lichoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 154 311"><path d="M5 125L11 120M11 125L5 120M137 4L46 307M52 270L60 273" style="fill:none;stroke:#000000;stroke-width:2"/><text x="69" y="282" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="7" y="139" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="144" y="18" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">q</text></svg>',
  'obr.svg',
  'V rovině leží bod B na přímce q, bod P mimo přímku q; přímka q prochází bodem B.',
  '',
  new List<String>{'Vrchol C leží na přímce $q$ a zároveň na přímce vedené bodem P kolmo k BP (protože úhlopříčky AC a BD jsou na sebe kolmé a P je jejich průsečík) — tím je C určen.','Bod A leží na přímce BP (na úhlopříčce BD prodloužené za P je vrchol D; A je na úhlopříčce AC, tj. na přímce PC) tak, aby AB byla základna a lichoběžník byl rovnoramenný; rovnoramenný lichoběžník je souměrný podle osy základny AB, čehož využijeme k dokončení konstrukce vrcholů A a D.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce rovnoramenného lichoběžníku ABCD (rameno BC na přímce $q$, kolmé úhlopříčky AC $\\perp$ BD protínající se v bodě P).',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost'},
  'M9PAD21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9A · úloha 11',
  new List<String>{'Děti mají mapu s měřítkem $1:50\\,000$.','Alena ujela na koloběžce trasu délky $10\\ \\mathrm{km}$ a vypočetla, že na mapě je to $5\\ \\mathrm{cm}$. Beáta ušla trasu, která je na mapě zobrazena čarou délky $15\\ \\mathrm{cm}$. Čestmír ušel dvakrát delší trasu než Beáta.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Alenin výpočet je správný.','11.2 Beáta ušla trasu délky $7{,}5\\ \\mathrm{km}$.','11.3 Na mapě je Beátina trasa o polovinu kratší než Čestmírova trasa.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'11.1: $10\\ \\mathrm{km}=1\\,000\\,000\\ \\mathrm{cm}$; na mapě $1\\,000\\,000:50\\,000=20\\ \\mathrm{cm}$, nikoli $5\\ \\mathrm{cm}$ — výpočet je chybný, tedy \\textbf{N}.','11.2: $15\\ \\mathrm{cm}\\cdot50\\,000=750\\,000\\ \\mathrm{cm}=7{,}5\\ \\mathrm{km}$ — \\textbf{A}.','11.3: Čestmír ušel dvakrát delší trasu, na mapě je jeho trasa $30\\ \\mathrm{cm}$; Beátiných $15\\ \\mathrm{cm}$ je polovina, tedy o polovinu kratší — \\textbf{A}.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','pomer','procenta','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
