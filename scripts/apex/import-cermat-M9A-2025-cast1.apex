String SRC   = 'CERMAT – Jednotná přijímací zkouška 2025, 1. řádný termín (M9A)';
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
  'CERMAT 2025 M9A · úloha 1',
  new List<String>{'Vypočtěte, kolikrát je součet čísel $16$ a $4$ větší než druhá odmocnina ze součinu čísel $16$ a $4$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Součet: $16+4=20$. Odmocnina ze součinu: $\\sqrt{16\\cdot4}=\\sqrt{64}=8$.','$20:8=2{,}5$.'},
  '$2{,}5$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','mocniny-odmocniny','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','2.1 \\quad $(-3)\\cdot\\left(\\dfrac{3}{4}-\\dfrac{5}{6}\\right)=$','2.2 \\quad $\\dfrac{\\dfrac{\\sqrt{25}}{\\sqrt{2\\cdot2}}}{\\dfrac{3\\cdot(3^2-2\\cdot2)}{\\sqrt{5^2-4^2}}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $(-3)\\cdot\\left(\\frac{9}{12}-\\frac{10}{12}\\right)=(-3)\\cdot\\left(-\\frac{1}{12}\\right)=\\frac{1}{4}$.','2.2: čitatel $\\frac{\\sqrt{25}}{\\sqrt{4}}=\\frac{5}{2}$; jmenovatel $\\frac{3\\cdot(9-4)}{\\sqrt{9}}=\\frac{15}{3}=5$; celkem $\\frac{5}{2}:5=\\frac{1}{2}$.'},
  '2.1: $\\frac{1}{4}$; 2.2: $\\frac{1}{2}$',
  3, 5, '3',
  new List<String>{'zs2','r9','zlomky','mocniny-odmocniny','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 3',
  new List<String>{'3.1 Do rámečků doplňte taková čísla, aby platila rovnost: $(a+\\square)^2=a^2+18a+\\square$.','3.2 Upravte na co nejjednodušší tvar bez závorek: $2-(n+2)\\cdot(-n)+(3-n)\\cdot(n+1)=$','3.3 Upravte a výsledný výraz rozložte na součin pomocí vzorce: $x\\cdot(18-x)+9\\cdot(16-2x)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $(a+9)^2=a^2+18a+81$, do rámečků $9$ a $81$.','3.2: $2+(n^2+2n)+(3n+3-n^2-n)=4n+5$.','3.3: $18x-x^2+144-18x=144-x^2=(12-x)(12+x)$.'},
  '3.1: $9$ a $81$; 3.2: $4n+5$; 3.3: $(12-x)(12+x)$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);
c.add(
  'CERMAT 2025 M9A · úloha 4',
  new List<String>{'Řešte rovnici:','4.1 \\quad $7\\cdot\\left(\\dfrac{4}{7}-\\dfrac{x}{10}\\right)-5\\cdot\\left(\\dfrac{x}{25}-\\dfrac{16}{5}\\right)=\\dfrac{1}{10}x$','4.2 \\quad $y-(y+5)\\cdot0{,}1=0{,}9y+0{,}5$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $4-\\frac{7x}{10}-\\frac{x}{5}+16=\\frac{x}{10}\\Rightarrow 20-\\frac{9x}{10}=\\frac{x}{10}\\Rightarrow 20=x\\Rightarrow x=20$.','4.2: $y-0{,}1y-0{,}5=0{,}9y+0{,}5\\Rightarrow 0{,}9y-0{,}5=0{,}9y+0{,}5\\Rightarrow -0{,}5=0{,}5$; rovnice nemá řešení.'},
  '4.1: $x=20$; 4.2: rovnice nemá řešení',
  4, 6, '4',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD25C0T01', 2025
);

System.debug('Vytvořeno úloh: '+c.created);
