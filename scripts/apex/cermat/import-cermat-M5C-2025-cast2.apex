String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD25C0T03';
Integer YEAR = 2025;

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
  'CERMAT M5C 2025 – úloha 5',
  new List<String>{'5.1 Písmena $K$, $L$ představují dvě různé číslice. Sčítaná trojciferná čísla jsou $\\overline{KLL}$ a $\\overline{KLK}$; jejich součet je čtyřciferné číslo, jehož poslední dvě číslice jsou $1$ a $1$ (první dvě číslice součtu chybějí). Určete číslice, kterými se nahradí $K$, $L$, a zapište je v tomto pořadí.','5.2 Písmena $S$, $T$, $U$ představují tři navzájem různé číslice. V zápise součtu tří dvouciferných čísel $\\overline{ST}+\\overline{ST}+\\overline{TU}$ je výsledek roven $211$. Určete číslice $S$, $T$, $U$ a zapište je v tomto pořadí. Najděte všechna tři řešení.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Z posledního sloupce $L+K$ končí na 1 a přenáší se; ze sloupce desítek $L+L+1$ končí na 1. Řešením je $K=6$, $L=5$: $655+656=1311$ (poslední dvě číslice jsou $1$, $1$).','5.2 Platí $\\overline{ST}+\\overline{ST}+\\overline{TU}=20S+12T+U=211$. Trojice různých číslic vyhovujících podmínce jsou $(S,T,U)=(9,2,7)$, $(8,4,3)$ a $(5,9,3)$.'},
  '5.1: $K=6$, $L=5$ (tj. $6, 5$); 5.2: $9, 2, 7$; $8, 4, 3$; $5, 9, 3$',
  4, 6, '4',
  new List<String>{'zs1','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2025 – úloha 6',
  new List<String>{'Šestiúhelník na obrázku je rozdělen dvěma úsečkami na dva bílé čtverce a dva stejné tmavé trojúhelníky. Délka strany malého čtverce je o čtvrtinu menší než délka strany velkého čtverce. Obvody obou čtverců se liší o 12 cm. Obvod jednoho tmavého trojúhelníku je stejný jako obvod malého čtverce.','6.1 Vypočtěte v cm délku strany malého čtverce.','6.2 Vypočtěte v cm obvod velkého čtverce.','6.3 Určete, kolikrát větší je obvod šestiúhelníku než obvod malého čtverce.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 285 285" font-family="sans-serif"> <polygon points="15,123 159,123 159,15" fill="#b3b3b3" stroke="#000"/> <polygon points="159,267 267,123 159,123" fill="#b3b3b3" stroke="#000"/> <polygon points="15,267 159,267 159,123 15,123" fill="#ffffff" stroke="#000"/> <polygon points="159,123 267,123 267,15 159,15" fill="#ffffff" stroke="#000"/> <polygon points="15,267 159,267 267,123 267,15 159,15 15,123" fill="none" stroke="#000" stroke-width="2.5"/> </svg>',
  'sestiuhelnik.svg',
  'Šestiúhelník rozdělený dvěma úsečkami na velký a malý bílý čtverec a dva shodné tmavé pravoúhlé trojúhelníky.',
  'Schematický nákres (rozměry dle zadání)',
  new List<String>{'6.1 Strana malého čtverce $m=\\frac{3}{4}v$. Obvody se liší o 12 cm: $4v-4m=12$, tj. $v-m=3$. Odtud $v-\\frac{3}{4}v=3$, $\\frac{1}{4}v=3$, $v=12$ cm a $m=9$ cm. Strana malého čtverce je $9$ cm.','6.2 Obvod velkého čtverce je $4\\cdot 12=48$ cm.','6.3 Tmavý trojúhelník je pravoúhlý s odvěsnami $12$ cm a $9$ cm a přeponou $\\sqrt{12^2+9^2}=15$ cm (jeho obvod $12+9+15=36$ cm je roven obvodu malého čtverce). Obvod šestiúhelníku tvoří dvě strany velkého čtverce, dvě strany malého čtverce a dvě přepony: $2\\cdot 12+2\\cdot 9+2\\cdot 15=72$ cm. Obvod malého čtverce je $36$ cm, tedy $72:36=2$.'},
  '6.1: $9$ cm; 6.2: $48$ cm; 6.3: 2krát',
  5, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
