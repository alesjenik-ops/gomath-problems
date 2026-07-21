String SRC   = 'CERMAT – Ilustrační test 2021, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2021 M9I · úloha 10',
  new List<String>{'V rovině leží body C, T (viz obrázek).','Bod C je vrchol rovnoramenného pravoúhlého trojúhelníku ABC s pravým úhlem při vrcholu C. Bod T je těžiště trojúhelníku ABC.','Sestrojte vrcholy A, B trojúhelníku ABC, označte je písmeny a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 57 143"><path d="M4 13L10 19M4 19L10 13M47 118L53 124M47 124L53 118" style="fill:none;stroke:#000000;stroke-width:2"/><text x="11" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="47" y="137" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">T</text></svg>',
  'obr.svg',
  'V rovině leží dva body: bod C nahoře a bod T níže a mírně vpravo.',
  '',
  new List<String>{'Přímka CT je osou souměrnosti rovnoramenného trojúhelníku a zároveň leží na těžnici z vrcholu C ke středu $S_{AB}$ přepony AB. Těžiště dělí těžnici v poměru $2:1$, proto $|CS_{AB}|=\\frac{3}{2}|CT|$; sestrojíme bod $S_{AB}$ na polopřímce CT za bodem T.','V pravoúhlém rovnoramenném trojúhelníku je $|CS_{AB}|=\\frac{1}{2}|AB|$, tedy $|S_{AB}A|=|S_{AB}B|=|CS_{AB}|$. Bodem $S_{AB}$ vedeme kolmici k CT; na ní ve vzdálenosti $|CS_{AB}|$ od $S_{AB}$ na obě strany leží vrcholy A a B.','Jde o konstrukční úlohu; hodnotí se přesnost a úplnost konstrukce.'},
  'Konstrukce rovnoramenného pravoúhlého trojúhelníku ABC (pravý úhel u C, T těžiště): $S_{AB}$ na polopřímce CT s $|CS_{AB}|=\\frac{3}{2}|CT|$, A a B na kolmici v $S_{AB}$ ve vzdálenosti $|CS_{AB}|$.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','bez-kontextu'},
  'M9PID21C0T01', 2021
);
c.add(
  'CERMAT 2021 M9I · úloha 11',
  new List<String>{'Podstavou kolmého pětibokého hranolu je pětiúhelník o obvodu $20\\ \\mathrm{cm}$ a obsahu $24\\ \\mathrm{cm}^2$. Všechny hrany hranolu mají stejnou délku (viz obrázek).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 \\quad Součet délek všech hran hranolu je $60\\ \\mathrm{cm}$.','11.2 \\quad Obsah podstavy je o polovinu větší než obsah jedné boční stěny hranolu.','11.3 \\quad Objem hranolu je $96\\ \\mathrm{cm}^3$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 108 79"><path d="M104 59L64 75L13 75L4 59M13 75L13 24M4 8L58 4L104 8L64 24L13 24L4 8M4 59L4 8M58 55L58 4M104 59L104 8M64 75L64 24M4 59L58 55L104 59" style="fill:none;stroke:#000000;stroke-width:2"/></svg>',
  'obr.svg',
  'Kolmý pětiboký hranol, jehož podstavou je pětiúhelník; všechny hrany mají stejnou délku.',
  '',
  new List<String>{'Pětiúhelník má $5$ stran, obvod $20\\ \\mathrm{cm}\\Rightarrow$ hrana $=4\\ \\mathrm{cm}$; všechny hrany (i výška hranolu) mají $4\\ \\mathrm{cm}$.','11.1: hranol má $15$ hran po $4\\ \\mathrm{cm}$: $15\\cdot4=60\\ \\mathrm{cm}$ — \\textbf{A}.','11.2: boční stěna je čtverec $4\\times4=16\\ \\mathrm{cm}^2$; $16\\cdot1{,}5=24=$ obsah podstavy — \\textbf{A}.','11.3: $V=S_{podstavy}\\cdot v=24\\cdot4=96\\ \\mathrm{cm}^3$ — \\textbf{A}.'},
  '11.1: A; 11.2: A; 11.3: A',
  4, 6, '3',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','uvazovani','bez-kalkulacky'},
  'M9PID21C0T01', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
