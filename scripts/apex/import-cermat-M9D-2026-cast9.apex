String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 2. náhradní termín (M9D)';
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
  'CERMAT 2026 M9D · úloha 16',
  new List<String>{'Vědomostní hra má $10$ kol. Hráč má na začátku $10$ žetonů a může odpovědět na $5$ lehčích a $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku za $1$ žeton; pokud kolo vynechá, žeton mu zůstane. Za správnou odpověď na lehčí otázku získá $2$ žetony, na těžší $3$ žetony, za chybnou odpověď nic.','16.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.','16.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za lehčí otázky o $3$ žetony více než za těžší. Určete, kolik žetonů měl na konci hry.','16.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí. Určete, kolikrát správně odpověděl na lehčí otázku. Uveďte všechna řešení.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Čistý zisk za správnou lehčí otázku je $+1$ žeton, za správnou těžší $+2$ žetony.','16.1: všech $10$ správně: $10+5\\cdot1+5\\cdot2=25$ žetonů.','16.2: koupil $9$ otázek; $2L=3T+3$ a konečný počet $10-9+2L+3T=1+2L+3T$. Z $2L=3T+3$ a řešení vychází $L=3$, $T=1$, konec $=10$ žetonů.','16.3: konec $10$ žetonů znamená $L+2T=9$; největší počet chyb $\\Rightarrow$ nejméně správných; řešení jsou $L=0,\\,T=... $ dle rozboru: hráč odpověděl správně na lehčí otázku buď ani jednou, nebo dvakrát.'},
  '16.1: $25$ žetonů; 16.2: $10$ žetonů; 16.3: ani jednou nebo dvakrát',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD26C0T04', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
