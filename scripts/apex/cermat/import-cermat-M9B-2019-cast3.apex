String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
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
  'CERMAT M9B 2019 – úloha 8',
  new List<String>{'Čtverec je rozdělen čtyřmi svislými úsečkami a jednou vodorovnou úsečkou na $10$ shodných malých obdélníků. Každý z malých obdélníků má obvod $42$ cm.','8.1 Vyjádřete v základním tvaru poměr délek sousedních stran jednoho malého obdélníku.','8.2 Vypočtěte v cm délku strany čtverce.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 260" font-family="sans-serif"> <rect x="30" y="30" width="200" height="200" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="70" y1="30" x2="70" y2="230" stroke="#000" stroke-width="1.3"/> <line x1="110" y1="30" x2="110" y2="230" stroke="#000" stroke-width="1.3"/> <line x1="150" y1="30" x2="150" y2="230" stroke="#000" stroke-width="1.3"/> <line x1="190" y1="30" x2="190" y2="230" stroke="#000" stroke-width="1.3"/> <line x1="30" y1="130" x2="230" y2="130" stroke="#000" stroke-width="1.3"/> </svg>',
  'ctverec-obdelniky.svg',
  'Čtverec rozdělený čtyřmi svislými a jednou vodorovnou úsečkou na 10 shodných obdélníků (5 sloupců, 2 řady).',
  'Čtverec rozdělený na 10 shodných obdélníků',
  new List<String>{'Čtverec je rozdělen na $5$ sloupců a $2$ řady. Má-li čtverec stranu $a$, malý obdélník má rozměry $\\frac{a}{5}$ a $\\frac{a}{2}$.','8.1 Poměr sousedních stran $\\frac{a}{5}:\\frac{a}{2}=2:5$ (příp. $5:2$).','8.2 Obvod obdélníku $2\\left(\\frac{a}{5}+\\frac{a}{2}\\right)=2\\cdot\\frac{7a}{10}=\\frac{7a}{5}=42$, odtud $a=30$ cm.'},
  '8.1: $2:5$ (příp. $5:2$); 8.2: $30$ cm',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2019 – úloha 9',
  new List<String>{'V rovině leží bod $B$ a přímka $p$, která prochází bodem $A$ (viz obrázek).','Body $A$, $B$ jsou vrcholy rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Rameno $AC$ leží na přímce $p$.','Sestrojte a označte písmenem chybějící vrchol $C$ trojúhelníku $ABC$ a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 400" font-family="sans-serif"> <line x1="280" y1="60" x2="280" y2="370" stroke="#000" stroke-width="2"/> <text x="292" y="366" font-size="18" font-style="italic">p</text> <line x1="270" y1="90" x2="290" y2="90" stroke="#000" stroke-width="2"/> <text x="298" y="96" font-size="18" font-style="italic">A</text> <text x="188" y="252" font-size="20" text-anchor="middle">×</text> <text x="188" y="274" font-size="18" font-style="italic" text-anchor="middle">B</text> </svg>',
  'primka-p-bod-B.svg',
  'Svislá přímka p procházející bodem A poblíž horního okraje a bod B vlevo dole.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Trojúhelník má základnu $AB$, takže ramena jsou shodná: $|CA|=|CB|$. Vrchol $C$ tedy leží na ose úsečky $AB$ a zároveň (podle zadání) na přímce $p$. Sestrojíme osu úsečky $AB$ a její průsečík s přímkou $p$ je hledaný vrchol $C$.'},
  'Vrchol $C$ je průsečík přímky $p$ s osou úsečky $AB$ (bod, pro který $|CA|=|CB|$); trojúhelník $ABC$ je rovnoramenný se základnou $AB$ – viz obrázek v klíči.',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
