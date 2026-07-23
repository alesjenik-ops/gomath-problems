String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD22C0T03';
Integer YEAR = 2022;

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
  'CERMAT M9C 2022 – úloha 1',
  new List<String>{'Vypočtěte: $\\dfrac{10^{2}\\cdot(10^{2}-1)}{10\\cdot 10^{2}+10^{2}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $10^{2}\\cdot(10^{2}-1)=100\\cdot 99=9\\,900$, jmenovatel $10\\cdot 10^{2}+10^{2}=1\\,000+100=1\\,100$. Podíl $9\\,900:1\\,100=9$.'},
  '$9$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 2.1',
  new List<String>{'Z kabelu dlouhého $5{,}1$ metru jsme uřízli tři půlmetrové kusy a zbytek jsme rozdělili na 12 stejně dlouhých dílů.','Určete, kolik centimetrů měří jeden díl.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Kabel měří $510$ cm, tři půlmetrové kusy $3\\cdot 50=150$ cm. Zbytek $510-150=360$ cm rozdělíme na 12 dílů: $360:12=30$ cm.'},
  '$30$ cm',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2022 – úloha 2.2',
  new List<String>{'Vypočtěte, kolik minut jsou tři pětiny z 1 hodiny 50 minut.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1$ hodina $50$ minut $=110$ minut. Tři pětiny: $\\dfrac{3}{5}\\cdot 110=66$ minut.'},
  '$66$ minut',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{1}{3}\\cdot\\left(5-\\dfrac{13}{5}\\right):20=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$5-\\dfrac{13}{5}=\\dfrac{25-13}{5}=\\dfrac{12}{5}$. Dále $\\dfrac{1}{3}\\cdot\\dfrac{12}{5}=\\dfrac{12}{15}=\\dfrac{4}{5}$ a $\\dfrac{4}{5}:20=\\dfrac{4}{100}=\\dfrac{1}{25}$.'},
  '$\\dfrac{1}{25}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{\\frac{2}{3}-\\frac{3}{2}}{\\frac{2}{3}:\\frac{3}{2}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\dfrac{2}{3}-\\dfrac{3}{2}=\\dfrac{4-9}{6}=-\\dfrac{5}{6}$. Jmenovatel: $\\dfrac{2}{3}:\\dfrac{3}{2}=\\dfrac{2}{3}\\cdot\\dfrac{2}{3}=\\dfrac{4}{9}$. Podíl: $-\\dfrac{5}{6}:\\dfrac{4}{9}=-\\dfrac{5}{6}\\cdot\\dfrac{9}{4}=-\\dfrac{45}{24}=-\\dfrac{15}{8}$.'},
  '$-\\dfrac{15}{8}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím:','$(4+x)\\cdot x+2x^{2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(4+x)\\cdot x+2x^{2}=4x+x^{2}+2x^{2}=3x^{2}+4x=x\\cdot(4+3x)$.'},
  '$x\\cdot(4+3x)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(y-3y)\\cdot(y+3y)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(y-3y)\\cdot(y+3y)=(-2y)\\cdot(4y)=-8y^{2}$.'},
  '$-8y^{2}$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(-n-1)^{2}+(1+4n)\\cdot(1+4n)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(-n-1)^{2}=n^{2}+2n+1$, $(1+4n)^{2}=16n^{2}+8n+1$. Součet $=17n^{2}+10n+2$.'},
  '$17n^{2}+10n+2$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$3\\cdot(2x-1)+\\dfrac{2}{3}=\\dfrac{2}{3}-(x+3)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$6x-3+\\dfrac{2}{3}=\\dfrac{2}{3}-x-3$. Po odečtení $\\dfrac{2}{3}$: $6x-3=-x-3$, tedy $6x=-x$, $7x=0$ a $x=0$.'},
  '$x=0$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\dfrac{y+1}{6}-\\dfrac{3y}{2}=2+\\dfrac{0{,}5-y}{3}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme 6: $(y+1)-9y=12+2\\cdot(0{,}5-y)$, tj. $-8y+1=13-2y$. Odtud $-6y=12$ a $y=-2$.'},
  '$y=-2$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
