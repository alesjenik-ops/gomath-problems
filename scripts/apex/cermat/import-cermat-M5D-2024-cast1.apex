String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD24C0T04';
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
  'CERMAT M5D 2024 – úloha 1.1',
  new List<String>{'Vypočítejte: $336+336:6-45=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací: $336:6=56$, tedy $336+56-45=347$.'},
  '$347$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 1.2',
  new List<String>{'Vypočítejte: $(725-25\\cdot 8+500):(75:3)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V závorkách: $725-200+500=1025$ a $75:3=25$. Tedy $1025:25=41$.'},
  '$41$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 2',
  new List<String>{'Najděte a napište jednu číslici, kterou lze nahradit všechny hvězdičky tak, aby výpočet byl správný. Jde o písemné odčítání, kde menšenec má tvar *45*, menšitel má tvar 1**4 a výsledek je $2\\,119$ (všechny hvězdičky nahraďte toutéž číslicí).','Do záznamového archu uveďte pouze chybějící číslici.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme hledanou číslici $c$. Menšenec je $1001c+450$, menšitel $1\\,004+110c$. Z rovnice $(1001c+450)-(1\\,004+110c)=2\\,119$ plyne $891c=2\\,673$, tedy $c=3$. Kontrola: $3\\,453-1\\,334=2\\,119$.'},
  'číslice $3$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 3',
  new List<String>{'Provedeme-li postupně všechny početní operace uvedené nad šipkami (viz obrázek), výsledné číslo bude $28$.','Vypočítejte neznámé číslo $x$ z prvního rámečku.','Do záznamového archu uveďte pouze neznámé číslo $x$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 110" font-family="sans-serif"><rect x="20" y="33" width="60" height="44" fill="none" stroke="#000"/><text x="50.0" y="61" font-size="18" text-anchor="middle" font-style="italic">x</text><rect x="130" y="33" width="60" height="44" fill="none" stroke="#000"/><rect x="240" y="33" width="60" height="44" fill="none" stroke="#000"/><rect x="350" y="33" width="60" height="44" fill="none" stroke="#000"/><rect x="460" y="33" width="60" height="44" fill="none" stroke="#000"/><rect x="570" y="33" width="60" height="44" fill="none" stroke="#000"/><text x="600.0" y="61" font-size="18" text-anchor="middle">28</text><line x1="80" y1="55.0" x2="130" y2="55.0" stroke="#000"/><polygon points="130,55.0 122,51.0 122,59.0" fill="#000"/><text x="105.0" y="47.0" font-size="14" text-anchor="middle">·3</text><line x1="190" y1="55.0" x2="240" y2="55.0" stroke="#000"/><polygon points="240,55.0 232,51.0 232,59.0" fill="#000"/><text x="215.0" y="47.0" font-size="14" text-anchor="middle">:2</text><line x1="300" y1="55.0" x2="350" y2="55.0" stroke="#000"/><polygon points="350,55.0 342,51.0 342,59.0" fill="#000"/><text x="325.0" y="47.0" font-size="14" text-anchor="middle">-6</text><line x1="410" y1="55.0" x2="460" y2="55.0" stroke="#000"/><polygon points="460,55.0 452,51.0 452,59.0" fill="#000"/><text x="435.0" y="47.0" font-size="14" text-anchor="middle">·12</text><line x1="520" y1="55.0" x2="570" y2="55.0" stroke="#000"/><polygon points="570,55.0 562,51.0 562,59.0" fill="#000"/><text x="545.0" y="47.0" font-size="14" text-anchor="middle">-8</text></svg>',
  'schema-sipky.svg',
  'Řetězec rámečků: x, poté operace krát 3, děleno 2, minus 6, krát 12, minus 8, výsledek 28.',
  'Výchozí obrázek k úloze 3',
  new List<String>{'Postupujeme od konce zpět: $28+8=36$; $36:12=3$; $3+6=9$; $9\\cdot 2=18$; $18:3=6$. Tedy $x=6$. Kontrola: $6\\cdot 3=18$, $18:2=9$, $9-6=3$, $3\\cdot 12=36$, $36-8=28$.'},
  '$x=6$',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2024 – úloha 4.1',
  new List<String>{'Řešte slovní úlohu. Sourozenci Ondra, Pavel a Šárka dohromady ušetřili $750$ Kč. Pokud částku, kterou našetřila Šárka, vynásobíme $5$, dostaneme stejnou částku, jako když celou našetřenou částku vydělíme počtem sourozenců.','Kolik peněz našetřila Šárka?'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Celá částka vydělená počtem sourozenců je $750:3=250$ Kč. Platí $5\\cdot S=250$, kde $S$ je Šárčina částka, tedy $S=250:5=50$ Kč.'},
  '$50$ Kč',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
