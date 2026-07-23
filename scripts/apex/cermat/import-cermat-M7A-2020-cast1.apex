String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M7A 2020 – úloha 1',
  new List<String>{'Pětina neznámého čísla je $5$.','Vypočtěte pětinásobek neznámého čísla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Neznámé číslo $x$: $x:5=5\\Rightarrow x=25$. Pětinásobek: $5\\cdot 25=125$.'},
  '$125$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 2.1',
  new List<String>{'Vypočtěte:','$5\\cdot(-3\\cdot 2)-21:(1-0{,}7)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5\\cdot(-6)-21:0{,}3=-30-70=-100$.'},
  '$-100$',
  2, 2, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 2.2',
  new List<String>{'Vypočtěte:','$\\frac{1}{0{,}01}:10-0{,}2\\cdot 50=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$100:10-10=10-10=0$.'},
  '$0$',
  1, 2, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\left(\\frac{5}{6}-\\frac{3}{8}\\right)-\\left(2-\\frac{11}{12}\\right)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{6}-\\frac{3}{8}=\\frac{20-9}{24}=\\frac{11}{24}$; $\\;2-\\frac{11}{12}=\\frac{13}{12}=\\frac{26}{24}$. Rozdíl $\\frac{11}{24}-\\frac{26}{24}=-\\frac{15}{24}=-\\frac{5}{8}$.'},
  '$-\\frac{5}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{2\\cdot\\frac{5}{6}-\\frac{1}{3}}{10}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $2\\cdot\\frac{5}{6}-\\frac{1}{3}=\\frac{5}{3}-\\frac{1}{3}=\\frac{4}{3}$. Celý zlomek: $\\frac{4}{3}:10=\\frac{4}{30}=\\frac{2}{15}$.'},
  '$\\frac{2}{15}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2020 – úloha 4.1',
  new List<String>{'Sjezdovka je o polovinu delší než lanovka. Jejich délky se liší o čtvrt kilometru.','Vypočtěte v metrech délku sjezdovky.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Délka lanovky $l$, sjezdovka $1{,}5\\,l$. Rozdíl $0{,}5\\,l=250$ m $\\Rightarrow l=500$ m. Sjezdovka $1{,}5\\cdot 500=750$ m.'},
  '$750$ m',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2020 – úloha 4.2',
  new List<String>{'Objem sudu je $1{,}1$ m³, objem kbelíku je $5\\,700$ cm³.','Ze sudu zcela naplněného vodou jsme odebrali $10$ plných kbelíků vody.','Vypočtěte, kolik litrů vody zbylo v sudu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Sud $1{,}1$ m³ $=1\\,100$ litrů. Kbelík $5\\,700$ cm³ $=5{,}7$ litru, $10$ kbelíků $=57$ litrů. Zbylo $1\\,100-57=1\\,043$ litrů.'},
  '$1\\,043$ litrů',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2020 – úloha 5',
  new List<String>{'Každý ze tří spolužáků měl zapsat co nejvíce hlavních měst evropských států. Adam zapsal $12$ hlavních měst, stejně jako Bětka, ale Eliška jich zapsala jen $6$. Mezi všemi zapsanými hlavními městy byla $2$ města zapsána třikrát, $7$ měst dvakrát a ostatní jen jedenkrát.','Vypočtěte,','5.1 kolik hlavních měst bylo zapsáno jen jedenkrát,','5.2 kolik různých hlavních měst bylo celkem zapsáno.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem bylo zapsáno $12+12+6=30$ měst (včetně opakování).','5.1 Vícekrát zapsaná: $2$ města třikrát ($6$ zápisů) a $7$ měst dvakrát ($14$ zápisů), celkem $20$ zápisů. Jen jedenkrát: $30-20=10$ měst.','5.2 Různých měst je $2+7+10=19$.'},
  '5.1: $10$ hlavních měst; 5.2: $19$ různých hlavních měst',
  3, 4, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
