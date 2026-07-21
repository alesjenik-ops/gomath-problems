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
  'CERMAT 2021 M9C · úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V domově pro seniory je $120$ klientů a $84$ z nich bylo očkováno. Kolik procent klientů domova pro seniory nebylo očkováno?','15.2 Vláďa má $40$ kartiček. Roman má o čtvrtinu kartiček více než Vláďa. O kolik procent má Vláďa méně kartiček než Roman?','15.3 Cena za víkendový pobyt činila $2\\,000$ korun a zahrnovala pouze dopravu, ubytování a stravování. Cena dopravy tvořila čtvrtinu ceny pobytu, ubytování stálo $800$ korun. Kolik procent ceny pobytu tvořila cena stravování?','Nabídka: A) $20\\ \\%$; B) $25\\ \\%$; C) $30\\ \\%$; D) $33\\ \\%$; E) $35\\ \\%$; F) jiný počet procent.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'15.1: neočkováno $120-84=36$; $\\frac{36}{120}=0{,}30=30\\ \\%$ — \\textbf{C}.','15.2: Roman $=40\\cdot1{,}25=50$ kartiček; Vláďa má o $50-40=10$ méně; $\\frac{10}{50}=0{,}20=20\\ \\%$ — \\textbf{A}.','15.3: doprava $=\\frac{1}{4}\\cdot2\\,000=500$; stravování $=2\\,000-500-800=700$; $\\frac{700}{2\\,000}=0{,}35=35\\ \\%$ — \\textbf{E}.'},
  '15.1: C; 15.2: A; 15.3: E',
  6, 8, '3',
  new List<String>{'zs2','r9','procenta','aritmetika','slovni','prirazovani','bez-kalkulacky','bezny-zivot'},
  'M9PCD21C0T03', 2021
);
c.add(
  'CERMAT 2021 M9C · úloha 16',
  new List<String>{'Trojúhelníkové obrazce se podle vzoru sestavují z tmavých šestiúhelníků a bílých trojúhelníků. Šestiúhelník se skládá ze $6$ shodných tmavých trojúhelníků. Řady obrazce jsou očíslovány vždy od nejkratší (řada $1$ – vrchol dole) po nejdelší; řada $k$ obsahuje $2k-1$ malých trojúhelníků. Na obrázku jsou tři nejmenší obrazce, které mají $3$, $5$ a $7$ řad.','Ze vzoru: vrchol (řada $1$) je jeden bílý trojúhelník. Tmavé šestiúhelníky vznikají po dvojicích řad – např. v obrazci se $7$ řadami je v řadách $2$–$3$ jeden šestiúhelník, v řadách $4$–$5$ dva a v řadách $6$–$7$ tři šestiúhelníky. Bílé trojúhelníky doplňují okraje a mezery mezi šestiúhelníky.','Obrazec má $19$ řad. Určete počet:','16.1 bílých trojúhelníků v $9.$ řadě,','16.2 tmavých trojúhelníků v $16.$ řadě,','16.3 tmavých šestiúhelníků v celém obrazci.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'V každé dvojici řad $2m$ a $2m+1$ (pro $m=1,2,\\dots$) je $m$ tmavých šestiúhelníků. Počet bílých trojúhelníků: v liché řadě $2m+1$ je jich $m+1$, v sudé řadě $2m$ je jich $m-1$ (řada $1$ má $1$ bílý). Řada $k$ má celkem $2k-1$ malých trojúhelníků.','16.1: řada $9=2\\cdot4+1$, tedy $m=4$; bílých $=m+1=5$.','16.2: řada $16=2\\cdot8$, tedy $m=8$; celkem $2\\cdot16-1=31$ trojúhelníků, z toho $m-1=7$ bílých, tedy tmavých $31-7=24$.','16.3: $19$ řad odpovídá dvojicím řad pro $m=1,\\dots,9$; šestiúhelníků $1+2+\\cdots+9=45$ (tmavých trojúhelníků celkem $6\\cdot45=270$).'},
  '16.1: $5$ bílých trojúhelníků; 16.2: $24$ tmavých trojúhelníků; 16.3: $45$ tmavých šestiúhelníků',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','planimetrie','uvazovani','vypocet','slovni','bez-kalkulacky'},
  'M9PCD21C0T03', 2021
);

System.debug('Vytvořeno úloh: '+c.created);
