String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M7D 2023 - uloha 1',
  new List<String>{'Hmotnosti dvou zavazi jsou v pomeru $3:5$ a lisi se o $600$ g.','Vypoctete v gramech hmotnost lehciho zavazi.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Pomer $3:5$, rozdil $5-3=2$ dily odpovidaji $600$ g, tj. jeden dil $=300$ g. Lehci zavazi $=3\\cdot 300=900$ g.'},
  '$900$ g',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\frac{9}{14}\\cdot\\left(2\\cdot\\frac{1}{6}-\\frac{3}{8}\\cdot 4\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\cdot\\frac{1}{6}=\\frac{1}{3}$, $\\frac{3}{8}\\cdot 4=\\frac{3}{2}$; zavorka $=\\frac{1}{3}-\\frac{3}{2}=-\\frac{7}{6}$. Pak $\\frac{9}{14}\\cdot\\left(-\\frac{7}{6}\\right)=-\\frac{63}{84}=-\\frac{3}{4}$.'},
  '$-\\frac{3}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $\\dfrac{\\frac{6}{7}-\\frac{9}{14}}{\\frac{8}{7}+\\frac{6}{7}:\\frac{3}{2}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $\\frac{6}{7}-\\frac{9}{14}=\\frac{12}{14}-\\frac{9}{14}=\\frac{3}{14}$. Jmenovatel: $\\frac{6}{7}:\\frac{3}{2}=\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{4}{7}$, pak $\\frac{8}{7}+\\frac{4}{7}=\\frac{12}{7}$. Celkem $\\frac{3}{14}:\\frac{12}{7}=\\frac{3}{14}\\cdot\\frac{7}{12}=\\frac{1}{8}$.'},
  '$\\frac{1}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2023 - uloha 3',
  new List<String>{'Na ciselne ose je vyznaceno $13$ bodu, ktere oddeluji $12$ stejnych dilku. V jednom z techto bodu je cislo $20$ a body $A$, $B$, $C$ predstavuji tri kladna cisla. Cislo v bode $C$ je souctem cisla v bode $A$ a cisla v bode $B$.','3.1 Vyznacte na ciselne ose bod $P$, v nemz je cislo $0$.','3.2 Urcete cislo v bode $B$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 671 140" font-family="sans-serif"><line x1="35" y1="80" x2="651" y2="80" stroke="#000" stroke-width="1.5"/><polygon points="651,80 641,75 641,85" fill="#000"/><g stroke="#000"><line x1="45" y1="72" x2="45" y2="88"/><line x1="93" y1="72" x2="93" y2="88"/><line x1="141" y1="72" x2="141" y2="88"/><line x1="189" y1="72" x2="189" y2="88"/><line x1="237" y1="72" x2="237" y2="88"/><line x1="285" y1="72" x2="285" y2="88"/><line x1="333" y1="72" x2="333" y2="88"/><line x1="381" y1="72" x2="381" y2="88"/><line x1="429" y1="72" x2="429" y2="88"/><line x1="477" y1="72" x2="477" y2="88"/><line x1="525" y1="72" x2="525" y2="88"/><line x1="573" y1="72" x2="573" y2="88"/><line x1="621" y1="72" x2="621" y2="88"/></g><text x="333" y="64" font-size="15" text-anchor="middle">20</text><g font-size="15" text-anchor="middle" font-style="italic"><text x="285" y="106">A</text><text x="429" y="106">B</text><text x="621" y="106">C</text></g></svg>',
  'ciselna-osa.svg',
  'Ciselna osa se 13 body a 12 stejnymi dilky; vyznaceno cislo 20 a body A, B, C.',
  'Vychozi obrazek k uloze 3',
  new List<String>{'Body oddeluji stejne dilky. Ze vztahu $C=A+B$ a polohy cisla $20$ plyne, ze jeden dilek ma hodnotu $4$ (pak $A=16$, $B=28$, $C=44=16+28$).','3.1 Bod $P$ (cislo $0$) lezi pet dilku vlevo od bodu s cislem $20$.','3.2 Bod $B$ je o dva dilky (o $8$) vpravo od cisla $20$, tedy $B=28$.'},
  '3.1: bod $P$ je pet dilku vlevo od cisla $20$; 3.2: $B=28$',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
