String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2023 M9D · úloha 6',
  new List<String>{'V pátek, v sobotu a v neděli se na mýtině vysazovaly stromy. V sobotu bylo vysázeno o třetinu více stromů než v pátek. V neděli bylo vysázeno dokonce o $60\\ \\%$ více stromů než v pátek. Počet stromů vysázených v pátek označíme $p$.','6.1 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v sobotu.','6.2 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v neděli.','6.3 V pátek bylo vysázeno o $290$ stromů méně než v obou zbývajících dnech dohromady. Vypočtěte, kolik stromů bylo vysázeno v pátek.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: sobota $=p+\\frac{1}{3}p=\\frac{4}{3}p$.','6.2: neděle $=p+0{,}6p=1{,}6p=\\frac{8}{5}p$.','6.3: $\\left(\\frac{4}{3}p+\\frac{8}{5}p\\right)-p=290\\Rightarrow p\\left(\\frac{20}{15}+\\frac{24}{15}-\\frac{15}{15}\\right)=290\\Rightarrow\\frac{29}{15}p=290\\Rightarrow p=150$.'},
  '6.1: $\\frac{4}{3}p$; 6.2: $\\frac{8}{5}p$; 6.3: $150$ stromů',
  3, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','procenta','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD23C0T04', 2023
);
c.add(
  'CERMAT 2023 M9D · úloha 7',
  new List<String>{'Na parkovišti je přesně $105$ parkovacích míst pro osobní auta. Zaparkuje-li na parkovišti autobus, obsadí vždy $4$ parkovací místa pro osobní auta. (Parkoviště tedy zcela zaplní např. $101$ osobních aut a jeden autobus.)','7.1 Na zcela zaplněném parkovišti je počet osobních aut stejný jako počet autobusů. Vypočtěte, kolik je na parkovišti osobních aut.','7.2 Na zcela zaplněném parkovišti je osobních aut o čtvrtinu více než autobusů. Vypočtěte, kolik je na parkovišti autobusů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: nechť aut $=$ autobusů $=n$; auta zaberou $n$ míst, autobusy $4n$ míst: $n+4n=105\\Rightarrow5n=105\\Rightarrow n=21$ osobních aut.','7.2: nechť autobusů $=b$, aut $=\\frac{5}{4}b$; $\\frac{5}{4}b+4b=105\\Rightarrow\\frac{21}{4}b=105\\Rightarrow b=20$ autobusů (a $25$ aut).'},
  '7.1: $21$ osobních aut; 7.2: $20$ autobusů',
  3, 5, '4',
  new List<String>{'zs2','r9','rovnice','aritmetika','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
