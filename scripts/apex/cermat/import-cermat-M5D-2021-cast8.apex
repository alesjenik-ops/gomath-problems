String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M5D 2021 – úloha 13',
  new List<String>{'V každém nákresu se do prázdných kroužků doplňují čísla podle vyznačených výpočtů. Z levého kroužku vznikne horní kroužek přičtením čísla u horní šipky a dolní kroužek přičtením čísla u dolní šipky (záporné číslo znamená odečtení). Do silně ohraničeného kroužku patří součet horního a dolního kroužku. Ve vzoru: z čísla $4$ vznikne $4+1=5$ a $4+3=7$, součet $5+7=12$.','Přiřaďte ke každému nákresu (13.1–13.3) číslo (A–F), které patří do silně ohraničeného kroužku.','13.1 U horní šipky je $-1$, u dolní šipky $+6$; ve spodním kroužku je číslo $18$. Silně ohraničený je výsledkový (poslední) kroužek.','13.2 Nákres je dvojitý, v obou částech je u horní šipky $+3$ a u dolní $-2$. Silně ohraničený je horní kroužek první části; ve druhé části je v horním kroužku číslo $64$.','13.3 Nákres je dvojitý, v obou částech je u horní šipky $-3$ a u dolní $-5$. Silně ohraničený je dolní kroužek první části; ve druhé části je ve výsledkovém kroužku číslo $120$.'},
  new List<String>{'A) číslo menší než $30$','B) $30$','C) $31$','D) $32$','E) $33$','F) číslo větší než $33$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 300" font-family="sans-serif" font-size="13"><path d="M40 37Q68 17 96 37M40 67Q92 87 144 67M40 135Q68 115 96 135M40 165Q92 185 144 165M218 135Q246 115 274 135M218 165Q270 185 322 165M40 233Q68 213 96 233M40 263Q92 283 144 263M218 233Q246 213 274 233M218 263Q270 283 322 263" fill="none" stroke="#000" stroke-width="1.1"/><g fill="#fff" stroke="#777" stroke-width="1.3"><circle cx="40" cy="52" r="15"/><circle cx="96" cy="52" r="15"/><circle cx="144" cy="52" r="15"/><circle cx="40" cy="150" r="15"/><circle cx="144" cy="150" r="15"/><circle cx="218" cy="150" r="15"/><circle cx="274" cy="150" r="15"/><circle cx="322" cy="150" r="15"/><circle cx="396" cy="150" r="15"/><circle cx="40" cy="248" r="15"/><circle cx="96" cy="248" r="15"/><circle cx="218" cy="248" r="15"/><circle cx="274" cy="248" r="15"/><circle cx="322" cy="248" r="15"/><circle cx="396" cy="248" r="15"/></g><g fill="#fff" stroke="#000" stroke-width="3"><circle cx="218" cy="52" r="15"/><circle cx="96" cy="150" r="15"/><circle cx="144" cy="248" r="15"/></g><text x="6" y="22">13.1</text><text x="144" y="57" text-anchor="middle" font-weight="bold">18</text><text x="68" y="13" text-anchor="middle">−1</text><text x="92" y="94" text-anchor="middle">+6</text><text x="120" y="57" text-anchor="middle">+</text><text x="183" y="57" text-anchor="middle">→</text><text x="6" y="120">13.2</text><text x="68" y="111" text-anchor="middle">+3</text><text x="92" y="192" text-anchor="middle">−2</text><text x="120" y="155" text-anchor="middle">+</text><text x="183" y="155" text-anchor="middle">→</text><text x="274" y="155" text-anchor="middle" font-weight="bold">64</text><text x="246" y="111" text-anchor="middle">+3</text><text x="270" y="192" text-anchor="middle">−2</text><text x="298" y="155" text-anchor="middle">+</text><text x="361" y="155" text-anchor="middle">→</text><text x="6" y="218">13.3</text><text x="68" y="209" text-anchor="middle">−3</text><text x="92" y="290" text-anchor="middle">−5</text><text x="120" y="253" text-anchor="middle">+</text><text x="183" y="253" text-anchor="middle">→</text><text x="396" y="253" text-anchor="middle" font-weight="bold">120</text><text x="246" y="209" text-anchor="middle">−3</text><text x="270" y="290" text-anchor="middle">−5</text><text x="298" y="253" text-anchor="middle">+</text><text x="361" y="253" text-anchor="middle">→</text></svg>',
  'nakresy.svg',
  'Tři schematické nákresy s kroužky a šipkami označenými výpočty.',
  'Nákresy k úloze 13',
  new List<String>{'13.1 Označíme levý kroužek $x$. Spodní kroužek $x+6=18$, tedy $x=12$; horní $x-1=11$; výsledek $11+18=29$ → A.','13.2 Ve druhé části $x_2+3=64$, tedy $x_2=61$; to je výsledek první části: $(x+3)+(x-2)=2x+1=61$, tedy $x=30$; silně ohraničený horní kroužek $x+3=33$ → E.','13.3 Ve druhé části $2x_2-8=120$, tedy $x_2=64$; v první části $2x-8=64$, tedy $x=36$; silně ohraničený dolní kroužek $x-5=31$ → C.'},
  '13.1: A (číslo $29$); 13.2: E ($33$); 13.3: C ($31$)',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
