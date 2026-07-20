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
  'Zelený K6 – uzenář a separát',
  new List<String>{'Uzenář Kabiš z Postelce má problém. Inspektoři potravinářské inspekce při kontrole jeho párků zjistili, že maso sice tvoří $90\\,\\%$ hmotnosti párku (jak je uvedeno na obalu), ale třetinu masa výrobce nahrazuje tzv. separátem (hmotou z rozemletého masa a kostí). Cena separátu je ve srovnání s cenou masa pětinová.','6.1 Vypočtěte, jakou částku ušetří uzenář na výrobě $1$ tuny párků tím, že šidí, víme-li, že vstupní cena $1$ kg správného masa pro výrobu párků činí $60$ Kč.','6.2 Vypočtěte, jak vysokou pokutu by měli inspektoři uzenáři vystavit, aby se mu šizení masa nevyplatilo, jestliže ke kontrole dochází jednou za $18$ měsíců a ročně uzenář vyrobí v průměru $2000$ tun těchto párků.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 V $1$ tuně ($=1000$ kg) párků je masa $90\\,\\%$, tj. $900$ kg. Třetina masa je nahrazena separátem: $900:3=300$ kg. Maso stojí $60$ Kč/kg, separát pětinu, tj. $12$ Kč/kg. Úspora na $1$ kg náhrady je $60-12=48$ Kč, celkem $300\\cdot 48=14\\,400$ Kč.','6.2 Ročně ušetří $2000\\cdot 14\\,400=28\\,800\\,000$ Kč $=28{,}8$ mil. Kč. Mezi kontrolami je $18$ měsíců $=1{,}5$ roku, tedy ušetří $28{,}8\\cdot 1{,}5=43{,}2$ mil. Kč. Pokuta má být nejméně $43{,}2$ mil. Kč.'},
  '6.1: $14\\,400$ Kč; 6.2: nejméně $43{,}2$ mil. Kč',
  4, 8, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'Zelený K7.1 – drát na hřebíky',
  new List<String>{'Jak dlouhý drát potřebujeme k výrobě $10\\,000$ ks hřebíků o délce $40$ mm, jestliže k výrobě hlavičky hřebíku je třeba $1$ cm drátu? Délku drátu uveďte v km.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Na jeden hřebík: tělo $40$ mm $=4$ cm a hlavička $1$ cm, celkem $5$ cm. Pro $10\\,000$ ks: $10\\,000\\cdot 5=50\\,000$ cm $=500$ m $=0{,}5$ km.'},
  '$0{,}5$ km',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený K7.2 – hmotnost ocelových kuliček',
  new List<String>{'Jakou hmotnost má $100$ ocelových kuliček, každá o objemu $1$ cm³, jestliže $1$ m³ oceli váží $7{,}5$ tuny? Výsledek uveďte v kg.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$100$ kuliček má objem $100$ cm³. $1$ m³ $=1\\,000\\,000$ cm³ váží $7500$ kg, takže $1$ cm³ váží $0{,}0075$ kg. $100$ cm³ váží $0{,}75$ kg.'},
  '$0{,}75$ kg',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'Zelený K7.3 – skládání rychlostí',
  new List<String>{'Jakou rychlostí (viděno pozorovatelem na nástupišti) se pohybuje kulka vystřelená ve vlaku po směru jízdy, jestliže vlak jede rychlostí $72$ km/h a rychlost střely je $280$ m/s? Výslednou rychlost uveďte v km/h.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$280$ m/s $=280\\cdot 3{,}6=1008$ km/h. Rychlosti se sčítají: $1008+72=1080$ km/h.'},
  '$1080$ km/h',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
