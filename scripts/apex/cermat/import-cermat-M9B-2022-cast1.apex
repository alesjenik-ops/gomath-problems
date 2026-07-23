String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
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
  'CERMAT M9B 2022 – úloha 1',
  new List<String>{'Vypočtěte: $(-6)^2-3\\cdot(-3)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(-6)^2=36$, $3\\cdot(-3)=-9$; tedy $36-(-9)=36+9=45$.'},
  '$45$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 2',
  new List<String>{'Body $A$, $B$, $C$ a $D$ představují čtyři čísla na číselné ose. Bod $B$ dělí (zleva) úsečku $AC$ v poměru $7:3$. Bod $B$ představuje číslo $10$, bod $C$ číslo $22$ a bod $D$ číslo $52$.','2.1 Určete, v jakém poměru dělí bod $C$ (zleva) úsečku $BD$. Poměr zapište v základním tvaru.','2.2 Určete číslo, které na číselné ose představuje bod $A$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"> <line x1="30" y1="70" x2="530" y2="70" stroke="#000" stroke-width="1.5"/> <polygon points="530,70 519,65 519,75" fill="#000"/> <line x1="95" y1="60" x2="95" y2="80" stroke="#000" stroke-width="1.5"/> <line x1="330" y1="60" x2="330" y2="80" stroke="#000" stroke-width="1.5"/> <line x1="385" y1="60" x2="385" y2="80" stroke="#000" stroke-width="1.5"/> <line x1="495" y1="60" x2="495" y2="80" stroke="#000" stroke-width="1.5"/> <text x="330" y="52" font-size="15" text-anchor="middle">10</text> <text x="385" y="52" font-size="15" text-anchor="middle">22</text> <text x="495" y="52" font-size="15" text-anchor="middle">52</text> <text x="95" y="98" font-size="15" font-style="italic" text-anchor="middle">A</text> <text x="330" y="98" font-size="15" font-style="italic" text-anchor="middle">B</text> <text x="385" y="98" font-size="15" font-style="italic" text-anchor="middle">C</text> <text x="495" y="98" font-size="15" font-style="italic" text-anchor="middle">D</text> <text x="212" y="118" font-size="14" text-anchor="middle">7   :   3</text> </svg>',
  'ciselna-osa.svg',
  'Číselná osa s body A, B, C, D; nad B je 10, nad C je 22, nad D je 52, pod B je poměr 7:3.',
  'Body A, B, C, D na číselné ose',
  new List<String>{'2.1 $|BC|=22-10=12$, $|CD|=52-22=30$; poměr $|BC|:|CD|=12:30=2:5$.','2.2 Úsek $|BC|=12$ odpovídá 3 dílům poměru $7:3$, jeden díl je $4$, tedy $|AB|=7\\cdot4=28$; číslo bodu $A$ je $10-28=-18$.'},
  '2.1: $2:5$; 2.2: $-18$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{7}{5}\\cdot\\frac{3}{8}\\cdot\\frac{10}{21}+\\frac{3}{10}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Součin: $\\frac{7\\cdot3\\cdot10}{5\\cdot8\\cdot21}=\\frac{210}{840}=\\frac{1}{4}$. Poté $\\frac{1}{4}+\\frac{3}{10}=\\frac{5}{20}+\\frac{6}{20}=\\frac{11}{20}$.'},
  '$\\frac{11}{20}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{1}{4}-\\frac{5}{8}}{3\\cdot\\frac{5}{12}}=$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{1}{4}-\\frac{5}{8}=\\frac{2}{8}-\\frac{5}{8}=-\\frac{3}{8}$. Jmenovatel: $3\\cdot\\frac{5}{12}=\\frac{15}{12}=\\frac{5}{4}$. Podíl: $-\\frac{3}{8}:\\frac{5}{4}=-\\frac{3}{8}\\cdot\\frac{4}{5}=-\\frac{3}{10}$.'},
  '$-\\frac{3}{10}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím: $x\\cdot x-x+2x^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$x\\cdot x-x+2x^2=x^2+2x^2-x=3x^2-x=x\\cdot(3x-1)$.'},
  '$x\\cdot(3x-1)$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 4.2',
  new List<String>{'Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $(5b-0{,}4a)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(5b)^2-2\\cdot5b\\cdot0{,}4a+(0{,}4a)^2=25b^2-4ab+0{,}16a^2$.'},
  '$25b^2-4ab+0{,}16a^2$',
  1, 3, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2022 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2n-3)\\cdot(4n-2)+(n-3)\\cdot(n+3)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(2n-3)(4n-2)=8n^2-4n-12n+6=8n^2-16n+6$; $(n-3)(n+3)=n^2-9$. Součet: $8n^2-16n+6+n^2-9=9n^2-16n-3$.'},
  '$9n^2-16n-3$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
