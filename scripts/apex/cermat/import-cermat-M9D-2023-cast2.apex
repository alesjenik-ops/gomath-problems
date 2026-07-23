String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 4.2',
  new List<String>{'Rozložte na součin podle vzorce: $49-(-4a)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$49-(-4a)^2=7^2-(4a)^2=(7+4a)\\cdot(7-4a)$.'},
  '$(7+4a)\\cdot(7-4a)$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 4.3',
  new List<String>{'Zjednodušte (výsledný výraz nesmí obsahovat závorky): $n\\cdot(2n-1)-(-2n-n)\\cdot(3n+2)+(1-2n)\\cdot(1+2n)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$n\\cdot(2n-1)=2n^2-n$; $-(-2n-n)\\cdot(3n+2)=3n\\cdot(3n+2)=9n^2+6n$; $(1-2n)\\cdot(1+2n)=1-4n^2$.','Součet: $2n^2-n+9n^2+6n+1-4n^2=7n^2+5n+1$.'},
  '$7n^2+5n+1$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 5.1',
  new List<String>{'Řešte rovnici: $\\frac{2-x}{2}+2x=2{,}5x-3$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme dvěma: $2-x+4x=5x-6$, tj. $2+3x=5x-6$. Odtud $8=2x$, tedy $x=4$.'},
  '$x=4$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 5.2',
  new List<String>{'Řešte rovnici: $3\\cdot\\frac{y+1}{2}-\\frac{y}{3}=\\frac{3}{2}\\cdot\\frac{2y-3}{3}+\\frac{3}{2}$'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovnici vynásobíme šesti: $9\\cdot(y+1)-2y=3\\cdot(2y-3)+9$, tj. $9y+9-2y=6y-9+9$, tedy $7y+9=6y$. Odtud $y=-9$.'},
  '$y=-9$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2023 – úloha 6',
  new List<String>{'V pátek, v sobotu a v neděli se na mýtině vysazovaly stromy. V sobotu bylo vysázeno o třetinu více stromů než v pátek. V neděli bylo vysázeno dokonce o 60 % více stromů než v pátek. Počet stromů vysázených v pátek označíme $p$.','6.1 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v sobotu.','6.2 Vyjádřete výrazem s proměnnou $p$ počet stromů vysázených v neděli.','6.3 V pátek bylo vysázeno o 290 stromů méně než v obou zbývajících dnech dohromady. Vypočtěte, kolik stromů bylo vysázeno v pátek.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 V sobotu bylo o třetinu více: $p+\\frac{1}{3}p=\\frac{4}{3}p$.','6.2 V neděli bylo o $60\\,\\%$ více: $p+0{,}6p=1{,}6p=\\frac{8}{5}p$.','6.3 Sobota a neděle dohromady dají $\\frac{4}{3}p+\\frac{8}{5}p=\\frac{20}{15}p+\\frac{24}{15}p=\\frac{44}{15}p$. Z rovnice $p=\\frac{44}{15}p-290$ plyne $\\frac{29}{15}p=290$, tedy $p=150$.'},
  '6.1: $\\frac{4}{3}p$; 6.2: $\\frac{8}{5}p$; 6.3: $150$ stromů',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2023 – úloha 7',
  new List<String>{'Na parkovišti je přesně 105 parkovacích míst pro osobní auta. Zaparkuje-li na parkovišti autobus, obsadí vždy 4 parkovací místa pro osobní auta. (Parkoviště tedy zcela zaplní např. 101 osobních aut a jeden autobus.)','7.1 Na zcela zaplněném parkovišti je počet osobních aut stejný jako počet autobusů. Vypočtěte, kolik je na parkovišti osobních aut.','7.2 Na zcela zaplněném parkovišti je osobních aut o čtvrtinu více než autobusů. Vypočtěte, kolik je na parkovišti autobusů.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Je-li osobních aut i autobusů po $n$, obsadí dohromady $n+4n=5n=105$ míst, tedy $n=21$. Osobních aut je $21$.','7.2 Autobusů je $b$, osobních aut $\\frac{5}{4}b$; obsadí $\\frac{5}{4}b+4b=\\frac{21}{4}b=105$ míst, odkud $b=20$. Autobusů je $20$.'},
  '7.1: $21$ osobních aut; 7.2: $20$ autobusů',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
