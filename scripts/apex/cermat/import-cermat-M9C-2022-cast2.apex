String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD22C0T03';
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
  'CERMAT M9C 2022 – úloha 6',
  new List<String>{'V hruškovém království získal každý princ tolik zlatých hrušek, kolik si zasloužil. První princ získal nejméně hrušek. Druhý princ získal o třetinu více hrušek než první princ a třetí princ o 12 hrušek více než první princ. Počet zlatých hrušek, které získal první princ, označíme $x$.','6.1 Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal druhý princ.','6.2 Vyjádřete výrazem s proměnnou $x$, kolik hrušek získal třetí princ.','6.3 První a třetí princ získali dohromady dvakrát více hrušek než druhý princ. Vypočtěte, kolik hrušek získal první princ.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 O třetinu více než $x$: $x+\\dfrac{1}{3}x=\\dfrac{4}{3}x$.','6.2 O 12 více než $x$: $x+12$.','6.3 Rovnice $x+(x+12)=2\\cdot\\dfrac{4}{3}x$, tj. $2x+12=\\dfrac{8}{3}x$. Odtud $12=\\dfrac{2}{3}x$ a $x=18$.'},
  '6.1: $\\dfrac{4}{3}x$; 6.2: $x+12$; 6.3: $18$ hrušek',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2022 – úloha 7',
  new List<String>{'Pro soutěž Malování na chodník bylo připraveno celkem 300 kříd zabalených v krabičkách dvou velikostí – menších a větších. V krabičkách téže velikosti byl vždy stejný počet kříd. Menších krabiček bylo pouze 5 a celkem v nich bylo tolik kříd jako ve 3 větších krabičkách. Každá z větších krabiček obsahovala 10 kříd.','7.1 Určete počet kříd v jedné menší krabičce.','7.2 Určete počet všech větších krabiček s křídami.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Ve 3 větších krabičkách je $3\\cdot 10=30$ kříd, tolik je i v 5 menších krabičkách. Jedna menší krabička: $30:5=6$ kříd.','7.2 V menších krabičkách je $5\\cdot 6=30$ kříd, ve větších tedy $300-30=270$ kříd. Počet větších krabiček: $270:10=27$.'},
  '7.1: $6$ kříd; 7.2: $27$ větších krabiček',
  3, 4, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2022 – úloha 8',
  new List<String>{'Poličku na zeď tvoří tmavá obdélníková deska podepřená dvěma stejnými bílými trojúhelníkovými deskami. Tloušťku desek zanedbáváme.','8.1 Tmavý obdélník má obsah $270$ cm² a jeho kratší strana měří $9$ cm. Vypočtěte v cm obvod obdélníku.','8.2 Oba bílé trojúhelníky jsou pravoúhlé. V trojúhelníku má jedna odvěsna délku $9$ cm a nejdelší strana měří $15$ cm. Vypočtěte v cm² obsah jednoho trojúhelníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 290" font-family="sans-serif"> <polygon points="125,150 175,115 150,250" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="440,150 490,115 465,250" fill="#ffffff" stroke="#000" stroke-width="1.5"/> <polygon points="120,150 435,150 495,115 180,115" fill="#565656" stroke="#000" stroke-width="1.6"/> <text x="95" y="130" font-size="15" text-anchor="middle">9 cm</text> <text x="505" y="190" font-size="15">15 cm</text> </svg>',
  'policka.svg',
  'Polička – tmavá obdélníková deska podepřená dvěma bílými pravoúhlými trojúhelníkovými deskami.',
  'Schematický nákres poličky (rozměry dle zadání)',
  new List<String>{'8.1 Delší strana obdélníku: $270:9=30$ cm. Obvod $=2\\cdot(9+30)=78$ cm.','8.2 Druhá odvěsna: $\\sqrt{15^{2}-9^{2}}=\\sqrt{225-81}=\\sqrt{144}=12$ cm. Obsah $=\\dfrac{9\\cdot 12}{2}=54$ cm².'},
  '8.1: $78$ cm; 8.2: $54$ cm²',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
