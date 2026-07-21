String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, druhý náhradní termín (M9D)';
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
  'CERMAT 2022 M9D · úloha 8',
  new List<String>{'Obrazec se skládá z tmavého čtverce, dvou shodných bílých rovnoramenných trojúhelníků a dvou shodných bílých lichoběžníků (viz obrázek). S každou stranou čtverce splývá základna jednoho bílého útvaru.','Tmavý čtverec má obsah $144\\ \\mathrm{cm}^2$, což je polovina obsahu celého obrazce. Jeden trojúhelník má obsah $30\\ \\mathrm{cm}^2$. Délka kratší základny lichoběžníku je $9\\ \\mathrm{cm}$.','8.1 Vypočtěte v cm výšku na základnu rovnoramenného trojúhelníku.','8.2 Vypočtěte v cm výšku lichoběžníku.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 116 110"><path d="M27 24L88 24L88 86L27 86Z" style="fill:#bfbfbf;stroke:#000000;stroke-width:2"/><path d="M27 24L58 4L88 24L27 24M27 86L58 106L88 86L27 86M27 24L4 32L4 78L27 86L27 24M88 24L112 32L112 78L88 86L88 24" style="fill:none;stroke:#000000;stroke-width:2"/></svg>',
  'obr.svg',
  'Obrazec: uprostřed tmavý čtverec, na jeho protějších stranách dva bílé rovnoramenné trojúhelníky (nahoře a dole) a dva bílé lichoběžníky (vlevo a vpravo).',
  '',
  new List<String>{'Strana čtverce $a=\\sqrt{144}=12\\ \\mathrm{cm}$; to je delší základna trojúhelníku i lichoběžníku.','8.1: $\\frac{1}{2}\\cdot12\\cdot v=30\\Rightarrow 6v=30\\Rightarrow v=5\\ \\mathrm{cm}$.','Celý obrazec má obsah $288\\ \\mathrm{cm}^2$, bílé útvary dohromady $144\\ \\mathrm{cm}^2$; dva trojúhelníky $60\\ \\mathrm{cm}^2$, tedy dva lichoběžníky $84\\ \\mathrm{cm}^2$, jeden $42\\ \\mathrm{cm}^2$.','8.2: $\\frac{1}{2}(12+9)\\cdot v=42\\Rightarrow10{,}5\\,v=42\\Rightarrow v=4\\ \\mathrm{cm}$.'},
  '8.1: $5\\ \\mathrm{cm}$; 8.2: $4\\ \\mathrm{cm}$',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obsah','vypocet','bez-kalkulacky'},
  'M9PDD22C0T04', 2022
);
c.add(
  'CERMAT 2022 M9D · úloha 9',
  new List<String>{'V rovině leží body $A$, $S$ a přímka $p$ procházející bodem $A$ (viz obrázek).','Bod $A$ je vrchol rovnoběžníku $ABCD$, bod $S$ je střed tohoto rovnoběžníku. Na přímce $p$ leží vrchol $B$ rovnoběžníku $ABCD$. Úhel $ASB$ má velikost $120^\\circ$.','Sestrojte vrcholy $B$, $C$, $D$ rovnoběžníku $ABCD$, označte je písmeny a rovnoběžník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 257"><path d="M4 252L5 252L5 253L4 253Z" style="fill:#000000"/><path d="M4 252L5 252L5 253L4 253Z" style="fill:#000000"/><path d="M5 252L467 252L467 253L5 253Z" style="fill:#000000"/><path d="M467 252L468 252L468 253L467 253Z" style="fill:#000000"/><path d="M467 252L468 252L468 253L467 253Z" style="fill:#000000"/><path d="M4 4L5 4L5 252L4 252Z" style="fill:#000000"/><path d="M467 4L468 4L468 252L467 252Z" style="fill:#000000"/><path d="M396 140L63 211M128 201L127 193M199 127L193 121M199 121L193 127" style="fill:none;stroke:#000000;stroke-width:2"/><text x="129" y="216" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="197" y="142" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">S</text><text x="393" y="155" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'V rovině leží bod A na přímce p a bod S mimo přímku p.',
  '',
  new List<String>{'U bodu $S$ sestrojíme od polopřímky $SA$ úhel $120^\\circ$; jeho rameno protne přímku $p$ v bodě $B$ (vrchol $B$ leží na $p$ a zároveň splňuje $|\\angle ASB|=120^\\circ$).','Bod $S$ je střed rovnoběžníku, proto je středem úhlopříček $AC$ i $BD$: vrchol $C$ je obraz $A$ ve středové souměrnosti se středem $S$ a vrchol $D$ obraz $B$. Rovnoběžník $ABCD$ narýsujeme.'},
  'Konstrukce rovnoběžníku $ABCD$ ($B$ na přímce $p$, $|\\angle ASB|=120^\\circ$, $S$ střed).',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PDD22C0T04', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
