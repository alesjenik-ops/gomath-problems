String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 1',
  new List<String>{'Vypočtěte v minutách jednu dvacetinu z 12 hodin.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$12$ hodin $=720$ minut. Jedna dvacetina je $720:20=36$ minut.'},
  '$36$ minut',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 2.1',
  new List<String>{'Vypočtěte: $0{,}5\\cdot 1{,}2 + 0{,}02$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$0{,}5\\cdot 1{,}2=0{,}6$, tedy $0{,}6+0{,}02=0{,}62$.'},
  '$0{,}62$',
  1, 2, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 2.2',
  new List<String>{'Vypočtěte: $\\dfrac{10}{0{,}5}-\\dfrac{0{,}5}{10}$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{10}{0{,}5}=20$ a $\\frac{0{,}5}{10}=0{,}05$, tedy $20-0{,}05=19{,}95$.'},
  '$19{,}95$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 3.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $2-\\dfrac{6}{5}\\left(\\dfrac{11}{6}-\\dfrac{4}{9}\\right)$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'$\\frac{11}{6}-\\frac{4}{9}=\\frac{33-8}{18}=\\frac{25}{18}$; $\\frac{6}{5}\\cdot\\frac{25}{18}=\\frac{5}{3}$; $2-\\frac{5}{3}=\\frac{1}{3}$.'},
  '$\\frac{1}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 3.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\frac{1}{4}\\cdot\\frac{3}{2}+\\frac{5}{2}}{\\frac{1}{4}+\\frac{3}{2}\\cdot\\frac{5}{2}}$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\frac{1}{4}\\cdot\\frac{3}{2}+\\frac{5}{2}=\\frac{3}{8}+\\frac{20}{8}=\\frac{23}{8}$. Jmenovatel: $\\frac{1}{4}+\\frac{3}{2}\\cdot\\frac{5}{2}=\\frac{1}{4}+\\frac{15}{4}=4$. Podíl: $\\frac{23}{8}:4=\\frac{23}{32}$.'},
  '$\\frac{23}{32}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2019 – úloha 4',
  new List<String>{'Aleš má v pravé kapse o polovinu méně korun než v levé kapse. Kdyby přendal 40 korun z levé kapsy do pravé, měl by v obou kapsách stejně.','4.1 Vypočtěte, o kolik korun má Aleš v levé kapse více než v pravé.','4.2 Vypočtěte, kolik korun má Aleš celkem v obou kapsách.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Levá kapsa $L$, pravá $\\frac{L}{2}$. Po přendání 40 Kč: $L-40=\\frac{L}{2}+40$, odtud $\\frac{L}{2}=80$, tedy $L=160$ Kč a pravá $80$ Kč.','4.1 Rozdíl $L-\\frac{L}{2}=160-80=80$ korun.','4.2 Celkem $160+80=240$ korun.'},
  '4.1: o $80$ korun; 4.2: $240$ korun',
  3, 5, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7B 2019 – úloha 5',
  new List<String>{'Chovatel chová dospělé kočky a koťata a kupuje jim univerzální granule balené vždy ve stejných pytlích. Za jeden den sežerou 3 koťata stejné množství granulí jako 2 dospělé kočky. Dospělá kočka má jeden pytel granulí přesně na 12 dní. (Každá dospělá kočka sežere denně stejně, totéž platí o koťatech.)','5.1 Vypočtěte, na kolik dní mají jeden pytel granulí 3 koťata.','5.2 Vypočtěte, na kolik dní mají jeden pytel granulí 3 koťata společně s 1 dospělou kočkou.','5.3 Vypočtěte, kolik koťat sežere jeden pytel granulí přesně za 1 den.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Dospělá kočka sežere denně $\\frac{1}{12}$ pytle. 3 koťata sežerou denně tolik co 2 kočky, tj. $\\frac{2}{12}=\\frac{1}{6}$ pytle.','5.1 $1:\\frac{1}{6}=6$ dní.','5.2 Denní spotřeba 3 koťat a 1 kočky $=\\frac{1}{6}+\\frac{1}{12}=\\frac{1}{4}$ pytle, tj. $1:\\frac{1}{4}=4$ dny.','5.3 Jedno kotě sežere denně $\\frac{1}{18}$ pytle, takže jeden pytel za den sní $18$ koťat.'},
  '5.1: na $6$ dní; 5.2: na $4$ dny; 5.3: $18$ koťat',
  5, 7, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
