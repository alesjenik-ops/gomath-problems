String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený J16 – rodné číslo (dělitelnost 11)',
  new List<String>{'Rodné číslo má přiděleno každý občan ČR. Má deset číslic; prvních šest (před lomítkem) vyjadřuje datum narození a pohlaví (u žen se k číslu měsíce přičítá $50$), za lomítkem je třímístné pořadové číslo a poslední, desátá číslice je kontrolní. Kontrolní číslice doplňuje číslo tak, aby rozdíl mezi součtem číslic na lichých pozicích a součtem číslic na sudých pozicích byl dělitelný $11$ (tj. celé rodné číslo je dělitelné $11$). Na obrázku je příklad rodného čísla chlapce (Petr) a dívky (Lucie) narozených 19. listopadu 2002.','16.1 Nahraďte v následujících 10místných kódech symboly △ a ▽ číslicemi tak, aby šlo o správné rodné číslo: Václav 62△▽19/1162; Anežka 84△611/003▽; Jolana 0052△0/▽215.','16.2 Rozhodněte, které z následujících kódů nemohou být rodným číslem dané osoby, a uveďte proč: Igor 886212/1136; Marie 005231/0016; Honza 121212/1218.','16.3 Vypočtěte, o kolik dnů je Petr mladší než Klára, jestliže Klára uvedla rodné číslo 045331/2134 a Petr 040611/0033. Ale mohli při tom udělat chybu.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 180" font-family="sans-serif" font-size="14"> <rect x="90" y="10" width="400" height="160" fill="none" stroke="#000" stroke-width="1.5"/> <line x1="90" y1="60" x2="490" y2="60" stroke="#000" stroke-width="1"/> <line x1="90" y1="115" x2="490" y2="115" stroke="#000" stroke-width="1"/> <line x1="160" y1="10" x2="160" y2="170" stroke="#000" stroke-width="1"/> <line x1="230" y1="10" x2="230" y2="170" stroke="#000" stroke-width="1"/> <line x1="300" y1="10" x2="300" y2="170" stroke="#000" stroke-width="1"/> <line x1="405" y1="10" x2="405" y2="170" stroke="#000" stroke-width="1"/> <text x="125" y="42" text-anchor="middle">rok</text> <text x="195" y="42" text-anchor="middle">měsíc</text> <text x="265" y="42" text-anchor="middle">den</text> <text x="352" y="34" text-anchor="middle">Pořadové</text> <text x="352" y="50" text-anchor="middle">číslo</text> <text x="447" y="34" text-anchor="middle">Kontrolní</text> <text x="447" y="50" text-anchor="middle">číslice</text> <text x="45" y="92" text-anchor="middle" font-weight="bold">PETR</text> <text x="125" y="92" text-anchor="middle">02</text> <text x="195" y="92" text-anchor="middle">11</text> <text x="265" y="92" text-anchor="middle">19</text> <text x="352" y="92" text-anchor="middle">102</text> <text x="447" y="92" text-anchor="middle">4</text> <text x="45" y="147" text-anchor="middle" font-weight="bold">LUCIE</text> <text x="125" y="147" text-anchor="middle">02</text> <text x="195" y="147" text-anchor="middle">61</text> <text x="265" y="147" text-anchor="middle">19</text> <text x="352" y="147" text-anchor="middle">102</text> <text x="447" y="147" text-anchor="middle">9</text> </svg>',
  'rodne-cislo.svg',
  'Tabulka rodných čísel Petra (021119/1024) a Lucie (026119/1029) s popisky rok, měsíc, den, pořadové číslo, kontrolní číslice.',
  'Příklad rodného čísla chlapce a dívky',
  new List<String>{'16.1 Václav: rozdíl součtů je △$-$▽, dělitelný $11$ jen pro △$=$▽; měsíc △▽ musí být $01$–$12$, tedy $11$: △$=1$, ▽$=1$ (621119/1162). Anežka (žena): měsíc △$6$ musí být $51$–$62$, tj. $56$ (△$=5$); z dělitelnosti pak ▽$=6$ (845611/0036). Jolana (žena): rok $00$, měsíc $52$ (únor), den △$0$ je $10$ nebo $20$; z dělitelnosti △$+$▽$=3$: △$=1$,▽$=2$ nebo △$=2$,▽$=1$.','16.2 Igor: druhé dvojčíslí (měsíc) je $62$; pro muže nesmí být větší než $12$ — nemůže. Marie: měsíc $52$ (únor), den $31$ — $31$. únor neexistuje, nemůže. Honza: $121212/1218$ je platné (dělitelné $11$, datum existuje) — může.','16.3 Rodné číslo Petra ($0406110033$) není dělitelné $11$ (rozdíl součtů je $-10$), je tedy chybné, a proto rozdíl věku nelze spolehlivě vypočítat.'},
  '16.1: Václav △=1, ▽=1; Anežka △=5, ▽=6; Jolana △=1, ▽=2 nebo △=2, ▽=1. 16.2: Igor nemůže (měsíc nesmí být větší než 12), Marie nemůže (31. únor neexistuje), Honza může. 16.3: nelze vypočítat, protože rodné číslo Petra je chybné.',
  6, 10, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
