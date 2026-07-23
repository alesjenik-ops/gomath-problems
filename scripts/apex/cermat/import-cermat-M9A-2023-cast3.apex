String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
Integer YEAR = 2023;

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
  'CERMAT M9A 2023 – úloha 7',
  new List<String>{'Pouze pro žáky 8. a 9. tříd byly otevřeny tři kroužky – hudební, šachový a robotický. Každý žák může být jen v jednom z těchto tří kroužků. Graf znázorňuje počty žáků v jednotlivých kroužcích; jeden údaj (9. třídy v robotickém kroužku) a čísla na svislé ose chybí. V hudebním kroužku je celkem o $6$ žáků méně než v šachovém. Ve všech třech kroužcích dohromady je poměr počtu žáků 8. tříd ku počtu žáků 9. tříd $2:3$.','7.1 Určete, o kolik procent více je v hudebním kroužku žáků 8. tříd než žáků 9. tříd.','7.2 Určete, kolik žáků 9. tříd je v šachovém kroužku.','7.3 Určete, jaký je v robotickém kroužku poměr počtu žáků 8. tříd ku počtu žáků 9. tříd.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"><line x1="55" y1="60" x2="55" y2="250" stroke="#000"/><line x1="55" y1="250" x2="410" y2="250" stroke="#000"/><line x1="55" y1="226" x2="410" y2="226" stroke="#ddd"/><line x1="55" y1="202" x2="410" y2="202" stroke="#ddd"/><line x1="55" y1="178" x2="410" y2="178" stroke="#ddd"/><line x1="55" y1="154" x2="410" y2="154" stroke="#ddd"/><line x1="55" y1="130" x2="410" y2="130" stroke="#ddd"/><line x1="55" y1="106" x2="410" y2="106" stroke="#ddd"/><line x1="55" y1="82" x2="410" y2="82" stroke="#ddd"/><rect x="78" y="130" width="26" height="120" fill="#555" stroke="#000"/><rect x="106" y="154" width="26" height="96" fill="#d9d9d9" stroke="#000"/><rect x="178" y="154" width="26" height="96" fill="#555" stroke="#000"/><rect x="206" y="82" width="26" height="168" fill="#d9d9d9" stroke="#000"/><rect x="278" y="178" width="26" height="72" fill="#555" stroke="#000"/><rect x="306" y="210" width="26" height="40" fill="none" stroke="#999" stroke-dasharray="4 3"/><text x="319" y="202" font-size="15" text-anchor="middle">?</text><text x="110" y="268" font-size="12" text-anchor="middle">hudebni</text><text x="210" y="268" font-size="12" text-anchor="middle">sachovy</text><text x="310" y="268" font-size="12" text-anchor="middle">roboticky</text><text x="46" y="254" font-size="12" text-anchor="end">0</text><text x="24" y="160" font-size="12" text-anchor="middle" transform="rotate(-90 24 160)">Pocet zaku</text><rect x="330" y="70" width="13" height="13" fill="#555" stroke="#000"/><text x="348" y="81" font-size="12">8. tridy</text><rect x="330" y="90" width="13" height="13" fill="#d9d9d9" stroke="#000"/><text x="348" y="101" font-size="12">9. tridy</text></svg>',
  'graf-krouzky.svg',
  'Skupinový sloupcový graf: pro hudební, šachový a robotický kroužek jsou dvojice sloupců pro 8. a 9. třídy; sloupec 9. tříd u robotického kroužku a čísla na svislé ose chybí.',
  'Počty žáků 8. a 9. tříd v kroužcích (schematický graf)',
  new List<String>{'Ze sloupců lze odečíst poměry výšek (v dílcích): hudební 8. tříd $5$, 9. tříd $4$; šachový 8. tříd $4$, 9. tříd $7$; robotický 8. tříd $3$. Hudební kroužek má $9$ dílců, šachový $11$ dílců; jelikož se liší o $6$ žáků, je $2$ dílce $=6$ žáků, tedy $1$ dílec $=3$ žáci. Počty: hudební 8. tříd $15$, 9. tříd $12$; šachový 8. tříd $12$, 9. tříd $21$; robotický 8. tříd $9$.','7.1 V hudebním kroužku je 8. tříd $15$ a 9. tříd $12$, tj. o $\\frac{15-12}{12}=25\\,\\%$ více.','7.2 V šachovém kroužku je $21$ žáků 9. tříd.','7.3 Celkem je žáků 8. tříd $15+12+9=36$; při poměru $2:3$ je žáků 9. tříd $54$, z toho v robotickém $54-(12+21)=21$. Poměr v robotickém kroužku je $9:21=3:7$.'},
  '7.1: o $25\\,\\%$; 7.2: $21$ žáků; 7.3: $3:7$',
  3, 5, '3',
  new List<String>{'zs2','r9','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
