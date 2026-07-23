String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 1',
  new List<String>{'Hmotnosti dvou závaží jsou v poměru $3:5$ a liší se o $600$ g.','Vypočtěte v gramech hmotnost lehčího závaží.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl hmotností odpovídá $5-3=2$ dílům, jeden díl je tedy $600:2=300$ g. Lehčí závaží má $3$ díly, tj. $3\\cdot 300=900$ g.'},
  '$900$ g',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 2',
  new List<String>{'Na číselné ose je vyznačeno 13 bodů, které oddělují 12 stejných dílků. V jednom z těchto bodů je číslo 20 a body $A$, $B$, $C$ představují tři kladná čísla. Číslo v bodě $C$ je součtem čísla v bodě $A$ a čísla v bodě $B$ (viz obrázek).','2.1 Určete číslo v bodě $C$.','2.2 Určete číslo v bodě $B$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 604 120" font-family="sans-serif"><line x1="36" y1="68" x2="588" y2="68" stroke="#000" stroke-width="1.5"/><polygon points="588,68 576,63 576,73" fill="#000"/><g stroke="#000"><line x1="50" y1="61" x2="50" y2="75"/><line x1="92" y1="61" x2="92" y2="75"/><line x1="134" y1="61" x2="134" y2="75"/><line x1="176" y1="61" x2="176" y2="75"/><line x1="218" y1="61" x2="218" y2="75"/><line x1="260" y1="61" x2="260" y2="75"/><line x1="302" y1="61" x2="302" y2="75"/><line x1="344" y1="61" x2="344" y2="75"/><line x1="386" y1="61" x2="386" y2="75"/><line x1="428" y1="61" x2="428" y2="75"/><line x1="470" y1="61" x2="470" y2="75"/><line x1="512" y1="61" x2="512" y2="75"/><line x1="554" y1="61" x2="554" y2="75"/></g><text x="260" y="54" font-size="16" text-anchor="middle">20</text><g font-size="16" text-anchor="middle" font-style="italic"><text x="176" y="96">A</text><text x="344" y="96">B</text><text x="470" y="96">C</text></g></svg>',
  'ciselna-osa.svg',
  'Číselná osa se 13 body a 12 stejnými dílky; nad jedním bodem je číslo 20, pod třemi body jsou písmena A, B, C.',
  'Číselná osa k úloze 2',
  new List<String>{'Označíme velikost jednoho dílku $d$. Podle obrázku je v bodě $A$ číslo $20-2d$, v bodě $B$ číslo $20+2d$ a v bodě $C$ číslo $20+5d$. Z podmínky $C=A+B$ dostaneme $20+5d=(20-2d)+(20+2d)=40$, tedy $d=4$.','Proto je v bodě $A$ číslo $12$, v bodě $B$ číslo $28$ a v bodě $C$ číslo $40$.'},
  '2.1: $C=40$; 2.2: $B=28$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{2}{3}-1}{\\frac{8}{9}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{\\frac{2}{3}-1}{\\frac{8}{9}}=\\dfrac{-\\frac{1}{3}}{\\frac{8}{9}}=-\\frac{1}{3}\\cdot\\frac{9}{8}=-\\frac{9}{24}=-\\frac{3}{8}$.'},
  '$-\\frac{3}{8}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $2\\cdot\\frac{1}{6}-\\frac{3}{8}\\cdot 4=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\cdot\\frac{1}{6}-\\frac{3}{8}\\cdot 4=\\frac{1}{3}-\\frac{3}{2}=\\frac{2}{6}-\\frac{9}{6}=-\\frac{7}{6}$.'},
  '$-\\frac{7}{6}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 3.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{6}{7}-\\frac{9}{14}}{\\frac{8}{7}+\\frac{6}{7}:\\frac{3}{2}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{6}{7}-\\frac{9}{14}=\\frac{12}{14}-\\frac{9}{14}=\\frac{3}{14}$. Jmenovatel: $\\frac{8}{7}+\\frac{6}{7}:\\frac{3}{2}=\\frac{8}{7}+\\frac{6}{7}\\cdot\\frac{2}{3}=\\frac{8}{7}+\\frac{4}{7}=\\frac{12}{7}$.','Podíl: $\\frac{3}{14}:\\frac{12}{7}=\\frac{3}{14}\\cdot\\frac{7}{12}=\\frac{21}{168}=\\frac{1}{8}$.'},
  '$\\frac{1}{8}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 4.1',
  new List<String>{'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(0{,}3x+0{,}5)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(0{,}3x+0{,}5)^2=(0{,}3x)^2+2\\cdot 0{,}3x\\cdot 0{,}5+0{,}5^2=0{,}09x^2+0{,}3x+0{,}25$.'},
  '$0{,}09x^2+0{,}3x+0{,}25$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
