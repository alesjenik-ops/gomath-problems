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
  'Zelený L15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Z dětí narozených v roce 1936 bylo $52\\,\\%$ chlapečků a $48\\,\\%$ děvčátek. Ze všech narozených v tomto roce žila v roce 2017 již jen pouhá jedna čtvrtina, muži však ze žijících osmdesátníků tvořili jen $28\\,\\%$. Kolik $\\%$ ze zemřelých, kteří se narodili v roce 1936, tvořili muži?','15.2 Do obou devítek – Áčka i Béčka – chodí stejný počet žáků. V naší třídě je ale jen $30\\,\\%$ kluků, zatímco v Béčku je jejich podíl dvakrát větší. Kolik $\\%$ deváťáků jsou chlapci?','15.3 Manželé Vojta a Ivana Novákovi si za loňský rok dohromady vydělali o čtvrtinu více než v roce předchozím, tedy o $300\\,000$ korun. Vojta si proti předchozímu roku vloni polepšil o osminu a vydělal vloni o polovinu více než Ivana. O kolik $\\%$ si meziročně polepšila Ivana?'},
  new List<String>{'A) o $45\\,\\%$','B) o $50\\,\\%$','C) o $55\\,\\%$','D) o $60\\,\\%$','E) o $65\\,\\%$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Ze $100$ narozených: chlapců $52$, dívek $48$. Žije $\\frac{1}{4}$, tj. $25$; z nich mužů $28\\,\\%$, tj. $7$, žen $18$. Zemřelo $75$: mužů $52-7=45$, žen $48-18=30$. Podíl mužů mezi zemřelými $\\frac{45}{75}=60\\,\\%$ → D.','15.2 Obě třídy mají stejný počet žáků. Chlapců je v Áčku $30\\,\\%$ a v Béčku dvakrát více, tj. $60\\,\\%$. Průměr $\\frac{30+60}{2}=45\\,\\%$ → A.','15.3 Celkem loni $1\\,500\\,000$ Kč (o čtvrtinu, tj. o $300\\,000$ Kč, více než $1\\,200\\,000$ Kč). Loni $V_1=1{,}5\\cdot I_1$ a $V_1+I_1=1\\,500\\,000$, tedy $I_1=600\\,000$, $V_1=900\\,000$. Vojta si polepšil o osminu: $V_0=\\frac{8}{9}\\cdot 900\\,000=800\\,000$, takže $I_0=1\\,200\\,000-800\\,000=400\\,000$. Ivana: $\\frac{600\\,000}{400\\,000}=1{,}5$, polepšila si o $50\\,\\%$ → B.'},
  '15.1: D (o $60\\,\\%$); 15.2: A (o $45\\,\\%$); 15.3: B (o $50\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený L16 – závod k táborové škole',
  new List<String>{'Na prázdninovém táboře jsme běželi závod od tábora k místní škole a zpět. Celkově byla trať dlouhá $3\\,900$ metrů, start i cíl byly u brány tábora a v polovině trasy jsme se u školy obraceli zpět. Startovali jsme po dvojicích a já jsem běžel s Válečkem. Ten na mne od začátku ztrácel. Poté, co jsem obrátil u školy, potkali jsme se $50$ metrů od obrátky.','16.1 Vypočtěte, kolik metrů bude chybět ještě Válečkovi do cíle v momentě, kdy do cíle doběhnu já. (Předpokládáme, že já i Váleček běžíme celou trasu stejnou rychlostí.)','16.2 Vypočtěte, o kolik sekund po mně doběhne Váleček do cíle, jestliže já jsem dosáhl času 19:00 min.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 240" font-family="sans-serif"> <rect x="40" y="90" width="46" height="46" fill="#333"/> <polygon points="63,100 78,128 48,128" fill="#fff"/> <text x="63" y="82" font-size="13" text-anchor="middle" font-weight="bold">TÁBOR</text> <text x="28" y="152" font-size="12">START / CÍL</text> <rect x="440" y="66" width="58" height="48" fill="#bbb" stroke="#000"/> <text x="469" y="56" font-size="13" text-anchor="middle" font-weight="bold">ŠKOLA</text> <line x1="90" y1="104" x2="420" y2="90" stroke="#000" stroke-width="1.5"/> <line x1="90" y1="120" x2="420" y2="106" stroke="#000" stroke-width="1.5"/> <path d="M420 90 C 445 94 445 102 420 106" fill="none" stroke="#000" stroke-width="1.5"/> <circle cx="405" cy="107" r="4" fill="#000"/> <line x1="405" y1="107" x2="420" y2="98" stroke="#555" stroke-width="1"/> <text x="300" y="140" font-size="12">místo setkání 50 m od obrátky</text> </svg>',
  'zavod.svg',
  'Schéma trati závodu od tábora ke škole a zpět; obrátka je u školy a místo setkání běžců je 50 m od obrátky.',
  'Schéma závodní trati (schematický nákres)',
  new List<String>{'16.1 Obrátka je v polovině, tj. na $1\\,950$ m. Když jsem já od obrátky uběhl $50$ m (celkem $2\\,000$ m), Váleček měl do obrátky ještě $50$ m, tj. uběhl $1\\,900$ m. Poměr rychlostí je $2\\,000:1\\,900=20:19$. Až doběhnu já $3\\,900$ m, Váleček uběhne $3\\,900\\cdot\\frac{19}{20}=3\\,705$ m, chybí mu $3\\,900-3\\,705=195$ m.','16.2 Můj čas 19:00 min $=1\\,140$ s. Válečkův čas $=1\\,140\\cdot\\frac{20}{19}=1\\,200$ s. Doběhne o $1\\,200-1\\,140=60$ s později.'},
  '16.1: $195$ m; 16.2: o $60$ s později',
  5, 8, '3',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
