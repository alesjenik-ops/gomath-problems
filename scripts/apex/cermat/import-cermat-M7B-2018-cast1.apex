String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M7B 2018 – úloha 1',
  new List<String>{'Vypočtěte, kolik procent je $400$ mililitrů z $5$ litrů.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5$ litrů $=5000$ ml. Podíl $\\frac{400}{5000}=0{,}08=8\\,\\%$.'},
  '$8\\,\\%$',
  1, 2, '2',
  new List<String>{'zs2','r7','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 2',
  new List<String>{'Doplňte do rámečku takové číslo, aby platila rovnost.','2.1 $\\frac{1}{4}$ hodiny $+\\,300$ sekund $=\\,\\square$ minut','2.2 $\\frac{1}{2}$ km $=\\,\\square\\cdot 40$ m'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'2.1 $\\frac{1}{4}$ hodiny $=15$ minut, $300$ sekund $=5$ minut; dohromady $20$ minut.','2.2 $\\frac{1}{2}$ km $=500$ m; $500:40=12{,}5$, tedy $500$ m $=12{,}5\\cdot 40$ m.'},
  '2.1: $20$; 2.2: $12{,}5$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 $\\frac{2}{3}\\cdot 0{,}25-\\frac{1}{4}\\cdot\\left(2-\\frac{2}{3}\\right)=$','3.2 $\\dfrac{\\frac{2+3}{6-2}:\\frac{15}{16}}{\\frac{3\\cdot 5}{3+5}-\\frac{1}{8}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 $\\frac{2}{3}\\cdot 0{,}25=\\frac{1}{6}$ a $\\frac{1}{4}\\cdot\\left(2-\\frac{2}{3}\\right)=\\frac{1}{4}\\cdot\\frac{4}{3}=\\frac{1}{3}$; tedy $\\frac{1}{6}-\\frac{1}{3}=-\\frac{1}{6}$.','3.2 Čitatel: $\\frac{5}{4}:\\frac{15}{16}=\\frac{5}{4}\\cdot\\frac{16}{15}=\\frac{4}{3}$. Jmenovatel: $\\frac{15}{8}-\\frac{1}{8}=\\frac{14}{8}=\\frac{7}{4}$. Podíl $\\frac{4}{3}:\\frac{7}{4}=\\frac{16}{21}$.'},
  '3.1: $-\\frac{1}{6}$; 3.2: $\\frac{16}{21}$',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2018 – úloha 4',
  new List<String>{'Maminka dala všechny upečené koláče na dva talíře ve stejném počtu. Jarda z prvního talíře 5 koláčů snědl a potom na něj přendal 3 koláče z druhého talíře. Emilka pak z talíře s větším počtem koláčů odebrala třetinu koláčů a dala si je do krabičky. Odnesla si tak v krabičce celkem 5 koláčů.','Určete','4.1 počet všech upečených koláčů (tj. na obou talířích dohromady);','4.2 počet koláčů, které zbyly na druhém talíři.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Na každém talíři bylo $n$ koláčů. Po Jardových přesunech je na 1. talíři $n-5+3=n-2$ koláčů, na 2. talíři $n-3$ koláčů. Více jich je na 1. talíři; Emilka z něj vzala třetinu, tj. 5 koláčů, takže na 1. talíři bylo $15$ koláčů: $n-2=15$, $n=17$.','4.1 Všech koláčů je $2n=34$.','4.2 Na druhém talíři zbylo $n-3=14$ koláčů.'},
  '4.1: $34$; 4.2: $14$',
  3, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2018 – úloha 5',
  new List<String>{'Jana si nahrála na několik CD všechny lekce němčiny, a to postupně od první lekce do poslední. Jednotlivá CD zaplňovala rovněž v pořadí od prvního do posledního CD. Na každém CD je stejný počet lekcí – nejméně 5, ale nejvíce 10. Jen jediná dvojice ze čtyř lekcí 11, 13, 31 a 33 je nahrána na stejném CD.','Určete, kolik lekcí může být na jednom CD. Uveďte všechna možná řešení.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Lekce číslo $L$ je na CD číslo $\\lceil L/k\\rceil$, kde $k$ je počet lekcí na CD. Pro $k=5,7,9,10$ jsou dvě dvojice na stejném CD; pro $k=6$ je spolu jen dvojice 31, 33; pro $k=8$ je spolu jen dvojice 11, 13.','Podmínku „právě jedna dvojice" splňuje $k=6$ a $k=8$.'},
  '$6$ lekcí nebo $8$ lekcí',
  3, 6, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
