String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD19C0T01';
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
  'CERMAT M9A 2019 – úloha 6',
  new List<String>{'Všichni chlapci atletického oddílu se seřadili do zástupu podle velikosti. Před Petrem stála jedna osmina celkového počtu chlapců. Hned za Petrem stál jeho bratr Radek a za Radkem ještě pět šestin celkového počtu chlapců. Neznámý celkový počet chlapců atletického oddílu označte $x$.','6.1 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli před Petrem.','6.2 V závislosti na veličině $x$ vyjádřete počet chlapců, kteří stáli za Petrem.','6.3 Vypočtěte celkový počet chlapců atletického oddílu.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Před Petrem stála jedna osmina všech chlapců, tj. $\\frac{x}{8}$.','6.2 Za Petrem stál Radek (jeden chlapec) a dále pět šestin všech chlapců, tj. $\\frac{5x}{6} + 1$.','6.3 Celkem: před Petrem $\\frac{x}{8}$, Petr $1$, za Petrem $\\frac{5x}{6} + 1$. Rovnice $\\frac{x}{8} + 1 + \\frac{5x}{6} + 1 = x$; $\\frac{x}{8} + \\frac{5x}{6} + 2 = x$; $\\frac{3x + 20x}{24} + 2 = x$; $x - \\frac{23x}{24} = 2$; $\\frac{x}{24} = 2$; $x = 48$.'},
  '6.1: $\\frac{x}{8}$; 6.2: $\\frac{5x}{6}+1$; 6.3: $48$ chlapců',
  4, 6, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2019 – úloha 7',
  new List<String>{'Na obrázku jsou sestaveny dvě různé dvojice ozubených koleček. Šedé kolečko má $15$ zubů a obě bílá kolečka $24$ zubů. Černé kolečko, které má méně zubů než bílé, se za každých $5$ sekund otočí třikrát.','7.1 Pro první dvojici koleček (šedé a bílé) určete, kolikrát se musí otočit šedé kolečko, než se poprvé obě kolečka vrátí do výchozí polohy.','7.2 Určete, kolikrát se černé kolečko otočí za $5$ minut.','7.3 Ve druhé dvojici koleček (bílé a černé) se obě kolečka vrátí do výchozí polohy poprvé po dvou otáčkách bílého kolečka. Vypočtěte, kolik zubů má černé kolečko.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 210" font-family="sans-serif"><circle cx="95" cy="105" r="36" fill="#bdbdbd" stroke="#000" stroke-width="6" stroke-dasharray="7 5"/><circle cx="95" cy="105" r="32" fill="#bdbdbd" stroke="#000" stroke-width="1"/><text x="95" y="110" font-size="16" text-anchor="middle" fill="#000">15</text><circle cx="184" cy="105" r="52" fill="#ffffff" stroke="#000" stroke-width="6" stroke-dasharray="7 5"/><circle cx="184" cy="105" r="48" fill="#ffffff" stroke="#000" stroke-width="1"/><text x="184" y="110" font-size="16" text-anchor="middle" fill="#000">24</text><text x="140" y="200" font-size="12" text-anchor="middle">1. dvojice</text><circle cx="400" cy="105" r="52" fill="#ffffff" stroke="#000" stroke-width="6" stroke-dasharray="7 5"/><circle cx="400" cy="105" r="48" fill="#ffffff" stroke="#000" stroke-width="1"/><text x="400" y="110" font-size="16" text-anchor="middle" fill="#000">24</text><circle cx="490" cy="105" r="38" fill="#333333" stroke="#000" stroke-width="6" stroke-dasharray="7 5"/><circle cx="490" cy="105" r="34" fill="#333333" stroke="#000" stroke-width="1"/><text x="450" y="200" font-size="12" text-anchor="middle">2. dvojice</text></svg>',
  'kolecka.svg',
  'Dvě dvojice ozubených koleček: šedé (15 zubů) s bílým (24 zubů) a bílé (24 zubů) s menším černým kolečkem.',
  'Dvě dvojice ozubených koleček',
  new List<String>{'7.1 Nejmenší společný násobek čísel $15$ a $24$ je $120$. Šedé kolečko se otočí $120:15 = 8$krát (bílé $120:24 = 5$krát).','7.2 $5$ minut $= 300$ sekund $= 60$ pětisekundových úseků; za každý se černé kolečko otočí $3$krát, celkem $60\\cdot 3 = 180$krát.','7.3 Dvě otáčky bílého kolečka odpovídají $2\\cdot 24 = 48$ zubům, což je nejmenší společný násobek počtů zubů obou koleček. Černé kolečko má méně než $24$ zubů a nejmenší společný násobek $24$ a jeho počtu zubů je $48$; to splňuje $16$ zubů (černé se přitom otočí $48:16 = 3$krát).'},
  '7.1: $8$krát; 7.2: $180$krát; 7.3: $16$ zubů',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
