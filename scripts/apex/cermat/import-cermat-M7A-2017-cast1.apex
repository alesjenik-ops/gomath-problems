String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M7A 2017 – úloha 1',
  new List<String>{'Vypočtěte:','$(-3-2)\\cdot(21-3\\cdot 8)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'V závorkách: $-3-2=-5$ a $21-3\\cdot 8=21-24=-3$.','Součin: $(-5)\\cdot(-3)=15$.'},
  '$15$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 2',
  new List<String>{'Vypočtěte:','$0{,}25\\cdot 400+0{,}4:0{,}01=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}25\\cdot 400=100$, $0{,}4:0{,}01=40$.','Celkem $100+40=140$.'},
  '$140$',
  2, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.','$\\frac{5}{4}\\cdot\\left(\\frac{1}{5}+\\frac{3}{7}\\right)=$'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'V závorce: $\\frac{1}{5}+\\frac{3}{7}=\\frac{7}{35}+\\frac{15}{35}=\\frac{22}{35}$.','Součin: $\\frac{5}{4}\\cdot\\frac{22}{35}=\\frac{110}{140}=\\frac{11}{14}$.'},
  '$\\frac{11}{14}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek uveďte zlomkem v základním tvaru. Uveďte postup řešení.','$\\frac{1:\\frac{3}{2}+\\frac{1}{3}}{\\frac{5}{6}+\\frac{1}{4}}=$'},
  null,
  5,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $1:\\frac{3}{2}+\\frac{1}{3}=\\frac{2}{3}+\\frac{1}{3}=1$.','Jmenovatel: $\\frac{5}{6}+\\frac{1}{4}=\\frac{10}{12}+\\frac{3}{12}=\\frac{13}{12}$.','Podíl: $1:\\frac{13}{12}=\\frac{12}{13}$.'},
  '$\\frac{12}{13}$',
  2, 5, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2017 – úloha 4',
  new List<String>{'Vyškrtnutím tří číslic z osmiciferného čísla $42\\,680\\,153$ vznikne pěticiferné číslo (např. vyškrtnutím číslic 6, 0, 1 dostaneme $42\\,853$).','Vyškrtněte tři číslice tak, abyste dostali:','4.1 co nejmenší číslo;','4.2 co nejmenší číslo dělitelné pěti.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Pořadí číslic se zachovává. Na první místo lze dostat nejméně 2 (vyškrtneme 4), pak co nejdříve 0 (vyškrtneme 6 a 8): zbývá $20\\,153$.','4.2 Číslo musí končit číslicí 0, nebo 5. Konec na 0 dává $42\\,680$; konec na 5 dává nejméně $26\\,015$ (vyškrtneme 4, 8 a poslední 3). Menší je $26\\,015$.'},
  '4.1: $20\\,153$; 4.2: $26\\,015$',
  2, 5, '4',
  new List<String>{'zs2','r7','aritmetika','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
