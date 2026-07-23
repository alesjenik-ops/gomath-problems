String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD26C0T04';
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
  'CERMAT M9D 2026 – úloha 1',
  new List<String>{'Filip se učil házet oštěpem. Délka jeho prvního hodu byla $7$ m. Každý další hod byl o desetinu delší než předchozí hod.','Vypočtěte, o kolik cm byl Filipův třetí hod delší než první.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'První hod $7$ m. Druhý hod je o desetinu delší: $7\\cdot 1{,}1=7{,}7$ m. Třetí hod: $7{,}7\\cdot 1{,}1=8{,}47$ m. Rozdíl třetího a prvního hodu je $8{,}47-7=1{,}47$ m $=147$ cm.'},
  'o $147$ cm',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2026 – úloha 2.1',
  new List<String>{'Vypočtěte: $0{,}5\\cdot(-0{,}04)-100\\cdot 0{,}02=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5\\cdot(-0{,}04)-100\\cdot 0{,}02=-0{,}02-2=-2{,}02$.'},
  '$-2{,}02$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\left(\\frac{18}{14}\\cdot\\frac{7}{6}-1\\right):6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{18}{14}\\cdot\\frac{7}{6}=\\frac{9}{7}\\cdot\\frac{7}{6}=\\frac{3}{2}$; $\\frac{3}{2}-1=\\frac{1}{2}$; $\\frac{1}{2}:6=\\frac{1}{12}$.'},
  '$\\frac{1}{12}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 2.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru (uveďte celý postup řešení):','$\\left(\\frac{7}{2}-\\frac{1}{6}\\right):\\left(12-6\\cdot\\frac{3}{4}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{2}-\\frac{1}{6}=\\frac{21-1}{6}=\\frac{20}{6}=\\frac{10}{3}$; $12-6\\cdot\\frac{3}{4}=12-\\frac{9}{2}=\\frac{15}{2}$; $\\frac{10}{3}:\\frac{15}{2}=\\frac{10}{3}\\cdot\\frac{2}{15}=\\frac{20}{45}=\\frac{4}{9}$.'},
  '$\\frac{4}{9}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 3.1',
  new List<String>{'Vytkněte $(-x)$:','$-4x^2-x+8xy=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-4x^2-x+8xy=(-x)\\cdot(4x+1-8y)=(-x)\\cdot(4x-8y+1)$.'},
  '$(-x)\\cdot(4x-8y+1)$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 3.2',
  new List<String>{'Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky):','$\\frac{1}{2}\\cdot(2a+4)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{2}\\cdot(2a+4)^2=\\frac{1}{2}\\cdot(4a^2+16a+16)=2a^2+8a+8$.'},
  '$2a^2+8a+8$',
  1, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 3.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení):','$(2+2n)\\cdot(2-2n)-2\\cdot(n+1)+(4n-n)\\cdot 3n=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(2+2n)(2-2n)=4-4n^2$; $-2(n+1)=-2n-2$; $(4n-n)\\cdot 3n=3n\\cdot 3n=9n^2$. Součet: $4-4n^2-2n-2+9n^2=5n^2-2n+2$.'},
  '$5n^2-2n+2$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 4.1',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení):','$0{,}5\\cdot(3-5x)=0{,}25\\cdot(3x+6)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $100$: $50\\cdot(3-5x)=25\\cdot(3x+6)$, tj. $150-250x=75x+150$. Odtud $0=325x$, tedy $x=0$.'},
  '$x=0$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2026 – úloha 4.2',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení):','$\\frac{5}{3}\\cdot\\left(y-\\frac{3}{2}\\right)+\\frac{1}{2}\\cdot y=\\frac{5}{9}\\cdot(3y-9)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $18$: $30\\cdot\\left(y-\\frac{3}{2}\\right)+9y=10\\cdot(3y-9)$, tj. $30y-45+9y=30y-90$. Odtud $9y=-45$, tedy $y=-5$.'},
  '$y=-5$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
