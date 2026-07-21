String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, náhradní termín (M9C)';
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
  'CERMAT 2022 M9C · úloha 7',
  new List<String>{'Pro soutěž Malování na chodník bylo připraveno celkem $300$ kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze $5$ a celkem v nich bylo tolik kříd jako ve $3$ větších krabičkách. Každá z větších krabiček obsahovala $10$ kříd.','7.1 \\quad Určete počet kříd v jedné menší krabičce.','7.2 \\quad Určete počet všech větších krabiček s křídami.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: ve $3$ větších krabičkách je $3\\cdot10=30$ kříd; tolik je i v $5$ menších, tedy v jedné menší $30:5=6$ kříd.','7.2: v menších krabičkách je celkem $30$ kříd; ve větších $300-30=270$ kříd; větších krabiček $270:10=27$.'},
  '7.1: $6$ kříd; 7.2: $27$ větších krabiček',
  3, 4, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 8',
  new List<String>{'Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme.','8.1 \\quad Tmavý obdélník má obsah $270\\ \\mathrm{cm}^2$ a jeho kratší strana měří $9\\ \\mathrm{cm}$. Vypočtěte v cm obvod obdélníku.','8.2 \\quad Oba bílé trojúhelníky jsou pravoúhlé. V trojúhelníku má jedna odvěsna délku $9\\ \\mathrm{cm}$ a nejdelší strana měří $15\\ \\mathrm{cm}$. Vypočtěte v cm$^2$ obsah jednoho trojúhelníku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: delší strana obdélníku $=270:9=30\\ \\mathrm{cm}$; obvod $=2\\cdot(9+30)=78\\ \\mathrm{cm}$.','8.2: druhá odvěsna $=\\sqrt{15^2-9^2}=\\sqrt{225-81}=\\sqrt{144}=12\\ \\mathrm{cm}$; obsah $=\\frac{1}{2}\\cdot9\\cdot12=54\\ \\mathrm{cm}^2$.'},
  '8.1: $78\\ \\mathrm{cm}$; 8.2: $54\\ \\mathrm{cm}^2$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','vypocet','slovni','bez-kalkulacky'},
  'M9PCD22C0T03', 2022
);
c.add(
  'CERMAT 2022 M9C · úloha 9',
  new List<String>{'V rovině leží body P, Q a přímka $o$ (viz obrázek).','Body P, Q jsou vrcholy trojúhelníku PQR. Přímka $o$ je osou některé strany tohoto trojúhelníku.','Sestrojte vrchol R trojúhelníku PQR, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 300"><path d="M4 295L5 295L5 296L4 296Z" style="fill:#000000"/><path d="M4 295L5 295L5 296L4 296Z" style="fill:#000000"/><path d="M5 295L467 295L467 296L5 296Z" style="fill:#000000"/><path d="M467 295L468 295L468 296L467 296Z" style="fill:#000000"/><path d="M467 295L468 295L468 296L467 296Z" style="fill:#000000"/><path d="M4 4L5 4L5 295L4 295Z" style="fill:#000000"/><path d="M467 4L468 4L468 295L467 295Z" style="fill:#000000"/><path d="M120 44L114 38M120 38L114 44M89 160L83 155M89 155L83 160M280 21L117 276" style="fill:none;stroke:#000000;stroke-width:2"/><text x="119" y="36" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">P</text><text x="86" y="175" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Q</text><text x="283" y="35" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text></svg>',
  'obr.svg',
  'V rovině leží body P a Q (vyznačené křížky) a přímka o (šikmá úsečka).',
  '',
  new List<String>{'Osa strany trojúhelníku je osou příslušné úsečky (kolmice v jejím středu), takže krajní body této strany jsou souměrné podle přímky $o$.','Je-li $o$ osou strany PR, je vrchol R obrazem bodu P v osové souměrnosti podle $o$; je-li $o$ osou strany QR, je vrchol R obrazem bodu Q podle $o$. Sestrojíme tedy obrazy bodů P a Q v osové souměrnosti s osou $o$ a získáme dvě řešení $R_1$ a $R_2$.'},
  'Dvě řešení: $R_1$ je obraz bodu P a $R_2$ je obraz bodu Q v osové souměrnosti s osou $o$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','soumernost','rysovani','bez-kontextu'},
  'M9PCD22C0T03', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
