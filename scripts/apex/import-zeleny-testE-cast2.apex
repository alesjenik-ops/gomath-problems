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
  'Zelený E6 – nádrže s olejem',
  new List<String>{'V nedaleké chemičce došlo k havárii a ze dvou nádrží musí být odčerpán všechen olej. Včera se z každé z nich podařilo odčerpat $72$ hl. Díky tomu v nádrži A klesl objem oleje ze $41\\,\\%$ na $23\\,\\%$ jejího maximálního objemu a v nádrži B ze $73\\,\\%$ na $64\\,\\%$ jejího maximálního objemu.','6.1 Vypočtěte, o kolik $\\%$ je větší nádrž B ve srovnání s nádrží A.','6.2 Vypočtěte, za kolik dnů ode dneška budou obě nádrže prázdné, jestliže se předpokládá, že denně je možné z každé nádrže odčerpat nejvýše $128$ hl oleje.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 V nádrži A odpovídá $72$ hl poklesu o $41-23=18\\,\\%$, tedy $V_A=72:0{,}18=400$ hl. V nádrži B poklesu o $73-64=9\\,\\%$, tedy $V_B=72:0{,}09=800$ hl. Nádrž B je $2$krát větší, tj. o $100\\,\\%$.','6.2 Zbývá odčerpat: v A $0{,}23\\cdot400=92$ hl (do jednoho dne), v B $0{,}64\\cdot800=512$ hl, tj. $512:128=4$ dny. Obě nádrže budou prázdné za $4$ dny.'},
  '6.1: o $100\\,\\%$; 6.2: za $4$ dny',
  4, 6, '3',
  new List<String>{'zs2','r9','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený E7.1 – balíčky do bedny',
  new List<String>{'Kolik balíčků o objemu $25$ cm³ můžete umístit do bedny o objemu $0{,}5$ m³?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5$ m³ $=500\\,000$ cm³. Počet balíčků $500\\,000:25=20\\,000$.'},
  '$20\\,000$ balíčků',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený E7.2 – vteřinová ručička',
  new List<String>{'Kolikrát oběhne do půlnoci vteřinová ručička hodinový ciferník, jestliže je ráno a hodiny ukazují za pět minut čtvrt na šest?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Za pět minut čtvrt na šest je $5{:}10$ ráno. Do půlnoci ($24{:}00$) zbývá $18$ hodin a $50$ minut, tj. $18\\cdot60+50=1\\,130$ minut. Vteřinová ručička oběhne ciferník jednou za minutu, tedy $1\\,130$krát.'},
  '$1\\,130$krát',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený E7.3 – hmotnost sněhu',
  new List<String>{'Jaká je hmotnost půl metru silné vrstvy sněhu na střeše o ploše $800$ m², víme-li, že rozpuštěním $1$ m³ vznikne $100$ litrů vody a $1$ dm³ vody váží $1$ kg? Výsledek uveďte v tunách.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Objem sněhu: $0{,}5\\cdot800=400$ m³. Vody vznikne $400\\cdot100=40\\,000$ litrů $=40\\,000$ dm³, což váží $40\\,000$ kg $=40$ tun.'},
  '$40$ tun',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
