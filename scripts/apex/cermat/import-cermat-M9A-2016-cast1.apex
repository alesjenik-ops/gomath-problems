String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M9A 2016 – úloha 1',
  new List<String>{'Vypočtěte, kolikrát je rozdíl čísel $1{,}4$ a $0{,}7$ (v tomto pořadí) menší než jejich součet.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Rozdíl: $1{,}4-0{,}7=0{,}7$. Součet: $1{,}4+0{,}7=2{,}1$.','$2{,}1:0{,}7=3$.'},
  '$3$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 2.1',
  new List<String>{'Vypočtěte: $0{,}5\\cdot 0{,}06-0{,}09:0{,}1=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5\\cdot 0{,}06=0{,}03$ a $0{,}09:0{,}1=0{,}9$.','$0{,}03-0{,}9=-0{,}87$.'},
  '$-0{,}87$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 2.2',
  new List<String>{'Vypočtěte: $\\left(9-\\sqrt{9}\\right)^2-\\left(\\sqrt{9}\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{9}=3$, tedy $(9-3)^2-3^2$.','$6^2-9=36-9=27$.'},
  '$27$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\frac{2-\\frac{3}{5}\\cdot\\frac{5}{2}}{2}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'V čitateli nejprve násobíme: $\\frac{3}{5}\\cdot\\frac{5}{2}=\\frac{3}{2}$.','Čitatel je $2-\\frac{3}{2}=\\frac{1}{2}$.','$\\frac{1}{2}:2=\\frac{1}{4}$.'},
  '$\\frac{1}{4}$',
  2, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru. Uveďte celý postup řešení.','$\\frac{3}{4}:\\frac{15}{2}-\\left(\\frac{3}{5}\\right)^2=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{3}{4}:\\frac{15}{2}=\\frac{3}{4}\\cdot\\frac{2}{15}=\\frac{6}{60}=\\frac{1}{10}$.','$\\left(\\frac{3}{5}\\right)^2=\\frac{9}{25}$.','$\\frac{1}{10}-\\frac{9}{25}=\\frac{5}{50}-\\frac{18}{50}=-\\frac{13}{50}$.'},
  '$-\\frac{13}{50}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 4.1',
  new List<String>{'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.','$(2x-3)^2+(12x-2x^2)=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$(2x-3)^2=4x^2-12x+9$.','$4x^2-12x+9+12x-2x^2=2x^2+9$.'},
  '$2x^2+9$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 4.2',
  new List<String>{'Zjednodušte. Výsledný výraz nesmí obsahovat závorky. Uveďte celý postup řešení.','$(2+y)(y-2)-2(y^2-1)=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$(2+y)(y-2)=y^2-4$ (rozdíl druhých mocnin).','$y^2-4-2y^2+2=-y^2-2$.'},
  '$-y^2-2$',
  2, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 5',
  new List<String>{'Řešte rovnici. Uveďte celý postup řešení (zkoušku nezapisujte).','$\\frac{6+5x}{6}-\\frac{1}{3}=\\frac{10}{9}x+1$'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme číslem 18: $3(6+5x)-6=20x+18$.','$18+15x-6=20x+18$, tedy $15x+12=20x+18$.','$-6=5x$, tedy $x=-\\frac{6}{5}$.'},
  '$x=-\\frac{6}{5}$',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2016 – úloha 6',
  new List<String>{'Farmář přivezl na trh brambory. Za první hodinu prodal dvě pětiny přivezených brambor, za druhou hodinu prodal pět šestin zbývajících brambor a během třetí hodiny doprodal posledních $40$ kg brambor.','6.1 Vyjádřete zlomkem, jaká část přivezených brambor zbyla farmářovi po první hodině prodeje.','6.2 Vypočtěte, kolik kilogramů brambor prodal farmář za druhou hodinu.','6.3 Vypočtěte, kolik kilogramů brambor přivezl farmář na trh.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Po první hodině zbylo $1-\\frac{2}{5}=\\frac{3}{5}$ přivezených brambor.','Za druhou hodinu prodal $\\frac{5}{6}$ z $\\frac{3}{5}$, tedy $\\frac{5}{6}\\cdot\\frac{3}{5}=\\frac{1}{2}$ všech přivezených brambor.','Po druhé hodině zbývá $\\frac{3}{5}-\\frac{1}{2}=\\frac{1}{10}$ přivezených brambor, což je $40$ kg.','6.3 Celkem přivezl $40\\cdot 10=400$ kg brambor.','6.2 Za druhou hodinu prodal $\\frac{1}{2}\\cdot 400=200$ kg brambor.'},
  '6.1: $\\frac{3}{5}$; 6.2: $200$ kg; 6.3: $400$ kg',
  4, 6, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
