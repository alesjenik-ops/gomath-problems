String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M9B 2018 – úloha 16',
  new List<String>{'Na obrazovce počítače jsou dvě čísla – jedno v modrém a druhé v červeném poli. Na počátku jsou obě čísla stejná. Při každém pípnutí se obě čísla současně zvětší. V modrém poli se číslo zvětší vždy o $6$. Přírůstky čísla v červeném poli se pravidelně střídají – jednou se číslo zvětší o $3$, při dalším pípnutí o $5$, potom znovu o $3$, o $5$, o $3$, o $5$ atd. V jednu chvíli se objeví v modrém poli číslo $500$ a současně v červeném poli číslo $400$.','16.1 Určete, jaké číslo je v modrém poli na počátku.','16.2 Určete, o kolik se zvětší číslo v modrém poli, zatímco se číslo v červeném poli zvětší o $123$.','16.3 Určete číslo v červeném poli v okamžiku, kdy je o $444$ menší než číslo v modrém poli.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl (modré − červené) roste po dvojicích pípnutí: přírůstky se liší o $6-3=3$ a o $6-5=1$, tedy o $4$ za dvojici. Za sudý počet $2m$ pípnutí je rozdíl $4m$. Když je modré $500$ a červené $400$, je rozdíl $100=4m$, tj. $m=25$ a $50$ pípnutí.','16.1 Modré: počátek $+6\\cdot 50=500$, tedy počátek $=500-300=200$.','16.2 Červené se za dvojici pípnutí zvětší o $8$; $123=8\\cdot 15+3$, tj. $30$ pípnutí (o $120$) a ještě jedno pípnutí (o $3$), celkem $31$ pípnutí. Modré se zvětší o $6\\cdot 31=186$.','16.3 Rozdíl $444=4m\\Rightarrow m=111$, tj. $222$ pípnutí. Červené $=200+8\\cdot 111=200+888=1\\,088$.'},
  '16.1: $200$; 16.2: o $186$; 16.3: $1\\,088$',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
