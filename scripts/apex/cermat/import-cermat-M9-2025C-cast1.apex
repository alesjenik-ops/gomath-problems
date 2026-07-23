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
  'CERMAT M9C 2025 – úloha 1',
  new List<String>{'Určete, kolikrát více je $5$ kilogramů než $0{,}25$ gramu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$5$ kg $=5000$ g. Kolikrát více: $5000:0{,}25=20\\,000$.'},
  '$20\\,000$krát',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 2',
  new List<String>{'Druhá mocnina neznámého prvočísla je o $3$ menší než jiné prvočíslo.','Určete větší z obou prvočísel.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hledáme prvočíslo $p$, pro které je i $p^2+3$ prvočíslo. Pro $p=2$ je $2^2+3=7$ (prvočíslo). Pro liché $p$ by $p^2+3$ bylo sudé číslo větší než $2$, tedy složené. Prvočísla jsou $2$ a $7$, větší je $7$.'},
  '$7$',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\sqrt{10^2-19}}{\\sqrt{10^2}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{\\sqrt{100-19}}{\\sqrt{100}}=\\frac{\\sqrt{81}}{10}=\\frac{9}{10}$.'},
  '$\\frac{9}{10}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\left(\\frac{3}{5}\\right)^2}{\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{3^2}{5}\\right)}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\left(\\frac{3}{5}\\right)^2=\\frac{9}{25}$. Jmenovatel: $\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{9}{5}\\right)=\\frac{27}{34}\\cdot\\left(-\\frac{17}{15}\\right)=-\\frac{9}{10}$.','Podíl: $\\frac{9}{25}:\\left(-\\frac{9}{10}\\right)=\\frac{9}{25}\\cdot\\left(-\\frac{10}{9}\\right)=-\\frac{2}{5}$.'},
  '$-\\frac{2}{5}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 4.1',
  new List<String>{'Upravte a umocněte (výsledný výraz nesmí obsahovat závorky): $(4+8a-8)^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(4+8a-8)^2=(8a-4)^2=64a^2-64a+16$.'},
  '$64a^2-64a+16$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 4.2',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $(2-3x)\\cdot 2+(2x)^2-x\\cdot(-6)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(2-3x)\\cdot 2+(2x)^2-x\\cdot(-6)=4-6x+4x^2+6x=4x^2+4$.'},
  '$4x^2+4$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 4.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $(1-2n)\\cdot(1-2n+4n)-2n\\cdot(1-3n)+(3n-1)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(1-2n)(1+2n)-2n(1-3n)+(3n-1)=(1-4n^2)-(2n-6n^2)+3n-1=2n^2+n$.'},
  '$2n^2+n$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 5.1',
  new List<String>{'Řešte rovnici: $5x+\\frac{2}{15}+\\frac{1}{15}x=\\frac{2}{3}x-\\frac{3}{5}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $15$: $75x+2+x=10x-9$, tj. $76x+2=10x-9$. Odtud $66x=-11$, a proto $x=-\\frac{1}{6}$.'},
  '$x=-\\frac{1}{6}$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2025 – úloha 5.2',
  new List<String>{'Řešte rovnici: $4-\\frac{7-3y}{5}=3+\\frac{7y-4}{10}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Vynásobíme $10$: $40-2(7-3y)=30+(7y-4)$, tj. $40-14+6y=30+7y-4$, a tedy $26+6y=26+7y$. Odtud $y=0$.'},
  '$y=0$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
