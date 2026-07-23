String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD25C0T02';
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
  'CERMAT M5B 2025 - uloha 8',
  new List<String>{'Vera, Pavel a Tomas setrili po dobu ctyr mesicu pouze padesatikorunove mince a vsechny nasetrene mince vkladali do kasicky. Graf udava pocet minci, ktere deti vlozily do kasicky v jednotlivych mesicich.','Rozhodnete o kazdem z nasledujicich tvrzeni 8.1-8.3, zda je pravdive (A), ci nikoli (N).','8.1 Vera vlozila do kasicky v lednu tolik korun, kolik nasetrila behem zbyvajicich tri mesicu dohromady.','8.2 V unoru vlozili do kasicky Pavel s Verou dohromady trikrat vice korun nez Tomas.','8.3 Tomas vlozil v dubnu do kasicky vice nez jednu devitinu vsech penez, ktere nasetrily za uvedene ctyri mesice vsechny tri deti dohromady.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 350" font-family="sans-serif"><text x="260" y="24" font-size="14" text-anchor="middle" font-weight="bold">Nove vlozene mince</text><line x1="70" y1="40" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="460" y2="300" stroke="#000"/><line x1="66" y1="300" x2="70" y2="300" stroke="#000"/><text x="62" y="304" font-size="11" text-anchor="end">0</text><line x1="66" y1="264" x2="70" y2="264" stroke="#000"/><text x="62" y="268" font-size="11" text-anchor="end">2</text><line x1="66" y1="228" x2="70" y2="228" stroke="#000"/><text x="62" y="232" font-size="11" text-anchor="end">4</text><line x1="66" y1="192" x2="70" y2="192" stroke="#000"/><text x="62" y="196" font-size="11" text-anchor="end">6</text><line x1="66" y1="156" x2="70" y2="156" stroke="#000"/><text x="62" y="160" font-size="11" text-anchor="end">8</text><line x1="66" y1="120" x2="70" y2="120" stroke="#000"/><text x="62" y="124" font-size="11" text-anchor="end">10</text><line x1="66" y1="84" x2="70" y2="84" stroke="#000"/><text x="62" y="88" font-size="11" text-anchor="end">12</text><line x1="66" y1="48" x2="70" y2="48" stroke="#000"/><text x="62" y="52" font-size="11" text-anchor="end">14</text><text x="24" y="170" font-size="12" text-anchor="middle" transform="rotate(-90 24 170)">Pocet padesatikorun</text><rect x="100" y="228" width="52" height="72" fill="#7f7f7f" stroke="#000"/><rect x="100" y="192" width="52" height="36" fill="#ffffff" stroke="#000"/><rect x="100" y="66" width="52" height="126" fill="#cccccc" stroke="#000"/><text x="126.0" y="316" font-size="11" text-anchor="middle">Leden</text><rect x="182" y="246" width="52" height="54" fill="#7f7f7f" stroke="#000"/><rect x="182" y="156" width="52" height="90" fill="#ffffff" stroke="#000"/><rect x="182" y="102" width="52" height="54" fill="#cccccc" stroke="#000"/><text x="208.0" y="316" font-size="11" text-anchor="middle">Unor</text><rect x="264" y="246" width="52" height="54" fill="#7f7f7f" stroke="#000"/><rect x="264" y="120" width="52" height="126" fill="#ffffff" stroke="#000"/><rect x="264" y="84" width="52" height="36" fill="#cccccc" stroke="#000"/><text x="290.0" y="316" font-size="11" text-anchor="middle">Brezen</text><rect x="346" y="210" width="52" height="90" fill="#7f7f7f" stroke="#000"/><rect x="346" y="174" width="52" height="36" fill="#ffffff" stroke="#000"/><rect x="346" y="120" width="52" height="54" fill="#cccccc" stroke="#000"/><text x="372.0" y="316" font-size="11" text-anchor="middle">Duben</text><rect x="475" y="70" width="12" height="12" fill="#cccccc" stroke="#000"/><text x="492" y="80" font-size="11">Vera</text><rect x="475" y="90" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="492" y="100" font-size="11">Pavel</text><rect x="475" y="110" width="12" height="12" fill="#7f7f7f" stroke="#000"/><text x="492" y="120" font-size="11">Tomas</text></svg>',
  'graf-mince.svg',
  'Skladany sloupcovy graf poctu padesatikorun vlozenych Verou, Pavlem a Tomasem v lednu az dubnu.',
  'Nove vlozene mince (pocet padesatikorun)',
  new List<String>{'Z grafu (pocty minci, leden az duben): Tomas $4, 3, 3, 5$; Pavel $2, 5, 7, 2$; Vera $7, 3, 2, 3$.','8.1 Vera v lednu $7$ minci, ve zbyvajicich mesicich $3+2+3=8$ minci; $7\\neq 8$, tvrzeni je nepravdive (N).','8.2 V unoru Pavel a Vera dohromady $5+3=8$ minci, Tomas $3$ mince; $3\\cdot 3=9\\neq 8$, tvrzeni je nepravdive (N).','8.3 Celkem vsech minci $13+11+12+10=46$; devitina je $\\frac{46}{9}\\approx 5{,}1$. Tomas v dubnu $5$ minci, coz neni vice nez $\\frac{46}{9}$, tvrzeni je nepravdive (N).'},
  '8.1: N; 8.2: N; 8.3: N',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
