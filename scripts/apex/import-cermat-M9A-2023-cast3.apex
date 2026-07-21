String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, 1. řádný termín (M9A)';
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
  'CERMAT 2023 M9A · úloha 8',
  new List<String>{'Čtvercový pozemek má stejný obvod jako obdélníkový pozemek. Obdélníkový pozemek má jednu stranu o $25\\ \\%$ kratší než strana čtvercového pozemku a druhou stranu o $10\\ \\mathrm{m}$ delší než strana čtvercového pozemku. Délku strany čtvercového pozemku označíme $a$.','8.1 Vyjádřete výrazem s proměnnou $a$ délku kratší strany obdélníkového pozemku.','8.2 Vypočtěte v metrech délku $a$ strany čtvercového pozemku.','8.3 Vypočtěte, o kolik $\\mathrm{m}^2$ se liší obsahy obdélníkového a čtvercového pozemku.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: kratší strana obdélníku $=0{,}75a$ (o $25\\ \\%$ kratší).','8.2: stejný obvod: $4a=2\\big(0{,}75a+(a+10)\\big)\\Rightarrow 4a=3{,}5a+20\\Rightarrow a=40\\ \\mathrm{m}$.','8.3: čtverec $40^2=1\\,600$; obdélník $0{,}75\\cdot40\\cdot(40+10)=30\\cdot50=1\\,500$; rozdíl $100\\ \\mathrm{m}^2$.'},
  '8.1: $0{,}75a$; 8.2: $a=40\\ \\mathrm{m}$; 8.3: o $100\\ \\mathrm{m}^2$',
  4, 6, '4',
  new List<String>{'zs2','r9','vyrazy','rovnice','geometrie','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 9',
  new List<String>{'V rovině leží body $A$, $C$, $M$. Body $A$, $C$ jsou vrcholy obdélníku $ABCD$, bod $M$ leží na úhlopříčce $BD$ (viz obrázek).','Sestrojte vrcholy $B$, $D$ obdélníku $ABCD$, označte je a obdélník narýsujte.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Úhlopříčka $AC$ má střed $S$; obě úhlopříčky obdélníku se půlí a jsou stejně dlouhé, takže $B$, $D$ leží na kružnici se středem $S$ a poloměrem $|SA|$.','Úhlopříčka $BD$ prochází středem $S$ a bodem $M$; její průsečíky s kružnicí $(S,|SA|)$ jsou vrcholy $B$ a $D$.'},
  'Střed $S$ úhlopříčky $AC$; přímka $SM$ (úhlopříčka $BD$) protne kružnici $(S,|SA|)$ ve vrcholech $B$ a $D$.',
  2, 5, '4',
  new List<String>{'zs2','r9','konstrukce','geometrie','planimetrie','konstrukcni','rysovani','bez-kontextu'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
