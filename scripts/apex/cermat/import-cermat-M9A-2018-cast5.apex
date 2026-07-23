String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M9A 2018 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Obrázek tvaru obdélníku s rozměry $12$ cm a $8$ cm je nalepen na obdélníkové podložce. Podložka přesahuje obrázek nahoře, dole, vpravo i vlevo o $2$ cm. Kolik procent plochy podložky není zakryto obrázkem?','15.2 V lednu se $2$ litry limonády prodávaly za $24$ Kč, v únoru se za tuto cenu prodávalo $2{,}5$ litru limonády. O kolik procent byl $1$ litr limonády v únoru levnější než v lednu?','15.3 Cyklista ujel za $3$ dny trasu dlouhou $240$ km. První den ujel polovinu celé trasy, druhý den ujel dvě pětiny zbytku trasy. Kolik procent celé trasy ujel cyklista třetí den?'},
  new List<String>{'A) o méně než $20\\,\\%$','B) o $20\\,\\%$','C) o $25\\,\\%$','D) o $30\\,\\%$','E) o $50\\,\\%$','F) o více než $50\\,\\%$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 200" font-family="sans-serif"> <rect x="20" y="25" width="200" height="150" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <rect x="45" y="50" width="150" height="100" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/> <text x="90" y="95" font-size="13">12 cm</text> <text x="150" y="116" font-size="13">8 cm</text> <text x="200" y="103" font-size="10">2 cm</text> <text x="110" y="170" font-size="10">2 cm</text> </svg>',
  'podlozka-obrazek.svg',
  'Šedý obrázek 12 cm krát 8 cm nalepený na bílé obdélníkové podložce přesahující o 2 cm na každé straně.',
  'Obrázek k úloze 15.1',
  new List<String>{'15.1 Podložka má rozměry $(12+4)\\times(8+4)=16\\times 12=192$ cm², obrázek $12\\cdot 8=96$ cm². Nezakryto $192-96=96$ cm², tj. $\\frac{96}{192}=50\\,\\%$ → E.','15.2 Leden: $1$ l za $12$ Kč; únor: $24:2{,}5=9{,}6$ Kč/l. Zlevnění $\\frac{12-9{,}6}{12}=20\\,\\%$ → B.','15.3 První den $\\frac{1}{2}\\cdot 240=120$ km, zbytek $120$ km; druhý den $\\frac{2}{5}\\cdot 120=48$ km; třetí den $120-48=72$ km, tj. $\\frac{72}{240}=30\\,\\%$ → D.'},
  '15.1: E (o $50\\,\\%$); 15.2: B (o $20\\,\\%$); 15.3: D (o $30\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2018 – úloha 16',
  new List<String>{'Shodné čtverce jsou podle jednotného pravidla rozděleny vždy na světlou a tmavou plochu. Obě plochy se liší o $3$, $4$ nebo více čtverečků, které lze vyznačit po úhlopříčce. Poměr velikostí světlé a tmavé plochy u prvního zobrazeného čtverce je $6:3$ a v základním tvaru jej zapisujeme $2:1$.','16.1 Zapište v základním tvaru poměr velikostí světlé a tmavé plochy čtverce, jestliže se obě plochy liší o $9$ čtverečků vyznačených po úhlopříčce.','16.2 Zapište v základním tvaru poměr velikostí světlé a tmavé plochy čtverce, jestliže se obě plochy liší o $100$ čtverečků vyznačených po úhlopříčce.','16.3 Určete počet čtverečků vyznačených po úhlopříčce, jestliže je poměr velikostí světlé a tmavé plochy $13:11$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 120" font-family="sans-serif"><rect x="20" y="20" width="48" height="48" fill="#ffffff" stroke="#000"/><polygon points="36,20 68,20 68,52 52,52 52,36 36,36 36,20" fill="#8a8a8a" stroke="#000"/><text x="130" y="70" font-size="20">…</text><rect x="200" y="20" width="80" height="80" fill="#ffffff" stroke="#000"/><polygon points="216,20 280,20 280,84 264,84 264,68 248,68 248,52 232,52 232,36 216,36 216,20" fill="#8a8a8a" stroke="#000"/><text x="350" y="70" font-size="20">…</text></svg>',
  'ctverce-plochy.svg',
  'Shodné čtverce schodovitě rozdělené po úhlopříčce na světlou (bílou) a tmavou (šedou) plochu; ukázka pro tři a pět čtverečků na straně.',
  'Schodovité rozdělení čtverců na světlou a tmavou plochu',
  new List<String>{'Čtverec o straně $n$ čtverečků má světlou plochu $\\frac{n^2+n}{2}$ a tmavou $\\frac{n^2-n}{2}$; liší se právě o $n$ čtverečků na úhlopříčce a jejich poměr je $(n+1):(n-1)$.','16.1 Rozdíl $9\\Rightarrow n=9$: poměr $10:8=5:4$.','16.2 Rozdíl $100\\Rightarrow n=100$: poměr $101:99$.','16.3 $(n+1):(n-1)=13:11\\Rightarrow n=12$; po úhlopříčce je $12$ čtverečků.'},
  '16.1: $5:4$; 16.2: $101:99$; 16.3: $12$',
  4, 6, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
