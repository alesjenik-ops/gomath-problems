String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M5D 2026 – úloha 1.1',
  new List<String>{'Vypočtěte: $(8\\cdot 3+7\\cdot 4):2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(8\\cdot 3+7\\cdot 4):2=(24+28):2=52:2=26$.'},
  '$26$',
  1, 1, '1',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 1.2',
  new List<String>{'Vypočtěte: $300-(4+13\\cdot 4)+4=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$300-(4+13\\cdot 4)+4=300-(4+52)+4=300-56+4=248$.'},
  '$248$',
  1, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 1.3',
  new List<String>{'Vypočtěte: $20\\cdot 210-6\\,020:20+5\\cdot 60=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$20\\cdot 210-6\\,020:20+5\\cdot 60=4\\,200-301+300=4\\,199$.'},
  '$4\\,199$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 2',
  new List<String>{'2.1 Vypočtěte, o kolik centimetrů je jedna pětina metru delší než $80$ milimetrů.','2.2 Pět stejných krabiček váží dohromady o $50$ g méně než závaží o hmotnosti $1$ kg. Vypočtěte v gramech hmotnost jedné krabičky.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 Jedna pětina metru $=\\frac{100}{5}=20$ cm $=200$ mm; $80$ mm $=8$ cm. Rozdíl $20-8=12$ cm (tj. o $120$ mm).','2.2 Pět krabiček váží $1\\,000-50=950$ g, jedna krabička $950:5=190$ g.'},
  '2.1: o $12$ cm; 2.2: $190$ g',
  3, 4, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 3',
  new List<String>{'V malé rodinné pekárně pečou vánočky tří velikostí – malé splétají ze $3$ pramenů těsta, střední ze $6$ pramenů a velké z $9$ pramenů. Každý pramen těsta váží $200$ g.','3.1 Včera v pekárně upekli vánočky z $8\\,400$ g těsta. Z upečených vánoček byly $2$ velké, $2$ střední a zbývající byly malé. Určete, kolik vánoček včera v pekárně upekli.','3.2 Na zítřek přijali v pekárně objednávku na $36$ vánoček, z nichž čtvrtina má být malých, třetina velkých a zbytek středních. Určete v kg hmotnost těsta na celou tuto objednávku.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Velká vánočka má $9\\cdot 200=1\\,800$ g, střední $6\\cdot 200=1\\,200$ g, malá $3\\cdot 200=600$ g. Na $2$ velké a $2$ střední padne $3\\,600+2\\,400=6\\,000$ g, zbývá $8\\,400-6\\,000=2\\,400$ g na malé, tj. $2\\,400:600=4$ malé. Celkem $2+2+4=8$ vánoček.','3.2 Malých $36:4=9$, velkých $36:3=12$, středních $36-9-12=15$. Těsto: $9\\cdot 600+12\\cdot 1\\,800+15\\cdot 1\\,200=5\\,400+21\\,600+18\\,000=45\\,000$ g $=45$ kg.'},
  '3.1: $8$ vánoček; 3.2: $45$ kg',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
