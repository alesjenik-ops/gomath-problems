String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2024 M9B · úloha 6',
  new List<String>{'Čtyřúhelník $ABCD$ je lichoběžník se základnami $AB$ a $CD$, přičemž úsečka $BD$ je jeho výška. Platí $|AD|=17\\ \\mathrm{cm}$, $|BD|=8\\ \\mathrm{cm}$ a obsah trojúhelníku $BCD$ je $24\\ \\mathrm{cm}^2$ (viz obrázek).','6.1 Vypočítejte obsah lichoběžníku $ABCD$ (v $\\mathrm{cm}^2$).','6.2 Vypočítejte obvod lichoběžníku $ABCD$ (v cm).'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 224"><path d="M4 219L455 219L455 220L4 220Z" style="fill:#231f20"/><path d="M455 4L456 4L456 219L455 219Z" style="fill:#231f20"/><path d="M455 219L456 219L456 220L455 220Z" style="fill:#231f20"/><path d="M455 219L456 219L456 220L455 220Z" style="fill:#231f20"/><path d="M112 175L281 86M280 86L348 86M281 175L348 86M112 175L282 175M281 86L281 175M262 174C262 164 270 156 280 156" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M273 167C273 167 274 167 274 167C274 167 274 167 274 167C274 167 274 168 274 168C274 168 273 167 273 167Z" style="fill:#231f20;stroke:#231f20;stroke-width:1"/></svg>',
  'obr.svg',
  'Lichoběžník ABCD se základnami AB, CD a výškou BD; AD=17 cm, BD=8 cm, obsah trojúhelníku BCD je 24 cm².',
  '',
  new List<String>{'$BD\\perp AB$, tedy v trojúhelníku $ABD$: $AB=\\sqrt{AD^2-BD^2}=\\sqrt{17^2-8^2}=15\\ \\mathrm{cm}$. Z obsahu $BCD$: $\\frac{CD\\cdot8}{2}=24\\Rightarrow CD=6\\ \\mathrm{cm}$.','6.1: $S=\\frac{15+6}{2}\\cdot8=84\\ \\mathrm{cm}^2$.','6.2: $BC=\\sqrt{6^2+8^2}=10\\ \\mathrm{cm}$; obvod $15+10+6+17=48\\ \\mathrm{cm}$.'},
  '6.1: $84\\ \\mathrm{cm}^2$; 6.2: $48\\ \\mathrm{cm}$',
  4, 5, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD24C0T02', 2024
);
c.add(
  'CERMAT 2024 M9B · úloha 7',
  new List<String>{'Petr sbírá modely aut. Druhý rok nasbíral o polovinu počtu modelů více než první rok. Třetí rok nasbíral $72$ modelů. Počet modelů z prvního roku označíme $x$.','7.1 Vyjádřete výrazem s proměnnou $x$, kolik modelů nasbíral druhý rok.','7.2 Vypočítejte, kolik modelů nasbíral první rok, pokud za tři roky nasbíral $217$ modelů.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: druhý rok $x+\\frac{1}{2}x=1{,}5x$.','7.2: $x+1{,}5x+72=217\\Rightarrow 2{,}5x=145\\Rightarrow x=58$.'},
  '7.1: $1{,}5x$; 7.2: $58$ modelů',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','rovnice','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PBD24C0T02', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
