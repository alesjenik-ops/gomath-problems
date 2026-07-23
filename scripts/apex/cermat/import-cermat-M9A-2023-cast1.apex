String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
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
  'CERMAT M9A 2023 – úloha 1',
  new List<String>{'Celý film trvá $1$ hodinu. Doba, která ještě zbývá do konce filmu, je polovinou doby, která již uplynula od začátku filmu.','Vypočtěte, kolik minut zbývá do konce filmu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme uplynulou dobu $u$ a zbývající dobu $z$. Platí $z=\\frac{u}{2}$ a $u+z=60$ minut. Dosazením $u+\\frac{u}{2}=60$, tj. $\\frac{3u}{2}=60$, $u=40$ min. Zbývá tedy $z=60-40=20$ minut.'},
  '$20$ minut',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2023 – úloha 2.1',
  new List<String>{'Vnitřní objem sudu je $15$krát větší než objem kbelíku. Objem kbelíku je $5$krát větší než objem konvičky. Ze sudu plného vody jsme třetinu vody odebrali, takže v něm zbylo $60$ litrů vody.','Vypočtěte v litrech objem konvičky.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V sudu zbyly dvě třetiny, tedy $60$ litrů odpovídá $\\frac{2}{3}$ objemu sudu; plný sud má $60:\\frac{2}{3}=90$ litrů. Kbelík: $90:15=6$ litrů. Konvička: $6:5=1{,}2$ litru.'},
  '$1{,}2$ litru',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2023 – úloha 2.2',
  new List<String>{'Kvádr je možné beze zbytku rozřezat na $200$ krychlí, z nichž každá má objem $8$ dm³.','Vypočtěte, na kolik krychliček o objemu $1$ cm³ lze tento kvádr beze zbytku rozřezat.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Objem kvádru je $200\\cdot 8=1600$ dm³. Protože $1$ dm³ $=1000$ cm³, je objem kvádru $1600\\cdot 1000=1\\,600\\,000$ cm³, tj. lze jej rozřezat na $1\\,600\\,000$ krychliček o objemu $1$ cm³.'},
  '$1\\,600\\,000$ krychliček',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2023 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{5}{9}-\\dfrac{5}{9}:5=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{5}{9}:5=\\frac{5}{9}\\cdot\\frac{1}{5}=\\frac{1}{9}$. Tedy $\\frac{5}{9}-\\frac{1}{9}=\\frac{4}{9}$.'},
  '$\\dfrac{4}{9}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{4-7}{8}\\cdot\\dfrac{16}{21}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{4-7}{8}=\\frac{-3}{8}$. Dále $\\frac{-3}{8}\\cdot\\frac{16}{21}=\\frac{-3\\cdot 16}{8\\cdot 21}=\\frac{-48}{168}=-\\frac{2}{7}$.'},
  '$-\\dfrac{2}{7}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 3.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\dfrac{\\frac{3}{5}:\\left(\\frac{2}{5}+\\frac{1}{2}\\right)}{\\frac{7}{6}+\\frac{7}{10}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{2}{5}+\\frac{1}{2}=\\frac{4}{10}+\\frac{5}{10}=\\frac{9}{10}$, tedy $\\frac{3}{5}:\\frac{9}{10}=\\frac{3}{5}\\cdot\\frac{10}{9}=\\frac{2}{3}$. Jmenovatel: $\\frac{7}{6}+\\frac{7}{10}=\\frac{35}{30}+\\frac{21}{30}=\\frac{56}{30}=\\frac{28}{15}$. Podíl: $\\frac{2}{3}:\\frac{28}{15}=\\frac{2}{3}\\cdot\\frac{15}{28}=\\frac{30}{84}=\\frac{5}{14}$.'},
  '$\\dfrac{5}{14}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím:','$2\\cdot(x^2-x)+x=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2\\cdot(x^2-x)+x=2x^2-2x+x=2x^2-x=x\\cdot(2x-1)$.'},
  '$x\\cdot(2x-1)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2023 – úloha 4.2',
  new List<String>{'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky):','$\\left(\\dfrac{2}{3}a-3\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(\\frac{2}{3}a-3\\right)^2=\\left(\\frac{2}{3}a\\right)^2-2\\cdot\\frac{2}{3}a\\cdot 3+3^2=\\frac{4}{9}a^2-4a+9$.'},
  '$\\dfrac{4}{9}a^2-4a+9$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
