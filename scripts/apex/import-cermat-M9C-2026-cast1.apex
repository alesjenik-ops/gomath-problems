String SRC   = 'CERMAT – Jednotná přijímací zkouška 2026, 1. náhradní termín (M9C)';
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
  'CERMAT 2026 M9C · úloha 1',
  new List<String>{'Pan Červený strávil jízdou v autě přesně $7$ hodin, než dojel do cíle. Svou jízdu autem zahájil ráno v $7{:}44$ a přerušil ji jen jednou, když si udělal pauzu na oběd. Z auta vystoupil ve $12{:}02$ a do auta se vrátil za $38$ minut. Pak pokračoval v jízdě až do cíle.','Určete, kdy pan Červený dorazil do cíle. Výsledek zapište ve tvaru hodiny : minuty.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'K času jízdy $7$ hodin je nutné přičíst $38$ minut přestávky.','$7{:}44 + 7\\ \\mathrm{h} = 14{:}44$, poté $+\\,38\\ \\mathrm{min} = 15{:}22$.'},
  '$15{:}22$',
  1, 2, '2',
  new List<String>{'zs2','r9','aritmetika','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PCD26C0T03', 2026
);
c.add(
  'CERMAT 2026 M9C · úloha 2',
  new List<String>{'Vypočtěte a výsledek zapište zlomkem v základním tvaru nebo celým číslem:','2.1 \\quad $\\dfrac{6}{5}:\\dfrac{9}{15}-2=$','2.2 \\quad $\\dfrac{5}{44}\\cdot(-5{,}5)=$','2.3 \\quad $\\dfrac{\\frac{5}{3}-\\frac{3}{5}}{\\frac{8}{7}\\cdot\\frac{14}{5}}=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'2.1: $\\frac{6}{5}\\cdot\\frac{15}{9}-2=\\frac{90}{45}-2=2-2=0$.','2.2: $\\frac{5}{44}\\cdot\\left(-\\frac{11}{2}\\right)=-\\frac{55}{88}=-\\frac{5}{8}$.','2.3: čitatel $\\frac{5}{3}-\\frac{3}{5}=\\frac{16}{15}$, jmenovatel $\\frac{8}{7}\\cdot\\frac{14}{5}=\\frac{16}{5}$; $\\frac{16}{15}:\\frac{16}{5}=\\frac{1}{3}$.'},
  '2.1: $0$; 2.2: $-\\frac{5}{8}$; 2.3: $\\frac{1}{3}$',
  4, 5, '3',
  new List<String>{'zs2','r9','zlomky','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);
c.add(
  'CERMAT 2026 M9C · úloha 3',
  new List<String>{'3.1 Rozložte na součin užitím vzorce: $6\\cdot 6-25a^2=$','3.2 Roznásobte a upravte (výsledný výraz nesmí obsahovat závorky): $4\\cdot\\left(n-\\dfrac{1}{2}\\right)^2=$','3.3 Upravte na co nejjednodušší tvar bez závorek: $(3-x)\\cdot(3+x)+(x^2+2)\\cdot3-2x\\cdot(x+1)=$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'3.1: $36-25a^2=(6+5a)(6-5a)$.','3.2: $4\\left(n^2-n+\\frac{1}{4}\\right)=4n^2-4n+1$.','3.3: $(9-x^2)+(3x^2+6)-(2x^2+2x)=9-x^2+3x^2+6-2x^2-2x=-2x+15$.'},
  '3.1: $(6+5a)(6-5a)$; 3.2: $4n^2-4n+1$; 3.3: $-2x+15$',
  4, 5, '3',
  new List<String>{'zs2','r9','vyrazy','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);
c.add(
  'CERMAT 2026 M9C · úloha 4',
  new List<String>{'4.1 Řešte rovnici: $2+\\dfrac{x-6}{7}-\\dfrac{x}{14}=\\dfrac{4+x}{2}$','4.2 Řešte soustavu rovnic: $\\begin{aligned}2x-3y&=-6\\\\ 2x-y&=2\\end{aligned}$'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'4.1: vynásobíme $14$: $28+2(x-6)-x=7(4+x)\\Rightarrow 16+x=28+7x\\Rightarrow -12=6x\\Rightarrow x=-2$.','4.2: odečtením rovnic $-2y=-8\\Rightarrow y=4$; dosazením $2x-4=2\\Rightarrow x=3$.'},
  '4.1: $x=-2$; 4.2: $x=3$, $y=4$',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','linearni-rovnice','soustava','algebra','vypocet','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PCD26C0T03', 2026
);
c.add(
  'CERMAT 2026 M9C · úloha 5',
  new List<String>{'Do fitcentra mají přístup členové klubu i běžní návštěvníci. Člen klubu zaplatí na začátku roku jednorázový poplatek $600$ korun a za každý vstup platí $120$ korun. Běžný návštěvník platí za každý vstup $160$ korun. Tereza je členkou klubu, Mirek platí běžné vstupné.','Počet Tereziných letošních vstupů označíme $x$.','5.1 Vyjádřete výrazem s proměnnou $x$, kolik korun Tereza letos celkem zaplatila fitcentru.','5.2 Tereza s Mirkem navštěvují fitcentrum vždy společně. Mirek zaplatil letos za všechny vstupy stejnou částku jako Tereza. Vypočtěte, kolikrát Tereza letos navštívila fitcentrum.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'5.1: $120x+600$ korun.','5.2: Mirek platí $160x$; z $160x=120x+600$ plyne $40x=600$, tedy $x=15$.'},
  '5.1: $120x+600$; 5.2: $15$krát',
  3, 5, '3',
  new List<String>{'zs2','r9','rovnice','algebra','slovni','modelovani','s-kalkulackou','bezny-zivot'},
  'M9PCD26C0T03', 2026
);

System.debug('Vytvořeno úloh: '+c.created);
