String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD19C0T01';
Integer YEAR = 2019;

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
  'CERMAT M5A 2019 – úloha 1.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$216-144:(9+3)=\\square+4$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle pořadí operací $216-144:(9+3)=216-144:12=216-12=204$. Z rovnosti $204=\\square+4$ plyne $\\square=200$.'},
  '$200$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2019 – úloha 1.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost:','$9\\cdot 3\\,000-\\square=2\\,400+300$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9\\cdot 3\\,000=27\\,000$ a $2\\,400+300=2\\,700$. Z rovnosti $27\\,000-\\square=2\\,700$ plyne $\\square=24\\,300$.'},
  '$24\\,300$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2019 – úloha 2.1',
  new List<String>{'Automobil široký $1\\,770$ mm jel v jízdním pruhu širokém $3$ m $25$ cm. Jízdní pruh se zúžil o půl metru.','Vypočtěte, o kolik centimetrů je zúžený jízdní pruh širší než automobil.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Jízdní pruh $3$ m $25$ cm $=325$ cm; po zúžení o půl metru ($50$ cm) měří $275$ cm. Automobil je široký $1\\,770$ mm $=177$ cm. Rozdíl je $275-177=98$ cm.'},
  'o $98$ cm',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2019 – úloha 2.2',
  new List<String>{'Cesta z Prahy do Žiliny autobusem trvala $6$ hodin a $20$ minut, vlakem jen $4$ hodiny a $45$ minut.','Vypočtěte, o kolik minut trvala cesta autobusem déle než vlakem.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Autobusem $6$ h $20$ min $=380$ min, vlakem $4$ h $45$ min $=285$ min. Rozdíl je $380-285=95$ min.'},
  'o $95$ minut',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2019 – úloha 3',
  new List<String>{'Soutěže se zúčastnila čtvrtina žáků školy, ale někteří z nich soutěž nedokončili. Soutěž dokončilo pouze $76$ žáků školy, což je přesně sedmina žáků školy.','3.1 Určete počet všech žáků školy.','3.2 Určete počet žáků školy, kteří soutěž nedokončili.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Dokončilo $76$ žáků, což je sedmina školy, proto škola má $7\\cdot 76=532$ žáků.','3.2 Soutěže se zúčastnila čtvrtina, tj. $532:4=133$ žáků; z nich dokončilo $76$, takže nedokončilo $133-76=57$ žáků.'},
  '3.1: $532$ žáků; 3.2: $57$ žáků',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2019 – úloha 4',
  new List<String>{'Eva s Janou mají dohromady $220$ korun. Václav má o $60$ korun více než Jana, ale o $20$ korun méně než Eva.','4.1 Vypočtěte, o kolik korun se liší částky obou dívek.','4.2 Vypočtěte, kolik korun má Václav.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Eva má o $20$ korun více než Václav a Jana o $60$ korun méně než Václav, takže Eva má o $20+60=80$ korun více než Jana.','4.2 Označme Václavovu částku $V$. Pak Eva má $V+20$ a Jana $V-60$; z rovnice $(V+20)+(V-60)=220$ plyne $2V-40=220$, tedy $V=130$ korun.'},
  '4.1: o $80$ korun; 4.2: $130$ korun',
  3, 4, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5A 2019 – úloha 5',
  new List<String>{'Od školy k Martinovi domů vede jediná cesta. Tato cesta je dlouhá $450$ m. Martin na ní udělá víc kroků než jeho tatínek, neboť Martinův krok měří $60$ cm a tatínkův $90$ cm.','5.1 Vypočtěte, o kolik kroků více udělá na této cestě Martin než tatínek.','5.2 Martin jde opačným směrem než tatínek a oba se od sebe vzdalují. Vypočtěte, o kolik metrů se od sebe vzdálí, když každý udělá přesně $30$ kroků.','5.3 Martin šel od školy domů, odkud mu tatínek vyrazil naproti. Než se setkali, udělali oba stejný počet kroků. Vypočtěte, kolik kroků udělal Martin od školy k místu setkání.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Cesta $450$ m $=45\\,000$ cm. Martin udělá $45\\,000:60=750$ kroků, tatínek $45\\,000:90=500$ kroků; rozdíl je $250$ kroků.','5.2 Za $30$ kroků ujde Martin $30\\cdot 60=1\\,800$ cm $=18$ m a tatínek $30\\cdot 90=2\\,700$ cm $=27$ m; vzdálí se o $18+27=45$ m.','5.3 Oba udělají stejný počet kroků $n$; dohromady ujdou $60n+90n=150n=45\\,000$ cm, odtud $n=300$. Martin tedy udělal $300$ kroků.'},
  '5.1: o $250$ kroků; 5.2: o $45$ metrů; 5.3: $300$ kroků',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
