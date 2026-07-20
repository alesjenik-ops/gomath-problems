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
  'Zelený L6 – požární nádrž',
  new List<String>{'Jmenuji se Pavel. Na návsi máme požární nádrž. Je to vlastně kvádr široký $9$ metrů a dlouhý $15$ metrů. Seshora do ní přitéká trubkou voda. Hladina vody v nádrži je zajištěna přepadem ve výši $20$ cm pod korunou hráze. Přepad umožňuje za normálních okolností, aby z nádrže odtékalo až $10$ litrů vody za sekundu. Jenže přepad někdo v noci ucpal, a snížil tak nejvyšší možný odtok z nádrže o $90\\,\\%$. V 5.30 h ráno začala nádrž přetékat. Rozhodl jsem se vypátrat, kdy k ucpání odtoku došlo. Nejprve jsem změřil, že do nádrže přitéká každou minutu $120$ litrů vody...','6.1 Pomozte Pavlovi a vypočtěte, v kolik hodin došlo k ucpání odtoku.','6.2 Vypočtěte, za jak dlouho po uvolnění odtoku klesne hladina vody v nádrži na obvyklou úroveň.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Po ucpání se odtok snížil o $90\\,\\%$ na $1$ l/s, tj. $60$ l/min; přítok je $120$ l/min. Hladina stoupá o $120-60=60$ l/min. Aby nádrž začala přetékat, musela hladina stoupnout o $20$ cm; objem $9\\cdot 15\\cdot 0{,}2=27$ m³ $=27\\,000$ l. To trvá $27\\,000:60=450$ min $=7{,}5$ h. Přetékat začala v 5.30, ucpání tedy nastalo o $7{,}5$ h dříve, ve 22.00 h.','6.2 Po uvolnění odtéká $10$ l/s $=600$ l/min, přitéká $120$ l/min, hladina klesá o $600-120=480$ l/min. Nadbytek $27\\,000$ l zmizí za $27\\,000:480=56{,}25$ min $=56$ min $15$ s.'},
  '6.1: ve 22.00 h; 6.2: za 56 minut a 15 sekund',
  5, 9, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L7.1 – úhel ručiček v půl třetí',
  new List<String>{'Jaký úhel svírá na hodinovém ciferníku hodinová a minutová ručička v půl třetí?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V půl třetí míří minutová ručička na číslici $6$ (poloha $180^\\circ$) a hodinová je uprostřed mezi $2$ a $3$, tj. v poloze $2{,}5\\cdot 30^\\circ=75^\\circ$. Ručičky svírají úhel $180^\\circ-75^\\circ=105^\\circ$.'},
  '$105^\\circ$',
  1, 3, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený L7.2 – spotřeba vody koupáním',
  new List<String>{'Kolik m³ vody spotřebuje ročně naše $4$členná rodina koupáním, jestliže se každý z nás koupe jedenkrát denně a v průměru na $1$ koupání spotřebuje $100$ litrů vody? Počítejme s délkou roku $360$ dnů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Za den: $4\\cdot 100=400$ l. Za rok: $400\\cdot 360=144\\,000$ l $=144$ m³.'},
  '$144$ m³ vody',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L7.3 – čas odletu z Prahy',
  new List<String>{'Jaký byl čas našeho odletu z pražského letiště, jestliže jsme v New Yorku přistáli ráno v 5.50 h newyorského času, cesta z Prahy trvala 11.20 hodin a v New Yorku zapadá (vychází) slunce o $6$ hodin později než v Praze?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl časových pásem je $6$ hodin (v Praze je o $6$ h více). Přílet 5.50 newyorského času odpovídá 11.50 pražského času. Odečteme dobu letu 11 h 20 min: 11.50 − 11.20 = 0.30 h. Odlet byl v 0.30 h středoevropského času.'},
  '0.30 h středoevropského času',
  1, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
