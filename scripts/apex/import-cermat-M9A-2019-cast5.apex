String SRC   = 'CERMAT – Jednotná přijímací zkouška 2019, 1. řádný termín (M9A)';
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
  'CERMAT 2019 M9A · úloha 16',
  new List<String>{'Na čtvercovou desku s lichým počtem políček rozmísťujeme žetony takto: v prvním kroku položíme na každé políčko po obvodu desky $1$ žeton; v každém dalším kroku vybereme všechna dosud prázdná políčka, která bezprostředně sousedí s obsazenými, a na každé z nich položíme o $1$ žeton více než v předchozím kroku. Největší počet žetonů tak bude na prostředním políčku desky. Počty žetonů tvoří soustředné čtvercové rámečky: na vnějším rámečku je $1$ žeton, na dalším $2$, atd. až po střed.','Pro desku $3\\times3$ jsou počty žetonů po řádcích $1,1,1\\,/\\,1,2,1\\,/\\,1,1,1$; pro desku $5\\times5$ jsou $1,1,1,1,1\\,/\\,1,2,2,2,1\\,/\\,1,2,3,2,1\\,/\\,1,2,2,2,1\\,/\\,1,1,1,1,1$.','16.1 Čtvercová deska má na prostředním políčku $9$ žetonů. Určete, kolik políček je v každé řadě této čtvercové desky.','16.2 Žetony rozmístíme na čtvercovou desku, která má $9\\times9$ políček. Určete počet všech políček, na nichž leží právě $2$ žetony.','16.3 Žetony rozmístíme na dvě čtvercové desky, z nichž jedna má $9\\times9$ políček, druhá $11\\times11$ políček. Určete, o kolik více žetonů je na větší desce než na menší desce.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: prostřední políčko má tolik žetonů, kolik je soustředných rámečků; při $9$ žetonech je rámečků $9$, deska má $2\\cdot9-1=17$ políček v každé řadě.','16.2: na desce $9\\times9$ leží právě $2$ žetony na políčkách druhého rámečku od kraje — to je obvod čtverce $7\\times7$: $4\\cdot7-4=24$ políček.','16.3: součet žetonů na desce $9\\times9$ je $32\\cdot1+24\\cdot2+16\\cdot3+8\\cdot4+1\\cdot5=165$; na desce $11\\times11$ je $40\\cdot1+32\\cdot2+24\\cdot3+16\\cdot4+8\\cdot5+1\\cdot6=286$; rozdíl je $286-165=121$ žetonů.'},
  '16.1: $17$ políček; 16.2: $24$ políček; 16.3: o $121$ žetonů',
  4, 8, '5',
  new List<String>{'zs2','r9','posloupnosti','algebra','uvazovani','vypocet','slovni','bez-kalkulacky'},
  'M9PAD19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
