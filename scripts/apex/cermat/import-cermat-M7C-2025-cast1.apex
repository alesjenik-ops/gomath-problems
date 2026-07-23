String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD25C0T03';
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
  'CERMAT M7C 2025 – úloha 1',
  new List<String>{'Vlak vyjel v poledne ze stanice a za každých 8 minut ujel 7 km. Ve 12:20 vlak minul lom a ve 12:36 dojel na most přes řeku.','Určete v km vzdálenost, kterou ujel vlak od lomu k mostu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Od 12:20 do 12:36 uplynulo $16$ minut, což je dvakrát $8$ minut. Vlak tedy ujel $2\\cdot 7=14$ km.'},
  '$14$ km',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2025 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{1}{4}+\\left(\\frac{9}{10}-\\frac{3}{5}\\right)-\\left(1-\\frac{1}{6}\\right):\\frac{5}{3}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{9}{10}-\\frac{3}{5}=\\frac{3}{10}$, $\\left(1-\\frac{1}{6}\\right):\\frac{5}{3}=\\frac{5}{6}\\cdot\\frac{3}{5}=\\frac{1}{2}$. Pak $\\frac{1}{4}+\\frac{3}{10}-\\frac{1}{2}=\\frac{5}{20}+\\frac{6}{20}-\\frac{10}{20}=\\frac{1}{20}$.'},
  '$\\frac{1}{20}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{3}{5}\\cdot\\frac{3}{5}}{\\frac{27}{34}\\cdot\\left(\\frac{2}{3}-\\frac{9}{5}\\right)}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\frac{3}{5}\\cdot\\frac{3}{5}=\\frac{9}{25}$. Jmenovatel $\\frac{2}{3}-\\frac{9}{5}=-\\frac{17}{15}$, $\\frac{27}{34}\\cdot\\left(-\\frac{17}{15}\\right)=-\\frac{9}{10}$. Podíl $\\frac{9}{25}:\\left(-\\frac{9}{10}\\right)=\\frac{9}{25}\\cdot\\left(-\\frac{10}{9}\\right)=-\\frac{2}{5}$.'},
  '$-\\frac{2}{5}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2025 – úloha 3',
  new List<String>{'Stuhu jsme beze zbytku rozstříhali na 20 dílů dvou různých délek – kratší díly po 20 cm a delší po 30 cm. Kratších dílů bylo o třetinu méně než delších dílů.','3.1 Vypočtěte, kolik delších dílů jsme ze stuhy nastříhali.','3.2 Vypočtěte, kolik cm měřila celá stuha, než jsme ji začali stříhat.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Kratších je o třetinu méně, tj. $\\frac{2}{3}$ počtu delších. Označíme delší $d$: $d+\\frac{2}{3}d=20$, tedy $\\frac{5}{3}d=20$, $d=12$. Delších dílů je $12$, kratších $8$.','3.2 Celá stuha měřila $8\\cdot 20+12\\cdot 30=160+360=520$ cm.'},
  '3.1: $12$ delších dílů; 3.2: $520$ cm',
  2, 4, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2025 – úloha 4',
  new List<String>{'Adam pravidelně kupuje pro psy mražené mleté maso v baleních po 1,5 kg. Dnes měl v peněžence o 14 korun víc, než potřeboval minule na nákup 9 kg masa. Maso však bylo zdraženo, a tak mu dnes na nákup stejného množství masa 40 korun chybělo. Koupil proto o 1 balení masa méně a v peněžence mu zbylo 50 korun.','4.1 Vypočtěte, kolik balení masa Adam dnes koupil.','4.2 Vypočtěte, kolik korun dnes stálo jedno balení masa.','4.3 Vypočtěte, kolik korun si dnes Adam vzal na nákup masa.','4.4 Vypočtěte, o kolik korun bylo dnes jedno balení masa dražší než minule.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'$9$ kg $=6$ balení po $1{,}5$ kg. Označíme dnešní cenu balení $c$ a částku v peněžence $P$. Na $6$ balení dnes chybělo $40$ Kč: $6c=P+40$. Koupil $5$ balení a zbylo $50$ Kč: $P-5c=50$, tj. $P=50+5c$.','4.1 Koupil o $1$ balení méně než $6$, tedy $5$ balení.','4.2 Z $6c=50+5c+40$ plyne $c=90$ Kč.','4.3 $P=50+5\\cdot 90=500$ Kč.','4.4 Minule na $6$ balení potřeboval $P-14=486$ Kč, tj. $486:6=81$ Kč za balení. Rozdíl $90-81=9$ Kč.'},
  '4.1: $5$ balení; 4.2: $90$ korun; 4.3: $500$ korun; 4.4: o $9$ korun',
  4, 7, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
