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
  'CERMAT M5C 2025 – úloha 9',
  new List<String>{'V kamionu se převážejí bedny naplněné baleními minerálek. Do každé bedny se jednotlivá balení naskládají do 4 vrstev nad sebou. Každá vrstva obsahuje 3 řady po 7 baleních. K přepravě bylo připraveno 1560 balení minerálek, která se postupně skládala do beden. Všechny bedny kromě poslední byly zcela naplněny.','Kolik balení minerálek by bylo třeba přidat do poslední bedny, aby byla plná?'},
  new List<String>{'A) méně než 32 balení','B) 32 balení','C) 34 balení','D) 36 balení','E) více než 36 balení'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jedna bedna pojme $4\\cdot 3\\cdot 7=84$ balení. Platí $1560=18\\cdot 84+48$, v poslední bedně je tedy $48$ balení. Do plné bedny chybí $84-48=36$ balení.'},
  'D) 36 balení',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2025 – úloha 10',
  new List<String>{'Jitka s maminkou a babičkou trhaly na zahradě rybíz do stejně velkých hrnků. Maminka natrhala dvakrát více rybízu než Jitka. Babička natrhala o polovinu více rybízu než Jitka. Přitom babička natrhala o 2 hrnky rybízu méně než maminka.','Kolik hrnků rybízu natrhaly všechny tři dohromady?'},
  new List<String>{'A) 18 hrnků','B) 20 hrnků','C) 21 hrnků','D) 24 hrnků','E) 25 hrnků'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jitka natrhala $j$ hrnků, maminka $2j$, babička $1{,}5j$. Babička o 2 hrnky méně než maminka: $1{,}5j=2j-2$, odtud $0{,}5j=2$, $j=4$. Maminka $8$, babička $6$. Celkem $4+8+6=18$ hrnků.'},
  'A) 18 hrnků',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2025 – úloha 11',
  new List<String>{'Záhon má tvar obdélníku, jehož délka je trojnásobkem jeho šířky. Záhon má obvod 16 m. Po obvodu záhonu jsou vysázeny květiny ve stejných rozestupech, vzdálenost dvou sousedních květin je vždy 40 cm. Jedna květina je i v každém rohu záhonu.','O kolik se liší počet květin vysázených na kratší straně záhonu a počet květin vysázených na delší straně záhonu?'},
  new List<String>{'A) o 9 květin','B) o 10 květin','C) o 11 květin','D) o 12 květin','E) o jiný počet květin'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Obvod je $16$ m a délka je trojnásobek šířky: $2(3s+s)=16$, $8s=16$, $s=2$ m, délka $6$ m. Rozestup $40$ cm $=0{,}4$ m. Na kratší straně ($2$ m) je $2:0{,}4=5$ mezer, tj. $6$ květin i s rohovými; na delší straně ($6$ m) je $6:0{,}4=15$ mezer, tj. $16$ květin. Rozdíl je $16-6=10$.'},
  'B) o 10 květin',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5C 2025 – úloha 12',
  new List<String>{'Ze tří stejných kvádrů o rozměrech 7 cm, 5 cm a 4 cm jsme v rohu místnosti postavili stavbu jako na obrázku. Po černě vyznačené trase vedoucí po hranách kvádrů lezl od startu do cíle mravenec.','Jak dlouhá je vyznačená mravencova trasa?'},
  new List<String>{'A) méně než 53 cm','B) 53 cm','C) 55 cm','D) 56 cm','E) 57 cm'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"><polygon points="250,215 310,215 334,199 274,199" fill="#e9e9e9" stroke="#000"/><polygon points="310,265 310,215 334,199 334,249" fill="#cfcfcf" stroke="#000"/><polygon points="250,265 310,265 310,215 250,215" fill="#f6f6f6" stroke="#000"/><polygon points="160,188 240,188 264,172 184,172" fill="#e9e9e9" stroke="#000"/><polygon points="240,240 240,188 264,172 264,224" fill="#cfcfcf" stroke="#000"/><polygon points="160,240 240,240 240,188 160,188" fill="#f6f6f6" stroke="#000"/><polygon points="70,105 125,105 149,89 94,89" fill="#e9e9e9" stroke="#000"/><polygon points="125,205 125,105 149,89 149,189" fill="#cfcfcf" stroke="#000"/><polygon points="70,205 125,205 125,105 70,105" fill="#f6f6f6" stroke="#000"/><text x="60" y="120" font-size="12">Cíl</text><text x="320" y="255" font-size="12">Start</text><text x="40" y="165" font-size="11">7 cm</text><text x="95" y="118" font-size="11">4 cm</text><text x="190" y="205" font-size="11">7 cm</text><text x="285" y="205" font-size="11">5 cm</text><text x="330" y="235" font-size="11">4 cm</text></svg>',
  'stavba-kvadry.svg',
  'Schematický nákres stavby ze tří shodných kvádrů 7 cm krát 5 cm krát 4 cm sestavených do schodů, se startem a cílem.',
  'Schematický nákres (prostorová stavba – posuzuje se podle originálu)',
  new List<String>{'Vyznačená trasa vede po hranách kvádrů o rozměrech $7$ cm, $5$ cm a $4$ cm. Součet délek všech jejích úseků je $57$ cm.'},
  'E) 57 cm',
  2, 4, '3',
  new List<String>{'zs1','stereometrie','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
