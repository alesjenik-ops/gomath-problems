String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
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
  'CERMAT M7C 2024 – úloha 15',
  new List<String>{'Babička si vzpomíná na výborný čaj proti kašli, ale zapomněla poměry, ve kterých se bylinky míchají. Vzpomíná si, že čaj byl z lipového květu, jitrocele a mateřídoušky. Lipový květ k jitroceli byl v poměru $2:3$ a jitrocel k mateřídoušce také v poměru $2:3$.','Rozhodněte o každém z tvrzení 15.1–15.3, zda je pravdivé (A), či nikoli (N).','15.1 Babička přidávala ke $100$ g lipového květu $150$ g jitrocele.','15.2 Lipový květ k mateřídoušce bude v poměru $2:3$.','15.3 Babička přidávala k $200$ g lipového květu $450$ g mateřídoušky.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Lipový květ : jitrocel $=2:3$ a jitrocel : mateřídouška $=2:3$. Sjednocením přes jitrocel dostaneme lipový květ : jitrocel : mateřídouška $=4:6:9$.','15.1 Lipový květ : jitrocel $=2:3=100:150$, ke $100$ g lipového květu tedy $150$ g jitrocele, tvrzení je pravdivé (A).','15.2 Lipový květ : mateřídouška $=4:9\\ne 2:3$, tvrzení je nepravdivé (N).','15.3 Lipový květ : mateřídouška $=4:9$; ke $200$ g lipového květu je $200\\cdot\\frac{9}{4}=450$ g mateřídoušky, tvrzení je pravdivé (A).'},
  '15.1: A; 15.2: N; 15.3: A',
  3, 5, '3',
  new List<String>{'zs2','r7','procenta','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2024 – úloha 16',
  new List<String>{'Jana naplánovala pro sebe a svou kamarádku Olinu výlet. Jedna třetina cesty vedla po rovině, tři čtvrtiny zbytku do kopce a posledních $800$ m z kopce.','16.1 Jaká byla délka celé cesty? Výsledek uveďte v kilometrech.','16.2 Cesta byla vyznačena na mapě s měřítkem $1:24\\,000$. Jak dlouhá byla cesta na této mapě? Výsledek uveďte v centimetrech.','16.3 $40\\,\\%$ cesty nesla batoh Jana. Kolik kilometrů nesla batoh Jana? Výsledek zaokrouhlete na desetiny kilometrů.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Rovinou vede $\\frac{1}{3}$ cesty, zbývají $\\frac{2}{3}$. Do kopce jsou $\\frac{3}{4}$ zbytku, tj. $\\frac{3}{4}\\cdot\\frac{2}{3}=\\frac{1}{2}$ cesty. Z kopce zbývá $\\frac{1}{4}\\cdot\\frac{2}{3}=\\frac{1}{6}$ cesty, a to je $800$ m.','16.1 Celá cesta $=6\\cdot 800=4800$ m $=4{,}8$ km.','16.2 $4{,}8$ km $=480\\,000$ cm; na mapě $480\\,000:24\\,000=20$ cm.','16.3 $40\\,\\%$ ze $4{,}8$ km je $1{,}92$ km $\\approx 1{,}9$ km.'},
  '16.1: $4{,}8$ km; 16.2: $20$ cm; 16.3: $1{,}9$ km',
  6, 8, '4',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
