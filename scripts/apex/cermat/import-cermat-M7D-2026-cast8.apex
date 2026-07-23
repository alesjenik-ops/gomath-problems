String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M7D 2026 – úloha 16',
  new List<String>{'Vědomostní hra má $10$ kol. Hráč má na začátku hry celkem $10$ žetonů a postupně může odpovědět na $5$ lehčích a na $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku a zaplatí za ni $1$ žeton. Pokud hráč kolo vynechá (otázku si nekoupí), žeton mu zůstane. Za správnou odpověď na lehčí otázku získá hráč $2$ žetony, za správnou odpověď na těžší otázku $3$ žetony. Za chybnou odpověď žádný žeton nezíská. (Např. hráč, který $3$ kola vynechal a ze $7$ zakoupených otázek správně odpověděl pouze na $1$ lehčí, měl na konci hry celkem $5$ žetonů.)','16.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.','16.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za odpovědi na lehčí otázky o $3$ žetony více než za odpovědi na těžší otázky. Určete, kolik žetonů měl hráč na konci hry.','16.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí s tímto výsledkem. Určete, kolikrát v této hře správně odpověděl na lehčí otázku. Uveďte všechna řešení.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 Koupí všech $10$ otázek (zaplatí $10$ žetonů) a odpoví správně: $5\\cdot 2+5\\cdot 3=25$. Celkem $10-10+25=25$ žetonů.','16.2 Koupil $9$ otázek; správné lehčí $e$ ($2e$ žet.), správné těžší $h$ ($3h$ žet.), $2e-3h=3$. Jediné řešení v mezích $e=3$, $h=1$. Konec $=10-9+2\\cdot 3+3\\cdot 1=10$ žetonů.','16.3 Konec $10\\Rightarrow$ počet koupených $=2e+3h$. Chybných $=(2e+3h)-e-h=e+2h$; maximum $6$ dosáhnou dvě možnosti: $e=0,h=3$ a $e=2,h=2$. Lehčích správně tedy $0$, nebo $2$.'},
  '16.1: $25$ žetonů; 16.2: $10$ žetonů; 16.3: ani jednou; dvakrát',
  4, 9, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
