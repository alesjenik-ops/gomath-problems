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
  'Zelený J6 – Vašek cestou do školy',
  new List<String>{'Vašek si dnes cestou do školy přispíšil. Šel o čtvrtinu rychleji než obvykle, a byl také ve škole o $6$ minut dříve než obvykle. Zato zpátky se loudal. Odcházel v půl druhé, šel ve srovnání s ránem poloviční rychlostí a ještě si cestu proti ránu o čtvrtinu prodloužil přes les.','6.1 Vypočtěte, kolik minut dnes Vaškovi trvala cesta do školy.','6.2 V kolik hodin dorazil Vašek ze školy domů?'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Obvyklá rychlost $v$, obvyklý čas $t$. Dnes rychlost $\\frac{5}{4}v$, čas $\\frac{4}{5}t$. Úspora $t-\\frac{4}{5}t=\\frac{1}{5}t=6$ min, tedy obvyklý čas $t=30$ min a dnešní cesta trvala $\\frac{4}{5}\\cdot 30=24$ minut.','6.2 Ranní dnešní cesta trvala $24$ min (vzdálenost $d$, rychlost $s$, takže $\\frac{d}{s}=24$). Zpět jde poloviční rychlostí $\\frac{s}{2}$ po trase o čtvrtinu delší, tj. $\\frac{5}{4}d$. Čas $=\\frac{\\frac{5}{4}d}{\\frac{s}{2}}=\\frac{5}{2}\\cdot\\frac{d}{s}=\\frac{5}{2}\\cdot 24=60$ min. Odešel v $13{:}30$, doma byl v $14{:}30$ (v půl třetí).'},
  '6.1: $24$ minut; 6.2: v půl třetí (ve $14{:}30$)',
  4, 8, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený J7.1 – zpožďování hodinek',
  new List<String>{'O kolik sekund za hodinu se zpožďují moje hodinky, jestliže jsem přesně týden po jejich seřízení zjistil, že proti přesnému času ukazují o $5$ minut a $36$ sekund méně?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5$ min $36$ s $=336$ s za týden. Týden má $7\\cdot 24=168$ hodin. $336:168=2$ s za hodinu.'},
  '$2$ s za hodinu',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený J7.2 – naplnění bazénu',
  new List<String>{'Za jak dlouho se naplní bazén vodou přitékající trubkou rychlostí $2$ litry za sekundu, jestliže objem bazénu je $20$ m³ a nyní je naplněn ze $40\\,\\%$? Dobu uveďte v hodinách a minutách (např. $3.40$ h).'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Zbývá naplnit $60\\,\\%$ z $20$ m³, tj. $12$ m³ $=12\\,000$ litrů. Čas $=12\\,000:2=6\\,000$ s $=100$ min $=1$ h $40$ min.'},
  '$1.40$ h',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený J7.3 – množství deště na zahradu',
  new List<String>{'Kolik hl vody napadlo včera na zahradu o ploše půl hektaru, jestliže se nám ve válcovitém zásobníku stojícím na zahradě za včerejšek zvýšila hladina vody o $2$ cm?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Déšť zvedl hladinu všude stejně o $2$ cm $=0{,}02$ m. Plocha $0{,}5$ ha $=5\\,000$ m². Objem $=5\\,000\\cdot 0{,}02=100$ m³ $=1\\,000$ hl.'},
  '$1\\,000$ hl',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
