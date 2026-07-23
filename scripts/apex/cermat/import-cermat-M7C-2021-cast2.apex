String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD21C0T03';
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
  'CERMAT M7C 2021 – úloha 6',
  new List<String>{'Od startu $S$ do cíle $C$ vede jedna snadná cyklistická trasa údolími a druhá náročná přes kopce. Obě trasy se kříží v místě $K$.','Po snadné trase ujedeme v první části od startu $S$ do místa $K$ $45$ km, což je o polovinu více, než ujedeme v druhé části od místa $K$ do cíle $C$.','Náročná trasa je dlouhá $45$ km a její první část od startu $S$ do místa $K$ je o pětinu kratší než její druhá část od místa $K$ do cíle $C$.','Vypočtěte, kolik km měří druhá část (od místa $K$ do cíle $C$)','6.1 snadné trasy,','6.2 náročné trasy.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 240" font-family="sans-serif"> <text x="150" y="40" font-size="14">Snadná trasa</text> <path d="M60 120 C 120 60 220 60 260 120" fill="none" stroke="#000" stroke-width="2"/> <path d="M260 120 C 320 60 420 60 460 120" fill="none" stroke="#000" stroke-width="2"/> <path d="M60 120 C 120 180 220 180 260 120" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="5 5"/> <path d="M260 120 C 320 180 420 180 460 120" fill="none" stroke="#000" stroke-width="2" stroke-dasharray="5 5"/> <text x="150" y="212" font-size="14">Náročná trasa</text> <circle cx="60" cy="120" r="3" fill="#000"/><text x="50" y="140" font-size="15" font-style="italic">S</text> <circle cx="260" cy="120" r="3" fill="#000"/><text x="253" y="140" font-size="15" font-style="italic">K</text> <circle cx="460" cy="120" r="3" fill="#000"/><text x="455" y="140" font-size="15" font-style="italic">C</text> </svg>',
  'trasy-skc.svg',
  'Schéma snadné (plná čára) a náročné (čárkovaná) trasy mezi body S, K a C.',
  'Snadná a náročná trasa se křižují v místě K',
  new List<String>{'6.1 První část snadné trasy ($45$ km) je o polovinu delší než druhá část, tedy je jejím $1{,}5$násobkem: druhá část $=45:1{,}5=30$ km.','6.2 Druhou část náročné trasy označíme $x$; první část je o pětinu kratší, tedy $\\frac{4}{5}x$. Celkem $\\frac{4}{5}x+x=\\frac{9}{5}x=45$, odtud $x=25$ km.'},
  '6.1: $30$ km; 6.2: $25$ km',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
