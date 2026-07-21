String SRC   = 'CERMAT – Jednotná přijímací zkouška 2021, náhradní termín (M9C)';
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
  'CERMAT 2021 M9C · úloha 6',
  new List<String>{'Do firmy, která si pronajala dvě prázdné dílny, přivezli stroje. Polovinu přivezených strojů umístili do první dílny a polovinu do druhé dílny. První den zprovoznili tři pětiny strojů umístěných v první dílně (a žádný stroj v druhé dílně). Druhý den zprovoznili tři čtvrtiny strojů umístěných v druhé dílně (a žádný další v první). Třetí den zprovoznili veškeré zbývající stroje v obou dílnách.','Neznámá $x$ představuje celkový počet strojů přivezených do firmy.','6.1 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili první den.','6.2 V závislosti na veličině $x$ vyjádřete, kolik strojů zprovoznili třetí den v první dílně.','6.3 Třetí den zprovoznili v obou dílnách dohromady $52$ strojů. Vypočtěte celkový počet strojů přivezených do firmy.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'6.1: v první dílně je $\\frac{x}{2}$ strojů; první den $\\frac{3}{5}\\cdot\\frac{x}{2}=\\frac{3x}{10}$.','6.2: v první dílně zbývá (a třetí den se zprovozní) $\\frac{x}{2}-\\frac{3x}{10}=\\frac{5x-3x}{10}=\\frac{2x}{10}=\\frac{x}{5}$.','6.3: v druhé dílně druhý den $\\frac{3}{4}\\cdot\\frac{x}{2}=\\frac{3x}{8}$, zbývá $\\frac{x}{2}-\\frac{3x}{8}=\\frac{x}{8}$; třetí den celkem $\\frac{x}{5}+\\frac{x}{8}=\\frac{8x+5x}{40}=\\frac{13x}{40}=52\\Rightarrow x=160$.'},
  '6.1: $\\dfrac{3x}{10}$; 6.2: $\\dfrac{x}{5}$; 6.3: $160$ strojů',
  3, 6, '4',
  new List<String>{'zs2','r9','vyrazy','rovnice','zlomky','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 7',
  new List<String>{'Brigádníci plní bedýnky ovocem. Za naplnění každé z prvních $10$ bedýnek dostávají základní odměnu $40$ korun za $1$ bedýnku. Za naplnění každé další bedýnky dostanou vyšší odměnu: odměna za $11.$ až $15.$ bedýnku je o $25\\ \\%$ vyšší než základní odměna. Počínaje $16.$ bedýnkou je odměna za každou bedýnku o $50\\ \\%$ vyšší než základní odměna.','7.1 Vypočtěte, kolik korun si brigádník vydělá za naplnění $12$ bedýnek.','7.2 Vypočtěte, kolik nejméně bedýnek musí brigádník naplnit, aby si vydělal alespoň $1\\,000$ korun.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'7.1: prvních $10$ bedýnek po $40$ korunách $=400$; $11.$ a $12.$ bedýnka po $40\\cdot1{,}25=50$ korunách $=100$; celkem $500$ korun.','7.2: po $15$ bedýnkách má $400+5\\cdot50=650$ korun; od $16.$ bedýnky je odměna $40\\cdot1{,}5=60$ korun; chybí $1\\,000-650=350$, tj. $350:60\\Rightarrow6$ bedýnek ($6\\cdot60=360$). Celkem $15+6=21$ bedýnek.'},
  '7.1: $500$ korun; 7.2: $21$ bedýnek',
  4, 6, '4',
  new List<String>{'zs2','r9','aritmetika','procenta','slovni','vypocet','bezny-zivot'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 8',
  new List<String>{'Z celých dlaždic tvaru obdélníku o rozměrech $18\\ \\mathrm{cm}$ a $8\\ \\mathrm{cm}$ je sestaven nejmenší možný čtverec. Z každého ze čtyř rohů tohoto čtverce odebereme po jedné dlaždici a dostaneme nový útvar. (Jedna strana čtverce je rovnoběžná s delšími stranami všech dlaždic.)','8.1 Vypočtěte v cm délku strany sestaveného čtverce.','8.2 Vypočtěte počet dlaždic v novém útvaru.','8.3 Vypočtěte v cm obvod nového útvaru.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'8.1: strana čtverce je nejmenší společný násobek $18$ a $8$, tedy $\\mathrm{nsn}(18,8)=72\\ \\mathrm{cm}$.','8.2: čtverec obsahuje $\\frac{72\\cdot72}{18\\cdot8}=\\frac{5184}{144}=36$ dlaždic; po odebrání $4$ rohových dlaždic zbývá $32$ dlaždic.','8.3: odebráním obdélníkové dlaždice v rohu se obvod nezmění (chybějící vnější části nahradí stejně dlouhé zářezy), proto obvod $=4\\cdot72=288\\ \\mathrm{cm}$.'},
  '8.1: $a=72\\ \\mathrm{cm}$; 8.2: $32$ dlaždic; 8.3: $o=288\\ \\mathrm{cm}$',
  3, 6, '3',
  new List<String>{'zs2','r9','planimetrie','geometrie','obvod','slovni','vypocet','bez-kalkulacky'},
  'M9PCD21C0T03', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
