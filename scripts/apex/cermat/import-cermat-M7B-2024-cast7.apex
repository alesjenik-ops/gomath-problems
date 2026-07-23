String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M7B 2024 - uloha 12',
  new List<String>{'Na sachovnici $8\\times 8$ jsou prazdna pole a pole se znackami (kolecka, hvezdy, sipky, trojuhelniky a kosoctverce).','Jaky je pomer poctu kolecek ku poctu prazdnych poli?'},
  new List<String>{'A) $1:4$','B) $1:3$','C) $3:8$','D) $8:3$','E) $5:4$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 238 272" font-family="sans-serif"><line x1="15" y1="15" x2="15" y2="223" stroke="#000"/><line x1="15" y1="15" x2="223" y2="15" stroke="#000"/><line x1="41" y1="15" x2="41" y2="223" stroke="#000"/><line x1="15" y1="41" x2="223" y2="41" stroke="#000"/><line x1="67" y1="15" x2="67" y2="223" stroke="#000"/><line x1="15" y1="67" x2="223" y2="67" stroke="#000"/><line x1="93" y1="15" x2="93" y2="223" stroke="#000"/><line x1="15" y1="93" x2="223" y2="93" stroke="#000"/><line x1="119" y1="15" x2="119" y2="223" stroke="#000"/><line x1="15" y1="119" x2="223" y2="119" stroke="#000"/><line x1="145" y1="15" x2="145" y2="223" stroke="#000"/><line x1="15" y1="145" x2="223" y2="145" stroke="#000"/><line x1="171" y1="15" x2="171" y2="223" stroke="#000"/><line x1="15" y1="171" x2="223" y2="171" stroke="#000"/><line x1="197" y1="15" x2="197" y2="223" stroke="#000"/><line x1="15" y1="197" x2="223" y2="197" stroke="#000"/><line x1="223" y1="15" x2="223" y2="223" stroke="#000"/><line x1="15" y1="223" x2="223" y2="223" stroke="#000"/><circle cx="28" cy="28" r="8" fill="none" stroke="#000"/><circle cx="80" cy="28" r="8" fill="none" stroke="#000"/><polygon points="124,36 132,20 140,36" fill="none" stroke="#000"/><text x="119" y="245" font-size="11" text-anchor="middle">Sachovnice 8 x 8 se znackami - rozmisteni viz testovy sesit.</text></svg>',
  'sachovnice.svg',
  'Sachovnice 8 krat 8 s prazdnymi poli a poli se znackami (schematicky nakres).',
  'Sachovnice se znackami - viz testovy sesit',
  new List<String>{'Pomer poctu kolecek k poctu prazdnych poli na sachovnici je $3:8$ (moznost C).'},
  'C) $3:8$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2024 - uloha 13',
  new List<String>{'Mapa na orientacni beh ma meritko $1:5\\,000$.','Jak velkou vzdalenost v metrech ubehli orientacni bezci, je-li ubehnuta vzdalenost vyznacena na mape useckou o delce $8{,}5$ cm?'},
  new List<String>{'A) $42{,}5$ m','B) $142{,}5$ m','C) $212{,}5$ m','D) $425$ m','E) $4\\,250$ m'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Skutecna vzdalenost je $8{,}5$ cm $\\cdot\\, 5\\,000 = 42\\,500$ cm $= 425$ m.'},
  'D) $425$ m',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2024 - uloha 14',
  new List<String>{'Jsou dany rovnobezky $a$, $b$ a primky $c$, $d$ (viz obrazek). Primka $d$ je kolma k rovnobezkam, primka $c$ je ruznobezka, ktera s primkou $a$ svira uhel $147^\\circ$.','Jaka je velikost uhlu $\\alpha$? Velikosti uhlu nemerte, ale vypocitejte.'},
  new List<String>{'A) $67^\\circ$','B) $57^\\circ$','C) $53^\\circ$','D) $47^\\circ$','E) $33^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <line x1="40" y1="90" x2="380" y2="90" stroke="#000" stroke-width="1.5"/> <text x="70" y="82" font-size="14" font-style="italic">a</text> <text x="92" y="86" font-size="12">||</text> <line x1="40" y1="180" x2="380" y2="180" stroke="#000" stroke-width="1.5"/> <text x="70" y="172" font-size="14" font-style="italic">b</text> <text x="92" y="176" font-size="12">||</text> <line x1="150" y1="30" x2="150" y2="270" stroke="#000" stroke-width="1.5"/> <text x="138" y="44" font-size="14" font-style="italic">d</text> <line x1="70" y1="270" x2="360" y2="40" stroke="#000" stroke-width="1.5"/> <text x="70" y="262" font-size="14" font-style="italic">c</text> <rect x="152" y="78" width="10" height="10" fill="none" stroke="#000"/> <text x="298" y="84" font-size="12">147 st.</text> <text x="166" y="204" font-size="14">alfa</text> </svg>',
  'uhly-rovnobezky.svg',
  'Rovnobezky a, b, kolma primka d a ruznobezka c; u primky a je vyznacen uhel 147 stupnu, u primky b uhel alfa.',
  'Schematicky nakres k uloze 14',
  new List<String>{'Primka $c$ svira s rovnobezkou $a$ (a tedy i s $b$) ostry uhel $180^\\circ - 147^\\circ = 33^\\circ$. Protoze primka $d$ je kolma k rovnobezkam, je uhel $\\alpha$ mezi primkami $c$ a $d$ roven $90^\\circ - 33^\\circ = 57^\\circ$.'},
  'B) $57^\\circ$',
  2, 3, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
