String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD25C0T03';
Integer YEAR = 2025;

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
  'CERMAT M9C 2025 – úloha 6',
  new List<String>{'Do ložnice jsme přikoupili postel, noční stolek a skříň. Noční stolek byl o polovinu levnější než skříň, ale o třetinu dražší než postel. Cenu nočního stolku označíme $n$.','6.1 Vyjádřete výrazem s proměnnou $n$ cenu skříně.','6.2 Vyjádřete výrazem s proměnnou $n$ cenu postele.','6.3 Za všechny tři kusy nábytku jsme zaplatili celkem $9\\,000$ korun. Vypočtěte, kolik korun stál noční stolek.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Noční stolek je o polovinu levnější než skříň, tedy je poloviční: $n=\\frac{1}{2}\\cdot$ cena skříně. Cena skříně je $2n$.','6.2 Noční stolek je o třetinu dražší než postel: $n=\\frac{4}{3}\\cdot$ cena postele. Cena postele je $\\frac{3}{4}n$.','6.3 $n+2n+\\frac{3}{4}n=9\\,000$, tj. $\\frac{15}{4}n=9\\,000$, a proto $n=2\\,400$ korun.'},
  '6.1: $2n$; 6.2: $\\frac{3}{4}n$; 6.3: $2\\,400$ korun',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M9C 2025 – úloha 7',
  new List<String>{'Cyklista jel část své trasy po rovině, část klesal a zbytek trasy stoupal. Po rovině ujel třetinu délky celé trasy, a to průměrnou rychlostí $30$ km/h. Klesání bylo pětkrát kratší než celá trasa a cyklista ho sjížděl průměrnou rychlostí o $40\\,\\%$ vyšší, než jel po rovině. Stoupání bylo na $14$ km trasy a cyklista v něm měl průměrnou rychlost o polovinu nižší než při klesání.','7.1 Vypočtěte v km/h průměrnou rychlost cyklisty při klesání.','7.2 Vypočtěte v km délku celé cyklistovy trasy.','7.3 Vypočtěte v minutách, jak dlouho cyklista na své trase stoupal.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'7.1 Rychlost při klesání je o $40\\,\\%$ vyšší než $30$ km/h: $30\\cdot 1{,}4=42$ km/h.','7.2 Rovina je $\\frac{1}{3}$ trasy, klesání $\\frac{1}{5}$ trasy, stoupání $14$ km. Platí $L=\\frac{1}{3}L+\\frac{1}{5}L+14$, tj. $\\frac{7}{15}L=14$, a proto $L=30$ km.','7.3 Rychlost při stoupání je o polovinu nižší než při klesání: $\\frac{42}{2}=21$ km/h. Doba: $\\frac{14}{21}$ h $=\\frac{2}{3}$ h $=40$ minut.'},
  '7.1: $42$ km/h; 7.2: $30$ km; 7.3: $40$ minut',
  4, 8, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
