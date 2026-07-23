String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD26C0T03';
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
  'CERMAT M7C 2026 – úloha 1',
  new List<String>{'Pan Červený strávil jízdou v autě přesně 7 hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v 7:44 a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve 12:02 a do auta se vrátil za 38 minut. Pak pokračoval v jízdě až do cíle.','Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'},
  null,
  1,
  null,
  null,
  null,
  null,
  new List<String>{'Do pauzy jel od 7:44 do 12:02, tj. 4 h 18 min. Pauza 38 min skončila ve 12:40. Zbývá dojet 7 h $-$ 4 h 18 min $=$ 2 h 42 min. Od 12:40 dojede v 12:40 $+$ 2 h 42 min, tedy v 15:22.'},
  '15:22 (resp. 3:22 odpoledne)',
  1, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7C 2026 – úloha 2.1',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $4{,}4\\cdot\\left(\\dfrac{4}{11}-\\dfrac{1}{44}\\right)-2=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$\\dfrac{4}{11}-\\dfrac{1}{44}=\\dfrac{16}{44}-\\dfrac{1}{44}=\\dfrac{15}{44}$; dále $4{,}4=\\dfrac{22}{5}$, takže $\\dfrac{22}{5}\\cdot\\dfrac{15}{44}=\\dfrac{3}{2}$ a $\\dfrac{3}{2}-2=-\\dfrac{1}{2}$.'},
  '$-\\dfrac{1}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2026 – úloha 2.2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru: $\\dfrac{\\dfrac{5}{3}-\\dfrac{3}{5}}{\\dfrac{8}{7}\\cdot\\dfrac{14}{5}}=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Čitatel: $\\dfrac{5}{3}-\\dfrac{3}{5}=\\dfrac{25-9}{15}=\\dfrac{16}{15}$. Jmenovatel: $\\dfrac{8}{7}\\cdot\\dfrac{14}{5}=\\dfrac{16}{5}$. Celkem $\\dfrac{16}{15}:\\dfrac{16}{5}=\\dfrac{16}{15}\\cdot\\dfrac{5}{16}=\\dfrac{1}{3}$.'},
  '$\\dfrac{1}{3}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7C 2026 – úloha 3',
  new List<String>{'Klára přinesla košík s jablky a dvě devítiny počtu jablek z košíku položila do prázdné misky. Matěj si později vzal polovinu jablek z misky a ještě další 3 jablka z košíku. V košíku tak zůstalo o 21 jablek více než v misce.','3.1 Vypočtěte, kolik jablek přinesla Klára v košíku.','3.2 Vypočtěte, kolik jablek si vzal Matěj.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Označme počet jablek $x$. Do misky dala Klára $\\frac{2}{9}x$, v košíku zůstalo $\\frac{7}{9}x$. Matěj vzal polovinu misky, v misce pak zůstalo $\\frac{1}{9}x$ a v košíku $\\frac{7}{9}x-3$.','3.1 Rovnice $\\frac{7}{9}x-3=\\frac{1}{9}x+21$ dává $\\frac{6}{9}x=24$, tedy $x=36$ jablek.','3.2 Matěj vzal $\\frac{1}{2}\\cdot\\frac{2}{9}\\cdot 36+3=4+3=7$ jablek.'},
  '3.1: $36$ jablek; 3.2: $7$ jablek',
  3, 5, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
