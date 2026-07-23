String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD22C0T01';
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
  'CERMAT M9A 2022 – úloha 1',
  new List<String>{'Vypočtěte: $\\dfrac{7^2-\\sqrt{7^2}}{\\sqrt{49}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{7^2}=7$ a $\\sqrt{49}=7$, tedy $\\dfrac{49-7}{7}=\\dfrac{42}{7}=6$.'},
  '$6$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 2.1',
  new List<String>{'Obdélník má šířku $8$ cm a obsah $4$ dm².','Vypočtěte, o kolik cm se liší délka a šířka obdélníku.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4$ dm² $=400$ cm². Délka $=400:8=50$ cm, šířka je $8$ cm, rozdíl $50-8=42$ cm.'},
  'o $42$ cm',
  1, 2, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 2.2',
  new List<String>{'Vypočtěte, kolikrát větší je objem $1{,}2$ dm³ než objem $300$ mm³.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1{,}2$ dm³ $=1\\,200\\,000$ mm³; podíl $1\\,200\\,000:300=4\\,000$.'},
  '$4\\,000$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{8}{5}\\cdot\\left(\\dfrac{5}{6}\\cdot\\dfrac{7}{10}-\\dfrac{5}{6}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{5}{6}\\cdot\\dfrac{7}{10}=\\dfrac{35}{60}=\\dfrac{7}{12}$; $\\dfrac{7}{12}-\\dfrac{5}{6}=\\dfrac{7-10}{12}=-\\dfrac{1}{4}$; $\\dfrac{8}{5}\\cdot\\left(-\\dfrac{1}{4}\\right)=-\\dfrac{8}{20}=-\\dfrac{2}{5}$.'},
  '$-\\dfrac{2}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$\\dfrac{\\left(\\dfrac{4}{5}-\\dfrac{2}{3}\\right)\\cdot\\dfrac{5}{8}}{\\dfrac{2}{3}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{4}{5}-\\dfrac{2}{3}=\\dfrac{12-10}{15}=\\dfrac{2}{15}$; $\\dfrac{2}{15}\\cdot\\dfrac{5}{8}=\\dfrac{10}{120}=\\dfrac{1}{12}$; $\\dfrac{1}{12}:\\dfrac{2}{3}=\\dfrac{1}{12}\\cdot\\dfrac{3}{2}=\\dfrac{3}{24}=\\dfrac{1}{8}$.'},
  '$\\dfrac{1}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 4.1',
  new List<String>{'Z daného výrazu vytkněte $3y$:','$3y^2-9y+6xy=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3y^2-9y+6xy=3y\\cdot(y-3+2x)$.'},
  '$3y\\cdot(y-3+2x)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 4.2',
  new List<String>{'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky):','$\\left(x+\\dfrac{3}{2}\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\left(x+\\dfrac{3}{2}\\right)^2=x^2+2\\cdot x\\cdot\\dfrac{3}{2}+\\dfrac{9}{4}=x^2+3x+\\dfrac{9}{4}$.'},
  '$x^2+3x+\\dfrac{9}{4}$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky):','$(4+3n)\\cdot(3n-2n)-(n-1)\\cdot 5n=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$3n-2n=n$, tedy $(4+3n)\\cdot n=4n+3n^2$ a $(n-1)\\cdot 5n=5n^2-5n$; $4n+3n^2-(5n^2-5n)=-2n^2+9n$.'},
  '$-2n^2+9n$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 5.1',
  new List<String>{'Řešte rovnici:','$5\\cdot 0{,}4-3x:2=0{,}5x+7$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$2-1{,}5x=0{,}5x+7$; $-1{,}5x-0{,}5x=7-2$; $-2x=5$; $x=-2{,}5$.'},
  '$x=-2{,}5$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2022 – úloha 5.2',
  new List<String>{'Řešte rovnici:','$\\dfrac{3-y}{3}+\\dfrac{3}{5}\\cdot(y+1)+\\dfrac{y}{3}=y$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{3-y}{3}+\\dfrac{y}{3}=\\dfrac{3}{3}=1$, tedy $1+\\dfrac{3}{5}(y+1)=y$. Po vynásobení pěti: $5+3(y+1)=5y$; $5+3y+3=5y$; $8=2y$; $y=4$.'},
  '$y=4$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
