String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD21C0T04';
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
  'CERMAT M9D 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V lednu navštívilo výstavu $350$ lidí, v únoru $420$ lidí. O kolik procent byla návštěvnost v únoru vyšší než v lednu?','15.2 Obdélník i tmavý obrazec zakreslený v obdélníku mají všechny vrcholy v mřížových bodech čtvercové sítě (viz obrázek). O kolik procent je obsah tmavého obrazce menší než obsah obdélníku?','15.3 Věra měla naspořeno $1\\,000$ korun. Nejprve si za $20$ % úspor koupila tričko a potom $20$ % ze zbývajících peněz utratila za knížku. O kolik procent bylo tričko dražší než knížka?'},
  new List<String>{'A) o $0$ %','B) o $20$ %','C) o $25$ %','D) o $30$ %','E) o $35$ %','F) o jiný počet procent'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 210 176" font-family="sans-serif"><polygon points="88,20 190,54 190,156 122,156 105,122 54,156 20,156 20,122" fill="#b9b9b9"/><line x1="20" y1="20" x2="20" y2="156" stroke="#999" stroke-width="1"/><line x1="54" y1="20" x2="54" y2="156" stroke="#999" stroke-width="1"/><line x1="88" y1="20" x2="88" y2="156" stroke="#999" stroke-width="1"/><line x1="122" y1="20" x2="122" y2="156" stroke="#999" stroke-width="1"/><line x1="156" y1="20" x2="156" y2="156" stroke="#999" stroke-width="1"/><line x1="190" y1="20" x2="190" y2="156" stroke="#999" stroke-width="1"/><line x1="20" y1="20" x2="190" y2="20" stroke="#999" stroke-width="1"/><line x1="20" y1="54" x2="190" y2="54" stroke="#999" stroke-width="1"/><line x1="20" y1="88" x2="190" y2="88" stroke="#999" stroke-width="1"/><line x1="20" y1="122" x2="190" y2="122" stroke="#999" stroke-width="1"/><line x1="20" y1="156" x2="190" y2="156" stroke="#999" stroke-width="1"/><polygon points="88,20 190,54 190,156 122,156 105,122 54,156 20,156 20,122" fill="none" stroke="#000" stroke-width="2.5"/><rect x="20" y="20" width="170" height="136" fill="none" stroke="#000" stroke-width="2.5"/></svg>',
  'sit-obrazec.svg',
  'Obdélník 5 krát 4 ve čtvercové síti s tmavým mnohoúhelníkem s vrcholy v mřížových bodech (schéma k úloze 15.2).',
  'Obrázek k úloze 15.2',
  new List<String>{'15.1 $\\dfrac{420-350}{350}=\\dfrac{70}{350}=20$ % → B.','15.2 Obdélník má $5\\cdot 4=20$ čtverečků, tmavý obrazec $13$ čtverečků; je menší o $20-13=7$ čtverečků, tj. o $\\dfrac{7}{20}=35$ % → E.','15.3 Tričko: $20$ % z $1\\,000=200$ Kč, zbývá $800$ Kč. Knížka: $20$ % z $800=160$ Kč. Tričko je dražší o $\\dfrac{200-160}{160}=\\dfrac{40}{160}=25$ % → C.'},
  '15.1: B (o $20$ %); 15.2: E (o $35$ %); 15.3: C (o $25$ %)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2021 – úloha 16',
  new List<String>{'Do řady po sobě jdoucích kladných celých čísel přidáme za každé číslo dělitelné třemi toto číslo ještě jednou. Nová řada tak všechna čísla dělitelná třemi obsahuje dvakrát. V nové řadě je na $1.$ až $17.$ místě těchto $17$ čísel: $1, 2, 3, 3, 4, 5, 6, 6, 7, 8, 9, 9, 10, 11, 12, 12, 13, \\ldots$','Určete,','16.1 na kolikátém místě nové řady je číslo $100$,','16.2 které číslo je na $100.$ místě nové řady,','16.3 na kolika místech nové řady je mezi čísly $1$ až $101$ uvedeno sudé číslo.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Do čísla $n$ (včetně) je v nové řadě $n$ čísel a k tomu tolik navíc, kolik je mezi nimi násobků tří, tj. celkem $n+\\left\\lfloor\\dfrac{n}{3}\\right\\rfloor$ míst.','16.1 Číslo $100$ není dělitelné třemi, jeho místo je $100+\\left\\lfloor\\dfrac{99}{3}\\right\\rfloor=100+33=133$. Je na $133.$ místě.','16.2 Hledáme $n$ s $n+\\left\\lfloor\\dfrac{n}{3}\\right\\rfloor=100$. Pro $n=75$ je $75+25=100$; číslo $75$ je dělitelné třemi (stojí na $99.$ a $100.$ místě), na $100.$ místě je tedy $75$.','16.3 Sudých čísel mezi $1$ a $101$ je $50$ (čísla $2,4,\\ldots,100$). Z nich je $16$ dělitelných třemi (násobky šesti $6,12,\\ldots,96$) a ta jsou v řadě dvakrát. Sudé číslo je proto na $50+16=66$ místech.'},
  '16.1: na $133.$ místě; 16.2: $75$; 16.3: na $66$ místech',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
