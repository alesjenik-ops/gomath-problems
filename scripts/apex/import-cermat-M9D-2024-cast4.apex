String SRC   = 'CERMAT – Jednotná přijímací zkouška 2024, 2. náhradní termín (M9D)';
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
  'CERMAT 2024 M9D · úloha 12',
  new List<String>{'Petr přečetl již $1\\,050$ stran, do konce mu zbývá $450$ stran. Kolik procent stran mu zbývá dočíst?'},
  new List<String>{'A) $27\\ \\%$','B) $30\\ \\%$','C) $33\\ \\%$','D) $40\\ \\%$','E) $43\\ \\%$'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $1\\,050+450=1\\,500$ stran; zbývá $\\frac{450}{1\\,500}=30\\ \\%$.'},
  'B) $30\\ \\%$',
  2, 3, '2',
  new List<String>{'zs2','r9','procenta','slovni','vypocet','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 13',
  new List<String>{'Maminka oškrabe $6\\ \\mathrm{kg}$ brambor za $2$ hodiny a $24$ minut, babička $2\\ \\mathrm{kg}$ za $1$ hodinu a $20$ minut. Za kolik minut oškrabou $1\\ \\mathrm{kg}$ dohromady?'},
  new List<String>{'A) za $64$ minut','B) za $32$ minut','C) za $15$ minut','D) za $12$ minut','E) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Maminka $\\frac{6}{144}=\\frac{1}{24}\\ \\mathrm{kg/min}$, babička $\\frac{2}{80}=\\frac{1}{40}\\ \\mathrm{kg/min}$.','Dohromady $\\frac{1}{24}+\\frac{1}{40}=\\frac{1}{15}\\ \\mathrm{kg/min}$, tedy $1\\ \\mathrm{kg}$ za $15$ minut.'},
  'C) za $15$ minut',
  2, 4, '3',
  new List<String>{'zs2','r9','zlomky','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 14',
  new List<String>{'Přímky $p$, $r$, $s$ se protínají v jednom bodě. V obrázku je vyznačen úhel $126^\\circ30\'$ a pravý úhel; hledané úhly jsou $\\alpha$, $\\beta$, $\\gamma$.','Jaký je součet úhlů $\\alpha+\\beta+\\gamma$? (Velikosti neměřte, ale vypočítejte.)'},
  new List<String>{'A) $126^\\circ30\'$','B) $133^\\circ30\'$','C) $143^\\circ30\'$','D) $180^\\circ$','E) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Z úhlů kolem průsečíku tří přímek, z vyznačeného úhlu $126^\\circ30\'$ a pravého úhlu se dopočtou $\\alpha$, $\\beta$, $\\gamma$.','Jejich součet je $\\alpha+\\beta+\\gamma=143^\\circ30\'$.'},
  'C) $143^\\circ30\'$',
  2, 4, '4',
  new List<String>{'zs2','r9','geometrie','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 15',
  new List<String>{'Kilogram dražších jablek stojí $30$ Kč, kilogram levnějších $25$ Kč. Paní Vitamínová koupila $x$ kilogramů ($x$ celé číslo) a zaplatila $330$ Kč.','Rozhodněte o každém z tvrzení, zda je pravdivé (A), či nikoli (N):','15.1 Pokud koupila $12\\ \\mathrm{kg}$, koupila stejná množství obou druhů.','15.2 Mohla koupit jen levnější druh jablek.','15.3 Chce-li koupit co nejvíce kilogramů, musí koupit právě $1\\ \\mathrm{kg}$ dražších.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: $6\\ \\mathrm{kg}$ dražších a $6\\ \\mathrm{kg}$ levnějších: $6\\cdot30+6\\cdot25=330$ Kč — A.','15.2: jen levnější: $25x=330\\Rightarrow x=13{,}2$, není celé — N.','15.3: nejvíce kg dává $1\\ \\mathrm{kg}$ dražších a $12\\ \\mathrm{kg}$ levnějších ($30+300=330$, celkem $13\\ \\mathrm{kg}$) — A.'},
  '15.1: A; 15.2: N; 15.3: A',
  3, 5, '4',
  new List<String>{'zs2','r9','aritmetika','rovnice','argumentace','slovni','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);
c.add(
  'CERMAT 2024 M9D · úloha 16',
  new List<String>{'Přiřaďte ke každé podúloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Zvětšíme-li neznámé číslo o $4\\ \\%$, dostaneme $780$. Jaké je to číslo?','16.2 O kolik procent musíme zvětšit $\\dfrac{1}{8}$, abychom dostali $\\dfrac{1}{2}$?','16.3 Výkony dvou čerpadel jsou v poměru $3:7$. Méně výkonné vyčerpá $150$ litrů za dvě hodiny. Kolik litrů vyčerpá výkonnější za $5$ hodin?'},
  new List<String>{'A) $300$','B) $400$','C) $720$','D) $750$','E) $875$','F) jiný výsledek'},
  null,
  null,
  null,
  null,
  null,
  new List<String>{'16.1: $1{,}04\\cdot x=780\\Rightarrow x=750$ — D.','16.2: $\\frac{\\frac{1}{2}-\\frac{1}{8}}{\\frac{1}{8}}=\\frac{\\frac{3}{8}}{\\frac{1}{8}}=3=300\\ \\%$ — A.','16.3: méně výkonné $\\frac{150}{2}=75$ l/h; výkonnější $75\\cdot\\frac{7}{3}=175$ l/h; za $5$ h $875$ litrů — E.'},
  '16.1: D ($750$); 16.2: A ($300\\ \\%$); 16.3: E ($875$)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','slovni','modelovani','bez-kalkulacky','bezny-zivot'},
  'M9PDD24C0T04', 2024
);

System.debug('Vytvořeno úloh: '+c.created);
