String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD24C0T03';
Integer YEAR = 2024;

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
  'CERMAT M9C 2024 – úloha 1',
  new List<String>{'Města Jihlava a Třebíč mají dohromady $86\\,200$ obyvatel. Jihlava má o $16\\,000$ obyvatel více.','Kolik obyvatel má Třebíč?'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet obyvatel Třebíče $t$. Jihlava má $t+16\\,000$ obyvatel a platí $t+(t+16\\,000)=86\\,200$, tj. $2t=70\\,200$, tedy $t=35\\,100$.'},
  '$35\\,100$ obyvatel',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2024 – úloha 2',
  new List<String>{'Dvě válcové nádoby $A$ a $B$ mají stejnou výšku $v=20$ cm. Nádoba $A$ má průměr podstavy $d_1=10$ cm, nádoba $B$ má průměr podstavy $d_2=20$ cm. Nádoba $A$ je naplněna až po okraj vodou, nádoba $B$ je prázdná (viz obrázek).','Do jaké výšky bude sahat voda v nádobě $B$, pokud všechnu vodu z nádoby $A$ přelijeme do nádoby $B$?'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"> <path d="M82 55 L82 190 A28 9 0 0 0 138 190 L138 55" fill="#cfe3f5" stroke="#000"/> <ellipse cx="110" cy="55" rx="28" ry="9" fill="#cfe3f5" stroke="#000"/> <text x="110" y="128" font-size="16" text-anchor="middle" font-style="italic">A</text> <line x1="82" y1="205" x2="138" y2="205" stroke="#444"/> <text x="110" y="220" font-size="12" text-anchor="middle">10 cm</text> <path d="M238 55 L238 190 A52 14 0 0 0 342 190 L342 55" fill="#ffffff" stroke="#000"/> <ellipse cx="290" cy="55" rx="52" ry="14" fill="#ffffff" stroke="#000"/> <text x="290" y="128" font-size="16" text-anchor="middle" font-style="italic">B</text> <line x1="238" y1="212" x2="342" y2="212" stroke="#444"/> <text x="290" y="227" font-size="12" text-anchor="middle">20 cm</text> <line x1="410" y1="55" x2="410" y2="190" stroke="#444"/> <text x="418" y="128" font-size="12">20 cm</text> </svg>',
  'valce-AB.svg',
  'Dvě válcové nádoby stejné výšky 20 cm: užší nádoba A (průměr 10 cm) naplněná vodou a širší prázdná nádoba B (průměr 20 cm).',
  'Válcové nádoby A a B',
  new List<String>{'Objem vody se přeléváním nemění. Poloměr nádoby $A$ je $5$ cm, poloměr nádoby $B$ je $10$ cm. Z rovnosti objemů $\\pi\\cdot 5^2\\cdot 20=\\pi\\cdot 10^2\\cdot h$ plyne $h=\\frac{25\\cdot 20}{100}=5$ cm. (Průměr $B$ je dvojnásobný, obsah podstavy čtyřnásobný, proto výška hladiny klesne na čtvrtinu.)'},
  '$5$ cm',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2024 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\frac{7}{5}+3{,}3-\\frac{1}{2}}{\\frac{1}{15}+\\frac{1}{3}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{7}{5}+3{,}3-\\frac{1}{2}=1{,}4+3{,}3-0{,}5=4{,}2$. Jmenovatel: $\\frac{1}{15}+\\frac{1}{3}=\\frac{1}{15}+\\frac{5}{15}=\\frac{6}{15}=\\frac{2}{5}=0{,}4$. Podíl: $4{,}2:0{,}4=\\frac{21}{2}$.'},
  '$\\frac{21}{2}$',
  2, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{1}{2}+\\frac{1}{3}:\\frac{5}{6}\\right)-\\frac{7}{2}+\\frac{3}{5}:\\frac{3}{2}-1=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{1}{3}:\\frac{5}{6}=\\frac{1}{3}\\cdot\\frac{6}{5}=\\frac{2}{5}$, proto $\\frac{1}{2}+\\frac{2}{5}=\\frac{9}{10}$. Dále $\\frac{3}{5}:\\frac{3}{2}=\\frac{3}{5}\\cdot\\frac{2}{3}=\\frac{2}{5}$. Celkem $\\frac{9}{10}-\\frac{7}{2}+\\frac{2}{5}-1=\\frac{9-35+4-10}{10}=-\\frac{32}{10}=-\\frac{16}{5}$.'},
  '$-\\frac{16}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 4.1',
  new List<String>{'Umocněte a zjednodušte; výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{b}{3}-3b\\right)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{b}{3}-3b=\\frac{b-9b}{3}=-\\frac{8b}{3}$, po umocnění $\\left(-\\frac{8b}{3}\\right)^2=\\frac{64}{9}b^2$.'},
  '$\\frac{64}{9}b^2$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2024 – úloha 4.2',
  new List<String>{'Upravte a výsledný výraz rozložte na součin pomocí vzorců: $5-(1-x^2)-x\\cdot 2x=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5-(1-x^2)-x\\cdot 2x=5-1+x^2-2x^2=4-x^2=(2+x)\\cdot(2-x)$.'},
  '$(2+x)\\cdot(2-x)$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
