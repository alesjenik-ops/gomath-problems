String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M5A 2015 – úloha 15',
  new List<String>{'V každé z tabulek 15.1–15.3 je v prvním řádku vlevo číslo 6 a vpravo prázdné pole, ve druhém řádku jsou čísla 3 a 4 (viz obrázek).','Doplňte do prázdného pole každé tabulky (15.1–15.3) takové číslo (A–F), aby platilo:','15.1 Součin čísel v prvním řádku tabulky je dvojnásobkem součinu čísel ve druhém řádku.','15.2 Součin čísel v prvním řádku tabulky je o 12 menší než součin čísel ve druhém řádku.','15.3 Součin čísel v prvním řádku tabulky je o 6 větší než součin čísel ve druhém řádku.'},
  new List<String>{'A) 0','B) 1','C) 2','D) 3','E) 4','F) jiné číslo'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 140" font-family="sans-serif"><text x="8" y="70" font-size="14">15.1</text><rect x="60" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="82" y="71" font-size="19" font-weight="bold" text-anchor="middle">6</text><rect x="104" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><rect x="60" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="82" y="109" font-size="19" font-weight="bold" text-anchor="middle">3</text><rect x="104" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="126" y="109" font-size="19" font-weight="bold" text-anchor="middle">4</text><text x="168" y="70" font-size="14">15.2</text><rect x="220" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="242" y="71" font-size="19" font-weight="bold" text-anchor="middle">6</text><rect x="264" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><rect x="220" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="242" y="109" font-size="19" font-weight="bold" text-anchor="middle">3</text><rect x="264" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="286" y="109" font-size="19" font-weight="bold" text-anchor="middle">4</text><text x="328" y="70" font-size="14">15.3</text><rect x="380" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="402" y="71" font-size="19" font-weight="bold" text-anchor="middle">6</text><rect x="424" y="44" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><rect x="380" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="402" y="109" font-size="19" font-weight="bold" text-anchor="middle">3</text><rect x="424" y="82" width="44" height="38" fill="#fff" stroke="#000" stroke-width="2"/><text x="446" y="109" font-size="19" font-weight="bold" text-anchor="middle">4</text></svg>',
  'tabulky.svg',
  'Tři stejné tabulky o dvou řádcích a dvou sloupcích: v prvním řádku 6 a prázdné pole, ve druhém řádku 3 a 4.',
  'Tabulky k úlohám 15.1–15.3',
  new List<String>{'Součin čísel ve druhém řádku je $3\\cdot 4=12$. Hledané číslo označme $x$, součin v prvním řádku je pak $6x$.','15.1 $6x=2\\cdot 12=24$, tedy $x=4$ (možnost E).','15.2 $6x=12-12=0$, tedy $x=0$ (možnost A).','15.3 $6x=12+6=18$, tedy $x=3$ (možnost D).'},
  '15.1: E ($4$); 15.2: A ($0$); 15.3: D ($3$)',
  6, 7, '3',
  new List<String>{'zs1','rovnice','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
