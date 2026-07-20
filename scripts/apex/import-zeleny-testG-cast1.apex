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
  'Zelený G1 – osminásobek a pětina',
  new List<String>{'Vypočtěte, kolikrát větší je osminásobek čísla $6{,}28$ než jeho pětina.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'Osminásobek je $8\\cdot 6{,}28=50{,}24$, pětina je $6{,}28:5=1{,}256$. Podíl $50{,}24:1{,}256=40$ (obecně $\\frac{8x}{x/5}=40$).'},
  '$40$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G2.1 – zlomky a desetinná čísla',
  new List<String>{'Vypočtěte: $\\frac{7}{5}:0{,}14-0{,}8:\\frac{1}{5}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{5}:0{,}14=1{,}4:0{,}14=10$; $0{,}8:\\frac{1}{5}=0{,}8\\cdot 5=4$. Výsledek $10-4=6$.'},
  '$6$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G2.2 – odmocnina a druhá mocnina',
  new List<String>{'Vypočtěte: $\\frac{\\sqrt{0{,}04}}{0{,}1}\\cdot 0{,}5^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{0{,}04}=0{,}2$, tedy $\\frac{0{,}2}{0{,}1}=2$. Dále $0{,}5^2=0{,}25$. Výsledek $2\\cdot 0{,}25=0{,}5$.'},
  '$0{,}5$',
  1, 2, '2',
  new List<String>{'zs2','r9','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G3.1 – výraz se zlomky (desetinný výsledek)',
  new List<String>{'Vypočtěte a výsledek zapište jako desetinné číslo: $\\frac{3}{8}-0{,}2\\cdot\\left(\\frac{9}{2}+3\\right):1{,}5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{9}{2}+3=7{,}5$; $0{,}2\\cdot 7{,}5=1{,}5$; $1{,}5:1{,}5=1$. Výsledek $\\frac{3}{8}-1=0{,}375-1=-0{,}625$.'},
  '$-0{,}625$',
  1, 3, '2',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G3.2 – složený zlomek (desetinný výsledek)',
  new List<String>{'Vypočtěte a výsledek zapište jako desetinné číslo: $\\dfrac{-\\frac{6}{5}+3\\frac{1}{5}}{2+\\frac{2}{3}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $-1{,}2+3{,}2=2$. Jmenovatel: $2+\\frac{2}{3}=\\frac{8}{3}$. Výsledek $2:\\frac{8}{3}=\\frac{6}{8}=0{,}75$.'},
  '$0{,}75$',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G4.1 – úprava výrazu',
  new List<String>{'Zjednodušte: $(4x-y+3)\\cdot x-(y+x)\\cdot 5x=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(4x-y+3)x=4x^2-xy+3x$; $(y+x)\\cdot 5x=5xy+5x^2$. Rozdíl $4x^2-xy+3x-5xy-5x^2=3x-6xy-x^2$.'},
  '$3x-6xy-x^2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G4.2 – úprava výrazu se zlomkem',
  new List<String>{'Zjednodušte: $\\dfrac{(x^2-y^2)\\cdot(x+y)}{x-y}-2x^3y^2:yx^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{x^2-y^2}{x-y}=x+y$, proto první člen $=(x+y)^2$. Dále $2x^3y^2:(yx^2)=2xy$. Výsledek $(x+y)^2-2xy=x^2+y^2$.'},
  '$x^2+y^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G5.1 – lineární rovnice',
  new List<String>{'Řešte rovnici: $3x-2=\\frac{1}{3}\\cdot(x-2)-(5-2x)$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme třemi: $9x-6=(x-2)-3(5-2x)=7x-17$. Odtud $2x=-11$, tedy $x=-\\frac{11}{2}=-5{,}5$.'},
  '$x=-\\frac{11}{2}=-5{,}5$',
  2, 3, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G5.2 – lineární rovnice se zlomky',
  new List<String>{'Řešte rovnici: $2{,}5a-16-\\dfrac{7{,}5a+2}{3}=\\dfrac{\\frac{7}{3}a-3}{2}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme šesti: $15a-96-2(7{,}5a+2)=3\\left(\\frac{7}{3}a-3\\right)$, tj. $15a-96-15a-4=7a-9$. Odtud $-100=7a-9$, $7a=-91$, $a=-13$.'},
  '$a=-13$',
  2, 4, '3',
  new List<String>{'zs2','r9','linearni-rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
