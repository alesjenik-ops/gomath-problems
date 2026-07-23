String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD21C0T01';
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
  'CERMAT M7A 2021 – úloha 6',
  new List<String>{'Matěj prošel celou vyhlídkovou trasu, která vede od nádraží k jezeru. Od nádraží k první vyhlídce ušel $\\frac{1}{6}$ trasy. Po dalších $5{,}5$ km chůze se dostal k druhé vyhlídce. Od ní mu k jezeru zbývaly už jen $\\frac{2}{9}$ trasy. Ještě $1$ km před druhou vyhlídkou se Matěj zastavil u studánky.','6.1 Vypočtěte, kolik km ušel Matěj od nádraží k první vyhlídce.','6.2 Vyjádřete zlomkem v základním tvaru, jakou část trasy Matěj ušel od nádraží ke studánce.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 300" font-family="sans-serif" font-size="14"> <polyline points="60,250 210,150 410,255 500,175 690,265" fill="none" stroke="#000" stroke-width="2"/> <circle cx="60" cy="250" r="5"/><circle cx="210" cy="150" r="5"/><circle cx="410" cy="255" r="5"/><circle cx="500" cy="175" r="5"/><circle cx="690" cy="265" r="5"/> <text x="60" y="278" text-anchor="middle">nádraží</text> <text x="210" y="138" text-anchor="middle">1. vyhlídka</text> <text x="410" y="283" text-anchor="middle">studánka</text> <text x="500" y="163" text-anchor="middle">2. vyhlídka</text> <text x="690" y="290" text-anchor="middle">jezero</text> </svg>',
  'trasa.svg',
  'Schematická trasa od nádraží přes 1. vyhlídku, studánku a 2. vyhlídku k jezeru.',
  'Výchozí obrázek k úloze 6 (schematicky)',
  new List<String>{'Úsek mezi vyhlídkami je $5{,}5$ km a tvoří $1-\\frac{1}{6}-\\frac{2}{9}=\\frac{11}{18}$ celé trasy. Celá trasa $t=5{,}5:\\frac{11}{18}=9$ km.','6.1 K první vyhlídce: $\\frac{1}{6}\\cdot 9=1{,}5$ km.','6.2 Od nádraží ke druhé vyhlídce je $1{,}5+5{,}5=7$ km, studánka je o $1$ km blíž, tj. $6$ km, což je $\\frac{6}{9}=\\frac{2}{3}$ trasy.'},
  '6.1: $1{,}5$ km; 6.2: $\\frac{2}{3}$ trasy',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2021 – úloha 7',
  new List<String>{'Horní část skleněného kvádru tvoří $6$ krychlí z barevného skla umístěných v jedné vrstvě; každá krychle má hranu délky $2$ cm. Stejná vrstva krychlí tvoří také spodní část kvádru. Obě vrstvy barevných krychlí dohromady zaujímají $20\\,\\%$ objemu celého kvádru. Zbytek kvádru je z bílého skla.','Vypočtěte:','7.1 v cm³ objem jedné vrstvy barevných krychlí,','7.2 v cm délku nejdelší hrany celého kvádru,','7.3 v cm² povrch celého kvádru.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 280 400" font-family="sans-serif" font-size="13"> <polygon points="40,40 160,40 200,18 80,18" fill="#cccccc" stroke="#000"/> <polygon points="160,40 200,18 200,360 160,382" fill="#dcdcdc" stroke="#000"/> <rect x="40" y="40" width="120" height="342" fill="#f5f5f5" stroke="#000"/> <rect x="40" y="40" width="40" height="44" fill="#8a8a8a" stroke="#000"/><rect x="80" y="40" width="40" height="44" fill="#bdbdbd" stroke="#000"/><rect x="120" y="40" width="40" height="44" fill="#8a8a8a" stroke="#000"/> <rect x="40" y="338" width="40" height="44" fill="#bdbdbd" stroke="#000"/><rect x="80" y="338" width="40" height="44" fill="#8a8a8a" stroke="#000"/><rect x="120" y="338" width="40" height="44" fill="#bdbdbd" stroke="#000"/> <line x1="210" y1="60" x2="242" y2="60" stroke="#000"/><text x="212" y="54">2 cm</text> </svg>',
  'kvadr.svg',
  'Vysoký skleněný kvádr s vrstvou šesti barevných krychlí nahoře i dole.',
  'Výchozí obrázek k úloze 7 (schematicky)',
  new List<String>{'7.1 Jedna vrstva: $6$ krychlí po $2^3=8$ cm³, tj. $6\\cdot 8=48$ cm³.','7.2 Obě vrstvy $=96$ cm³ $=20\\,\\%$, celý kvádr má $96:0{,}2=480$ cm³. Podstava vrstvy je obdélník $6\\times 4$ cm (obsah $24$ cm²), takže výška kvádru $=480:24=20$ cm; to je nejdelší hrana.','7.3 Kvádr $6\\times 4\\times 20$ cm: $S=2\\,(6\\cdot 4+6\\cdot 20+4\\cdot 20)=2\\,(24+120+80)=448$ cm².'},
  '7.1: $48$ cm³; 7.2: $20$ cm; 7.3: $448$ cm²',
  4, 7, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
