String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD26C0T04';
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
  'CERMAT M7D 2026 – úloha 1',
  new List<String>{'Filip se učil házet oštěpem. Délka jeho prvního hodu byla $7$ m. Každý další hod byl o desetinu delší než předchozí hod.','Vypočtěte, o kolik cm byl Filipův třetí hod delší než první.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Druhý hod $7\\cdot 1{,}1=7{,}7$ m, třetí hod $7{,}7\\cdot 1{,}1=8{,}47$ m. Rozdíl $8{,}47-7=1{,}47$ m $=147$ cm.'},
  'o $147$ cm',
  1, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2026 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\left(\\frac{7}{2}-\\frac{1}{6}\\right):\\left(12-6\\cdot\\frac{3}{4}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{7}{2}-\\frac{1}{6}=\\frac{21-1}{6}=\\frac{20}{6}=\\frac{10}{3}$; $12-6\\cdot\\frac{3}{4}=12-\\frac{9}{2}=\\frac{15}{2}$.','$\\frac{10}{3}:\\frac{15}{2}=\\frac{10}{3}\\cdot\\frac{2}{15}=\\frac{20}{45}=\\frac{4}{9}$.'},
  '$\\frac{4}{9}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\frac{\\left(2-\\frac{7}{8}\\right)\\cdot 2}{\\frac{7}{5}-5}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel $\\left(2-\\frac{7}{8}\\right)\\cdot 2=\\frac{9}{8}\\cdot 2=\\frac{18}{8}$; jmenovatel $\\frac{7}{5}-5=-\\frac{18}{5}$.','$\\frac{18}{8}:\\left(-\\frac{18}{5}\\right)=\\frac{18}{8}\\cdot\\left(-\\frac{5}{18}\\right)=-\\frac{5}{8}$.'},
  '$-\\frac{5}{8}$',
  2, 4, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2026 – úloha 3',
  new List<String>{'Pozemek má tvar obdélníku, jehož jedna strana je o třetinu delší než sousední strana. Bára obešla celý pozemek po jeho obvodu stejně dlouhými kroky, přitom delší stranu pozemku přešla $120$ kroky.','3.1 Vypočtěte, kolika kroky obešla Bára celý pozemek po jeho obvodu.','3.2 Jeden Bářin krok měří $65$ cm. Vypočtěte, o kolik cm se liší délky sousedních stran pozemku.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'3.1 Delší strana $=120$ kroků $=\\frac{4}{3}$ kratší strany, tedy kratší $=120\\cdot\\frac{3}{4}=90$ kroků. Obvod $=2\\cdot(120+90)=420$ kroků.','3.2 Rozdíl stran $=120-90=30$ kroků; $30\\cdot 65=1\\,950$ cm.'},
  '3.1: $420$ kroků; 3.2: o $1\\,950$ cm',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2026 – úloha 4',
  new List<String>{'V parku běží dva běžci trasu dlouhou $8$ km. Žádný z nich svou rychlost běhu nemění. Rychlejší běžec uběhne celou trasu za $40$ minut. Přitom rychlejší běžec uběhne $3$ km za čas, za který pomalejší běžec uběhne $2\\,500$ m.','4.1 Vypočtěte v minutách, za jaký čas uběhne rychlejší běžec $3$ km.','4.2 Vypočtěte v minutách, za jaký čas uběhne pomalejší běžec celou trasu.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Rychlejší běžec: $8$ km za $40$ min, tj. $1$ km za $5$ min; $3$ km za $15$ min.','4.2 Za $15$ min uběhne pomalejší $2\\,500$ m, tj. $1$ km za $6$ min; $8$ km za $48$ min.'},
  '4.1: $15$ minut; 4.2: $48$ minut',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);
c.add(
  'CERMAT M7D 2026 – úloha 5',
  new List<String>{'Spolek daroval na školní akci velké a malé balíčky sušenek. Malý balíček obsahuje $6$ sušenek a velký balíček $10$ sušenek. Ve všech darovaných balíčcích bylo celkem $264$ sušenek.','5.1 Dopoledne se na akci rozdalo $15$ balíčků sušenek. Velkých balíčků se dopoledne rozdalo o polovinu více než malých. Vypočtěte, kolik sušenek bylo v balíčcích, které zbyly na odpoledne.','5.2 Všech darovaných balíčků bylo dohromady $32$. Vypočtěte, kolik z darovaných balíčků bylo velkých.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'5.1 Dopoledne: malých $m$, velkých $1{,}5m$, dohromady $2{,}5m=15\\Rightarrow m=6$, velkých $9$. Rozdáno $6\\cdot 6+9\\cdot 10=126$ sušenek; zbylo $264-126=138$ sušenek.','5.2 $m+v=32$ a $6m+10v=264$; dosazením $6(32-v)+10v=264\\Rightarrow 4v=72\\Rightarrow v=18$ velkých balíčků.'},
  '5.1: $138$ sušenek; 5.2: $18$ velkých balíčků',
  4, 6, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
