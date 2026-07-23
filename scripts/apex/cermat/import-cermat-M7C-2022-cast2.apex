String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
Integer YEAR = 2022;

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
  'CERMAT M7C 2022 – úloha 6',
  new List<String>{'Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme. Bílý trojúhelník má obsah $50$ cm², je pravoúhlý a rovnoramenný. Rameno trojúhelníku má stejnou délku jako kratší strana obdélníku. Delší strana tmavého obdélníku měří $36$ cm.','6.1 Vypočtěte v cm obvod obdélníku.','6.2 Vypočtěte v cm² obsah obdélníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 220" font-family="sans-serif"> <polygon points="60,70 400,70 360,110 100,110" fill="#9a9a9a" stroke="#000" stroke-width="1.5"/> <polygon points="100,110 130,110 108,175" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="360,110 388,110 366,175" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <line x1="60" y1="52" x2="400" y2="52" stroke="#444"/> <polygon points="60,52 68,48 68,56" fill="#444"/><polygon points="400,52 392,48 392,56" fill="#444"/> <text x="230" y="44" font-size="15" text-anchor="middle">36 cm</text> <text x="230" y="205" font-size="12" text-anchor="middle" fill="#555">tmavý obdélník na dvou bílých pravoúhlých rovnoramenných trojúhelnících</text> </svg>',
  'policka.svg',
  'Tmavá obdélníková deska poličky podepřená dvěma bílými pravoúhlými rovnoramennými trojúhelníky; delší strana desky měří 36 cm.',
  'Schematický nákres poličky',
  new List<String>{'Pravoúhlý rovnoramenný trojúhelník s rameny (odvěsnami) délky $r$ má obsah $\\frac{1}{2}r^2=50$, tedy $r^2=100$ a $r=10$ cm. Kratší strana obdélníku je $10$ cm.','6.1 Obvod $=2\\cdot(36+10)=92$ cm.','6.2 Obsah $=36\\cdot 10=360$ cm².'},
  '6.1: $92$ cm; 6.2: $360$ cm²',
  3, 5, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 7',
  new List<String>{'Kvádr o rozměrech $6$ cm, $4$ cm a $5$ cm jsme dvěma svislými řezy rozdělili na tři kolmé trojboké hranoly (viz obrázek).','7.1 Vypočtěte v cm² povrch kvádru.','7.2 Ze tří trojbokých hranolů vybereme ten, který má největší objem. Vypočtěte v cm³ objem vybraného trojbokého hranolu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif"> <polygon points="70,90 250,90 300,55 120,55" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/> <polygon points="70,90 250,90 250,210 70,210" fill="#dcdcdc" stroke="#000" stroke-width="1.5"/> <polygon points="250,90 300,55 300,175 250,210" fill="#cfcfcf" stroke="#000" stroke-width="1.5"/> <line x1="130" y1="90" x2="170" y2="55" stroke="#000" stroke-dasharray="4 3"/> <line x1="190" y1="90" x2="240" y2="55" stroke="#000" stroke-dasharray="4 3"/> <line x1="130" y1="90" x2="130" y2="210" stroke="#000"/> <line x1="190" y1="90" x2="190" y2="210" stroke="#000"/> <text x="52" y="155" font-size="14" text-anchor="end">5 cm</text> <text x="160" y="230" font-size="14" text-anchor="middle">6 cm</text> <text x="315" y="140" font-size="14">4 cm</text> <text x="240" y="248" font-size="12" text-anchor="middle" fill="#555">dva svislé řezy dělí kvádr na tři trojboké hranoly</text> </svg>',
  'kvadr-hranoly.svg',
  'Kvádr o rozměrech 6 cm, 4 cm a 5 cm rozdělený dvěma svislými řezy na tři trojboké hranoly.',
  'Kvádr rozdělený na tři trojboké hranoly',
  new List<String>{'7.1 Povrch kvádru $=2\\cdot(6\\cdot 4+6\\cdot 5+4\\cdot 5)=2\\cdot(24+30+20)=148$ cm².','7.2 Řezy jsou svislé, výška všech hranolů je $5$ cm. Podstavy vzniknou rozdělením obdélníku $6\\times 4$ (obsah $24$ cm²); největší podstava má obsah $12$ cm². Objem $=12\\cdot 5=60$ cm³.'},
  '7.1: $148$ cm²; 7.2: $60$ cm³',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
