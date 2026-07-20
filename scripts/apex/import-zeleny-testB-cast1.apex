String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený B1 – 2,5násobek a odmocnina',
  new List<String>{'Vypočtěte, kolikrát větší je $2{,}5$násobek čísla $16$ než jeho druhá odmocnina.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2{,}5$násobek: $2{,}5\\cdot 16=40$. Druhá odmocnina: $\\sqrt{16}=4$. Podíl $40:4=10$.'},
  '$10$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B2.1 – pořadí operací s desetinnými čísly',
  new List<String>{'Vypočtěte: $6{,}4+0{,}8:0{,}08-0{,}5:0{,}1=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejdřív dělení: $0{,}8:0{,}08=10$ a $0{,}5:0{,}1=5$. Potom $6{,}4+10-5=11{,}4$.'},
  '$11{,}4$',
  1, 2, '2',
  new List<String>{'zs2','r9','desetinna-cisla','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B2.2 – odmocnina, desetinné číslo a mocnina',
  new List<String>{'Vypočtěte: $\\sqrt{\\frac{1}{100}}+12{,}35-2^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{\\frac{1}{100}}=0{,}1$ a $2^2=4$. Potom $0{,}1+12{,}35-4=8{,}45$.'},
  '$8{,}45$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B3.1 – zlomek v základním tvaru',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{9}{2}-2{,}5\\right)\\cdot\\frac{1}{4}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{9}{2}-2{,}5=4{,}5-2{,}5=2$. Potom $2\\cdot\\frac{1}{4}=\\frac{1}{2}$.'},
  '$\\frac{1}{2}$',
  1, 2, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B3.2 – složený zlomek',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{4}{3}-\\frac{5}{6}}{\\frac{4}{3}+\\frac{5}{6}}:\\frac{12}{39}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{4}{3}-\\frac{5}{6}=\\frac{1}{2}$, jmenovatel $\\frac{4}{3}+\\frac{5}{6}=\\frac{13}{6}$. Podíl $\\frac{1}{2}:\\frac{13}{6}=\\frac{3}{13}$. Nakonec $\\frac{3}{13}:\\frac{12}{39}=\\frac{3}{13}\\cdot\\frac{39}{12}=\\frac{3}{4}$.'},
  '$\\frac{3}{4}$',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B4.1 – zjednodušení výrazu',
  new List<String>{'Zjednodušte výraz: $(3x-1)^2-(1+x^2)\\cdot 3+(1-x)^2=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(3x-1)^2=9x^2-6x+1$, $(1+x^2)\\cdot 3=3+3x^2$, $(1-x)^2=1-2x+x^2$. Součet: $9x^2-6x+1-3-3x^2+1-2x+x^2=7x^2-8x-1$.'},
  '$7x^2-8x-1$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B4.2 – zjednodušení výrazu s y',
  new List<String>{'Zjednodušte výraz: $\\frac{y^2}{3}-y\\cdot(2y-1)^2-\\frac{(2y-2)^2}{4}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$y\\cdot(2y-1)^2=y(4y^2-4y+1)=4y^3-4y^2+y$ a $\\frac{(2y-2)^2}{4}=\\frac{4y^2-8y+4}{4}=y^2-2y+1$. Dosazením: $\\frac{y^2}{3}-4y^3+4y^2-y-y^2+2y-1=-4y^3+\\frac{10}{3}y^2+y-1$.'},
  '$-4y^3+\\frac{10}{3}y^2+y-1$',
  2, 5, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $11-5x=2\\cdot(7x-4)$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$11-5x=14x-8$, tedy $19=19x$, odtud $x=1$.'},
  '$x=1$',
  2, 3, '2',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B5.2 – lineární rovnice se zlomkem',
  new List<String>{'Řešte rovnici: $\\frac{(y-2)\\cdot 4}{3}-2=2(y-3)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobením třemi: $4(y-2)-6=6(y-3)$, tedy $4y-8-6=6y-18$, odtud $4y-14=6y-18$, $4=2y$, $y=2$.'},
  '$y=2$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
