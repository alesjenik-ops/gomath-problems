String SRC   = 'CERMAT – Přijímací zkoušky 2015, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2015 M9 · úloha 9',
  new List<String>{'V rovině leží různoběžky $o$, $p$ a bod $A$ na přímce $p$ (viz obrázek).','9.1 Sestrojte bod $B$, který je obrazem bodu $A$ v osové souměrnosti s osou $o$.','9.2 Sestrojte přímku $q$, která je obrazem přímky $p$ v osové souměrnosti s osou $o$.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 333 166"><path d="M62 20L329 101L329 102L61 22Z" style="fill:#000000"/><path d="M219 141L224 132L223 131L218 140Z" style="fill:#000000"/><path d="M5 4L242 148L241 149L4 5Z" style="fill:#000000"/><text x="233" y="160" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="213" y="153" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="317" y="110" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">o</text></svg>',
  'obr.svg',
  'V rovině leží různoběžky o a p a bod A ležící na přímce p.',
  '',
  new List<String>{'9.1: Bodem $A$ vedeme kolmici k ose $o$; bod $B$ leží na této kolmici ve stejné vzdálenosti od $o$ jako $A$, ale na opačné straně.','9.2: Průsečík přímek $o$ a $p$ se zobrazí sám na sebe. Obraz $q$ přímky $p$ proto prochází tímto průsečíkem a bodem $B$ (obrazem bodu $A$).'},
  'Konstrukce: bod $B$ je obraz bodu $A$ v osové souměrnosti podle $o$; přímka $q$ prochází bodem $B$ a průsečíkem přímek $o$ a $p$.',
  2, 4, '3',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','soumernost','rysovani','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 10',
  new List<String>{'V rovině jsou dány body $A$, $B$ a $Y$ (bod $A$ dole uprostřed, bod $B$ vpravo nahoře, bod $Y$ zhruba uprostřed nahoře).','10.1 Na polopřímce $BY$ sestrojte bod $C$ tak, aby body $A$, $B$, $C$ tvořily vrcholy rovnoramenného trojúhelníku se základnou $AB$, a trojúhelník $ABC$ narýsujte.','10.2 Sestrojte osu souměrnosti $o$ trojúhelníku $ABC$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'10.1: Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$; bod $C$ leží na ose úsečky $AB$. Sestrojíme osu úsečky $AB$; její průsečík s polopřímkou $BY$ je hledaný bod $C$.','10.2: Osa souměrnosti $o$ rovnoramenného trojúhelníku $ABC$ je totožná s osou základny $AB$ (prochází bodem $C$ a středem $AB$).'},
  'Konstrukce: $C$ = průsečík polopřímky $BY$ s osou úsečky $AB$; osa souměrnosti $o$ je osa základny $AB$.',
  3, 6, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','soumernost','rysovani','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 11',
  new List<String>{'Uvnitř čtverce je sestrojen trojúhelník, jehož jedna strana je současně stranou čtverce. Přemístěním trojúhelníku k protější straně čtverce vznikne nový obrazec (trojúhelník se z vnitřku čtverce odebere a přiloží zvnějšku k protější straně). Obvod čtverce je $40\\ \\mathrm{cm}$ a obvod trojúhelníku $25\\ \\mathrm{cm}$.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 Obvod nového obrazce je $50\\ \\mathrm{cm}$.','11.2 Obsah čtverce je $100\\ \\mathrm{cm}^2$.','11.3 Obsah nového obrazce je větší než obsah čtverce.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Strana čtverce $=40:4=10\\ \\mathrm{cm}$. Základna trojúhelníku splývá se stranou čtverce, tj. $10\\ \\mathrm{cm}$; zbylé dvě strany trojúhelníku mají součet $25-10=15\\ \\mathrm{cm}$.','11.1: Nový obrazec tvoří dvě celé strany čtverce ($10+10=20$), na jedné straně místo úsečky $10\\ \\mathrm{cm}$ vznikl zářez ze dvou stran trojúhelníku ($15$) a na protější straně přečnívá trojúhelník ($15$): obvod $=20+15+15=50\\ \\mathrm{cm}$ — \\textbf{A} (pravda).','11.2: Obsah čtverce $=10^2=100\\ \\mathrm{cm}^2$ — \\textbf{A} (pravda).','11.3: Odebraná i přidaná plocha je týž trojúhelník, celkový obsah se nemění a je stejný jako obsah čtverce — \\textbf{N} (nepravda).'},
  '11.1: A; 11.2: A; 11.3: N',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','uvazovani','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);
c.add(
  'CERMAT 2015 M9 · úloha 12',
  new List<String>{'V pravoúhlém trojúhelníku $ABC$ leží proti přeponě $c$ úhel $\\gamma$ a proti odvěsnám $a$, $b$ úhly $\\alpha$, $\\beta$. Platí: $a=6\\ \\mathrm{cm}$, $c=10\\ \\mathrm{cm}$.','Rozhodněte o každém z tvrzení 12.1–12.3, zda je pravdivé (A), či nikoli (N).','12.1 \\quad $a+b=c$','12.2 \\quad $\\beta<\\gamma$','12.3 \\quad $\\alpha+\\beta=90^\\circ$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Přepona je $c$, proto $\\gamma=90^\\circ$. Odvěsna $b=\\sqrt{c^2-a^2}=\\sqrt{100-36}=\\sqrt{64}=8\\ \\mathrm{cm}$.','12.1: $a+b=6+8=14\\neq10=c$ — \\textbf{N} (nepravda).','12.2: $\\beta<90^\\circ=\\gamma$ — \\textbf{A} (pravda).','12.3: Součet ostrých úhlů pravoúhlého trojúhelníku je $\\alpha+\\beta=90^\\circ$ — \\textbf{A} (pravda).'},
  '12.1: N; 12.2: A; 12.3: A',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','uhly','uvazovani','bez-kalkulacky','bez-kontextu'},
  'M9PZD15C0T01', 2015
);

System.debug('Vytvořeno úloh: '+c.created);
