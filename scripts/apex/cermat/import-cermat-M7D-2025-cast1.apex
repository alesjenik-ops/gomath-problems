String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD25C0T04';
Integer YEAR = 2025;

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
  'CERMAT M7D 2025 - uloha 1',
  new List<String>{'Plavec uplave v bazenu rovnomernym tempem $2$ kilometry za $48$ minut.','Vypoctete, za kolik minut uplave plavec timto tempem celkem $5$ padesatimetrovych bazenu.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'$2$ km $=2000$ m; $5$ bazenu po $50$ m je $250$ m. To je $\\frac{250}{2000}=\\frac{1}{8}$ trasy, tedy $48:8=6$ minut.'},
  '$6$ minut',
  1, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2025 - uloha 2',
  new List<String>{'Pomer dvou neznamych prirozenych cisel je $4:5$ a dvojnasobky techto dvou cisel se lisi o $6$.','Urcete obe neznama cisla.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Cisla maji tvar $4k$ a $5k$. Jejich dvojnasobky $8k$ a $10k$ se lisi o $2k=6$, tedy $k=3$. Cisla jsou $12$ a $15$.'},
  '$12$; $15$',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 3.1',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\left(\\dfrac{7}{5}-\\dfrac{7}{4}\\right):\\left(2-\\dfrac{6}{5}\\cdot\\dfrac{4}{3}\\right)=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Zavorky: $\\dfrac{7}{5}-\\dfrac{7}{4}=-\\dfrac{7}{20}$ a $2-\\dfrac{6}{5}\\cdot\\dfrac{4}{3}=2-\\dfrac{8}{5}=\\dfrac{2}{5}$. Pak $-\\dfrac{7}{20}:\\dfrac{2}{5}=-\\dfrac{7}{20}\\cdot\\dfrac{5}{2}=-\\dfrac{7}{8}$.'},
  '$-\\dfrac{7}{8}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 3.2',
  new List<String>{'Vypoctete a vysledek zapiste zlomkem v zakladnim tvaru:','$\\dfrac{\\dfrac{8}{7}\\cdot\\left(1+\\dfrac{1}{7}\\right)\\cdot\\dfrac{7}{4}}{5-\\dfrac{9}{5}}=$'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'Citatel: $\\dfrac{8}{7}\\cdot\\dfrac{8}{7}\\cdot\\dfrac{7}{4}=\\dfrac{16}{7}$. Jmenovatel: $5-\\dfrac{9}{5}=\\dfrac{16}{5}$. Pak $\\dfrac{16}{7}:\\dfrac{16}{5}=\\dfrac{5}{7}$.'},
  '$\\dfrac{5}{7}$',
  2, 3, '3',
  new List<String>{'zs2','r7','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7D 2025 - uloha 4',
  new List<String>{'Martin ma jednobarevne kulicky. Jedna tretina vsech Martinovych kulicek je zlutych, $40\\,\\%$ kulicek je modrych a zbyvajicich $12$ kulicek je cervenych.','4.1 Urcete pocet vsech Martinovych kulicek.','4.2 Vyjadrete zlomkem v zakladnim tvaru, jakou cast vsech Martinovych kulicek tvori cervene kulicky.','4.3 Martin da kamaradce tolik cervenych kulicek, aby polovinu jeho zbylych kulicek tvorily modre kulicky. Urcete, kolik cervenych kulicek da Martin kamaradce.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Zlute $\\frac{1}{3}$, modre $\\frac{2}{5}$, dohromady $\\frac{5}{15}+\\frac{6}{15}=\\frac{11}{15}$. Cervene tvori zbytek $\\frac{4}{15}$, coz je $12$ kulicek, tedy celkem $12\\cdot\\frac{15}{4}=45$ kulicek.','4.2 Cervene tvori $\\frac{4}{15}$ vsech kulicek.','4.3 Modrych je $\\frac{2}{5}\\cdot 45=18$. Po darovani $x$ cervenych zbyde $45-x$ kulicek a plati $\\frac{45-x}{2}=18$, tedy $45-x=36$ a $x=9$.'},
  '4.1: $45$ kulicek; 4.2: $\\dfrac{4}{15}$; 4.3: $9$ cervenych kulicek',
  3, 5, '3',
  new List<String>{'zs2','r7','procenta','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2025 - uloha 5',
  new List<String>{'Na odvoz beden ze skladu se pouzivaji dva ruzni roboti A, B. Ve skladu bylo $95$ beden. Bedny nejprve odvazel robot A, a to po $5$ kusech. Jezdil v pravidelnych intervalech a odvezl ze skladu za $2$ hodiny celkem $50$ beden. Pak pokracoval robot B, ktery vozil bedny jen po $3$ kusech, avsak v kratsich pravidelnych intervalech. Odvezl tak ze skladu za $1{,}5$ hodiny zbyvajicich $45$ beden.','5.1 Vyjadrete v zakladnim tvaru pomer poctu beden odvezenych ze skladu za $1$ hodinu robotem A ku poctu beden odvezenych za $1$ hodinu robotem B.','5.2 Vyjadrete v zakladnim tvaru pomer poctu jizd robota A za hodinu ku poctu jizd robota B za hodinu.','5.3 Vypoctete, kolik beden by ze skladu odvezli za $36$ minut oba roboti dohromady pri spolecnem provozu.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'Robot A odveze $50:2=25$ beden za hodinu, robot B $45:1{,}5=30$ beden za hodinu.','5.1 Pomer $25:30=5:6$.','5.2 Robot A jezdi $25:5=5$ jizd za hodinu, robot B $30:3=10$ jizd za hodinu; pomer $5:10=1:2$.','5.3 Dohromady $25+30=55$ beden za hodinu. Za $36$ minut ($\\frac{3}{5}$ hodiny) to je $55\\cdot\\frac{3}{5}=33$ beden.'},
  '5.1: $5:6$; 5.2: $1:2$; 5.3: $33$ beden',
  4, 6, '3',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
