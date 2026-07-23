String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD26C0T01';
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
  'CERMAT M9A 2026 – úloha 1',
  new List<String>{'Pro čísla $A$, $B$, $C$ platí: $A=\\frac{2}{9}+\\frac{5}{18}$; $B=\\frac{2}{9}:\\frac{5}{18}$; číslo $C$ je aritmetický průměr čísel $A$ a $B$.','Zapište zlomkem v základním tvaru:','1.1 číslo $A$,','1.2 číslo $B$,','1.3 číslo $C$.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'1.1 $A=\\frac{2}{9}+\\frac{5}{18}=\\frac{4}{18}+\\frac{5}{18}=\\frac{9}{18}=\\frac{1}{2}$.','1.2 $B=\\frac{2}{9}:\\frac{5}{18}=\\frac{2}{9}\\cdot\\frac{18}{5}=\\frac{36}{45}=\\frac{4}{5}$.','1.3 $C=\\frac{1}{2}\\left(\\frac{1}{2}+\\frac{4}{5}\\right)=\\frac{1}{2}\\cdot\\frac{13}{10}=\\frac{13}{20}$.'},
  '1.1: $A=\\frac{1}{2}$; 1.2: $B=\\frac{4}{5}$; 1.3: $C=\\frac{13}{20}$',
  3, 4, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 2.1',
  new List<String>{'Vypočtěte: $(-1{,}5-1)\\cdot(-1{,}5+1)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(-2{,}5)\\cdot(-0{,}5)=1{,}25$.'},
  '$1{,}25$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{25}{28}\\cdot\\left(-\\frac{2}{5}\\right)}{\\frac{6}{7}:2+1}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{25}{28}\\cdot\\left(-\\frac{2}{5}\\right)=-\\frac{50}{140}=-\\frac{5}{14}$. Jmenovatel: $\\frac{6}{7}:2+1=\\frac{3}{7}+1=\\frac{10}{7}$.','Podíl: $-\\frac{5}{14}:\\frac{10}{7}=-\\frac{5}{14}\\cdot\\frac{7}{10}=-\\frac{35}{140}=-\\frac{1}{4}$.'},
  '$-\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 3.1',
  new List<String>{'Vypočtěte pro $a=7$: $9a^2-6a+1=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9\\cdot 7^2-6\\cdot 7+1=441-42+1=400$. (Také $9a^2-6a+1=(3a-1)^2=(3\\cdot 7-1)^2=20^2=400$.)'},
  '$400$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 3.2',
  new List<String>{'Upravte a rozložte na součin užitím vzorce: $1-2n+2n\\cdot(1-8n)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$1-2n+2n-16n^2=1-16n^2=(1+4n)\\cdot(1-4n)$.'},
  '$(1+4n)\\cdot(1-4n)$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 3.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $(x+2)\\cdot(1-x)-2x\\cdot\\left(-\\frac{1}{2}\\right)\\cdot x=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(x+2)(1-x)=x+2-x^2-2x=-x^2-x+2$. Dále $-2x\\cdot\\left(-\\frac{1}{2}\\right)\\cdot x=x^2$. Součet: $-x^2-x+2+x^2=2-x$.'},
  '$2-x$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 4.1',
  new List<String>{'Řešte rovnici: $0{,}5-(5-x)\\cdot 0{,}5=0{,}5\\cdot(1-9x)$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme dvěma: $1-(5-x)=1-9x$, tj. $1-5+x=1-9x$, $-4+x=1-9x$, $10x=5$, tedy $x=0{,}5$.'},
  '$x=0{,}5$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 4.2',
  new List<String>{'Řešte soustavu rovnic: $3x-y=11$; $3x+2y=-4$.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Odečtením první rovnice od druhé: $3y=-15$, tj. $y=-5$. Dosazením do první: $3x-(-5)=11$, $3x=6$, $x=2$.'},
  '$x=2$; $y=-5$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2026 – úloha 5',
  new List<String>{'Větší sud má o třetinu větší objem než menší sud. Objem většího sudu je $360$ litrů.','Vypočtěte v litrech objem menšího sudu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Větší sud má objem $\\frac{4}{3}$ objemu menšího sudu: $\\frac{4}{3}\\cdot V=360$, tedy $V=360\\cdot\\frac{3}{4}=270$ litrů.'},
  '$270$ litrů',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
