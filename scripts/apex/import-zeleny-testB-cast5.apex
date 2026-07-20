String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený B14 – obsah útvaru (půlkruh a trojúhelník)',
  new List<String>{'Na obrázku je vyznačen plošný útvar složený z poloviny kruhu o průměru $80$ mm a rovnoramenného trojúhelníka, jehož základnu tvoří průměr kruhu.','Jaký je obsah tohoto útvaru? Výsledek vyjádřete v cm². $\\pi=3{,}14$.'},
  new List<String>{'A) $28{,}56$ cm²','B) $33{,}12$ cm²','C) $41{,}12$ cm²','D) $57{,}12$ cm²','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 370" font-family="sans-serif"> <circle cx="180" cy="180" r="120" fill="none" stroke="#999" stroke-width="1" stroke-dasharray="2 5"/> <path d="M 60 180 A 120 120 0 0 0 300 180" fill="none" stroke="#000" stroke-width="2.5"/> <polygon points="60,180 300,180 180,60" fill="none" stroke="#000" stroke-width="2.5"/> <line x1="60" y1="180" x2="60" y2="322" stroke="#000" stroke-width="1" stroke-dasharray="5 5"/> <line x1="300" y1="180" x2="300" y2="322" stroke="#000" stroke-width="1" stroke-dasharray="5 5"/> <line x1="60" y1="318" x2="300" y2="318" stroke="#000" stroke-width="1"/> <polygon points="60,318 70,314 70,322" fill="#000"/><polygon points="300,318 290,314 290,322" fill="#000"/> <text x="180" y="342" font-size="17" text-anchor="middle">80 mm</text> </svg>',
  'pulkruh-trojuhelnik.svg',
  'Plošný útvar složený z dolní poloviny kruhu o průměru 80 mm a rovnoramenného trojúhelníku nad průměrem, jehož vrchol dosahuje k okraji kruhu.',
  'Útvar z půlkruhu a trojúhelníku',
  new List<String>{'Průměr $80$ mm $=8$ cm, poloměr $r=4$ cm. Půlkruh: $\\frac{1}{2}\\pi r^2=\\frac{1}{2}\\cdot 3{,}14\\cdot 16=25{,}12$ cm². Trojúhelník má základnu $8$ cm a výšku rovnou poloměru $4$ cm: $\\frac{8\\cdot 4}{2}=16$ cm². Celkem $25{,}12+16=41{,}12$ cm².'},
  'C) $41{,}12$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený B15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Na počátku hry byl poměr modrých a červených žetonů v banku $1:1$. V polovině hry však počet modrých žetonů v banku klesl o $60\\,\\%$ a počet červených o $20\\,\\%$. Jaký podíl z žetonů v banku tvořily v polovině hry modré žetony?','15.2 Když se stroj dostal do plného výkonu, spotřeba nafty náhle stoupla o jednu polovinu. Přechodem do stabilních otáček poté spotřeba naopak o polovinu klesla. O kolik nižší byla spotřeba stroje ve stabilních otáčkách ve srovnání se spotřebou stroje v době, než se dostal do plného výkonu?','15.3 V letech 2015 i 2016 se nám podařilo vždy meziročně zdvojnásobit obrat. O kolik nižší byl obrat v roce 2014 ve srovnání s rokem 2016?'},
  new List<String>{'A) $\\frac{1}{4}$','B) $\\frac{1}{3}$','C) $\\frac{1}{2}$','D) $\\frac{2}{3}$','E) $\\frac{3}{4}$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Ze $100:100$ zbude modrých $100\\cdot 0{,}4=40$ a červených $100\\cdot 0{,}8=80$. Podíl modrých $\\frac{40}{120}=\\frac{1}{3}$ → B.','15.2 Ze spotřeby $1$: plný výkon $1{,}5$, stabilní otáčky $1{,}5\\cdot\\frac{1}{2}=0{,}75$. To je o $0{,}25=\\frac{1}{4}$ méně než $1$ → A.','15.3 Obrat: $2014=x$, $2015=2x$, $2016=4x$. Rok $2014$ je oproti $2016$ nižší o $\\frac{3x}{4x}=\\frac{3}{4}$ → E.'},
  '15.1: B ($\\frac{1}{3}$); 15.2: A ($\\frac{1}{4}$); 15.3: E ($\\frac{3}{4}$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
