String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD26C0T03';
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
  'CERMAT M9C 2026 – úloha 1',
  new List<String>{'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.','Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Celková doba jízdy je 7 hodin. Od 7:44 do 12:02 pan Červený jel 4 hodiny a 18 minut. Po 38minutové pauze na oběd znovu vyjel ve 12:40. Zbývá tedy dojet 2 hodiny a 42 minut (7 hodin bez 4 hodin 18 minut). Do cíle dorazil ve 12:40 plus 2 h 42 min, tj. v 15:22.'},
  '15:22 (tj. 3:22 odpoledne)',
  1, 4, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2026 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $\\frac{6}{5}:\\frac{9}{15}-2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{6}{5}:\\frac{9}{15}-2=\\frac{6}{5}\\cdot\\frac{15}{9}-2=2-2=0$.'},
  '$0$',
  1, 2, '1',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem: $\\frac{5}{44}\\cdot(-5{,}5)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{44}\\cdot(-5{,}5)=\\frac{5}{44}\\cdot\\left(-\\frac{11}{2}\\right)=-\\frac{55}{88}=-\\frac{5}{8}$.'},
  '$-\\frac{5}{8}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 2.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem (uveďte celý postup řešení): $\\dfrac{\\frac{5}{3}-\\frac{3}{5}}{\\frac{8}{7}\\cdot\\frac{14}{5}}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{5}{3}-\\frac{3}{5}=\\frac{25-9}{15}=\\frac{16}{15}$. Jmenovatel: $\\frac{8}{7}\\cdot\\frac{14}{5}=\\frac{16}{5}$.','Podíl: $\\frac{16}{15}:\\frac{16}{5}=\\frac{16}{15}\\cdot\\frac{5}{16}=\\frac{5}{15}=\\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  2, 4, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 3.1',
  new List<String>{'Rozložte na součin užitím vzorce: $6\\cdot 6-25a^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$36-25a^2=6^2-(5a)^2=(6+5a)\\cdot(6-5a)$.'},
  '$(6+5a)\\cdot(6-5a)$',
  1, 2, '1',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 3.2',
  new List<String>{'Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $4\\cdot\\left(n-\\frac{1}{2}\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4\\cdot\\left(n^2-2\\cdot n\\cdot\\frac{1}{2}+\\frac{1}{4}\\right)=4\\cdot\\left(n^2-n+\\frac{1}{4}\\right)=4n^2-4n+1$.'},
  '$4n^2-4n+1$',
  1, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 3.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení): $(3-x)\\cdot(3+x)+(x^2+2)\\cdot 3-2x\\cdot(x+1)=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$(9-x^2)+(3x^2+6)-(2x^2+2x)=9-x^2+3x^2+6-2x^2-2x$.','Sečtením: kvadratické členy $-x^2+3x^2-2x^2=0$, lineární $-2x$, absolutní $9+6=15$; výsledek $-2x+15$.'},
  '$-2x+15$',
  2, 4, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 4.1',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení): $2+\\frac{x-6}{7}-\\frac{x}{14}=\\frac{4+x}{2}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme rovnici číslem 14: $28+2\\cdot(x-6)-x=7\\cdot(4+x)$.','$28+2x-12-x=28+7x$, tj. $16+x=28+7x$, odtud $-12=6x$ a $x=-2$.'},
  '$x=-2$',
  2, 4, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2026 – úloha 4.2',
  new List<String>{'Řešte soustavu rovnic (uveďte celý postup řešení): $2x-3y=-6$,  $2x-y=2$.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Odečtením rovnic: $(2x-3y)-(2x-y)=-6-2$, tj. $-2y=-8$, takže $y=4$.','Dosazením do $2x-y=2$: $2x-4=2$, tedy $2x=6$ a $x=3$.'},
  '$x=3$, $y=4$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
