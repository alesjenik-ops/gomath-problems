String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD26C0T01';
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
  'CERMAT M9A 2026 – úloha 15',
  new List<String>{'Na podložce stojí základní kvádr o rozměrech $2$ cm, $1$ cm a $1$ cm a další tři tělesa $A$, $B$, $C$, která jsme postavili z několika základních kvádrů (viz obrázek).','Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).','15.1 O kolik procent větší je objem tělesa $B$ než objem tělesa $A$?','15.2 O kolik procent menší je objem tělesa $B$ než objem tělesa $C$?','15.3 Ze základního kvádru odřízneme část, která přesně zaplní otvor uvnitř tělesa $C$. O kolik procent se zvětší objem tělesa $C$ zaplněním otvoru touto částí?'},
  new List<String>{'A) o $10\\,\\%$','B) o $25\\,\\%$','C) o $33\\,\\%$','D) o $40\\,\\%$','E) o $50\\,\\%$','F) o více než $50\\,\\%$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 120" font-family="sans-serif"> <text x="240" y="52" font-size="13" text-anchor="middle">Zakladni kvadr 2 cm × 1 cm × 1 cm; telesa A, B, C slozena z nekolika kvadru (viz testovy sesit).</text> <text x="240" y="82" font-size="11" text-anchor="middle" fill="#666">Prostorova telesa nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'telesa-abc.svg',
  'Základní kvádr 2 cm krát 1 cm krát 1 cm a tři prostorová tělesa A, B, C složená ze základních kvádrů.',
  'Prostorová tělesa – schematický nákres (viz testový sešit)',
  new List<String>{'Základní kvádr má objem $2\\cdot 1\\cdot 1=2$ cm³. Těleso $A$ je složeno ze $2$ kvádrů ($4$ cm³), těleso $B$ ze $3$ kvádrů ($6$ cm³) a těleso $C$ z $5$ kvádrů ($10$ cm³).','15.1 $\\frac{6-4}{4}=\\frac{1}{2}=50\\,\\%$ → E.','15.2 $\\frac{10-6}{10}=\\frac{2}{5}=40\\,\\%$ → D.','15.3 Otvor uvnitř tělesa $C$ má objem $1$ cm³; zaplněním se objem zvětší o $\\frac{1}{10}=10\\,\\%$ → A.'},
  '15.1: E (o $50\\,\\%$); 15.2: D (o $40\\,\\%$); 15.3: A (o $10\\,\\%$)',
  6, 8, '4',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 16',
  new List<String>{'Po spuštění automatu začali dva roboti Jas a Dok plnit prázdnou nádobu míčky a třetí robot Pat začal míčky odebírat. Jas dal do nádoby v každé sekundě $1$ míček, Dok dal do nádoby v každé druhé sekundě $2$ míčky najednou a Pat v každé páté sekundě z nádoby $5$ míčků najednou odebral.','16.1 Určete počet míčků v nádobě na konci 14. sekundy po spuštění automatu.','16.2 Určete, v kolikáté sekundě po spuštění počet míčků v nádobě poprvé překročil $30$.','16.3 V některých sekundách se oproti předchozí sekundě změnil počet míčků v nádobě celkem o $3$. Určete počet míčků v nádobě v okamžiku, kdy k této změně došlo právě po třicáté.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Za každou sekundu přibude $1$ míček (Jas), v každé sudé sekundě navíc $2$ (Dok) a v každé páté sekundě $5$ ubude (Pat). Počet míčků po $n$-té sekundě je $n+2\\cdot\\left\\lfloor\\frac{n}{2}\\right\\rfloor-5\\cdot\\left\\lfloor\\frac{n}{5}\\right\\rfloor$.','16.1 Po 14. sekundě: $14+2\\cdot 7-5\\cdot 2=14+14-10=18$ míčků.','16.2 Postupným sčítáním počet poprvé překročí $30$ na konci 28. sekundy (je tam $31$ míčků).','16.3 Změna o $+3$ nastává právě v sudých sekundách, které nejsou dělitelné pěti. Třicátá taková sekunda je 74. sekunda; počet míčků je $74+2\\cdot 37-5\\cdot 14=74+74-70=78$.'},
  '16.1: $18$ míčků; 16.2: ve $28.$ sekundě; 16.3: $78$ míčků (v $74.$ sekundě)',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
