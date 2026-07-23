String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
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
  'CERMAT M9B 2021 – úloha 16',
  new List<String>{'První čtverec má obvod $60$ cm. Každý další čtverec je sestaven z několika shodných obdélníků, z nichž každý má obvod $60$ cm. Druhý čtverec je sestaven ze dvou shodných obdélníků, třetí ze tří shodných (užších) obdélníků, čtvrtý ze čtyř atd. (viz obrázek).','16.1 Vypočtěte v cm délku strany třetího čtverce.','16.2 Vypočtěte v cm obvod devátého čtverce.','16.3 Určete, kolikátý čtverec má stranu délky $28$ cm.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif"> <text x="105" y="30" font-size="13" text-anchor="middle">1. čtverec</text> <text x="255" y="30" font-size="13" text-anchor="middle">2. čtverec</text> <text x="410" y="30" font-size="13" text-anchor="middle">3. čtverec</text> <rect x="60" y="45" width="90" height="90" fill="none" stroke="#000" stroke-width="2"/> <rect x="210" y="45" width="90" height="90" fill="none" stroke="#000" stroke-width="2"/> <line x1="255" y1="45" x2="255" y2="135" stroke="#000" stroke-width="1.5"/> <rect x="365" y="45" width="90" height="90" fill="none" stroke="#000" stroke-width="2"/> <line x1="395" y1="45" x2="395" y2="135" stroke="#000" stroke-width="1.5"/> <line x1="425" y1="45" x2="425" y2="135" stroke="#000" stroke-width="1.5"/> <text x="490" y="98" font-size="22">…</text> <line x1="210" y1="150" x2="300" y2="150" stroke="#000" stroke-width="1"/> <line x1="210" y1="146" x2="210" y2="154" stroke="#000" stroke-width="1"/> <line x1="300" y1="146" x2="300" y2="154" stroke="#000" stroke-width="1"/> <text x="255" y="170" font-size="13" text-anchor="middle">20 cm</text> </svg>',
  'ctverce-obdelniky.svg',
  'První, druhý a třetí čtverec; druhý rozdělený na dva svislé obdélníky, třetí na tři, dále tři tečky.',
  '1., 2. a 3. čtverec',
  new List<String>{'$n$-tý čtverec je složen z $n$ svislých obdélníků o výšce rovné straně $s_n$ a šířce $\\frac{s_n}{n}$. Obvod obdélníku $2\\left(s_n+\\frac{s_n}{n}\\right)=60$, odtud $s_n=\\frac{30n}{n+1}$. (Pro $n=1$ vyjde $s_1=15$ cm, obvod $60$ cm.)','16.1 $s_3=\\frac{30\\cdot 3}{4}=22{,}5$ cm.','16.2 $s_9=\\frac{30\\cdot 9}{10}=27$ cm, obvod $4\\cdot 27=108$ cm.','16.3 $\\frac{30n}{n+1}=28\\Rightarrow 30n=28n+28\\Rightarrow n=14$; stranu $28$ cm má 14. čtverec.'},
  '16.1: $22{,}5$ cm; 16.2: $108$ cm; 16.3: 14. čtverec',
  4, 6, '4',
  new List<String>{'zs2','r9','posloupnosti','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
