String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD19C0T01';
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
  'CERMAT M7A 2019 – úloha 1',
  new List<String>{'Vypočtěte, kolik procent je $150$ gramů ze tří čtvrtin kilogramu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Tři čtvrtiny kilogramu jsou $750$ g. Podíl $\\frac{150}{750}=\\frac{1}{5}=0{,}2$, tj. $20\\,\\%$.'},
  '$20\\,\\%$',
  1, 2, '2',
  new List<String>{'zs2','r7','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 2',
  new List<String>{'Vypočtěte.','2.1  $25\\cdot 0{,}2-0{,}2\\cdot 15=$','2.2  $0{,}03:(-0{,}12)-0{,}5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $25\\cdot 0{,}2-0{,}2\\cdot 15=5-3=2$.','2.2 $0{,}03:(-0{,}12)-0{,}5=-0{,}25-0{,}5=-0{,}75$.'},
  '2.1: $2$; 2.2: $-0{,}75$',
  3, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{6}{7}\\cdot\\left(\\frac{5}{6}-\\frac{3}{4}\\right)-1=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{6}-\\frac{3}{4}=\\frac{10-9}{12}=\\frac{1}{12}$; dále $\\frac{6}{7}\\cdot\\frac{1}{12}=\\frac{1}{14}$; a $\\frac{1}{14}-1=-\\frac{13}{14}$.'},
  '$-\\frac{13}{14}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\frac{9}{4}:\\frac{15}{2}}{3\\cdot\\frac{2}{15}+\\frac{2}{5}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{9}{4}:\\frac{15}{2}=\\frac{9}{4}\\cdot\\frac{2}{15}=\\frac{3}{10}$. Jmenovatel: $3\\cdot\\frac{2}{15}+\\frac{2}{5}=\\frac{2}{5}+\\frac{2}{5}=\\frac{4}{5}$. Podíl: $\\frac{3}{10}:\\frac{4}{5}=\\frac{3}{10}\\cdot\\frac{5}{4}=\\frac{3}{8}$.'},
  '$\\frac{3}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2019 – úloha 4',
  new List<String>{'4.1  Automobil široký $1\\,770$ mm jel v jízdním pruhu širokém $3$ m $25$ cm. Jízdní pruh se zúžil o půl metru. Vypočtěte, o kolik centimetrů je zúžený jízdní pruh širší než automobil.','4.2  Cesta z Prahy do Žiliny autobusem trvala $6$ hodin a $20$ minut, vlakem jen $4$ hodiny a $45$ minut. Vypočtěte, o kolik minut trvala cesta autobusem déle než vlakem.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Zúžený pruh $325-50=275$ cm; automobil $177$ cm; rozdíl $275-177=98$ cm.','4.2 Autobus $6$ h $20$ min $=380$ min, vlak $4$ h $45$ min $=285$ min; rozdíl $380-285=95$ min.'},
  '4.1: o $98$ cm; 4.2: o $95$ minut',
  3, 5, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2019 – úloha 5',
  new List<String>{'Martin má krok dlouhý $60$ cm a jeho tatínek $90$ cm. Od školy k nim domů vede jediná cesta a Martin na ní udělá $1\\,200$ kroků.','5.1 Vypočtěte, kolik kroků na této cestě udělá tatínek.','5.2 Tatínek vyrazil z domova naproti Martinovi, který šel touto cestou od školy domů. Než se setkali, udělali oba stejný počet kroků. Vypočtěte, kolik kroků udělal Martin od školy k místu setkání.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Délka cesty $60\\cdot 1\\,200=72\\,000$ cm; tatínek $72\\,000:90=800$ kroků.','5.2 Za stejný počet kroků $n$ ujdou dohromady celou cestu: $60n+90n=72\\,000$, tj. $150n=72\\,000$, $n=480$. Martin udělal $480$ kroků.'},
  '5.1: $800$ kroků; 5.2: $480$ kroků',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
