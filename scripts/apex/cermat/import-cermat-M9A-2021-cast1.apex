String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD21C0T01';
Integer YEAR = 2021;

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
  'CERMAT M9A 2021 – úloha 1',
  new List<String>{'Určete, na kolik $16$minutových intervalů lze rozdělit $1{,}6$ hodiny.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}6$ hodiny $=96$ minut; $96:16=6$, tedy na $6$ intervalů.'},
  'na $6$ intervalů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 2.1',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$0{,}3$ m² $-\\;52$ cm² $=\\;\\square$ cm²'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}3$ m² $=3\\,000$ cm²; $3\\,000-52=2\\,948$ cm².'},
  '$2\\,948$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 2.2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','$\\square$ dm³ $-\\;0{,}04$ m³ $=250$ cm³'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$250$ cm³ $=0{,}25$ dm³ a $0{,}04$ m³ $=40$ dm³, tedy $\\square=0{,}25+40=40{,}25$ dm³.'},
  '$40{,}25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\left(\\dfrac{5}{8}\\cdot\\dfrac{10}{9}-\\dfrac{4}{9}\\right):\\left(8\\cdot\\dfrac{1}{6}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{5}{8}\\cdot\\dfrac{10}{9}=\\dfrac{50}{72}=\\dfrac{25}{36}$; $\\dfrac{25}{36}-\\dfrac{4}{9}=\\dfrac{25-16}{36}=\\dfrac{9}{36}=\\dfrac{1}{4}$; $8\\cdot\\dfrac{1}{6}=\\dfrac{4}{3}$; $\\dfrac{1}{4}:\\dfrac{4}{3}=\\dfrac{1}{4}\\cdot\\dfrac{3}{4}=\\dfrac{3}{16}$.'},
  '$\\dfrac{3}{16}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','$\\dfrac{2-\\dfrac{13}{10}}{\\dfrac{5}{3}-\\dfrac{1}{2}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $2-\\dfrac{13}{10}=\\dfrac{20-13}{10}=\\dfrac{7}{10}$; jmenovatel: $\\dfrac{5}{3}-\\dfrac{1}{2}=\\dfrac{10-3}{6}=\\dfrac{7}{6}$; podíl $\\dfrac{7}{10}:\\dfrac{7}{6}=\\dfrac{7}{10}\\cdot\\dfrac{6}{7}=\\dfrac{6}{10}=\\dfrac{3}{5}$.'},
  '$\\dfrac{3}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 4.1',
  new List<String>{'Rozložte na součin podle vzorce.','$9a^2-30a+25=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9a^2-30a+25=(3a)^2-2\\cdot 3a\\cdot 5+5^2=(3a-5)^2$.'},
  '$(3a-5)^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 4.2',
  new List<String>{'Vynásobte (výsledný výraz nesmí obsahovat závorky).','$(3x+y)\\cdot(3x-2)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(3x+y)\\cdot(3x-2)=9x^2-6x+3xy-2y$.'},
  '$9x^2+3xy-6x-2y$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky).','$(4n-1)\\cdot(4n+1)-8n\\cdot(n-1)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(4n-1)(4n+1)=16n^2-1$ a $8n(n-1)=8n^2-8n$; $16n^2-1-(8n^2-8n)=8n^2+8n-1$.'},
  '$8n^2+8n-1$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$0{,}3\\cdot 2-0{,}5x\\cdot 2+0{,}4x=x+3{,}8$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}6-x+0{,}4x=x+3{,}8$; $0{,}6-0{,}6x=x+3{,}8$; $-1{,}6x=3{,}2$; $x=-2$.'},
  '$x=-2$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2021 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\dfrac{3}{4}\\cdot(4-y)+\\dfrac{3}{2}\\cdot(y+2)=6+\\dfrac{3y}{2}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$3-\\dfrac{3}{4}y+\\dfrac{3}{2}y+3=6+\\dfrac{3}{2}y$; $6+\\dfrac{3}{4}y=6+\\dfrac{3}{2}y$; $\\dfrac{3}{4}y-\\dfrac{3}{2}y=0$; $-\\dfrac{3}{4}y=0$; $y=0$.'},
  '$y=0$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
