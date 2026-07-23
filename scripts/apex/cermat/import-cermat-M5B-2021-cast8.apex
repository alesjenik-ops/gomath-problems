String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
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
  'CERMAT M5B 2021 – úloha 14',
  new List<String>{'Na kratší liště jsou $4$ žárovky a na delší liště je $6$ žárovek; na počátku žádná žárovka nesvítí. V 1. sekundě se na obou lištách rozsvítí první žárovka zleva, ve 2. sekundě ještě druhá atd. Jakmile jsou na liště rozsvíceny všechny žárovky, od další sekundy postupně zhasínají ve stejném pořadí; jakmile zhasnou všechny, od další sekundy se opět rozsvěcují. Cyklus se u každé lišty stále opakuje (viz obrázek).','Určete:','14.1 v kolikáté sekundě bude poprvé na kratší liště rozsvíceno více žárovek než na delší liště,','14.2 kolik žárovek bude rozsvíceno na delší liště v 57. sekundě,','14.3 kolik žárovek bude dohromady rozsvíceno na obou lištách v 91. sekundě.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 270 120" font-family="sans-serif"><text x="10" y="36" font-size="12">kratší lišta:</text><circle cx="110" cy="32" r="8" fill="#9a9a9a" stroke="#000"/><circle cx="132" cy="32" r="8" fill="#ffffff" stroke="#000"/><circle cx="154" cy="32" r="8" fill="#ffffff" stroke="#000"/><circle cx="176" cy="32" r="8" fill="#ffffff" stroke="#000"/><text x="10" y="86" font-size="12">delší lišta:</text><circle cx="110" cy="82" r="8" fill="#9a9a9a" stroke="#000"/><circle cx="132" cy="82" r="8" fill="#ffffff" stroke="#000"/><circle cx="154" cy="82" r="8" fill="#ffffff" stroke="#000"/><circle cx="176" cy="82" r="8" fill="#ffffff" stroke="#000"/><circle cx="198" cy="82" r="8" fill="#ffffff" stroke="#000"/><circle cx="220" cy="82" r="8" fill="#ffffff" stroke="#000"/></svg>',
  'zarovky.svg',
  'Kratší lišta se čtyřmi a delší lišta se šesti žárovkami; na počátku svítí první žárovka zleva.',
  'Dvě lišty se žárovkami',
  new List<String>{'Kratší lišta má periodu $8$ s s počty žárovek $1,2,3,4,3,2,1,0$; delší lišta periodu $12$ s s počty $1,2,3,4,5,6,5,4,3,2,1,0$.','14.1 Porovnáním počtů je kratší lišta poprvé napřed v 11. sekundě (kratší $3$, delší $1$).','14.2 $57=4\\cdot 12+9$; v 9. kroku periody delší lišty svítí $3$ žárovky.','14.3 $91=11\\cdot 8+3$ → kratší $3$; $91=7\\cdot 12+7$ → delší $5$; dohromady $3+5=8$ žárovek.'},
  '14.1: v 11. sekundě; 14.2: 3 žárovky; 14.3: 8 žárovek',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
