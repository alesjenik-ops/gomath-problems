String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 1. řádný termín (M9A)';
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
  'CERMAT 2022 M9A · úloha 16',
  new List<String>{'Tři děti v jednotlivých kolech hry přidávaly mince do klobouku, který byl na počátku prázdný. Julie přidávala v každém kole $1$ minci. Čeněk přidával mince pouze v každém $4$. kole, a to vždy $4$ najednou. Pavla přidávala mince pouze v každém $5$. kole, a to vždy $5$ najednou. Např. po prvních $9$ kolech bylo v klobouku celkem $22$ mincí ($9$ od Julie, $8$ od Čeňka a $5$ od Pavly).','16.1 \\quad Určete celkový počet mincí v klobouku po prvních $35$ kolech.','16.2 \\quad Čeněk přidal své $4$ mince do klobouku zatím $14$krát. Určete, kolikrát již přidala do klobouku svou pětici mincí Pavla.','16.3 \\quad Určete, po kolika kolech od počátku bylo v klobouku přesně $183$ mincí.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Po $n$ kolech je v klobouku $n+4\\cdot\\left\\lfloor\\frac{n}{4}\\right\\rfloor+5\\cdot\\left\\lfloor\\frac{n}{5}\\right\\rfloor$ mincí.','16.1: $35+4\\cdot\\lfloor35/4\\rfloor+5\\cdot\\lfloor35/5\\rfloor=35+4\\cdot8+5\\cdot7=35+32+35=102$ mincí.','16.2: Čeněk přidával $14$krát znamená $56\\le n\\le59$; v tomto rozsahu Pavla přidávala $\\lfloor n/5\\rfloor=11$krát (v kolech $5,10,\\dots,55$).','16.3: pro $n=60$ je součet $60+60+60=180$; $n=61\\to181$, $n=62\\to182$, $n=63\\to63+4\\cdot15+5\\cdot12=63+60+60=183$. Bylo to po $63$ kolech.'},
  '16.1: $102$ mincí; 16.2: $11$krát; 16.3: po $63$ kolech',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','aritmetika','uvazovani','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD22C0T01', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
