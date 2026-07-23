String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD25C0T01';
Integer YEAR = 2025;

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
  'CERMAT M9A 2025 - uloha 1',
  new List<String>{'Vypoctete, kolikrat je soucet cisel $16$ a $4$ vetsi nez druha odmocnina ze soucinu cisel $16$ a $4$.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Soucet $16+4=20$. Soucin $16\\cdot 4=64$, druha odmocnina $\\sqrt{64}=8$. Podil $20:8=2{,}5$.'},
  '$2{,}5$krat',
  1, 2, '1',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 2.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru: $(-3)\\cdot\\left(\\frac{3}{4}-\\frac{5}{6}\\right)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{4}-\\frac{5}{6}=\\frac{9}{12}-\\frac{10}{12}=-\\frac{1}{12}$; pak $(-3)\\cdot\\left(-\\frac{1}{12}\\right)=\\frac{3}{12}=\\frac{1}{4}$.'},
  '$\\frac{1}{4}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 2.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru; uvedte cely postup reseni.','$\\dfrac{\\;\\frac{\\sqrt{25}}{\\sqrt{2\\cdot 2}}\\;}{\\;\\frac{3\\cdot(3^2-2\\cdot 2)}{\\sqrt{5^2-4^2}}\\;}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel $\\frac{\\sqrt{25}}{\\sqrt{2\\cdot 2}}=\\frac{5}{2}$. Jmenovatel $\\frac{3\\cdot(3^2-2\\cdot 2)}{\\sqrt{5^2-4^2}}=\\frac{3\\cdot(9-4)}{\\sqrt{25-16}}=\\frac{15}{3}=5$. Celkem $\\frac{5}{2}:5=\\frac{5}{2}\\cdot\\frac{1}{5}=\\frac{1}{2}$.'},
  '$\\frac{1}{2}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 3.1',
  new List<String>{'Do ramecku doplnte takova cisla, aby platila rovnost: $(a+\\square)^2=a^2+18a+\\square$. Uvedte cisla doplnena do rameckU.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Podle vzorce $(a+b)^2=a^2+2ab+b^2$ je $2b=18$, tedy $b=9$; druhe cislo je $b^2=81$.'},
  '$9$; $81$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 3.2',
  new List<String>{'Upravte na co nejjednodussi tvar bez zavorek: $2-(n+2)\\cdot(-n)+(3-n)\\cdot(n+1)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-(n+2)\\cdot(-n)=n^2+2n$; $(3-n)(n+1)=-n^2+2n+3$. Celkem $2+n^2+2n-n^2+2n+3=4n+5$.'},
  '$4n+5$',
  1, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 3.3',
  new List<String>{'Upravte a vysledny vyraz rozlozte na soucin pomoci vzorce; uvedte cely postup reseni. $x\\cdot(18-x)+9\\cdot(16-2x)=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$x\\cdot(18-x)+9\\cdot(16-2x)=18x-x^2+144-18x=144-x^2$. Podle vzorce $a^2-b^2=(a+b)(a-b)$: $144-x^2=(12-x)(12+x)$.'},
  '$(12-x)\\cdot(12+x)$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 4.1',
  new List<String>{'Reste rovnici; uvedte cely postup reseni (zkousku nezapisujte).','$7\\cdot\\left(\\frac{4}{7}-\\frac{x}{10}\\right)-5\\cdot\\left(\\frac{x}{25}-\\frac{16}{5}\\right)=\\frac{1}{10}x$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$4-\\frac{7x}{10}-\\frac{x}{5}+16=\\frac{x}{10}$, tj. $20-\\frac{9x}{10}=\\frac{x}{10}$. Odtud $20=\\frac{10x}{10}=x$, tedy $x=20$.'},
  '$x=20$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2025 - uloha 4.2',
  new List<String>{'Reste rovnici; uvedte cely postup reseni (zkousku nezapisujte). $y-(y+5)\\cdot 0{,}1=0{,}9y+0{,}5$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$y-0{,}1y-0{,}5=0{,}9y+0{,}5$, tj. $0{,}9y-0{,}5=0{,}9y+0{,}5$. Po odecteni $0{,}9y$ zbude $-0{,}5=0{,}5$, coz neplati. Rovnice nema reseni.'},
  'Rovnice nema reseni.',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
