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
  'Zelený H15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Je-li dřevěná krabice plná, váží samotný obal pětinu váhy celého balení. Kolik $\\%$ váhy celého balení bude tvořit samotný obal, bude-li krabice naplněna ze tří čtvrtin?','15.2 V listopadu propustila výstupní kontrola $98\\,\\%$ zhotovených výrobků. V následujícím měsíci kontrola ze $3000$ výrobků vyřadila pouhých $36$. O kolik procent klesla v prosinci vadnost výrobků ve srovnání s předchozím měsícem?','15.3 Každý žák z posledního ročníku podal dvě přihlášky na střední školu. Celkem $40\\,\\%$ podalo přihlášku alespoň na jedno gymnázium, $60\\,\\%$ alespoň na jednu střední odbornou školu a $40\\,\\%$ žáků podalo alespoň jednu přihlášku na učiliště. Z těch, kteří podali přihlášku na $2$ typy středních škol, čtvrtina podala jednu přihlášku na gymnázium a jednu na SOŠ. Tři čtvrtiny žáků podaly jednu přihlášku na SOŠ a jednu na učiliště. Kolik $\\%$ žáků podalo obě přihlášky na gymnázium?'},
  new List<String>{'A) $10\\,\\%$','B) $20\\,\\%$','C) $30\\,\\%$','D) $40\\,\\%$','E) $50\\,\\%$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Obal $=\\frac{1}{5}$ plného balení, tedy náplň má $4$ díly obalu. Při naplnění ze $\\frac{3}{4}$ je náplň $3$ díly, celek $4$ díly, obal $\\frac{1}{4}=25\\,\\%$ → F.','15.2 Listopad vadnost $2\\,\\%$; prosinec $\\frac{36}{3000}=1{,}2\\,\\%$. Pokles $\\frac{2-1{,}2}{2}=40\\,\\%$ → D.','15.3 Na dva typy škol se hlásí $40\\,\\%$ žáků; z nich gymnázium a SOŠ $10\\,\\%$, SOŠ a učiliště $30\\,\\%$, gymnázium a učiliště $0\\,\\%$. Aspoň jedno gymnázium má $40\\,\\%$, takže obě přihlášky na gymnázium $40-10-0=30\\,\\%$ → C.'},
  '15.1: F ($25\\,\\%$); 15.2: D (o $40\\,\\%$); 15.3: C ($30\\,\\%$)',
  6, 10, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený H16 – rychlíková souprava',
  new List<String>{'Rychlíková souprava sestává ze čtyř $50$ m dlouhých částí. Souprava jede rychlostí $180$ km/h.','16.1 Vypočtěte, jak dlouhé je nástupiště na nádraží, kterým projíždí, jestliže jej souprava mine za $9$ sekund (dobou míjení nástupiště se rozumí doba mezi stavem 1 a stavem 2 na obrázku).','16.2 Vypočtěte délku brzdné dráhy vlaku, jestliže od okamžiku, kdy začne vlak rovnoměrně brzdit, do okamžiku zastavení uplyne $20$ sekund.','16.3 Vypočtěte, jakou rychlostí jede protijedoucí nákladní vlak dlouhý $500$ metrů, jestliže se s ním naše rychlíková souprava míjí $10$ sekund.'},
  null,
  6,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 210" font-family="sans-serif"> <line x1="20" y1="150" x2="480" y2="150" stroke="#000"/> <rect x="150" y="164" width="200" height="26" fill="#eeeeee" stroke="#000"/> <text x="250" y="182" font-size="15" text-anchor="middle">nástupiště</text> <rect x="40" y="120" width="90" height="26" rx="8" fill="#dddddd" stroke="#000"/> <line x1="63" y1="120" x2="63" y2="146" stroke="#000"/><line x1="85" y1="120" x2="85" y2="146" stroke="#000"/><line x1="108" y1="120" x2="108" y2="146" stroke="#000"/> <line x1="55" y1="105" x2="120" y2="105" stroke="#000"/><polygon points="120,105 112,101 112,109" fill="#000"/> <rect x="370" y="120" width="90" height="26" rx="8" fill="#dddddd" stroke="#000"/> <line x1="393" y1="120" x2="393" y2="146" stroke="#000"/><line x1="415" y1="120" x2="415" y2="146" stroke="#000"/><line x1="438" y1="120" x2="438" y2="146" stroke="#000"/> <line x1="380" y1="105" x2="445" y2="105" stroke="#000"/><polygon points="445,105 437,101 437,109" fill="#000"/> <ellipse cx="185" cy="55" rx="46" ry="18" fill="none" stroke="#000"/><text x="185" y="60" font-size="14" text-anchor="middle">STAV 1</text> <ellipse cx="305" cy="55" rx="46" ry="18" fill="none" stroke="#000"/><text x="305" y="60" font-size="14" text-anchor="middle">STAV 2</text> <line x1="170" y1="73" x2="128" y2="118" stroke="#000" stroke-width="0.7"/> <line x1="320" y1="73" x2="372" y2="118" stroke="#000" stroke-width="0.7"/> </svg>',
  'vlak-nastupiste.svg',
  'Rychlíková souprava míjí nástupiště; stav 1 před nástupištěm a stav 2 za nástupištěm.',
  'Výchozí obrázek k úloze 16',
  new List<String>{'16.1 Rychlost $180$ km/h $=50$ m/s, délka soupravy $4\\cdot50=200$ m. Za $9$ s ujede $450$ m; to je délka nástupiště plus délka soupravy, tedy nástupiště $450-200=250$ m.','16.2 Rovnoměrné brzdění z $50$ m/s na $0$ za $20$ s: dráha $=\\frac{50}{2}\\cdot20=500$ m.','16.3 Míjení dvou vlaků: součet délek $200+500=700$ m za $10$ s, tj. relativní rychlost $70$ m/s. Rychlost nákladního vlaku $70-50=20$ m/s $=72$ km/h.'},
  '16.1: $250$ m; 16.2: $500$ m; 16.3: $72$ km/h',
  6, 9, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
