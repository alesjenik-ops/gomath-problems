String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD24C0T01';
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
  'CERMAT M9A 2024 – úloha 12',
  new List<String>{'Obrazec je možné rozstříhat na $7$ shodných rovnoramenných trojúhelníků (viz obrázek). Obvod jednoho takového trojúhelníku je $30$ cm.','Jaký je obvod obrazce?'},
  new List<String>{'A) $55$ cm','B) $60$ cm','C) $66$ cm','D) $72$ cm','E) $90$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif"> <polygon points="180,185 35,130 55,80 100,50 150,38 210,38 260,50 305,80 325,130" fill="none" stroke="#000" stroke-width="2"/> <line x1="180" y1="185" x2="55" y2="80" stroke="#777" stroke-dasharray="4 3"/> <line x1="180" y1="185" x2="100" y2="50" stroke="#777" stroke-dasharray="4 3"/> <line x1="180" y1="185" x2="150" y2="38" stroke="#777" stroke-dasharray="4 3"/> <line x1="180" y1="185" x2="210" y2="38" stroke="#777" stroke-dasharray="4 3"/> <line x1="180" y1="185" x2="260" y2="50" stroke="#777" stroke-dasharray="4 3"/> <line x1="180" y1="185" x2="305" y2="80" stroke="#777" stroke-dasharray="4 3"/> </svg>',
  'obrazec-7-troj.svg',
  'Pětiúhelníkový obrazec rozdělený čárkovanými úsečkami z vnitřního bodu na sedm shodných rovnoramenných trojúhelníků.',
  'Schematický nákres obrazce',
  new List<String>{'Rovnoramenný trojúhelník má základnu $z$ a ramena délky $r$, přičemž $2r+z=30$ cm. Obvod obrazce tvoří sedm základen a dvě krajní ramena, tedy $7z+2r$. Podle obrázku jsou ramena dvakrát delší než základna ($r=2z$), z čehož $2\\cdot 2z+z=30$, $5z=30$, $z=6$ cm a $r=12$ cm. Obvod obrazce: $7\\cdot 6+2\\cdot 12=42+24=66$ cm.'},
  'C) $66$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 13',
  new List<String>{'Máme shodné čtverce $A$ a $B$. Čtverec $A$ je rozdělen na dva shodné obdélníky, čtverec $B$ na pět shodných obdélníků (viz obrázek). Obvod jednoho ze dvou obdélníků ve čtverci $A$ je o $6$ cm větší než obvod jednoho z pěti obdélníků ve čtverci $B$.','Jaký je obvod jednoho ze čtverců $A$ nebo $B$?'},
  new List<String>{'A) $40$ cm','B) $72$ cm','C) $80$ cm','D) $96$ cm','E) $128$ cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 200" font-family="sans-serif"> <rect x="40" y="60" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/> <line x1="100" y1="60" x2="100" y2="180" stroke="#000"/> <text x="100" y="46" font-size="14" text-anchor="middle">ctverec A</text> <rect x="260" y="60" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/> <line x1="284" y1="60" x2="284" y2="180" stroke="#000"/> <line x1="308" y1="60" x2="308" y2="180" stroke="#000"/> <line x1="332" y1="60" x2="332" y2="180" stroke="#000"/> <line x1="356" y1="60" x2="356" y2="180" stroke="#000"/> <text x="320" y="46" font-size="14" text-anchor="middle">ctverec B</text> </svg>',
  'ctverce-AB.svg',
  'Dva shodné čtverce: čtverec A rozdělený svislou čarou na dva obdélníky, čtverec B rozdělený na pět svislých obdélníků.',
  'Čtverec A a čtverec B',
  new List<String>{'Označme stranu čtverce $s$. Obdélník ve čtverci $A$ má rozměry $s\\times\\frac{s}{2}$, obvod $2\\left(s+\\frac{s}{2}\\right)=3s$. Obdélník ve čtverci $B$ má rozměry $s\\times\\frac{s}{5}$, obvod $2\\left(s+\\frac{s}{5}\\right)=\\frac{12s}{5}$. Rozdíl: $3s-\\frac{12s}{5}=\\frac{3s}{5}=6$, odtud $s=10$ cm. Obvod čtverce je $4s=40$ cm.'},
  'A) $40$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2024 – úloha 14',
  new List<String>{'Vynásobíme-li neznámé číslo dvěma a odečteme-li od výsledku $135$, získáme polovinu hodnoty neznámého čísla.','Jaká je hodnota neznámého čísla?'},
  new List<String>{'A) $270$','B) $170$','C) $135$','D) $90$','E) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme neznámé číslo $x$. Rovnice: $2x-135=\\frac{x}{2}$, tj. $2x-\\frac{x}{2}=135$, $\\frac{3x}{2}=135$, $x=90$.'},
  'D) $90$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
