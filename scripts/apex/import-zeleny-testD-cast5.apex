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
  'Zelený D12 – objem obytné části půdy',
  new List<String>{'Dům je široký $10$ metrů a dlouhý $8$ metrů. Výška štítu střechy, který má tvar rovnoramenného trojúhelníku, je $5$ metrů. Prostor půdy je rozdělen ve výšce $2$ metry od hřebenu hambalkem.','Jaký je objem obytné části půdy, která je vyznačena na obrázku šedým podkresem?'},
  new List<String>{'A) $84$ m³','B) $100$ m³','C) $168$ m³','D) $200$ m³','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 390" font-family="sans-serif"><text x="120" y="150" font-size="13" text-anchor="middle" font-weight="bold">Pohled z průčelí</text><rect x="40" y="250" width="160" height="90" fill="none" stroke="#000" stroke-width="2"/><polygon points="40,250 120,170 200,250" fill="none" stroke="#000" stroke-width="2"/><polygon points="40,250 200,250 152,202 88,202" fill="#cfcfcf" stroke="#000" stroke-width="1"/><line x1="120" y1="170" x2="120" y2="202" stroke="#444" stroke-dasharray="3 3"/><text x="138" y="192" font-size="13">2 m</text><line x1="222" y1="170" x2="222" y2="250" stroke="#444" stroke-dasharray="4 4"/><text x="228" y="214" font-size="13">5 m</text><line x1="40" y1="356" x2="200" y2="356" stroke="#444" stroke-width="1"/><text x="120" y="372" font-size="13" text-anchor="middle">10 m</text><text x="400" y="150" font-size="13" text-anchor="middle" font-weight="bold">Pohled z boku</text><rect x="320" y="175" width="160" height="165" fill="none" stroke="#000" stroke-width="2"/><rect x="320" y="278" width="160" height="62" fill="#cfcfcf" stroke="#000" stroke-width="1"/><line x1="320" y1="356" x2="480" y2="356" stroke="#444" stroke-width="1"/><text x="400" y="372" font-size="13" text-anchor="middle">8 m</text></svg>',
  'pudni-prostor.svg',
  'Pohled z průčelí na dům se sedlovou střechou výšky 5 m a hambalkem 2 m pod hřebenem, obytná část půdy je šedě vyznačena; pohled z boku s délkou 8 m.',
  'Půdní prostor rozdělený hambalkem',
  new List<String>{'Hambalek je $2$ m pod hřebenem, tj. $3$ m nad podlahou půdy. Ve výšce $3$ m z $5$ m má štít šířku $10\\cdot\\frac{5-3}{5}=4$ m. Obytná část je lichoběžník se základnami $10$ m a $4$ m a výškou $3$ m: $S=\\frac{10+4}{2}\\cdot 3=21$ m². Objem $=21\\cdot 8=168$ m³.'},
  'C) $168$ m³',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený D13 – velikost úhlu z přímek',
  new List<String>{'Na obrázku jsou přímky a vyznačené velikosti úhlů $30{,}25^\\circ$ a $105{,}2^\\circ$.','Jak velký je úhel na obrázku označený symbolem „?“.'},
  new List<String>{'A) $105^\\circ\\,12\'$','B) $135^\\circ\\,27\'$','C) $135^\\circ\\,45\'$','D) $155^\\circ\\,27\'$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 380" font-family="sans-serif"><line x1="60" y1="255" x2="460" y2="45" stroke="#000" stroke-width="2"/><line x1="60" y1="255" x2="492" y2="300" stroke="#000" stroke-width="2"/><line x1="335" y1="348" x2="406" y2="58" stroke="#000" stroke-width="2"/><text x="112" y="243" font-size="16">30,25°</text><text x="366" y="312" font-size="16">105,2°</text><text x="416" y="98" font-size="22" font-style="italic">?</text></svg>',
  'uhly-primky.svg',
  'Trojúhelník s úhlem 30,25° u levého dolního vrcholu a 105,2° u pravého dolního vrcholu; hledaný úhel označený otazníkem je u horního vrcholu.',
  'Schematický nákres k úloze 13',
  new List<String>{'Úhel označený „?“ je vnějším úhlem trojúhelníku a rovná se součtu dvou vnitřních úhlů při zbývajících vrcholech: $?=30{,}25^\\circ+105{,}2^\\circ=135{,}45^\\circ$. Protože $0{,}45^\\circ=27\'$, je $?=135^\\circ\\,27\'$.'},
  'B) $135^\\circ\\,27\'$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D14 – poměr drah ručiček hodin',
  new List<String>{'Délka vteřinové ručičky věžních hodin je stejná jako délka minutové ručičky a třikrát větší než délka ručičky hodinové.','Jaký je poměr délky drah špičky hodinové, minutové a vteřinové ručičky, které urazí za $1$ hodinu?'},
  new List<String>{'A) $1:12:720$','B) $1:36:720$','C) $1:36:2160$','D) $1:60:3600$','E) jiný poměr'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Označme délku hodinové ručičky $1$; minutová i vteřinová mají délku $3$. Za $1$ hodinu urazí špička hodinové $\\frac{1}{12}$ obvodu své kružnice, minutová $1$ obvod a vteřinová $60$ obvodů. Dráhy jsou úměrné součinu (délka $\\times$ počet otáček): $1\\cdot\\frac{1}{12} : 3\\cdot 1 : 3\\cdot 60 = \\frac{1}{12}:3:180$. Po vynásobení $12$: $1:36:2160$.'},
  'C) $1:36:2160$',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
