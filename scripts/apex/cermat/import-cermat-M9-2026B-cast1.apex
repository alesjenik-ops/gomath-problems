String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD26C0T02';
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
  'CERMAT M9B 2026 – úloha 1',
  new List<String>{'Vypočtěte, o kolik cm² je plocha o obsahu $0{,}1$ m² větší než plocha o obsahu $20$ cm².'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Platí $0{,}1$ m² $=0{,}1\\cdot 10\\,000$ cm² $=1000$ cm². Rozdíl je $1000-20=980$ cm².'},
  'o $980$ cm²',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $3\\cdot\\left(\\frac{2}{3}-\\frac{7}{9}\\right)+\\frac{2}{3}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{2}{3}-\\frac{7}{9}=\\frac{6}{9}-\\frac{7}{9}=-\\frac{1}{9}$; $3\\cdot\\left(-\\frac{1}{9}\\right)=-\\frac{1}{3}$; $-\\frac{1}{3}+\\frac{2}{3}=\\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $1:\\frac{6}{5}-\\frac{1}{6}:5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1:\\frac{6}{5}=\\frac{5}{6}$; $\\frac{1}{6}:5=\\frac{1}{30}$; $\\frac{5}{6}-\\frac{1}{30}=\\frac{25}{30}-\\frac{1}{30}=\\frac{24}{30}=\\frac{4}{5}$.'},
  '$\\frac{4}{5}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 2.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem (uveďte celý postup řešení): $\\frac{1-\\frac{1}{4}}{2\\cdot\\frac{5}{8}-2}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $1-\\frac{1}{4}=\\frac{3}{4}$. Jmenovatel: $2\\cdot\\frac{5}{8}-2=\\frac{5}{4}-2=-\\frac{3}{4}$. Podíl: $\\frac{3}{4}:\\left(-\\frac{3}{4}\\right)=-1$.'},
  '$-1$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 3.1',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $5x-3x\\cdot 3-3\\cdot(-2x)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5x-9x+6x=2x$.'},
  '$2x$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 3.2',
  new List<String>{'Upravte a rozložte na součin vytknutím: $(a-2b)\\cdot b-b+2b^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(a-2b)\\cdot b-b+2b^2=ab-2b^2-b+2b^2=ab-b=b\\cdot(a-1)$.'},
  '$b\\cdot(a-1)$',
  1, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 3.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení): $(3y+y)\\cdot(y-1)+(1-2y)\\cdot(2y+1)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(3y+y)\\cdot(y-1)=4y\\cdot(y-1)=4y^2-4y$; $(1-2y)\\cdot(2y+1)=1-4y^2$. Součet: $4y^2-4y+1-4y^2=1-4y$.'},
  '$1-4y$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 4.1',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení): $\\frac{1}{2}\\cdot(3x+4)+5=\\frac{1}{2}\\cdot(2-x)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme dvěma: $(3x+4)+10=2-x$, tj. $3x+14=2-x$. Odtud $4x=-12$, tedy $x=-3$.'},
  '$x=-3$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2026 – úloha 4.2',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení): $\\frac{6+y}{5}=7-\\frac{8+5y}{20}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme dvaceti: $4\\cdot(6+y)=140-(8+5y)$, tj. $24+4y=132-5y$. Odtud $9y=108$, tedy $y=12$.'},
  '$y=12$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
