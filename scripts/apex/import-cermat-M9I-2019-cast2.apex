String SRC   = 'CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2019 M9I · úloha 7',
  new List<String>{'Cukrárna se měla vybavit $4$ stejnými stolky a $20$ stejnými židlemi celkem za $9\\,200\\ \\mathrm{K\\check{c}}$. Nakonec se koupily stolky a židle jen za $7\\,800\\ \\mathrm{K\\check{c}}$, neboť $1$ stolek a $2$ židle již nebyly na skladě.','Vypočtěte, kolik Kč stojí','7.1 \\quad $1$ židle;','7.2 \\quad $1$ stolek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl cen $9\\,200-7\\,800=1\\,400\\ \\mathrm{K\\check{c}}$ odpovídá $1$ stolku a $2$ židlím: $s+2\\check{z}=1\\,400$.','Z $4s+20\\check{z}=9\\,200$ plyne $s+5\\check{z}=2\\,300$. Odečtením: $3\\check{z}=900\\Rightarrow \\check{z}=300$; pak $s=1\\,400-2\\cdot 300=800$.','7.1: $1$ židle stojí $300\\ \\mathrm{K\\check{c}}$. 7.2: $1$ stolek stojí $800\\ \\mathrm{K\\check{c}}$.'},
  '7.1: $300\\ \\mathrm{K\\check{c}}$; 7.2: $800\\ \\mathrm{K\\check{c}}$',
  3, 6, '3',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 8',
  new List<String>{'Cesty v bludišti jsou složeny z rovných úseků (silné čáry), všechny křižovatky jsou pravoúhlé. Čísla představují délky úseků v metrech. Přímá vzdálenost bodů $A$, $B$ je $13\\ \\mathrm{m}$.','Vyznačená cesta z bodu $A$ do bodu $B$ vede po úsecích: vodorovně $8\\ \\mathrm{m}$, svisle dolů $2\\ \\mathrm{m}$, vodorovně $4\\ \\mathrm{m}$ a nakonec svisle dolů do bodu $B$.','Vyznačená cesta z bodu $A$ do bodu $C$ vede po úsecích: svisle dolů $8\\ \\mathrm{m}$, vodorovně $4\\ \\mathrm{m}$, svisle dolů $8\\ \\mathrm{m}$, vodorovně $4\\ \\mathrm{m}$, svisle nahoru $4\\ \\mathrm{m}$ a vodorovně $8\\ \\mathrm{m}$ do bodu $C$ (všechny vodorovné úseky téhož směru).','Vypočtěte v metrech','8.1 \\quad délku vyznačené cesty z bodu $A$ do bodu $B$;','8.2 \\quad přímou vzdálenost bodů $A$, $C$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: vodorovné úseky cesty $A\\to B$ mají součet $8+4=12\\ \\mathrm{m}$, svislé úseky součet $s$. Protože přímá vzdálenost je $13\\ \\mathrm{m}$ a $13=\\sqrt{12^2+5^2}$, je celkový svislý pokles $5\\ \\mathrm{m}$. Délka cesty $=12+5=17\\ \\mathrm{m}$.','8.2: vodorovné posunutí z $A$ do $C$ je $4+4+8=16\\ \\mathrm{m}$, svislé posunutí je $8+8-4=12\\ \\mathrm{m}$. Přímá vzdálenost $=\\sqrt{16^2+12^2}=\\sqrt{256+144}=\\sqrt{400}=20\\ \\mathrm{m}$.'},
  '8.1: $17\\ \\mathrm{m}$; 8.2: $20\\ \\mathrm{m}$',
  3, 7, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 9',
  new List<String>{'Na přímce $p$ leží bod $A$ a mimo ni bod $C$ (viz obrázek).','Body $A$ a $C$ jsou vrcholy rovnoběžníku $ABCD$, jehož úhlopříčka $BD$ je dvakrát delší než úhlopříčka $AC$. Jeden ze zbývajících vrcholů $B$, $D$ tohoto rovnoběžníku leží na přímce $p$.','Sestrojte a označte chybějící vrcholy $B$, $D$ rovnoběžníku $ABCD$ a rovnoběžník narýsujte. Najděte všechna řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 379 197"><path d="M134 155L136 140M248 22L242 17M247 17L242 23M4 132L375 180" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="134" y="170" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="246" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="356" y="191" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text></svg>',
  'obr.svg',
  'Na přímce p leží bod A (vyznačen ryskou) a mimo přímku p leží bod C (vyznačen křížkem).',
  '',
  new List<String>{'Úhlopříčky rovnoběžníku se navzájem půlí; jejich průsečík $S$ je střed úsečky $AC$. Protože $|BD|=2\\,|AC|$, je $|SB|=|SD|=\\frac{|BD|}{2}=|AC|$.','Vrchol na přímce $p$ (např. $B$) tedy leží na $p$ a zároveň na kružnici se středem $S$ a poloměrem $|AC|$ — sestrojíme jej jako průsečík. Druhý vrchol $D$ je s ním souměrný podle středu $S$.','Podle počtu průsečíků přímky $p$ s kružnicí (obvykle dva) má úloha odpovídající počet řešení.'},
  'Konstrukce rovnoběžníku $ABCD$: $S$ je střed $AC$, vrcholy $B$, $D$ leží na přímce $p$ ve vzdálenosti $|AC|$ od $S$ a jsou souměrné podle $S$.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PID19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
