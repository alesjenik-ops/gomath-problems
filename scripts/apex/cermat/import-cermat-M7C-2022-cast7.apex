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
  'CERMAT M7C 2022 – úloha 13',
  new List<String>{'Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů.','Obvod druhého sestrojeného obdélníku je $120$ cm. Kolik mřížových bodů celkem obsahuje tento obdélník (včetně mřížových bodů po jeho obvodu)?'},
  new List<String>{'A) $500$','B) $510$','C) $520$','D) $530$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 210" font-family="sans-serif"><line x1="250" y1="40" x2="250" y2="184" stroke="#ddd"/><line x1="266" y1="40" x2="266" y2="184" stroke="#ddd"/><line x1="282" y1="40" x2="282" y2="184" stroke="#ddd"/><line x1="298" y1="40" x2="298" y2="184" stroke="#ddd"/><line x1="314" y1="40" x2="314" y2="184" stroke="#ddd"/><line x1="330" y1="40" x2="330" y2="184" stroke="#ddd"/><line x1="346" y1="40" x2="346" y2="184" stroke="#ddd"/><line x1="362" y1="40" x2="362" y2="184" stroke="#ddd"/><line x1="378" y1="40" x2="378" y2="184" stroke="#ddd"/><line x1="394" y1="40" x2="394" y2="184" stroke="#ddd"/><line x1="410" y1="40" x2="410" y2="184" stroke="#ddd"/><line x1="426" y1="40" x2="426" y2="184" stroke="#ddd"/><line x1="442" y1="40" x2="442" y2="184" stroke="#ddd"/><line x1="250" y1="40" x2="442" y2="40" stroke="#ddd"/><line x1="250" y1="56" x2="442" y2="56" stroke="#ddd"/><line x1="250" y1="72" x2="442" y2="72" stroke="#ddd"/><line x1="250" y1="88" x2="442" y2="88" stroke="#ddd"/><line x1="250" y1="104" x2="442" y2="104" stroke="#ddd"/><line x1="250" y1="120" x2="442" y2="120" stroke="#ddd"/><line x1="250" y1="136" x2="442" y2="136" stroke="#ddd"/><line x1="250" y1="152" x2="442" y2="152" stroke="#ddd"/><line x1="250" y1="168" x2="442" y2="168" stroke="#ddd"/><line x1="250" y1="184" x2="442" y2="184" stroke="#ddd"/><rect x="250" y="40" width="176" height="144" fill="none" stroke="#000" stroke-width="2"/><circle cx="250" cy="40" r="2.2" fill="#000"/><circle cx="250" cy="56" r="2.2" fill="#000"/><circle cx="250" cy="72" r="2.2" fill="#000"/><circle cx="250" cy="88" r="2.2" fill="#000"/><circle cx="250" cy="104" r="2.2" fill="#000"/><circle cx="250" cy="120" r="2.2" fill="#000"/><circle cx="250" cy="136" r="2.2" fill="#000"/><circle cx="250" cy="152" r="2.2" fill="#000"/><circle cx="250" cy="168" r="2.2" fill="#000"/><circle cx="250" cy="184" r="2.2" fill="#000"/><line x1="232" y1="40" x2="232" y2="184" stroke="#444"/><polygon points="232,40 228,48 236,48" fill="#444"/><polygon points="232,184 228,176 236,176" fill="#444"/><text x="224" y="116" font-size="13" text-anchor="end">9 cm</text><text x="240" y="200" font-size="11" text-anchor="middle" fill="#555">schéma: kratší strana 9 cm obsahuje 10 mřížových bodů</text></svg>',
  'ctvercova-sit-obdelniky.svg',
  'Čtvercová síť se dvěma obdélníky; kratší strana měří 9 cm a obsahuje 10 mřížových bodů.',
  'Schematický nákres k úlohám 12 a 13',
  new List<String>{'Rozteč sítě je $1$ cm (kratší strana $9$ cm má $10$ bodů). Obvod $=2\\cdot(9+b)=120$, tedy $9+b=60$ a $b=51$ cm. Delší strana má $52$ mřížových bodů, kratší $10$. Celkem $10\\cdot 52=520$ mřížových bodů.'},
  'C) $520$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2022 – úloha 14',
  new List<String>{'Hruškový král rozdělil podle zásluh všechny zlaté hrušky mezi tři rytíře. Jednu sedminu všech hrušek získal první rytíř, druhý získal o $42$ hrušek více než první a třetí získal třikrát více hrušek než první.','Kolik zlatých hrušek dohromady získali první a druhý rytíř?'},
  new List<String>{'A) $54$','B) $56$','C) $70$','D) $84$','E) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet hrušek prvního rytíře $x$; celkem je pak $7x$. Druhý má $x+42$, třetí $3x$. Ze součtu $x+(x+42)+3x=7x$ plyne $5x+42=7x$, tedy $2x=42$ a $x=21$. První a druhý mají dohromady $x+(x+42)=21+63=84$ hrušek.'},
  'D) $84$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
