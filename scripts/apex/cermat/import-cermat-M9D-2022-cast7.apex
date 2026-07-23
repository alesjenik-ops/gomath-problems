String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M9D 2022 – úloha 14',
  new List<String>{'Podstavou trojbokého kolmého hranolu je pravoúhlý trojúhelník s odvěsnami $15$ cm a $8$ cm (přepona $17$ cm) a výškou $5$ cm. Ze čtyř těchto hranolů je slepeno těleso (viz obrázek).','Jaký je objem slepeného tělesa?'},
  new List<String>{'A) $960$ cm³','B) $1\\,200$ cm³','C) $1\\,280$ cm³','D) $1\\,360$ cm³','E) jiný objem'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 250" font-family="sans-serif"> <polygon points="395,60 470,60 470,88 395,88" fill="#ffffff" stroke="#000"/> <polygon points="395,60 470,60 452,42" fill="#c9c9c9" stroke="#000"/> <line x1="452" y1="42" x2="452" y2="70" stroke="#000" stroke-dasharray="3 3"/> <line x1="470" y1="60" x2="470" y2="88" stroke="#000"/> <polygon points="55,205 150,120 360,120 455,205" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="55,205 150,120 108,205" fill="#c9c9c9" stroke="#000"/> <polygon points="455,205 360,120 402,205" fill="#c9c9c9" stroke="#000"/> <line x1="108" y1="205" x2="402" y2="205" stroke="#000"/> <line x1="150" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/> <line x1="360" y1="120" x2="255" y2="205" stroke="#000" stroke-dasharray="3 3"/> </svg>',
  'slepene-teleso.svg',
  'Těleso slepené ze čtyř trojbokých hranolů (schematicky).',
  'Slepené těleso ze čtyř trojbokých hranolů (schematicky)',
  new List<String>{'Objem jednoho hranolu je $\\frac{1}{2}\\cdot 15\\cdot 8\\cdot 5=300$ cm³. Těleso je slepeno ze čtyř hranolů, jeho objem je $4\\cdot 300=1\\,200$ cm³.'},
  'B) $1\\,200$ cm³',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2022 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Do prosince roku 2020 prodělal covid-19 každý dvacátý Čech. Kolik procent Čechů prodělalo covid-19 do prosince roku 2020?','15.2 Počet novorozenců tvořil v dubnu $\\frac{26}{25}$ počtu novorozenců v březnu. O kolik procent byl počet novorozenců v dubnu vyšší než v březnu?','15.3 Teplá kapalina v nádobě po vychladnutí zmenšila svůj objem o $\\frac{2}{27}$. O kolik procent byl objem teplé kapaliny větší než objem vychladlé kapaliny?'},
  new List<String>{'A) $4\\,\\%$','B) $5\\,\\%$','C) $6\\,\\%$','D) $7\\,\\%$','E) $8\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Každý dvacátý je $\\frac{1}{20}=5\\,\\%$ → B.','15.2 $\\frac{26}{25}=1{,}04$, tj. o $4\\,\\%$ více → A.','15.3 Vychladlá kapalina má $\\frac{25}{27}$ objemu teplé; poměr teplá : vychladlá $=\\frac{27}{25}=1{,}08$, tj. o $8\\,\\%$ více → E.'},
  '15.1: B ($5\\,\\%$); 15.2: A ($4\\,\\%$); 15.3: E ($8\\,\\%$)',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2022 – úloha 16',
  new List<String>{'Řada je vytvořena z celých čísel. První trojice čísel je $0, 1, 2$. Každou další trojici vytvoříme tak, že jednotlivá čísla z předchozí trojice zvětšíme o $1$. Na 1. až 18. místě jsou čísla $0, 1, 2, 1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 5, 6, 5, 6, 7, \\ldots$','Určete,','16.1 na kolikátém místě řady je poprvé číslo $12$,','16.2 na kolika místech řady je mezi prvními $125$ čísly uvedeno liché číslo,','16.3 které číslo je na 152. místě řady.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$k$-tá trojice ($k=1,2,\\ldots$) je $(k-1,\\ k,\\ k+1)$ na místech $3k-2,\\ 3k-1,\\ 3k$.','16.1 Číslo $12$ se poprvé objeví jako poslední člen trojice $k=11$: $(10,11,12)$ na místech $31,32,33$; tedy na 33. místě.','16.2 Prvních $125$ míst tvoří trojice $1$ až $41$ (místa 1–123) a místa 124, 125 (čísla $41$, $42$). V trojici se sudým $k$ jsou $2$ lichá čísla, s lichým $k$ jedno; pro $k=1$ až $41$ je to $20\\cdot 2+21\\cdot 1=61$, plus liché $41$ na 124. místě, celkem $62$.','16.3 Místo $152$ je v trojici $k=51$: $(50,51,52)$ na místech $151,152,153$; na 152. místě je číslo $51$.'},
  '16.1: na 33. místě; 16.2: na $62$ místech; 16.3: číslo $51$',
  4, 7, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
