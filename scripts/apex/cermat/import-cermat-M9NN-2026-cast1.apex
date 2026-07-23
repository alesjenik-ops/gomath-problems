String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PND26C0T01';
Integer YEAR = 2026;

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
  'CERMAT M9 nanečisto 2026 – úloha 1',
  new List<String>{'Vypočtěte druhou mocninu součtu prvního, druhého a třetího nejmenšího prvočísla.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'První tři nejmenší prvočísla jsou $2$, $3$, $5$. Součet je $2+3+5=10$, jeho druhá mocnina je $10^2=100$.'},
  '$100$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 2.1',
  new List<String>{'Vypočtěte: $-5\\cdot 5+(-12)^2-13^2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$-25+144-169=-50$.'},
  '$-50$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 2.2',
  new List<String>{'Vypočtěte: $\\sqrt{1-0{,}8^2}:6=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\sqrt{1-0{,}64}:6=\\sqrt{0{,}36}:6=0{,}6:6=0{,}1$.'},
  '$0{,}1$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru:','$-\\frac{5}{24}+\\frac{5}{24}\\cdot\\frac{7}{3}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejprve násobení: $\\frac{5}{24}\\cdot\\frac{7}{3}=\\frac{35}{72}$. Pak $-\\frac{15}{72}+\\frac{35}{72}=\\frac{20}{72}=\\frac{5}{18}$.'},
  '$\\frac{5}{18}$',
  1, 3, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru (uveďte celý postup řešení):','$\\frac{\\left(\\frac{125}{21}\\cdot\\frac{7}{25}-9\\right):4}{11}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{125}{21}\\cdot\\frac{7}{25}=\\frac{5}{3}$; $\\frac{5}{3}-9=-\\frac{22}{3}$; $-\\frac{22}{3}:4=-\\frac{22}{12}=-\\frac{11}{6}$; $-\\frac{11}{6}:11=-\\frac{1}{6}$.'},
  '$-\\frac{1}{6}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 4.1',
  new List<String>{'Upravte a rozložte na součin vytknutím:','$3y\\cdot(x+3y)-y=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$3xy+9y^2-y=y\\cdot(3x+9y-1)$.'},
  '$y\\cdot(3x+9y-1)$',
  1, 2, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 4.2',
  new List<String>{'Upravte a rozložte na součin užitím vzorce:','$n\\cdot(9n-1)+n-4=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$9n^2-n+n-4=9n^2-4=(3n)^2-2^2=(3n-2)(3n+2)$.'},
  '$(3n-2)(3n+2)$',
  1, 3, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 4.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek (uveďte celý postup řešení):','$4\\cdot(2x\\cdot x-x)-3+(2x+1)(3-4x)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$4(2x^2-x)=8x^2-4x$; $(2x+1)(3-4x)=-8x^2+2x+3$. Součet: $8x^2-4x-3-8x^2+2x+3=-2x$.'},
  '$-2x$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 5.1',
  new List<String>{'Řešte rovnici (uveďte celý postup řešení):','$3\\cdot\\left(4-\\frac{3}{4}x\\right)+x=1-\\frac{5}{4}x$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Levá strana: $12-\\frac{9}{4}x+x=12-\\frac{5}{4}x$. Rovnice $12-\\frac{5}{4}x=1-\\frac{5}{4}x$ vede na $12=1$, což neplatí. Rovnice nemá řešení.'},
  'Rovnice nemá řešení.',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9 nanečisto 2026 – úloha 5.2',
  new List<String>{'Řešte soustavu rovnic (uveďte celý postup řešení):','$2x-y=7$','$x-2y=11$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Z první rovnice $y=2x-7$. Dosazením: $x-2(2x-7)=11\\Rightarrow -3x+14=11\\Rightarrow x=1$. Pak $y=2\\cdot 1-7=-5$.'},
  '$x=1$; $y=-5$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
