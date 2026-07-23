String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD21C0T04';
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
  'CERMAT M7D 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?','15.2 Obdélník i tmavý obrazec v něm mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?','15.3 Věra měla naspořeno $1\\,000$ korun. Nejprve si za $20\\,\\%$ úspor koupila tričko a potom $20\\,\\%$ ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?'},
  new List<String>{'A) o $0\\,\\%$','B) o $20\\,\\%$','C) o $25\\,\\%$','D) o $30\\,\\%$','E) o $35\\,\\%$','F) o jiný počet procent'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 216" font-family="sans-serif"> <polygon points="108,20 240,64 240,196 108,152 64,196 20,152" fill="#bcbcbc"/> <g stroke="#8a8a8a" stroke-width="1"> <line x1="20" y1="20" x2="240" y2="20"/><line x1="20" y1="64" x2="240" y2="64"/><line x1="20" y1="108" x2="240" y2="108"/><line x1="20" y1="152" x2="240" y2="152"/><line x1="20" y1="196" x2="240" y2="196"/> <line x1="20" y1="20" x2="20" y2="196"/><line x1="64" y1="20" x2="64" y2="196"/><line x1="108" y1="20" x2="108" y2="196"/><line x1="152" y1="20" x2="152" y2="196"/><line x1="196" y1="20" x2="196" y2="196"/><line x1="240" y1="20" x2="240" y2="196"/> </g> <polygon points="108,20 240,64 240,196 108,152 64,196 20,152" fill="none" stroke="#000" stroke-width="2.5"/> <rect x="20" y="20" width="220" height="176" fill="none" stroke="#000" stroke-width="2"/> </svg>',
  'sit-obrazec.svg',
  'Obdélník 5 krát 4 ve čtvercové síti s tmavým mnohoúhelníkem o obsahu 13 čtverečků.',
  'Obrázek k úloze 15.2',
  new List<String>{'15.1 Nárůst $420-350=70$ z $350$, tj. $\\frac{70}{350}=0{,}2=20\\,\\%$ → B.','15.2 Obdélník má obsah $20$ čtverečků, tmavý obrazec $13$ čtverečků. Je menší o $\\frac{20-13}{20}=\\frac{7}{20}=35\\,\\%$ → E.','15.3 Tričko $20\\,\\%$ z $1\\,000=200$ Kč; zbývá $800$ Kč, knížka $20\\,\\%$ z $800=160$ Kč. Tričko je dražší o $\\frac{200-160}{160}=\\frac{40}{160}=25\\,\\%$ → C.'},
  '15.1: B (o $20\\,\\%$); 15.2: E (o $35\\,\\%$); 15.3: C (o $25\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2021 – úloha 16',
  new List<String>{'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. Na $1.$ až $17.$ místě je: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\ldots$','Určete','16.1 na kolikátém místě nové řady je číslo $100$,','16.2 které číslo je na $100.$ místě nové řady,','16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Číslo $n$ zabírá v nové řadě $n+\\lfloor n/3\\rfloor$ míst (násobky tří dvakrát).','16.1 Do čísla $100$ je míst $100+\\lfloor 100/3\\rfloor=100+33=133$; číslo $100$ je na $133.$ místě.','16.2 Hledáme $n$ s $n+\\lfloor n/3\\rfloor=100$: pro $n=75$ je $75+25=100$ ($75$ je dělitelné třemi, stojí na $99.$ i $100.$ místě). Na $100.$ místě je číslo $75$.','16.3 Sudých čísel od $1$ do $101$ je $50$; z nich jsou násobky šesti ($6,12,\\ldots,96$), tj. $16$ čísel, uvedeny dvakrát. Sudé číslo je tak na $50+16=66$ místech.'},
  '16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech',
  4, 7, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
