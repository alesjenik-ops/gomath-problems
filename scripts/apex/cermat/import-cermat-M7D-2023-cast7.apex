String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M7D 2023 - uloha 14',
  new List<String>{'Kvetinarka vazala pouze dva druhy kytic - jednak se $3$ ruzemi, jednak s $5$ ruzemi. Kytic se $3$ ruzemi uvazala o $8$ mene nez kytic s $5$ ruzemi. Na vsechny kytice dohromady pouzila $128$ ruzi.','Kolik kytic kvetinarka celkem uvazala?'},
  new List<String>{'A) $30$ kytic','B) $32$ kytic','C) $34$ kytic','D) $36$ kytic','E) jiny pocet kytic'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Kytic s $5$ ruzemi $x$, se $3$ ruzemi $x-8$. Ruze: $5x+3(x-8)=128$, tj. $8x-24=128$, $8x=152$, $x=19$. Celkem $19+(19-8)=19+11=30$ kytic.'},
  'A) $30$ kytic',
  2, 4, '2',
  new List<String>{'zs2','r7','rovnice','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2023 - uloha 15',
  new List<String>{'Priradte ke kazde uloze (15.1-15.3) odpovidajici vysledek (A-F).','15.1 Letos se na gymnazium prihlasilo $420$ uchazecu, coz je o $40\\,\\%$ vice, nez se jich prihlasilo loni. Kolik uchazecu se na gymnazium prihlasilo loni?','15.2 On-line kurzu ceskeho jazyka se zucastnilo $180$ zaku, coz je o $25\\,\\%$ mene, nez se jich zucastnilo on-line kurzu matematiky. Kolik zaku se zucastnilo on-line kurzu matematiky?','15.3 Vcera navstivilo plavecky bazen celkem $680$ dospelych, mezi nimiz bylo muzu o $30\\,\\%$ mene nez zen. Kolik muzu vcera navstivilo plavecky bazen?'},
  new List<String>{'A) mene nez $240$','B) $240$','C) $260$','D) $280$','E) $300$','F) vice nez $300$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Loni $=420:1{,}4=300$ -> E.','15.2 Matematika $=180:0{,}75=240$ -> B.','15.3 Zeny $z$, muzi $0{,}7z$; $1{,}7z=680$, $z=400$, muzu $0{,}7\\cdot 400=280$ -> D.'},
  '15.1: E ($300$); 15.2: B ($240$); 15.3: D ($280$)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2023 - uloha 16',
  new List<String>{'Obrazce tvaru trojuhelniku se sestavuji skladanim sedych trojuhelniku do pater (viz obrazek). Sede trojuhelniky maji ve vrcholech puntiky a na stranach stejne dlouhe usecky. V prvnim obrazci je pouze jeden sedy trojuhelnik a kazdy dalsi obrazec ma o jedno patro vice nez predchozi. Pro $1$, $2$, $3$ patra je sedych trojuhelniku $1$, $3$, $6$, puntiku $3$, $6$, $10$ a usecek $3$, $9$, $18$.','16.1 Urcete pocet usecek v obrazci, ktery ma $5$ pater.','16.2 Pocet usecek v poslednim a v predposlednim obrazci se lisi o $96$. Urcete, o kolik se lisi pocet puntiku v poslednim a predposlednim obrazci.','16.3 V jednom obrazci je $300$ puntiku. Urcete pocet usecek v nasledujicim obrazci.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 130" font-family="sans-serif"><g fill="#c9c9c9" stroke="#555"><polygon points="50.0,25.0 39.0,44.0 61.0,44.0"/><polygon points="180.0,25.0 169.0,44.0 191.0,44.0"/><polygon points="169.0,44.0 158.0,63.0 180.0,63.0"/><polygon points="191.0,44.0 180.0,63.0 202.0,63.0"/><polygon points="330.0,25.0 319.0,44.0 341.0,44.0"/><polygon points="319.0,44.0 308.0,63.0 330.0,63.0"/><polygon points="341.0,44.0 330.0,63.0 352.0,63.0"/><polygon points="308.0,63.0 297.0,82.0 319.0,82.0"/><polygon points="330.0,63.0 319.0,82.0 341.0,82.0"/><polygon points="352.0,63.0 341.0,82.0 363.0,82.0"/></g><g fill="#000"><circle cx="50.0" cy="25.0" r="2.4"/><circle cx="39.0" cy="44.0" r="2.4"/><circle cx="61.0" cy="44.0" r="2.4"/><circle cx="180.0" cy="25.0" r="2.4"/><circle cx="169.0" cy="44.0" r="2.4"/><circle cx="191.0" cy="44.0" r="2.4"/><circle cx="158.0" cy="63.0" r="2.4"/><circle cx="180.0" cy="63.0" r="2.4"/><circle cx="202.0" cy="63.0" r="2.4"/><circle cx="330.0" cy="25.0" r="2.4"/><circle cx="319.0" cy="44.0" r="2.4"/><circle cx="341.0" cy="44.0" r="2.4"/><circle cx="308.0" cy="63.0" r="2.4"/><circle cx="330.0" cy="63.0" r="2.4"/><circle cx="352.0" cy="63.0" r="2.4"/><circle cx="297.0" cy="82.0" r="2.4"/><circle cx="319.0" cy="82.0" r="2.4"/><circle cx="341.0" cy="82.0" r="2.4"/><circle cx="363.0" cy="82.0" r="2.4"/></g><text x="428" y="72" font-size="22">...</text></svg>',
  'trojuhelniky-patra.svg',
  'Tri obrazce z sedych trojuhelniku (1, 2 a 3 patra) s puntiky ve vrcholech.',
  '1., 2. a 3. obrazec',
  new List<String>{'Pro $n$ pater: puntiku $\\frac{(n+1)(n+2)}{2}$, usecek $\\frac{3n(n+1)}{2}$.','16.1 $n=5$: usecek $\\frac{3\\cdot 5\\cdot 6}{2}=45$.','16.2 Rozdil usecek mezi sousednimi obrazci je $3n=96$, tedy $n=32$; rozdil puntiku je $n+1=33$.','16.3 $\\frac{(n+1)(n+2)}{2}=300$ dava $n=23$; nasledujici obrazec ma $24$ pater a usecek $\\frac{3\\cdot 24\\cdot 25}{2}=900$.'},
  '16.1: $45$ usecek; 16.2: o $33$ puntiku; 16.3: $900$ usecek',
  4, 7, '3',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
