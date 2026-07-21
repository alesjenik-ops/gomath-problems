String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, 2. řádný termín (M9B)';
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
  'CERMAT 2021 M9B · úloha 1',
  new List<String>{'Vypočtěte:','$\\sqrt{\\dfrac{16}{0{,}1}+9}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{16}{0{,}1}=160$, tedy $\\sqrt{160+9}=\\sqrt{169}=13$.'},
  '$13$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','cisla','vypocet','bez-kalkulacky','bez-kontextu'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 2',
  new List<String>{'2.1 \\quad Vypočtěte, kolikrát více je polovina z $240$ minut než dvě třetiny z $1$ hodiny.','2.2 \\quad Čtyřúhelník lze rozdělit na dva rovnoramenné trojúhelníky o obsazích $S_1=1\\,200\\ \\mathrm{cm}^2$ a $S_2=0{,}2\\ \\mathrm{m}^2$, nebo na dva shodné trojúhelníky, každý o obsahu $S_3$. Vypočtěte v dm$^2$ obsah $S_3$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: polovina z $240$ min $=120$ min; dvě třetiny z $60$ min $=40$ min; $120:40=3$.','2.2: obsah čtyřúhelníku $=S_1+S_2=1\\,200\\ \\mathrm{cm}^2+0{,}2\\ \\mathrm{m}^2=1\\,200\\ \\mathrm{cm}^2+2\\,000\\ \\mathrm{cm}^2=3\\,200\\ \\mathrm{cm}^2$; dva shodné trojúhelníky mají $S_3=\\frac{3\\,200}{2}=1\\,600\\ \\mathrm{cm}^2=16\\ \\mathrm{dm}^2$.'},
  '2.1: $3$krát; 2.2: $16\\ \\mathrm{dm}^2$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','planimetrie','vypocet','bez-kalkulacky'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{2-\\frac{4}{7}}{3-\\frac{13}{21}}=$','3.2 \\quad $\\left(\\dfrac{3}{8}-\\dfrac{2}{5}\\right)\\cdot5-\\dfrac{3}{4}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: čitatel $2-\\frac{4}{7}=\\frac{10}{7}$; jmenovatel $3-\\frac{13}{21}=\\frac{63-13}{21}=\\frac{50}{21}$; $\\frac{10}{7}:\\frac{50}{21}=\\frac{10}{7}\\cdot\\frac{21}{50}=\\frac{3}{5}$.','3.2: $\\frac{3}{8}-\\frac{2}{5}=\\frac{15-16}{40}=-\\frac{1}{40}$; $-\\frac{1}{40}\\cdot5=-\\frac{1}{8}$; $-\\frac{1}{8}-\\frac{3}{4}=-\\frac{1}{8}-\\frac{6}{8}=-\\frac{7}{8}$.'},
  '3.1: $\\frac{3}{5}$; 3.2: $-\\frac{7}{8}$',
  4, 6, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 4',
  new List<String>{'4.1 \\quad Zjednodušte (výsledný výraz nesmí obsahovat závorky): $(2-x)\\cdot3x-2x=$','4.2 \\quad Umocněte a zjednodušte (výsledný výraz nesmí obsahovat závorky): $\\left(y-\\dfrac{1}{2}\\right)^2=$','4.3 \\quad Zjednodušte a rozložte podle vzorce (výsledný výraz uveďte ve tvaru součinu): $5^2-(a^2+16)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $(2-x)\\cdot3x-2x=6x-3x^2-2x=4x-3x^2$.','4.2: $\\left(y-\\frac{1}{2}\\right)^2=y^2-2\\cdot y\\cdot\\frac{1}{2}+\\frac{1}{4}=y^2-y+\\frac{1}{4}$.','4.3: $5^2-(a^2+16)=25-a^2-16=9-a^2=(3-a)(3+a)$.'},
  '4.1: $4x-3x^2$; 4.2: $y^2-y+\\frac{1}{4}$; 4.3: $(3-a)(3+a)$',
  4, 6, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD21C0T02', 2021
);
c.add(
  'CERMAT 2021 M9B · úloha 5',
  new List<String>{'Řešte rovnici:','5.1 \\quad $2x\\cdot(3{,}2-2{,}3)=2x-(3{,}2-2{,}3)$','5.2 \\quad $\\dfrac{y+3}{3}+\\dfrac{3}{8}\\cdot(y+1)=\\dfrac{2y-1}{4}+1$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $3{,}2-2{,}3=0{,}9$, tedy $2x\\cdot0{,}9=2x-0{,}9\\Rightarrow1{,}8x=2x-0{,}9\\Rightarrow-0{,}2x=-0{,}9\\Rightarrow x=4{,}5$.','5.2: vynásobíme $24$: $8(y+3)+9(y+1)=6(2y-1)+24\\Rightarrow8y+24+9y+9=12y-6+24\\Rightarrow17y+33=12y+18\\Rightarrow5y=-15\\Rightarrow y=-3$.'},
  '5.1: $x=4{,}5$; 5.2: $y=-3$',
  4, 7, '3',
  new List<String>{'zs2','r9','rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PBD21C0T02', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
