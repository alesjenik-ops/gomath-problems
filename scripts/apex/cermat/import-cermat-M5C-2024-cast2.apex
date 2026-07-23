String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD24C0T03';
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
  'CERMAT M5C 2024 – úloha 4.3',
  new List<String>{'Na pastvině je dohromady $195$ zvířat – ovečky, kůzlátka a telátka. Oveček je o polovinu více než kůzlátek a zároveň je jich dvakrát více než telátek.','Kolik je na poli oveček?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet kůzlátek $k$. Oveček je $\\frac{3}{2}k$, telátek je polovina počtu oveček, tj. $\\frac{3}{4}k$. Dohromady $\\frac{3}{2}k+k+\\frac{3}{4}k=\\frac{13}{4}k=195$, odtud $k=60$. Oveček je $\\frac{3}{2}\\cdot 60=90$.'},
  '$90$ oveček',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2024 – úloha 5.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$1$ hodina $-\\;s\\;$ sekund $=30$ minut, kde $s$ je hledaný počet sekund.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ hodina $=3\\,600$ sekund, $30$ minut $=1\\,800$ sekund. Platí $3\\,600-s=1\\,800$, odtud $s=1\\,800$.'},
  '$1\\,800$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 5.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$\\frac{1}{4}$ kilogramu $+\\,1\\,250$ gramů $-\\,100$ gramů $=1$ kilogram $+\\,g\\,$ gramů, kde $g$ je hledaný počet gramů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{4}$ kg $=250$ g. Levá strana: $250+1\\,250-100=1\\,400$ g. Pravá strana: $1$ kg $+g=1\\,000+g$. Z rovnosti $1\\,400=1\\,000+g$ plyne $g=400$.'},
  '$400$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2024 – úloha 6',
  new List<String>{'Na číselné ose je vyznačeno $10$ shodných úseků, čísla $24$ a $64$ a neznámá čísla $A$ a $B$ (viz obrázek).','6.1 Určete neznámá čísla $A$ a $B$.','6.2 Určete součin čísel $A$ a $B$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 110" font-family="sans-serif"><line x1="40" y1="60" x2="440" y2="60" stroke="#000" stroke-width="2"/><line x1="40" y1="50" x2="40" y2="70" stroke="#000"/><line x1="80" y1="50" x2="80" y2="70" stroke="#000"/><line x1="120" y1="50" x2="120" y2="70" stroke="#000"/><line x1="160" y1="50" x2="160" y2="70" stroke="#000"/><line x1="200" y1="50" x2="200" y2="70" stroke="#000"/><line x1="240" y1="50" x2="240" y2="70" stroke="#000"/><line x1="280" y1="50" x2="280" y2="70" stroke="#000"/><line x1="320" y1="50" x2="320" y2="70" stroke="#000"/><line x1="360" y1="50" x2="360" y2="70" stroke="#000"/><line x1="400" y1="50" x2="400" y2="70" stroke="#000"/><line x1="440" y1="50" x2="440" y2="70" stroke="#000"/><text x="120" y="88" font-size="15" text-anchor="middle">24</text><text x="160" y="88" font-size="15" text-anchor="middle" font-style="italic">A</text><text x="240" y="88" font-size="15" text-anchor="middle" font-style="italic">B</text><text x="320" y="88" font-size="15" text-anchor="middle">64</text></svg>',
  'ciselna-osa.svg',
  'Číselná osa s deseti shodnými úseky, vyznačenými čísly 24 a 64 a neznámými čísly A a B mezi nimi.',
  'Číselná osa k úloze 6',
  new List<String>{'Mezi čísly $24$ a $64$ je $5$ shodných úseků, jeden úsek má hodnotu $(64-24):5=8$.','6.1 $A=24+8=32$, $B=24+3\\cdot 8=48$.','6.2 $A\\cdot B=32\\cdot 48=1\\,536$.'},
  '6.1: $A=32$, $B=48$; 6.2: $A\\cdot B=1\\,536$',
  4, 4, '3',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
