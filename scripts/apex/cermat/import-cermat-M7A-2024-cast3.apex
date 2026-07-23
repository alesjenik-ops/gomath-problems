String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD24C0T01';
Integer YEAR = 2024;

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
  'CERMAT M7A 2024 – úloha 6',
  new List<String>{'Počet sportovců na závodech byl více než $1$ a zároveň méně než $90$. Pořadatel chtěl sportovce seřadit do slavnostního průvodu, ale ať je rozděloval do dvojic, trojic, čtveřic nebo pětic, vždy mu jeden sportovec zbyl.','Kolik sportovců se sešlo na závodech?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Počet zmenšený o $1$ musí být dělitelný $2$, $3$, $4$ i $5$, tedy dělitelný $\\mathrm{lcm}(2,3,4,5)=60$. V rozsahu od $2$ do $89$ vyhovuje jen $60+1=61$.'},
  '$61$ sportovců',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2024 – úloha 7',
  new List<String>{'V útulku mají $5$ štěňat. Krmení zvířat probíhá každý den odpoledne. $2.$ dubna ráno otevřeli $10$kg balení granulí pro psy, které těmto pěti štěňatům dohromady vystačí na $16$ dní. $8.$ dubna ráno bylo do útulku přivezeno $1$ štěně a $2$ dospělí psi. Víme, že každý dospělý pes sní za den dvojnásobek dávky určené pro štěně.','Kolikátého dubna byli naposledy psi a štěňata krmeni granulemi z tohoto balení?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Balení vystačí na $5\\cdot 16=80$ denních dávek pro štěně. Od $2.$ do $7.$ dubna (6 dnů krmení) sní $5$ štěňat $6\\cdot 5=30$ dávek, zbývá $50$ dávek. Od $8.$ dubna je zvířat $6$ štěňat a $2$ dospělí psi, tj. $6+2\\cdot 2=10$ dávek denně. Zbylých $50$ dávek vystačí na $50:10=5$ dnů, tedy $8.$ až $12.$ dubna.'},
  '$12.$ dubna',
  3, 6, '4',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2024 – úloha 8 (konstrukce)',
  new List<String>{'Je dána přímka $p$ a bod $A$, který neleží na přímce $p$ (viz obrázek). Na přímce $p$ leží bod $Y$.','Sestrojte pravoúhlý lichoběžník $ABCD$, pokud platí: rameno kolmé k základně $AB$ leží na přímce $p$; strana $AB$ má stejnou délku jako strana $AD$; strana $AB$ je dvakrát delší než strana $BC$; bod $C$ leží na polopřímce $BY$.','Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif"> <line x1="285" y1="40" x2="285" y2="285" stroke="#000" stroke-width="2"/> <line x1="277" y1="70" x2="293" y2="70" stroke="#000" stroke-width="2"/> <text x="300" y="75" font-size="16" font-style="italic">Y</text> <text x="296" y="278" font-size="16" font-style="italic">p</text> <text x="150" y="182" font-size="16" text-anchor="middle">×</text> <text x="150" y="200" font-size="16" text-anchor="middle" font-style="italic">A</text> </svg>',
  'primka-p-bod-A.svg',
  'Svisla primka p s bodem Y a bod A mimo primku.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Bod $B$ je pata kolmice vedené z bodu $A$ k přímce $p$ (tj. $AB\\perp p$). Bod $C$ leží na přímce $p$ tak, že $|BC|=\\frac{1}{2}|AB|$ (kružnice se středem $B$ a poloměrem $\\frac{1}{2}|AB|$). Bodem $C$ vedeme rovnoběžku s přímkou $AB$; bod $D$ na ní leží ve vzdálenosti $|AD|=|AB|$ od $A$ (kružnice se středem $A$ a poloměrem $|AB|$). Průsečíky dávají dvě řešení - lichoběžníky $ABCD_1$ a $ABCD_2$.'},
  'Dvě řešení: $B$ pata kolmice z $A$ na $p$, $|BC|=\\frac{1}{2}|AB|$ na přímce $p$, $CD\\parallel AB$, $|AD|=|AB|$ - lichoběžníky $ABCD_1$ a $ABCD_2$ (viz náčrt v klíči).',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
