String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD21C0T01';
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
  'CERMAT M7A 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Nemocnice obdržela $50\\,000$ dávek vakcíny a $92\\,\\%$ jich již použila k očkování. Kolik dávek vakcíny nemocnici zbývá?','15.2 Prováděla se kontrola kvality všech pamětních mincí. Požadovanou kvalitu nemělo $10\\,\\%$ mincí, zbývajících $2\\,700$ mincí bylo v pořádku. Kolik pamětních mincí bylo celkem zkontrolováno?','15.3 Hořká čokoláda tvořila $24\\,\\%$ celkového množství vyrobené čokolády, mléčné se vyrobilo o polovinu více než hořké a oříškové $1\\,120$ kg. Kolik kilogramů čokolády se celkem vyrobilo?'},
  new List<String>{'A) $2\\,800$','B) $3\\,000$','C) $3\\,200$','D) $3\\,600$','E) $4\\,000$','F) jiný počet'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Zbývá $8\\,\\%$ z $50\\,000$, tj. $0{,}08\\cdot 50\\,000=4\\,000$ dávek → E.','15.2 Kvalitních je $90\\,\\%=2\\,700$, celek $2\\,700:0{,}9=3\\,000$ mincí → B.','15.3 Hořká $24\\,\\%$, mléčná $36\\,\\%$, dohromady $60\\,\\%$; oříšková je $40\\,\\%=1\\,120$ kg, celek $1\\,120:0{,}4=2\\,800$ kg → A.'},
  '15.1: E ($4\\,000$); 15.2: B ($3\\,000$); 15.3: A ($2\\,800$)',
  6, 9, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2021 – úloha 16',
  new List<String>{'První obrazec tvoří jediný puntík. V dalších obrazcích jsou puntíky uspořádány ve čtvercích. Strana hraničního čtverce druhého obrazce obsahuje $3$ puntíky a u každého následujícího obrazce má vždy o $2$ puntíky více (např. strana $5.$ obrazce má $9$ puntíků). Počínaje třetím obrazcem vidíme uvnitř hraničního čtverce vždy celý obrazec s pořadovým číslem o $2$ menším. Počty puntíků: $1.$ obrazec $1$, $2.$ obrazec $8$, $3.$ obrazec $17$, $4.$ obrazec $32$, $5.$ obrazec $49$.','Určete:','16.1 kolik puntíků obsahuje jedna strana hraničního čtverce $10.$ obrazce,','16.2 o kolik se liší počty puntíků v $9.$ a $11.$ obrazci,','16.3 u kolikátého obrazce se počty puntíků v okolních dvou obrazcích (těsně před a těsně za ním) liší o $120$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 200" font-family="sans-serif" font-size="13"><text x="60" y="36" text-anchor="middle">1.</text><circle cx="60" cy="108" r="3.5" fill="#000"/><text x="160" y="36" text-anchor="middle">2.</text><circle cx="138" cy="76" r="3.5" fill="#000"/><circle cx="160" cy="76" r="3.5" fill="#000"/><circle cx="182" cy="76" r="3.5" fill="#000"/><circle cx="138" cy="98" r="3.5" fill="#000"/><circle cx="182" cy="98" r="3.5" fill="#000"/><circle cx="138" cy="120" r="3.5" fill="#000"/><circle cx="160" cy="120" r="3.5" fill="#000"/><circle cx="182" cy="120" r="3.5" fill="#000"/><text x="332" y="36" text-anchor="middle">3.</text><circle cx="288" cy="54" r="3.5" fill="#000"/><circle cx="310" cy="54" r="3.5" fill="#000"/><circle cx="332" cy="54" r="3.5" fill="#000"/><circle cx="354" cy="54" r="3.5" fill="#000"/><circle cx="376" cy="54" r="3.5" fill="#000"/><circle cx="288" cy="76" r="3.5" fill="#000"/><circle cx="376" cy="76" r="3.5" fill="#000"/><circle cx="288" cy="98" r="3.5" fill="#000"/><circle cx="376" cy="98" r="3.5" fill="#000"/><circle cx="288" cy="120" r="3.5" fill="#000"/><circle cx="376" cy="120" r="3.5" fill="#000"/><circle cx="288" cy="142" r="3.5" fill="#000"/><circle cx="310" cy="142" r="3.5" fill="#000"/><circle cx="332" cy="142" r="3.5" fill="#000"/><circle cx="354" cy="142" r="3.5" fill="#000"/><circle cx="376" cy="142" r="3.5" fill="#000"/><circle cx="332" cy="98" r="3.5" fill="#000"/><text x="470" y="112" font-size="20">…</text></svg>',
  'puntiky.svg',
  'První až třetí obrazec: jeden puntík, čtvercový rám z 8 puntíků a čtvercový rám z 16 puntíků s jedním puntíkem uprostřed.',
  '1., 2. a 3. obrazec (schematicky)',
  new List<String>{'Strana hraničního čtverce $n$-tého obrazce má $2n-1$ puntíků. Počet puntíků $P(n)$ splňuje $P(n)=4(2n-2)+P(n-2)$, takže rozdíl sousedních přes jeden je $P(n+1)-P(n-1)=8n$.','16.1 Strana $10.$ obrazce: $2\\cdot 10-1=19$ puntíků.','16.2 $P(11)-P(9)=8\\cdot 10=80$ puntíků.','16.3 $P(n+1)-P(n-1)=8n=120\\Rightarrow n=15$; jde o $15.$ obrazec.'},
  '16.1: $19$ puntíků; 16.2: o $80$ puntíků; 16.3: u $15.$ obrazce',
  4, 7, '4',
  new List<String>{'zs2','r7','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
