String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD25C0T04';
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
  'CERMAT M9D 2025 – úloha 1',
  new List<String>{'Třímetrovou dárkovou stuhu jsme dvěma střihy rozdělili na tři díly různých délek. Nejprve jsme odstřihli čtvrtinu stuhy na první dárek, potom jsme odstřihli dvě pětiny zbytku stuhy na druhý dárek a poslední díl jsme použili na třetí dárek.','Vypočtěte, kolik cm stuhy jsme použili na třetí dárek.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Stuha měří $300$ cm. První dárek $\\frac{1}{4}\\cdot 300=75$ cm, zbytek $225$ cm. Druhý dárek $\\frac{2}{5}\\cdot 225=90$ cm. Třetí dárek $225-90=135$ cm.'},
  '$135$ cm',
  1, 3, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9D 2025 – úloha 2',
  new List<String>{'Poměr dvou neznámých přirozených čísel je $4:5$ a dvojnásobky těchto dvou čísel se liší o $6$.','Určete menší z obou neznámých čísel.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čísla jsou $4k$ a $5k$, jejich dvojnásobky $8k$ a $10k$ se liší o $2k=6$, tedy $k=3$. Menší číslo je $4k=12$.'},
  '$12$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\dfrac{7}{5}-\\dfrac{7}{4}\\right):\\dfrac{2}{5}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{7}{5}-\\dfrac{7}{4}=\\dfrac{28-35}{20}=-\\dfrac{7}{20}$; $\\left(-\\dfrac{7}{20}\\right):\\dfrac{2}{5}=-\\dfrac{7}{20}\\cdot\\dfrac{5}{2}=-\\dfrac{7}{8}$.'},
  '$-\\dfrac{7}{8}$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\left(1+\\frac{1}{7}\\right)^2\\cdot\\frac{7}{4}}{\\sqrt{25}-\\frac{3^2}{5}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\left(\\dfrac{8}{7}\\right)^2\\cdot\\dfrac{7}{4}=\\dfrac{64}{49}\\cdot\\dfrac{7}{4}=\\dfrac{16}{7}$. Jmenovatel $\\sqrt{25}-\\dfrac{3^2}{5}=5-\\dfrac{9}{5}=\\dfrac{16}{5}$. Podíl $\\dfrac{16}{7}:\\dfrac{16}{5}=\\dfrac{5}{7}$.'},
  '$\\dfrac{5}{7}$',
  2, 4, '3',
  new List<String>{'zs2','r9','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 4.1',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $(y+1)^2+(y-1)\\cdot 2y=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$(y+1)^2+(y-1)\\cdot 2y=y^2+2y+1+2y^2-2y=3y^2+1$.'},
  '$3y^2+1$',
  1, 2, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 4.2',
  new List<String>{'Upravte a výsledný výraz rozložte na součin pomocí vzorce: $k\\cdot(k-9)+9\\cdot(k-16)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$k\\cdot(k-9)+9\\cdot(k-16)=k^2-9k+9k-144=k^2-144=(k+12)(k-12)$.'},
  '$(k+12)(k-12)$',
  1, 3, '2',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 4.3',
  new List<String>{'Upravte na co nejjednodušší tvar bez závorek: $(x-15)\\cdot(2x-x)-(5x-8)\\cdot(-3+1)-1=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$(x-15)\\cdot x-(5x-8)\\cdot(-2)-1=x^2-15x+10x-16-1=x^2-5x-17$.'},
  '$x^2-5x-17$',
  2, 4, '3',
  new List<String>{'zs2','r9','vyrazy','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 5.1',
  new List<String>{'Řešte rovnici: $0{,}1x+5\\cdot(0{,}04x-3{,}2)=4-0{,}7x$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}1x+0{,}2x-16=4-0{,}7x$, tj. $0{,}3x-16=4-0{,}7x$. Odtud $x=20$.'},
  '$x=20$',
  2, 3, '2',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9D 2025 – úloha 5.2',
  new List<String>{'Řešte soustavu rovnic:','$3x-(y+1)=10$','$2x-9=y$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Z druhé rovnice $y=2x-9$. Dosazením do první: $3x-(2x-9+1)=10$, tj. $3x-2x+8=10$, $x=2$. Pak $y=2\\cdot 2-9=-5$.'},
  '$x=2$, $y=-5$',
  2, 4, '3',
  new List<String>{'zs2','r9','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
