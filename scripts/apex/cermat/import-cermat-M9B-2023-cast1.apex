String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M9B 2023 – úloha 1',
  new List<String>{'Vypočtěte:','$\\sqrt{(-5)^2}-3^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{(-5)^2}=\\sqrt{25}=5$, tedy $5-3^2=5-9=-4$.'},
  '$-4$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 2',
  new List<String>{'Třídenní lyžařská permanentka je o $150\\,\\%$ dražší než jednodenní permanentka. Jednodenní permanentka stojí $600$ korun.','2.1 Vypočtěte, kolikrát více se zaplatí za třídenní permanentku než za jednodenní permanentku.','2.2 Vypočtěte, o kolik korun jsou 3 jednodenní permanentky dražší než 1 třídenní permanentka.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 Třídenní permanentka je o $150\\,\\%$ dražší, stojí tedy $600\\cdot(1+1{,}5)=600\\cdot 2{,}5=1\\,500$ korun. Je proto $1\\,500:600=2{,}5$krát dražší.','2.2 Tři jednodenní permanentky stojí $3\\cdot 600=1\\,800$ korun, jedna třídenní stojí $1\\,500$ korun. Rozdíl je $1\\,800-1\\,500=300$ korun.'},
  '2.1: $2{,}5$krát; 2.2: o $300$ korun',
  2, 4, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9B 2023 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\frac{1}{3}\\cdot\\frac{1}{2}-\\frac{8}{9}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{3}\\cdot\\frac{1}{2}=\\frac{1}{6}$; $\\frac{1}{6}-\\frac{8}{9}=\\frac{3}{18}-\\frac{16}{18}=-\\frac{13}{18}$.'},
  '$-\\frac{13}{18}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\left(2-\\frac{5}{6}\\right):\\frac{5}{3}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2-\\frac{5}{6}=\\frac{12-5}{6}=\\frac{7}{6}$; $\\frac{7}{6}:\\frac{5}{3}=\\frac{7}{6}\\cdot\\frac{3}{5}=\\frac{21}{30}=\\frac{7}{10}$.'},
  '$\\frac{7}{10}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 3.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\frac{\\frac{2}{3}+\\frac{2}{7}}{\\left(\\frac{9}{14}+\\frac{3}{2}\\right)\\cdot 2}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{2}{3}+\\frac{2}{7}=\\frac{14+6}{21}=\\frac{20}{21}$. Jmenovatel: $\\frac{9}{14}+\\frac{3}{2}=\\frac{9+21}{14}=\\frac{30}{14}=\\frac{15}{7}$, po vynásobení dvěma $\\frac{30}{7}$. Podíl: $\\frac{20}{21}:\\frac{30}{7}=\\frac{20}{21}\\cdot\\frac{7}{30}=\\frac{140}{630}=\\frac{2}{9}$.'},
  '$\\frac{2}{9}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím:','$x\\cdot(y-3)+3\\cdot(x-2y)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$x\\cdot(y-3)+3\\cdot(x-2y)=xy-3x+3x-6y=xy-6y=y\\cdot(x-6)$.'},
  '$y\\cdot(x-6)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 4.2',
  new List<String>{'Určete pomocí vzorce nejjednodušší výraz, kterým je třeba vynásobit výraz $3a-2^2$, abychom získali výraz $9a^2-16$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $9a^2-16=(3a)^2-4^2=(3a-4)\\cdot(3a+4)$ a $3a-2^2=3a-4$. Hledaný výraz je tedy $3a+4$.'},
  '$3a+4$',
  1, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky). Uveďte celý postup řešení.','$(3n+2)^2-n\\cdot(3n+4)+(2n-n)\\cdot n=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$(3n+2)^2=9n^2+12n+4$; $n\\cdot(3n+4)=3n^2+4n$; $(2n-n)\\cdot n=n\\cdot n=n^2$. Celkem $9n^2+12n+4-(3n^2+4n)+n^2=7n^2+8n+4$.'},
  '$7n^2+8n+4$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 5.1',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení.','$2+0{,}5\\cdot(x-3)=0{,}4\\cdot(1{,}5x+2)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$2+0{,}5x-1{,}5=0{,}6x+0{,}8$, tj. $0{,}5x+0{,}5=0{,}6x+0{,}8$. Odtud $0{,}5-0{,}8=0{,}6x-0{,}5x$, tedy $-0{,}3=0{,}1x$ a $x=-3$.'},
  '$x=-3$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
