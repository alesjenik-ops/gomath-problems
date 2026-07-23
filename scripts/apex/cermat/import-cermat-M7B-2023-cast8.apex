String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD23C0T02';
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
  'CERMAT M7B 2023 - uloha 16',
  new List<String>{'Zakladnim dilkem je 1. obdelnik, ktery je rozdeleny na bily ctverecek a sest stejne velkych trojuhelniku - bile prilehaji ke kratsim stranam obdelniku a sede k delsim stranam. Spojovanim zakladnich dilku vytvarime vetsi obdelniky podle pravidel: prilehaji k sobe pouze trojuhelniky teze barvy a jejich spojenim vznikaji dalsi ctverecky; delsi strana obdelniku je vzdy dvakrat delsi nez kratsi strana; v prvnim obdelniku prileha ke kratsi strane jeden bily trojuhelnik a v kazdem dalsim obdelniku vzdy o jeden bily trojuhelnik vice. Druhy obdelnik obsahuje 6 bilych a 4 sede ctverecky.','16.1 Urcete, kolik ctverecku (bilych i sedych dohromady) obsahuje 4. obdelnik.','16.2 Urcete, kolik sedych ctverecku obsahuje obdelnik se 45 bilymi ctverecky.','16.3 Urcete, kolik bilych ctverecku obsahuje obdelnik, ve kterem je bilych ctverecku o 7 vice nez sedych.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 190" font-family="sans-serif"> <rect x="30" y="60" width="44" height="22" fill="none" stroke="#000"/> <line x1="30" y1="60" x2="52" y2="82" stroke="#999"/><line x1="52" y1="60" x2="74" y2="82" stroke="#999"/> <text x="52" y="102" font-size="12" text-anchor="middle">1. obdelnik</text> <rect x="150" y="46" width="90" height="45" fill="none" stroke="#000"/> <line x1="150" y1="46" x2="195" y2="91" stroke="#999"/><line x1="195" y1="46" x2="240" y2="91" stroke="#999"/> <line x1="172" y1="46" x2="150" y2="68" stroke="#999"/><line x1="240" y1="68" x2="217" y2="91" stroke="#999"/> <text x="195" y="110" font-size="12" text-anchor="middle">2. obdelnik</text> <text x="195" y="126" font-size="11" text-anchor="middle">(6 bilych a 4 sede ctverecky)</text> <rect x="320" y="34" width="140" height="70" fill="none" stroke="#000"/> <line x1="320" y1="34" x2="390" y2="104" stroke="#999"/><line x1="390" y1="34" x2="460" y2="104" stroke="#999"/> <text x="390" y="122" font-size="12" text-anchor="middle">3. obdelnik</text> <text x="486" y="72" font-size="18">...</text> </svg>',
  'obdelniky.svg',
  'Rada obdelniku (1. az 3.) z bilych ctverecku a sedych trojuhelniku, delsi strana dvakrat delsi nez kratsi.',
  'Schematicky nakres rady obdelniku',
  new List<String>{'Pro $n$-ty obdelnik plati: pocet bilych ctverecku $B(n)=2n^2-n$, pocet sedych ctverecku $S(n)=2n^2-2n$ (overeni pro $n=2$: $B=6$, $S=4$).','16.1 Celkem $B(4)+S(4)=(2\\cdot 16-4)+(2\\cdot 16-8)=28+24=52$ ctverecku.','16.2 Z $2n^2-n=45$ plyne $n=5$, pak $S(5)=2\\cdot 25-10=40$ sedych ctverecku.','16.3 Rozdil $B(n)-S(n)=n=7$, tedy $B(7)=2\\cdot 49-7=91$ bilych ctverecku.'},
  '16.1: $52$ ctverecku; 16.2: $40$ sedych ctverecku; 16.3: $91$ bilych ctverecku',
  4, 8, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
