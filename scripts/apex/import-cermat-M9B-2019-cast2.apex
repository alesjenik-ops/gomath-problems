String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 2. řádný termín (M9B)';
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
  'CERMAT 2019 M9B · úloha 7',
  new List<String>{'Nájezdová rampa sestavená ze čtyř dřevotřískových desek je přistavena ke schodu. Nakloněnou čtvercovou desku rampy podpírají tři stejné trojúhelníkové desky. Hloubka rampy je $12\\ \\mathrm{dm}$ a výška rampy je $5\\ \\mathrm{dm}$. Trojúhelníkové desky jsou pravoúhlé trojúhelníky s odvěsnami $5\\ \\mathrm{dm}$ (výška) a $12\\ \\mathrm{dm}$ (hloubka); nakloněná deska je čtverec. Tloušťku desky neuvažujte.','Vypočtěte, kolik dm$^2$ dřevotřísky je v hotové rampě použito','7.1 na všechny tři trojúhelníkové desky dohromady,','7.2 na čtvercovou desku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: jedna trojúhelníková deska má obsah $\\frac{1}{2}\\cdot5\\cdot12=30\\ \\mathrm{dm}^2$; tři desky $3\\cdot30=90\\ \\mathrm{dm}^2$.','7.2: strana nakloněné čtvercové desky je přepona trojúhelníku $\\sqrt{5^2+12^2}=\\sqrt{169}=13\\ \\mathrm{dm}$; obsah čtverce $13^2=169\\ \\mathrm{dm}^2$.'},
  '7.1: $90\\ \\mathrm{dm}^2$; 7.2: $169\\ \\mathrm{dm}^2$',
  3, 5, '4',
  new List<String>{'zs2','r9','stereometrie','geometrie','povrch','vypocet','slovni','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 8',
  new List<String>{'Čtverec je rozdělen čtyřmi svislými úsečkami a jednou vodorovnou úsečkou na $10$ shodných malých obdélníků (viz obrázek). Každý z malých obdélníků má obvod $42\\ \\mathrm{cm}$.','8.1 Vyjádřete v základním tvaru poměr délek sousedních stran jednoho malého obdélníku.','8.2 Vypočtěte v cm délku strany čtverce.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 86 86"><path d="M4 4L82 4L82 82L4 82ZM20 4L20 82M35 4L35 82M51 4L51 82M66 4L66 82M4 43L82 43" style="fill:none;stroke:#231f20;stroke-width:2"/></svg>',
  'obr.svg',
  'Čtverec rozdělený čtyřmi svislými a jednou vodorovnou úsečkou na 10 shodných malých obdélníků (5 sloupců, 2 řady).',
  '',
  new List<String>{'8.1: čtverec o straně $a$ je rozdělen na $5$ sloupců a $2$ řady, malý obdélník má rozměry $\\frac{a}{5}$ a $\\frac{a}{2}$; poměr $\\frac{a}{5}:\\frac{a}{2}=2:5$.','8.2: obvod malého obdélníku $2\\left(\\frac{a}{5}+\\frac{a}{2}\\right)=2\\cdot\\frac{7a}{10}=\\frac{7a}{5}=42\\Rightarrow a=30\\ \\mathrm{cm}$.'},
  '8.1: $2:5$ (příp. $5:2$); 8.2: $30\\ \\mathrm{cm}$',
  3, 4, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','pomer','obvod','vypocet','bez-kalkulacky'},
  'M9PBD19C0T02', 2019
);
c.add(
  'CERMAT 2019 M9B · úloha 9',
  new List<String>{'V rovině leží bod $B$ a přímka $p$, která prochází bodem $A$ (viz obrázek).','Body $A$, $B$ jsou vrcholy rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Rameno $AC$ leží na přímce $p$.','Sestrojte a označte písmenem chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 151 237"><path d="M128 4L128 233M10 174L4 179M4 174L10 179M124 19L132 19" style="fill:none;stroke:#231f20;stroke-width:2"/><text x="135" y="230" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">p</text><text x="141" y="25" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="10" y="192" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text></svg>',
  'obr.svg',
  'V rovině leží bod B a přímka p procházející bodem A.',
  '',
  new List<String>{'Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$ — vrchol $C$ leží na ose úsečky $AB$. Zároveň $C$ leží na přímce $p$ (na ní leží rameno $AC$).','Vrchol $C$ je proto průsečík přímky $p$ s osou úsečky $AB$; ten spojíme s body $A$ a $B$ a trojúhelník narýsujeme.'},
  'Konstrukce: vrchol $C$ = průsečík přímky $p$ s osou úsečky $AB$ (rovnoramenný trojúhelník $ABC$ se základnou $AB$).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PBD19C0T02', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
