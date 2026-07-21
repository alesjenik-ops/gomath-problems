String SRC   = 'CERMAT – Ilustrační test 2018, matematika 9 (čtyřleté obory)';
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
  'CERMAT 2018 M9I · úloha 16',
  new List<String>{'Obdélník budeme opakovaně zvětšovat tak, že stranu, která je v daném okamžiku kratší, prodloužíme o $3\\ \\mathrm{cm}$ a delší stranu jen o $1\\ \\mathrm{cm}$. Po třetím prodloužení se vytvoří obdélník s rozměry $11\\ \\mathrm{cm}$ a $12\\ \\mathrm{cm}$. Strana, která byla na počátku kratší, zůstane kratší po prvním, druhém i třetím prodloužení.','16.1 Určete rozměry původního obdélníku.','16.2 Určete rozměry obdélníku po pátém prodloužení.','16.3 Určete rozměry obdélníku po sto pátém prodloužení.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Za každé prodloužení roste kratší strana o $3\\ \\mathrm{cm}$ a delší o $1\\ \\mathrm{cm}$. Po $3$ prodlouženích je kratší $s+9$ a delší $l+3$; z rozměrů $11$ a $12$ (kratší zůstala kratší) plyne $s+9=11$ a $l+3=12$, tedy $s=2$, $l=9$.','16.1: rozměry původního obdélníku jsou $2\\ \\mathrm{cm}$ a $9\\ \\mathrm{cm}$.','16.2: postupně $(2;9)\\to(5;10)\\to(8;11)\\to(11;12)\\to(14;13)\\to(16;15)$. Po pátém prodloužení má obdélník rozměry $15\\ \\mathrm{cm}$ a $16\\ \\mathrm{cm}$.','16.3: od třetího prodloužení se rozměry liší o $1\\ \\mathrm{cm}$ a jejich součet roste o $4\\ \\mathrm{cm}$ za krok. Součet po $n$ prodlouženích je $11+4n$; pro $n=105$ je $11+420=431$, strany jsou $\\frac{431-1}{2}=215$ a $\\frac{431+1}{2}=216$. Rozměry jsou $215\\ \\mathrm{cm}$ a $216\\ \\mathrm{cm}$.'},
  '16.1: $2\\ \\mathrm{cm}$, $9\\ \\mathrm{cm}$; 16.2: $15\\ \\mathrm{cm}$, $16\\ \\mathrm{cm}$; 16.3: $215\\ \\mathrm{cm}$, $216\\ \\mathrm{cm}$',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','slovni','uvazovani','vypocet','bez-kalkulacky'},
  'M9PID18C0T01', 2018
);

System.debug('Vytvořeno úloh: '+c.created);
