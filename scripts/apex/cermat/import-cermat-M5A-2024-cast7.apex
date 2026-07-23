String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD24C0T01';
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
  'CERMAT M5A 2024 - uloha 13',
  new List<String>{'Pan Josef jel autem z Heraltic do Trebice stalou rychlosti a cesta mu trvala $24$ minut. V $7{:}08$ byl v jedne tretine cesty. V polovine cesty projel pres zeleznicni prejezd.','Ke kazde poduloze (13.1-13.3) priradte spravny vysledek (A-F).','13.1 V kolik hodin pan Josef vyjel?','13.2 V kolik hodin prejel pan Josef zeleznicni prejezd?','13.3 V kolik hodin by pan Josef prijel, kdyby vyjel o $6$ minut pozdeji?'},
  new List<String>{'A) $7{:}30$','B) $7{:}24$','C) $7{:}12$','D) $7{:}08$','E) $7{:}00$','F) $6{:}52$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Tretina cesty je $24:3=8$ minut. V $7{:}08$ ujel $8$ minut, vyjel tedy v $7{:}00$ -> 13.1: E.','Polovina cesty je $12$ minut, prejezd projel v $7{:}00+12$ min $=7{:}12$ -> 13.2: C.','Kdyby vyjel v $7{:}06$, prijel by v $7{:}06+24$ min $=7{:}30$ -> 13.3: A.'},
  '13.1: E ($7{:}00$); 13.2: C ($7{:}12$); 13.3: A ($7{:}30$)',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2024 - uloha 14',
  new List<String>{'Pyramida postavena z kostek stavebnice muze mit libovolny pocet pater. Kazde patro pyramidy ma stejnou vysku. Do prvniho, druheho a kazdeho dalsiho patra vede vzdy stejny pocet schodu. Zdola do prvniho patra vedou vzdy cerne schody, do druheho patra bile schody a takto se rovnez ve vyssich patrech obe barvy schodu pravidelne stridaji. Napriklad pyramida na obr. 1 ma $6$ cernych a $4$ bile schody, pyramida na obr. 2 ma $6$ cernych a $3$ bile schody (viz obrazek).','14.1 Pyramida s $8$ patry ma celkem $48$ cernych schodu. Kolik schodu vede do prvniho patra?','14.2 Pyramida se $7$ patry ma celkem $84$ bilych schodu. Jaky je celkovy pocet schodu v pyramide?','14.3 V pyramide s $90$ schody ma $27$. schod stejnou barvu jako $30$. schod, ale jinou barvu nez $33$. schod. Jaky je nejvetsi mozny pocet pater v teto pyramide?'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 230" font-family="sans-serif"><polygon points="60,190 300,190 250,40 110,40" fill="none" stroke="#000"/><line x1="70" y1="160" x2="290" y2="160" stroke="#999"/><line x1="80" y1="130" x2="280" y2="130" stroke="#999"/><line x1="90" y1="100" x2="270" y2="100" stroke="#999"/><line x1="100" y1="70" x2="260" y2="70" stroke="#999"/><text x="305" y="179" font-size="12">1.</text><rect x="59" y="169" width="12" height="12" fill="#000" stroke="#000"/><text x="305" y="149" font-size="12">2.</text><rect x="69" y="139" width="12" height="12" fill="#fff" stroke="#000"/><text x="305" y="119" font-size="12">3.</text><rect x="79" y="109" width="12" height="12" fill="#000" stroke="#000"/><text x="305" y="89" font-size="12">4.</text><rect x="89" y="79" width="12" height="12" fill="#fff" stroke="#000"/><text x="305" y="59" font-size="12">5.</text><rect x="99" y="49" width="12" height="12" fill="#000" stroke="#000"/><text x="180" y="215" font-size="12" text-anchor="middle">schematicky nakres pyramidy</text></svg>',
  'pyramida.svg',
  'Schematicky nakres pyramidy s patry a se schody, ktere pravidelne stridaji cernou a bilou barvu.',
  'Pyramida s patry (schematicky nakres)',
  new List<String>{'Do kazdeho patra vede stejny pocet schodu, oznacme jej $s$; licha patra jsou cerna, suda bila.','14.1 Mezi $8$ patry jsou $4$ cerna (1., 3., 5., 7.): $4s=48$, tedy $s=12$ schodu do prvniho patra.','14.2 Mezi $7$ patry jsou $3$ bila (2., 4., 6.): $3s=84$, tedy $s=28$. Celkem $7\\cdot 28=196$ schodu.','14.3 Celkem $90$ schodu, $s$ deli $90$ a pocet pater je $90:s$; nejvetsi pocet pater znamena nejmensi $s$. Pro $s=5$ lezi $27$. i $30$. schod v $6$. patre (bile) a $33$. schod v $7$. patre (cerne), podminka plati; delitele $1$, $2$, $3$ ji nesplni. Nejvetsi pocet pater je $90:5=18$.'},
  '14.1: $12$; 14.2: $196$; 14.3: $18$',
  6, 8, '4',
  new List<String>{'zs1','posloupnosti','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
