String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 4.2',
  new List<String>{'Při příjezdu na letiště bylo ohlášené zpoždění odletu letadla $1$ hodina a $50$ minut, ale nakonec bylo zpoždění šestkrát delší. Vypočtěte v hodinách, jaké bylo nakonec zpoždění odletu letadla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ h $50$ min $=110$ min. Šestkrát delší: $6\\cdot 110=660$ min $=11$ hodin.'},
  '$11$ hodin',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2021 – úloha 5',
  new List<String>{'V zelené krabičce jsou jen zelené kuličky, v bílé krabičce jen bílé kuličky a v modré krabičce jen modré kuličky. V těchto třech krabičkách je dohromady $180$ kuliček. Modrých kuliček je o $10$ více než bílých. Aby byl ve všech třech krabičkách stejný počet kuliček, ze zelené krabičky vyndáme $40$ kuliček a rozdělíme je do zbývajících dvou krabiček.','5.1 Určete počet všech zelených kuliček.','5.2 Určete, kolik zelených kuliček přendáme do bílé krabičky.','5.3 Určete počet všech modrých kuliček.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Ve všech třech krabičkách má nakonec být $180:3=60$ kuliček. Zelená měla o $40$ více, tj. $60+40=100$ kuliček.','5.2 Bílých a modrých je dohromady $180-100=80$; z rovnice $b+(b+10)=80$ plyne $b=35$ bílých a $45$ modrých. Do bílé přendáme $60-35=25$ kuliček.','5.3 Modrých kuliček je $45$.'},
  '5.1: $100$ zelených kuliček; 5.2: $25$ zelených kuliček; 5.3: $45$ modrých kuliček',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2021 – úloha 6',
  new List<String>{'Třídy 7. A a 7. B se zúčastnily soutěže, která měla tři kola. V tabulce jsou uvedeny počty bodů, které třídy získaly v jednotlivých kolech soutěže, některé údaje však chybí.','6.1 Třída 7. A získala v každém následujícím kole vždy o $25\\,\\%$ bodů více než v kole předchozím. Vypočtěte, kolik bodů v soutěži získaly dohromady obě třídy.','6.2 Třída 7. B získala v 1. kole o $6$ bodů více než ve 2. kole a ve 3. kole dvakrát více bodů než ve 2. kole. Vypočtěte, kolik bodů získaly dohromady obě třídy ve 2. kole soutěže.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 200" font-family="sans-serif"> <rect x="20" y="20" width="500" height="165" fill="none" stroke="#000"/> <line x1="120" y1="20" x2="120" y2="185" stroke="#000"/> <line x1="220" y1="50" x2="220" y2="185" stroke="#000"/> <line x1="320" y1="50" x2="320" y2="185" stroke="#000"/> <line x1="420" y1="20" x2="420" y2="185" stroke="#000"/> <line x1="20" y1="80" x2="520" y2="80" stroke="#000"/> <line x1="120" y1="50" x2="420" y2="50" stroke="#000"/> <line x1="20" y1="115" x2="520" y2="115" stroke="#000"/> <line x1="20" y1="150" x2="520" y2="150" stroke="#000"/> <text x="70" y="55" font-size="12" text-anchor="middle">Trida</text> <text x="270" y="40" font-size="12" text-anchor="middle">Pocet bodu ziskanych</text> <text x="170" y="70" font-size="11" text-anchor="middle">v 1. kole</text> <text x="270" y="70" font-size="11" text-anchor="middle">ve 2. kole</text> <text x="370" y="70" font-size="11" text-anchor="middle">ve 3. kole</text> <text x="470" y="50" font-size="12" text-anchor="middle">Soucet</text> <text x="470" y="66" font-size="12" text-anchor="middle">bodu</text> <text x="70" y="102" font-size="12" text-anchor="middle">7. A</text> <text x="70" y="137" font-size="12" text-anchor="middle">7. B</text> <text x="70" y="172" font-size="11" text-anchor="middle">Obe tridy</text> <text x="270" y="102" font-size="12" text-anchor="middle">40</text> <text x="470" y="137" font-size="12" text-anchor="middle">138</text> </svg>',
  'tabulka-soutez.svg',
  'Tabulka bodů tříd 7. A a 7. B ve třech kolech; známé údaje jsou 40 bodů u 7. A ve 2. kole a součet 138 bodů u 7. B.',
  'Počty bodů získaných v jednotlivých kolech',
  new List<String>{'6.1 Třída 7. A ve 2. kole $40$ bodů; 1. kolo $40:1{,}25=32$, 3. kolo $40\\cdot 1{,}25=50$. Součet 7. A $=32+40+50=122$. Obě třídy $122+138=260$ bodů.','6.2 Označme body 7. B ve 2. kole $y$: $(y+6)+y+2y=138$, tj. $4y+6=138$, $y=33$. Ve 2. kole obě třídy $40+33=73$ bodů.'},
  '6.1: $260$ bodů; 6.2: $73$ bodů',
  4, 7, '3',
  new List<String>{'zs2','r7','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
