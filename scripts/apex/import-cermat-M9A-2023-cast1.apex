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
  'CERMAT 2023 M9A · úloha 1',
  new List<String>{'Celý film trvá $1$ hodinu. Doba, která ještě zbývá do konce filmu, je polovinou doby, která již uplynula od začátku filmu.','Vypočtěte, kolik minut zbývá do konce filmu.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Uplynulá doba $e$, zbývající $\\frac{e}{2}$; $e+\\frac{e}{2}=60\\Rightarrow \\frac{3}{2}e=60\\Rightarrow e=40$.','Zbývá $\\frac{40}{2}=20$ minut.'},
  '$20$ minut',
  1, 2, '3',
  new List<String>{'zs2','r9','aritmetika','rovnice','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 2',
  new List<String>{'2.1 Vnitřní objem sudu je $15$krát větší než objem kbelíku, objem kbelíku je $5$krát větší než objem konvičky. Ze sudu plného vody jsme třetinu vody odebrali, takže v něm zbylo $60$ litrů. Vypočtěte v litrech objem konvičky.','2.2 Kvádr je možné beze zbytku rozřezat na $200$ krychlí, z nichž každá má objem $8\\ \\mathrm{dm}^3$. Vypočtěte, na kolik krychliček o objemu $1\\ \\mathrm{cm}^3$ lze tento kvádr beze zbytku rozřezat.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: v sudu zbyly $\\frac{2}{3}$ objemu $=60$ l, tedy sud $90$ l; kbelík $\\frac{90}{15}=6$ l; konvička $\\frac{6}{5}=1{,}2$ litru.','2.2: objem kvádru $200\\cdot8=1\\,600\\ \\mathrm{dm}^3=1\\,600\\,000\\ \\mathrm{cm}^3$, tj. $1\\,600\\,000$ krychliček.'},
  '2.1: $1{,}2$ litru; 2.2: $1\\,600\\,000$ krychliček',
  3, 5, '3',
  new List<String>{'zs2','r9','aritmetika','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 3',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru.','3.1 \\quad $\\dfrac{5}{9}-\\dfrac{5}{9}:5=$','3.2 \\quad $\\dfrac{4-7}{8}\\cdot\\dfrac{16}{21}=$','3.3 \\quad $\\dfrac{\\frac{3}{5}:\\left(\\frac{2}{5}+\\frac{1}{2}\\right)}{\\frac{7}{6}+\\frac{7}{10}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $\\frac{5}{9}-\\frac{1}{9}=\\frac{4}{9}$.','3.2: $-\\frac{3}{8}\\cdot\\frac{16}{21}=-\\frac{2}{7}$.','3.3: čitatel $\\frac{3}{5}:\\frac{9}{10}=\\frac{2}{3}$; jmenovatel $\\frac{7}{6}+\\frac{7}{10}=\\frac{28}{15}$; $\\frac{2}{3}:\\frac{28}{15}=\\frac{5}{14}$.'},
  '3.1: $\\frac{4}{9}$; 3.2: $-\\frac{2}{7}$; 3.3: $\\frac{5}{14}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 4',
  new List<String>{'4.1 Upravte a rozložte na součin vytknutím: $2\\cdot(x^2-x)+x=$','4.2 Umocněte a zjednodušte: $\\left(\\dfrac{2}{3}a-3\\right)^2=$','4.3 Zjednodušte (bez závorek): $3n\\cdot(2-n+2n)+(2n+1)\\cdot(7-n)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: $2x^2-2x+x=2x^2-x=x\\cdot(2x-1)$.','4.2: $\\frac{4}{9}a^2-4a+9$.','4.3: $3n(2+n)+(2n+1)(7-n)=6n+3n^2+14n-2n^2+7-n=n^2+19n+7$.'},
  '4.1: $x\\cdot(2x-1)$; 4.2: $\\frac{4}{9}a^2-4a+9$; 4.3: $n^2+19n+7$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);
c.add(
  'CERMAT 2023 M9A · úloha 5',
  new List<String>{'Řešte rovnice.','5.1 \\quad $0{,}5x+2\\cdot(x+2{,}5)=2{,}5\\cdot(x+3)$','5.2 \\quad $\\dfrac{y+10}{15}+\\dfrac{2y}{5}=1-\\dfrac{5-y}{3}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $0{,}5x+2x+5=2{,}5x+7{,}5\\Rightarrow 2{,}5x+5=2{,}5x+7{,}5\\Rightarrow 5=7{,}5$; rovnice nemá řešení.','5.2: vynásobením $15$: $(y+10)+6y=15-5(5-y)\\Rightarrow 7y+10=5y-10\\Rightarrow 2y=-20\\Rightarrow y=-10$.'},
  '5.1: rovnice nemá řešení; 5.2: $y=-10$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PAD23C0T01', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
