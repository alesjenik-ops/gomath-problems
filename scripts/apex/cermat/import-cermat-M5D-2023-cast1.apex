String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
Integer YEAR = 2023;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5D 2023 – úloha 1.1',
  new List<String>{'Vypočtěte: $(24\\cdot 26-24\\cdot 6):12-2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$24\\cdot 26-24\\cdot 6=24\\cdot(26-6)=480$, dále $480:12-2=40-2=38$.'},
  '$38$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2023 – úloha 1.2',
  new List<String>{'Vypočtěte: $(3+7\\cdot 13)\\cdot 5+15\\cdot 30=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3+7\\cdot 13=94$, dále $94\\cdot 5+15\\cdot 30=470+450=920$.'},
  '$920$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2023 – úloha 2',
  new List<String>{'Na číselné ose je vyznačeno 13 bodů, které oddělují 12 stejných dílků. V jednom z těchto bodů je číslo 20 a body $A$, $B$, $C$ představují tři kladná čísla. Číslo v bodě $C$ je součtem čísla v bodě $A$ a čísla v bodě $B$ (viz obrázek).','2.1 Vyznačte na číselné ose bod $P$, v němž je číslo 0.','2.2 Určete číslo v bodě $B$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 150" font-family="sans-serif"><line x1="18" y1="100" x2="548" y2="100" stroke="#000" stroke-width="2"/><polygon points="548,100 536,94 536,106" fill="#000"/><line x1="40" y1="92" x2="40" y2="108" stroke="#000" stroke-width="2"/><line x1="80" y1="92" x2="80" y2="108" stroke="#000" stroke-width="2"/><line x1="120" y1="92" x2="120" y2="108" stroke="#000" stroke-width="2"/><line x1="160" y1="92" x2="160" y2="108" stroke="#000" stroke-width="2"/><line x1="200" y1="92" x2="200" y2="108" stroke="#000" stroke-width="2"/><line x1="240" y1="92" x2="240" y2="108" stroke="#000" stroke-width="2"/><line x1="280" y1="92" x2="280" y2="108" stroke="#000" stroke-width="2"/><line x1="320" y1="92" x2="320" y2="108" stroke="#000" stroke-width="2"/><line x1="360" y1="92" x2="360" y2="108" stroke="#000" stroke-width="2"/><line x1="400" y1="92" x2="400" y2="108" stroke="#000" stroke-width="2"/><line x1="440" y1="92" x2="440" y2="108" stroke="#000" stroke-width="2"/><line x1="480" y1="92" x2="480" y2="108" stroke="#000" stroke-width="2"/><line x1="520" y1="92" x2="520" y2="108" stroke="#000" stroke-width="2"/><text x="320" y="84" font-size="15" text-anchor="middle">20</text><text x="240" y="128" font-size="15" text-anchor="middle" font-style="italic">A</text><text x="400" y="128" font-size="15" text-anchor="middle" font-style="italic">B</text><text x="520" y="128" font-size="15" text-anchor="middle" font-style="italic">C</text></svg>',
  'osa.svg',
  'Číselná osa se 13 body (12 dílků); vyznačeno číslo 20 a body A, B, C.',
  'Výchozí číselná osa k úloze 2',
  new List<String>{'2.1 Bod $A$ je dva dílky vlevo od čísla 20, bod $B$ dva dílky vpravo a bod $C$ pět dílků vpravo (poslední bod). Z podmínky $C=A+B$ dostaneme pro velikost dílku $d$ rovnici $(20-2d)+(20+2d)=20+5d$, tedy $40=20+5d$ a $d=4$. Bod $P$ s číslem 0 leží pět dílků vlevo od čísla 20.','2.2 $B=20+2\\cdot 4=28$.'},
  '2.1: bod $P$ (číslo 0) leží pět dílků vlevo od čísla 20; 2.2: $28$',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2023 – úloha 3.1',
  new List<String>{'Závod v hodu kládou měl dvě kola a zúčastnilo se jej 36 závodníků. V 1. kole házel každý závodník pouze jednou. Někteří závodníci postoupili do 2. kola, v němž házel každý z postupujících ještě dvakrát. Během celého závodu tak bylo provedeno celkem 64 hodů kládou.','Vypočtěte, kolik závodníků postoupilo do druhého kola závodu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V 1. kole padlo 36 hodů. Na 2. kolo připadá $64-36=28$ hodů, kde každý postupující házel dvakrát; postoupilo tedy $28:2=14$ závodníků.'},
  '$14$ závodníků',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5D 2023 – úloha 3.2',
  new List<String>{'Cyklista během 5 dní ujel na kole celkem 200 km. První den ujel nejdelší trasu a každý další den ujel o 6 km méně než předchozí den (např. 4. den ujel o 6 km méně než 3. den).','Vypočtěte, kolik km ujel cyklista první den.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme trasu prvního dne $x$. Další dny: $x-6$, $x-12$, $x-18$, $x-24$. Součet $5x-60=200$, odtud $5x=260$ a $x=52$ km.'},
  '$52$ km',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
