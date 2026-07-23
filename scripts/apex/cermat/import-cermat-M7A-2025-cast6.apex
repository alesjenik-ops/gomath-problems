String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M7A 2025 - uloha 16',
  new List<String>{'Obrazec se postupne vytvari pridavanim dalsich rad podle pravidel: liche rady obsahuji pouze ctverce o strane 1 cm; sude rady obsahuji pouze obdelniky s rozmery 1 cm a 2 cm; prvni rada obsahuje jeden ctverec a kazda dalsi rada je vzdy o 1 cm delsi nez predchozi; ve treti a kazde dalsi rade ma kazdy druhy ctyruhelnik sedou barvu, ostatni jsou bile.','16.1 Urcete nejvyssi poradove cislo rady, ktera obsahuje prave 9 sedych obdelniku.','16.2 Urcete celkovy pocet bilych ctyruhelniku v casti obrazce obsahujici pouze 29. a 30. radu.','16.3 Vypoctete pomer obsahu bile plochy ku obsahu sede plochy v casti obrazce obsahujici pouze 50. a 51. radu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 150" font-family="sans-serif"> <text x="8" y="29" font-size="11">1. rada</text> <text x="8" y="47" font-size="11">2. rada</text> <text x="8" y="65" font-size="11">3. rada</text> <text x="8" y="83" font-size="11">4. rada</text> <text x="8" y="101" font-size="11">5. rada</text> <text x="8" y="119" font-size="11">6. rada</text> <rect x="80" y="16" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="80" y="34" width="36" height="18" fill="#fff" stroke="#000"/> <rect x="80" y="52" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="98" y="52" width="18" height="18" fill="#bdbdbd" stroke="#000"/> <rect x="116" y="52" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="80" y="70" width="36" height="18" fill="#fff" stroke="#000"/> <rect x="116" y="70" width="36" height="18" fill="#bdbdbd" stroke="#000"/> <rect x="80" y="88" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="98" y="88" width="18" height="18" fill="#bdbdbd" stroke="#000"/> <rect x="116" y="88" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="134" y="88" width="18" height="18" fill="#bdbdbd" stroke="#000"/> <rect x="152" y="88" width="18" height="18" fill="#fff" stroke="#000"/> <rect x="80" y="106" width="36" height="18" fill="#fff" stroke="#000"/> <rect x="116" y="106" width="36" height="18" fill="#bdbdbd" stroke="#000"/> <rect x="152" y="106" width="36" height="18" fill="#fff" stroke="#000"/> <text x="95" y="140" font-size="16" text-anchor="middle">&#8942;</text> </svg>',
  'obrazec-rady.svg',
  'Obrazec z rad: liche rady ctverce, sude rady obdelniky; od 3. rady je kazdy druhy ctyruhelnik sedy.',
  'Prvnich sest rad obrazce (schematicky)',
  new List<String>{'Rada s poradovym cislem $n$ je $n$ cm dlouha. Licha rada $n$ obsahuje $n$ ctvercu, suda rada $n$ obsahuje $\\frac{n}{2}$ obdelniku. Sedy je kazdy druhy ctyruhelnik, tj. jejich pocet je cela cast poloviny poctu ctyruhelniku v rade.','16.1 Suda rada $n$ ma $\\frac{n}{2}$ obdelniku, z nich sedych je cela cast z $\\frac{n}{4}$. Prave 9 sedych obdelniku ma rada 36 i rada 38 (rada 40 jich ma 10). Nejvyssi poradove cislo je 38.','16.2 Rada 29 (licha): 29 ctvercu, sedych 14, bilych 15. Rada 30 (suda): 15 obdelniku, sedych 7, bilych 8. Celkem bilych $15+8=23$.','16.3 Rada 50 (suda): 25 obdelniku po 2 cm2, bilych 13 (26 cm2), sedych 12 (24 cm2). Rada 51 (licha): 51 ctvercu po 1 cm2, bilych 26 (26 cm2), sedych 25 (25 cm2). Pomer bila : seda $=(26+26):(24+25)=52:49$.'},
  '16.1: 38. rada; 16.2: 23 bilych ctyruhelniku; 16.3: 52 : 49',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
