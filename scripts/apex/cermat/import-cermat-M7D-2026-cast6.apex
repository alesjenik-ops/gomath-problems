String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M7D 2026 – úloha 12',
  new List<String>{'Pepa na modelářském kroužku pracoval bez odpočinku po celou dobu. První pětinu celkové doby tvořil model letadla a čtvrtinu zbývající doby pomáhal kamarádovi. Pak až do konce kroužku barvil vytvořené modely letadel, což mu zabralo přesně $60$ minut.','Kolik minut pracoval Pepa na modelářském kroužku?'},
  new List<String>{'A) méně než $75$ minut','B) $75$ minut','C) $100$ minut','D) $120$ minut','E) více než $120$ minut'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celková doba $T$. Model letadla $\\frac{1}{5}T$, pomoc kamarádovi $\\frac{1}{4}\\cdot\\frac{4}{5}T=\\frac{1}{5}T$. Barvení $=T-\\frac{1}{5}T-\\frac{1}{5}T=\\frac{3}{5}T=60$ min $\\Rightarrow T=100$ min.'},
  'C) $100$ minut',
  2, 4, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2026 – úloha 13',
  new List<String>{'Květa si koupila čtyřdílný román. První díl románu byl o $30\\,\\%$ levnější než druhý díl a třetí díl byl o $30\\,\\%$ dražší než druhý díl. Čtvrtý díl stojí běžně $680$ korun, ale Květa ho sehnala v akci za $40\\,\\%$ běžné ceny, a tak za něj zaplatila stejně jako za první a třetí díl dohromady.','Kolik korun stál druhý díl románu?'},
  new List<String>{'A) $172$ korun','B) $170$ korun','C) $160$ korun','D) $142$ korun','E) $136$ korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Druhý díl $x$. První $0{,}7x$, třetí $1{,}3x$, dohromady $2x$. Čtvrtý díl v akci $0{,}4\\cdot 680=272$ Kč $=2x\\Rightarrow x=136$ Kč.'},
  'E) $136$ korun',
  2, 4, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7D 2026 – úloha 14',
  new List<String>{'Na obrázku je síť hranolu, který má podstavy tvaru kosočtverce a boční stěny tvaru čtverce. Obsah jedné podstavy je $15$ cm². Součet délek všech hran hranolu je $60$ cm.','Jaký je objem hranolu?'},
  new List<String>{'A) $60$ cm³','B) $75$ cm³','C) $90$ cm³','D) $105$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif"> <rect x="90" y="95" width="240" height="50" fill="none" stroke="#000"/> <line x1="150" y1="95" x2="150" y2="145" stroke="#000" stroke-dasharray="5 4"/> <line x1="210" y1="95" x2="210" y2="145" stroke="#000" stroke-dasharray="5 4"/> <line x1="270" y1="95" x2="270" y2="145" stroke="#000" stroke-dasharray="5 4"/> <polygon points="150,95 210,95 180,45 120,45" fill="none" stroke="#000"/> <polygon points="150,145 210,145 240,195 180,195" fill="none" stroke="#000"/> <polygon points="90,95 90,145 60,120" fill="none" stroke="#000"/> <polygon points="330,95 330,145 360,120" fill="none" stroke="#000"/> </svg>',
  'sit-hranolu.svg',
  'Síť hranolu s podstavami tvaru kosočtverce a bočními stěnami tvaru čtverce (schematicky).',
  'Schematický nákres sítě hranolu',
  new List<String>{'Boční stěny jsou čtverce, proto výška hranolu $=$ hraně podstavy $a$. Hranol má $12$ hran stejné délky $a$: $12a=60\\Rightarrow a=5$ cm. Objem $=$ obsah podstavy $\\times$ výška $=15\\cdot 5=75$ cm³.'},
  'B) $75$ cm³',
  2, 5, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
