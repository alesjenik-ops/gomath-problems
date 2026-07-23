String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD21C0T02';
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
  'CERMAT M7B 2021 – úloha 16',
  new List<String>{'Ve výloze obchodu jsou dvě reklamní lišty se žárovkami. Na kratší liště jsou $4$ žárovky a na delší liště je $6$ žárovek. Na počátku žádná žárovka nesvítí. Na kratší i delší liště se v 1. sekundě rozsvítí první žárovka zleva, ve 2. sekundě ještě druhá žárovka, ve 3. sekundě ještě třetí žárovka atd. Jakmile jsou na některé liště rozsvíceny všechny žárovky, od další sekundy začínají žárovky na této liště postupně zhasínat, a to ve stejném pořadí, v němž se rozsvěcovaly. Jakmile na liště zhasnou všechny žárovky, od další sekundy se začnou žárovky opět rozsvěcovat. Celý cyklus se u každé lišty opakuje stále dokola (viz obrázek).','16.1 Určete, v kolikáté sekundě bude poprvé na kratší liště rozsvíceno více žárovek než na delší liště.','16.2 Určete, kolik žárovek bude rozsvíceno na delší liště v 57. sekundě.','16.3 Určete, kolik žárovek bude dohromady rozsvíceno na obou lištách v 91. sekundě.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 740 118" font-family="sans-serif"><g stroke="#000"><circle cx="42" cy="60" r="7" fill="#555"/><circle cx="60" cy="60" r="7" fill="#fff"/><circle cx="78" cy="60" r="7" fill="#fff"/><circle cx="96" cy="60" r="7" fill="#fff"/><circle cx="42" cy="94" r="7" fill="#555"/><circle cx="60" cy="94" r="7" fill="#fff"/><circle cx="78" cy="94" r="7" fill="#fff"/><circle cx="96" cy="94" r="7" fill="#fff"/><circle cx="114" cy="94" r="7" fill="#fff"/><circle cx="132" cy="94" r="7" fill="#fff"/><circle cx="160" cy="60" r="7" fill="#555"/><circle cx="178" cy="60" r="7" fill="#555"/><circle cx="196" cy="60" r="7" fill="#fff"/><circle cx="214" cy="60" r="7" fill="#fff"/><circle cx="160" cy="94" r="7" fill="#555"/><circle cx="178" cy="94" r="7" fill="#555"/><circle cx="196" cy="94" r="7" fill="#fff"/><circle cx="214" cy="94" r="7" fill="#fff"/><circle cx="232" cy="94" r="7" fill="#fff"/><circle cx="250" cy="94" r="7" fill="#fff"/><circle cx="278" cy="60" r="7" fill="#555"/><circle cx="296" cy="60" r="7" fill="#555"/><circle cx="314" cy="60" r="7" fill="#555"/><circle cx="332" cy="60" r="7" fill="#fff"/><circle cx="278" cy="94" r="7" fill="#555"/><circle cx="296" cy="94" r="7" fill="#555"/><circle cx="314" cy="94" r="7" fill="#555"/><circle cx="332" cy="94" r="7" fill="#fff"/><circle cx="350" cy="94" r="7" fill="#fff"/><circle cx="368" cy="94" r="7" fill="#fff"/><circle cx="396" cy="60" r="7" fill="#555"/><circle cx="414" cy="60" r="7" fill="#555"/><circle cx="432" cy="60" r="7" fill="#555"/><circle cx="450" cy="60" r="7" fill="#555"/><circle cx="396" cy="94" r="7" fill="#555"/><circle cx="414" cy="94" r="7" fill="#555"/><circle cx="432" cy="94" r="7" fill="#555"/><circle cx="450" cy="94" r="7" fill="#555"/><circle cx="468" cy="94" r="7" fill="#fff"/><circle cx="486" cy="94" r="7" fill="#fff"/><circle cx="514" cy="60" r="7" fill="#555"/><circle cx="532" cy="60" r="7" fill="#555"/><circle cx="550" cy="60" r="7" fill="#555"/><circle cx="568" cy="60" r="7" fill="#fff"/><circle cx="514" cy="94" r="7" fill="#555"/><circle cx="532" cy="94" r="7" fill="#555"/><circle cx="550" cy="94" r="7" fill="#555"/><circle cx="568" cy="94" r="7" fill="#555"/><circle cx="586" cy="94" r="7" fill="#555"/><circle cx="604" cy="94" r="7" fill="#fff"/><circle cx="632" cy="60" r="7" fill="#555"/><circle cx="650" cy="60" r="7" fill="#555"/><circle cx="668" cy="60" r="7" fill="#fff"/><circle cx="686" cy="60" r="7" fill="#fff"/><circle cx="632" cy="94" r="7" fill="#555"/><circle cx="650" cy="94" r="7" fill="#555"/><circle cx="668" cy="94" r="7" fill="#555"/><circle cx="686" cy="94" r="7" fill="#555"/><circle cx="704" cy="94" r="7" fill="#555"/><circle cx="722" cy="94" r="7" fill="#555"/></g><text x="78" y="26" font-size="12" text-anchor="middle">1. sekunda</text><text x="196" y="26" font-size="12" text-anchor="middle">2. sekunda</text><text x="314" y="26" font-size="12" text-anchor="middle">3. sekunda</text><text x="432" y="26" font-size="12" text-anchor="middle">4. sekunda</text><text x="550" y="26" font-size="12" text-anchor="middle">5. sekunda</text><text x="668" y="26" font-size="12" text-anchor="middle">6. sekunda</text></svg>',
  'zarovky.svg',
  'Schéma rozsvěcování žárovek na kratší liště (4 žárovky) a delší liště (6 žárovek) v prvních šesti sekundách.',
  'Rozsvěcování žárovek v prvních sekundách',
  new List<String>{'16.1 Počet svítících žárovek na kratší liště se opakuje s periodou $8$ ($1,2,3,4,3,2,1,0$), na delší s periodou $12$ ($1,2,3,4,5,6,5,4,3,2,1,0$). Poprvé je na kratší liště více žárovek v $11.$ sekundě (kratší $3$, delší $1$).','16.2 $57=4\\cdot 12+9$, tedy jako v $9.$ sekundě: na delší liště svítí $3$ žárovky.','16.3 Kratší: $91=11\\cdot 8+3$, tj. $3$ žárovky; delší: $91=7\\cdot 12+7$, tj. $5$ žárovek. Dohromady $3+5=8$ žárovek.'},
  '16.1: v $11.$ sekundě; 16.2: $3$ žárovky; 16.3: $8$ žárovek',
  4, 7, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
