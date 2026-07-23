String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD23C0T03';
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
  'CERMAT M9C 2023 – úloha 1',
  new List<String>{'Vypočtěte, kolikrát je součet čísel $0{,}2$ a $0{,}5$ větší než jejich součin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Součet je $0{,}2+0{,}5=0{,}7$, součin je $0{,}2\\cdot 0{,}5=0{,}1$. Podíl $0{,}7:0{,}1=7$, součet je tedy $7$krát větší.'},
  '$7$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 2.1',
  new List<String>{'Vypočtěte: $4+6:2-5\\cdot(-3+5)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4+6:2-5\\cdot(-3+5)=4+3-5\\cdot 2=4+3-10=-3$.'},
  '$-3$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 2.2',
  new List<String>{'Vypočtěte: $\\sqrt{1{,}3^2-1{,}2^2}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{1{,}3^2-1{,}2^2}=\\sqrt{1{,}69-1{,}44}=\\sqrt{0{,}25}=0{,}5$.'},
  '$0{,}5$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $3\\cdot\\frac{2}{7}-\\frac{2}{7}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3\\cdot\\frac{2}{7}-\\frac{2}{7}=\\frac{6}{7}-\\frac{2}{7}=\\frac{4}{7}$.'},
  '$\\frac{4}{7}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $1-\\frac{14}{5}:2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{14}{5}:2=\\frac{14}{10}=\\frac{7}{5}$, proto $1-\\frac{7}{5}=\\frac{5}{5}-\\frac{7}{5}=-\\frac{2}{5}$.'},
  '$-\\frac{2}{5}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 3.3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{3}{4}+\\frac{4}{3}}{\\frac{5}{7}\\cdot\\frac{14}{3}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{3}{4}+\\frac{4}{3}=\\frac{9}{12}+\\frac{16}{12}=\\frac{25}{12}$. Jmenovatel: $\\frac{5}{7}\\cdot\\frac{14}{3}=\\frac{70}{21}=\\frac{10}{3}$. Podíl: $\\frac{25}{12}:\\frac{10}{3}=\\frac{25}{12}\\cdot\\frac{3}{10}=\\frac{75}{120}=\\frac{5}{8}$.'},
  '$\\frac{5}{8}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 4.1',
  new List<String>{'Rozložte na součin podle vzorce: $4a^2-9=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$4a^2-9=(2a)^2-3^2=(2a+3)\\cdot(2a-3)$.'},
  '$(2a+3)\\cdot(2a-3)$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 4.2',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2x-1)\\cdot\\frac{1}{2}-x=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2x-1)\\cdot\\frac{1}{2}-x=x-\\frac{1}{2}-x=-\\frac{1}{2}$.'},
  '$-\\frac{1}{2}$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(4n-3)^2-4n\\cdot(4n-3)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vytkneme společný činitel $(4n-3)$: $(4n-3)\\cdot[(4n-3)-4n]=(4n-3)\\cdot(-3)=-12n+9$. (Roznásobením: $16n^2-24n+9-(16n^2-12n)=-12n+9$.)'},
  '$-12n+9$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 5.1',
  new List<String>{'Řešte rovnici: $0{,}3\\cdot(2x+1)=0{,}2x-0{,}7$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}6x+0{,}3=0{,}2x-0{,}7$; po úpravě $0{,}4x=-1$, tedy $x=-2{,}5$.'},
  '$x=-2{,}5$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2023 – úloha 5.2',
  new List<String>{'Řešte rovnici: $y+\\frac{5y}{6}=\\frac{2y-1}{4}+\\frac{y+1}{2}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme dvanácti: $12y+10y=3\\cdot(2y-1)+6\\cdot(y+1)$, tj. $22y=6y-3+6y+6$, tedy $22y=12y+3$. Odtud $10y=3$ a $y=0{,}3$.'},
  '$y=0{,}3$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
