String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
Integer YEAR = 2021;

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
  'CERMAT M5B 2021 – úloha 1.1',
  new List<String>{'Vypočtěte: $5+15\\cdot(10-4)-15:5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $5+15\\cdot 6-3=5+90-3=92$.'},
  '$92$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2021 – úloha 1.2',
  new List<String>{'Vypočtěte: $55\\cdot 16+45\\cdot 16-50\\cdot 16=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vytkneme $16$: $16\\cdot(55+45-50)=16\\cdot 50=800$.'},
  '$800$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2021 – úloha 2',
  new List<String>{'Na číselné ose je zobrazeno deset stejných dílků, číslo $A=72$, číslo $B=192$ a neznámé číslo $C$ (viz obrázek).','2.1 Určete číslo $C$.','2.2 K odpovídajícímu bodu číselné osy zapište číslo $0$ a bod na ose zvýrazněte.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 130" font-family="sans-serif"><line x1="32" y1="72" x2="464" y2="72" stroke="#000" stroke-width="2"/><polygon points="464,72 453,67 453,77" fill="#000"/><line x1="40" y1="65" x2="40" y2="79" stroke="#000" stroke-width="2"/><line x1="80" y1="65" x2="80" y2="79" stroke="#000" stroke-width="2"/><line x1="120" y1="65" x2="120" y2="79" stroke="#000" stroke-width="2"/><line x1="160" y1="65" x2="160" y2="79" stroke="#000" stroke-width="2"/><line x1="200" y1="65" x2="200" y2="79" stroke="#000" stroke-width="2"/><line x1="240" y1="65" x2="240" y2="79" stroke="#000" stroke-width="2"/><line x1="280" y1="65" x2="280" y2="79" stroke="#000" stroke-width="2"/><line x1="320" y1="65" x2="320" y2="79" stroke="#000" stroke-width="2"/><line x1="360" y1="65" x2="360" y2="79" stroke="#000" stroke-width="2"/><line x1="400" y1="65" x2="400" y2="79" stroke="#000" stroke-width="2"/><line x1="440" y1="65" x2="440" y2="79" stroke="#000" stroke-width="2"/><text x="200" y="57" font-size="17" text-anchor="middle" font-style="italic">A</text><text x="200" y="99" font-size="15" text-anchor="middle">72</text><text x="320" y="57" font-size="17" text-anchor="middle" font-style="italic">C</text><text x="400" y="57" font-size="17" text-anchor="middle" font-style="italic">B</text><text x="400" y="99" font-size="15" text-anchor="middle">192</text></svg>',
  'osa.svg',
  'Číselná osa s deseti stejnými dílky; body A (72), C a B (192).',
  'Číselná osa k úloze 2',
  new List<String>{'Deset dílků, mezi $A=72$ a $B=192$ jsou tři dílky k $C$ a dva dílky dále k $B$; jeden dílek $=(192-72):5=24$.','2.1 $C=72+3\\cdot 24=144$.','2.2 Číslo $0$ odpovídá bodu o tři dílky vlevo od $A$ (o hodnotu $72$).'},
  '2.1: $C=144$; 2.2: bod $0$ leží o tři dílky vlevo od bodu $A$ (viz obrázek v klíči)',
  3, 3, '2',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2021 – úloha 3.1',
  new List<String>{'Kabel dlouhý $13$ m a $8$ cm rozdělíme na šest stejných dílů.','Vypočtěte v cm délku jednoho dílu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$13$ m $8$ cm $=1308$ cm; jeden díl $=1308:6=218$ cm.'},
  '$218$ cm',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2021 – úloha 3.2',
  new List<String>{'Při příjezdu na letiště bylo ohlášené zpoždění odletu letadla $1$ hodina a $50$ minut, ale nakonec bylo zpoždění šestkrát delší.','Vypočtěte v hodinách, jaké bylo nakonec zpoždění odletu letadla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ h $50$ min $=110$ min; šestkrát delší $=6\\cdot 110=660$ min $=11$ hodin.'},
  '$11$ hodin',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2021 – úloha 4',
  new List<String>{'V dětské hře se smí provádět pouze tyto nákupy: za $5$ mincí lze koupit $6$ panáčků, za $20$ mincí lze koupit $9$ zvířátek.','4.1 Žofie koupila $12$ panáčků a určitý počet zvířátek. Za panáčky a zvířátka zaplatila celkem $90$ mincí. Určete, kolik zvířátek koupila.','4.2 Pepa si chce koupit stejný počet panáčků jako zvířátek. Určete nejmenší počet mincí, které k takovému nákupu potřebuje.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 $12$ panáčků $=2\\cdot 6$, tj. $2\\cdot 5=10$ mincí. Na zvířátka zbývá $90-10=80$ mincí $=4\\cdot 20$, tedy $4\\cdot 9=36$ zvířátek.','4.2 Stejný počet panáčků i zvířátek musí být dělitelný $6$ i $9$, nejmenší je $18$. $18$ panáčků $=3\\cdot 5=15$ mincí, $18$ zvířátek $=2\\cdot 20=40$ mincí, celkem $55$ mincí.'},
  '4.1: $36$ zvířátek; 4.2: $55$ mincí',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
