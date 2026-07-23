String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
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
  'CERMAT M5D 2026 – úloha 14',
  new List<String>{'Vědomostní hra má $10$ kol. Hráč má na začátku hry celkem $10$ žetonů a postupně může odpovědět na $5$ lehčích a na $5$ těžších otázek. V každém kole si může koupit pouze $1$ otázku a zaplatí za ni $1$ žeton. Pokud hráč kolo vynechá (otázku si nekoupí), žeton mu zůstane. Za správnou odpověď na lehčí otázku získá hráč $2$ žetony, za správnou odpověď na těžší otázku $3$ žetony. Za chybnou odpověď žádný žeton nezíská.','14.1 Určete, kolik nejvíce žetonů může mít hráč na konci hry.','14.2 Hráč vynechal pouze $1$ kolo a ve zbývajících kolech získal za odpovědi na lehčí otázky o $3$ žetony více než za odpovědi na těžší otázky. Určete, kolik žetonů měl hráč na konci hry.','14.3 Hráč měl na konci hry $10$ žetonů a přitom měl největší možný počet chybných odpovědí s tímto výsledkem. Určete, kolikrát v této hře správně odpověděl na lehčí otázku. Uveďte všechna řešení.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'14.1 Za koupenou otázku se platí $1$ žeton; správná lehčí přinese čistý zisk $+1$, správná těžší $+2$. Nejvíce vydělá hráč, který správně odpoví na všech $5$ lehčích i $5$ těžších otázek: $5\\cdot 1+5\\cdot 2=15$. Na konci má $10+15=25$ žetonů.','14.2 Vynechal $1$ kolo (žeton zůstal), v $9$ kolech zaplatil $9$ žetonů. Za lehčí získal o $3$ žetony více než za těžší; jediná možnost v mezích $5$ a $5$ otázek je $6$ žetonů za lehčí ($3$ správné lehčí) a $3$ žetony za těžší ($1$ správná těžší). Na konci má $10-9+6+3=10$ žetonů.','14.3 Začátek i konec je $10$ žetonů, celková změna je $0$. Označíme počet správných lehčích $a$, těžších $b$ a chybných $w$; pak $a+2b=w$ při $a\\le 5$ a $b\\le 5$. Největší možný počet chybných je $6$: buď $a=0$, $b=3$ (a jedno vynechané kolo), nebo $a=2$, $b=2$. Na lehčí otázku tedy hráč odpověděl správně buď ani jednou, nebo dvakrát.'},
  '14.1: $25$ žetonů; 14.2: $10$ žetonů; 14.3: ani jednou nebo dvakrát',
  4, 8, '4',
  new List<String>{'zs1','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
