String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M9A 2019 – úloha 16',
  new List<String>{'Na čtvercovou desku s lichým počtem políček rozmístíme žetony takto: v prvním kroku položíme na každé políčko po obvodu desky $1$ žeton; v každém dalším kroku vybereme všechna prázdná políčka bezprostředně sousedící s obsazenými a na každé z nich položíme o $1$ žeton více než v předchozím kroku. Největší počet žetonů tak bude na prostředním políčku desky. Viz obrázek – desky $3\\times 3$ a $5\\times 5$.','16.1 Čtvercová deska má na prostředním políčku $9$ žetonů. Určete, kolik políček je v každé řadě této čtvercové desky.','16.2 Žetony rozmístíme na čtvercovou desku, která má $9\\times 9$ políček. Určete počet všech políček, na nichž leží právě $2$ žetony.','16.3 Žetony rozmístíme na dvě čtvercové desky, z nichž jedna má $9\\times 9$ políček a druhá $11\\times 11$ políček. Určete, o kolik více žetonů je na větší desce než na menší desce.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 230" font-family="sans-serif"><text x="85" y="30" font-size="13" text-anchor="middle">3 × 3 políčka</text><rect x="40" y="45" width="90" height="90" fill="#ffffff" stroke="#000"/><line x1="40" y1="75" x2="130" y2="75" stroke="#000"/><line x1="40" y1="105" x2="130" y2="105" stroke="#000"/><line x1="70" y1="45" x2="70" y2="135" stroke="#000"/><line x1="100" y1="45" x2="100" y2="135" stroke="#000"/><text x="55" y="64" font-size="14" text-anchor="middle">1</text><text x="85" y="64" font-size="14" text-anchor="middle">1</text><text x="115" y="64" font-size="14" text-anchor="middle">1</text><text x="55" y="94" font-size="14" text-anchor="middle">1</text><text x="85" y="94" font-size="14" text-anchor="middle">2</text><text x="115" y="94" font-size="14" text-anchor="middle">1</text><text x="55" y="124" font-size="14" text-anchor="middle">1</text><text x="85" y="124" font-size="14" text-anchor="middle">1</text><text x="115" y="124" font-size="14" text-anchor="middle">1</text><text x="320" y="30" font-size="13" text-anchor="middle">5 × 5 políček</text><rect x="250" y="45" width="150" height="150" fill="#ffffff" stroke="#000"/><line x1="250" y1="75" x2="400" y2="75" stroke="#000"/><line x1="250" y1="105" x2="400" y2="105" stroke="#000"/><line x1="250" y1="135" x2="400" y2="135" stroke="#000"/><line x1="250" y1="165" x2="400" y2="165" stroke="#000"/><line x1="280" y1="45" x2="280" y2="195" stroke="#000"/><line x1="310" y1="45" x2="310" y2="195" stroke="#000"/><line x1="340" y1="45" x2="340" y2="195" stroke="#000"/><line x1="370" y1="45" x2="370" y2="195" stroke="#000"/><text x="265" y="64" font-size="14" text-anchor="middle">1</text><text x="295" y="64" font-size="14" text-anchor="middle">1</text><text x="325" y="64" font-size="14" text-anchor="middle">1</text><text x="355" y="64" font-size="14" text-anchor="middle">1</text><text x="385" y="64" font-size="14" text-anchor="middle">1</text><text x="265" y="94" font-size="14" text-anchor="middle">1</text><text x="295" y="94" font-size="14" text-anchor="middle">2</text><text x="325" y="94" font-size="14" text-anchor="middle">2</text><text x="355" y="94" font-size="14" text-anchor="middle">2</text><text x="385" y="94" font-size="14" text-anchor="middle">1</text><text x="265" y="124" font-size="14" text-anchor="middle">1</text><text x="295" y="124" font-size="14" text-anchor="middle">2</text><text x="325" y="124" font-size="14" text-anchor="middle">3</text><text x="355" y="124" font-size="14" text-anchor="middle">2</text><text x="385" y="124" font-size="14" text-anchor="middle">1</text><text x="265" y="154" font-size="14" text-anchor="middle">1</text><text x="295" y="154" font-size="14" text-anchor="middle">2</text><text x="325" y="154" font-size="14" text-anchor="middle">2</text><text x="355" y="154" font-size="14" text-anchor="middle">2</text><text x="385" y="154" font-size="14" text-anchor="middle">1</text><text x="265" y="184" font-size="14" text-anchor="middle">1</text><text x="295" y="184" font-size="14" text-anchor="middle">1</text><text x="325" y="184" font-size="14" text-anchor="middle">1</text><text x="355" y="184" font-size="14" text-anchor="middle">1</text><text x="385" y="184" font-size="14" text-anchor="middle">1</text></svg>',
  'zetony-desky.svg',
  'Deska 3 krát 3 s hodnotami 1 po obvodu a 2 uprostřed a deska 5 krát 5 s hodnotami 1, 2 a 3 (uprostřed).',
  'Rozmístění žetonů na deskách 3 krát 3 a 5 krát 5',
  new List<String>{'Na desce $n\\times n$ ($n$ liché) má prostřední políčko $\\frac{n+1}{2}$ žetonů; políčka s hodnotou $k$ tvoří čtvercový prstenec o $4\\,(n - 2k + 1)$ políčkách (pro $k < \\frac{n+1}{2}$).','16.1 $\\frac{n+1}{2} = 9 \\Rightarrow n = 17$; v každé řadě je $17$ políček.','16.2 Na desce $9\\times 9$ mají hodnotu $2$ políčka druhého prstence: $4\\,(9 - 2\\cdot 2 + 1) = 4\\cdot 6 = 24$ políček.','16.3 Celkový počet žetonů na desce $9\\times 9$ je $165$, na desce $11\\times 11$ je $286$; rozdíl $286 - 165 = 121$ žetonů.'},
  '16.1: $17$ políček; 16.2: $24$ políček; 16.3: o $121$ žetonů',
  4, 7, '3',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
