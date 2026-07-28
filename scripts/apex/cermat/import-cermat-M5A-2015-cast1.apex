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
  'CERMAT M5A 2015 – úloha 1',
  new List<String>{'Vypočtěte: $65-5\\cdot(14-6:2)=$'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Nejdříve závorka: $14-6:2=14-3=11$.','Potom $65-5\\cdot 11=65-55=10$.'},
  '$10$',
  2, 2, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 2',
  new List<String>{'Výpočty se provádějí podle vzoru: z čísla v kroužku vznikne další číslo v kroužku tak, že se k němu přičte (nebo se od něj odečte) číslo ve čtverečku. Ve vzoru je $6+4=10$ a $10-3=7$.','Neznámá čísla ve všech čtvercích musí být stejná.','Vypočtěte chybějící číslo v kroužku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif"><text x="8" y="16" font-size="13">Vzor:</text><path d="M 102 72 Q 155 52 208 72" fill="none" stroke="#777" stroke-width="2"/><polygon points="208,72 194,63 202,75" fill="#777"/><path d="M 272 72 Q 325 52 378 72" fill="none" stroke="#777" stroke-width="2"/><polygon points="378,72 364,63 372,75" fill="#777"/><text x="134" y="42" font-size="20" text-anchor="middle">+</text><rect x="143" y="17" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/><text x="158" y="42" font-size="19" font-weight="bold" text-anchor="middle">4</text><text x="304" y="42" font-size="20" text-anchor="middle">&#8722;</text><rect x="313" y="17" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/><text x="328" y="42" font-size="19" font-weight="bold" text-anchor="middle">3</text><circle cx="70" cy="82" r="27" fill="#fff" stroke="#777" stroke-width="2"/><text x="70" y="89" font-size="19" font-weight="bold" text-anchor="middle">6</text><circle cx="240" cy="82" r="27" fill="#fff" stroke="#777" stroke-width="2"/><text x="240" y="89" font-size="19" font-weight="bold" text-anchor="middle">10</text><circle cx="410" cy="82" r="27" fill="#fff" stroke="#777" stroke-width="2"/><text x="410" y="89" font-size="19" font-weight="bold" text-anchor="middle">7</text><text x="8" y="150" font-size="13">Úloha:</text><path d="M 102 206 Q 155 186 208 206" fill="none" stroke="#777" stroke-width="2"/><polygon points="208,206 194,197 202,209" fill="#777"/><path d="M 272 206 Q 325 186 378 206" fill="none" stroke="#777" stroke-width="2"/><polygon points="378,206 364,197 372,209" fill="#777"/><text x="134" y="176" font-size="20" text-anchor="middle">+</text><rect x="143" y="151" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/><text x="276" y="176" font-size="20" text-anchor="middle">+</text><rect x="285" y="151" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/><text x="342" y="176" font-size="20" text-anchor="middle">+</text><rect x="351" y="151" width="31" height="34" fill="#fff" stroke="#222" stroke-width="2"/><circle cx="70" cy="216" r="27" fill="#fff" stroke="#777" stroke-width="2"/><circle cx="240" cy="216" r="27" fill="#fff" stroke="#777" stroke-width="2"/><text x="240" y="223" font-size="19" font-weight="bold" text-anchor="middle">45</text><circle cx="410" cy="216" r="27" fill="#fff" stroke="#777" stroke-width="2"/><text x="410" y="223" font-size="19" font-weight="bold" text-anchor="middle">77</text></svg>',
  'schema-kruzky.svg',
  'Vzor 6 plus 4 rovná se 10, 10 minus 3 rovná se 7; úloha: prázdný kroužek, plus čtvereček, 45, plus čtvereček plus čtvereček, 77.',
  'Vzor a schéma úlohy',
  new List<String>{'Ze druhého kroužku do třetího se dvakrát přičítá totéž neznámé číslo $x$: $45+2x=77$, tedy $2x=32$ a $x=16$.','Z prvního kroužku do druhého se přičítá stejné číslo, hledané číslo je proto $45-16=29$.'},
  '$29$',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2015 – úloha 3',
  new List<String>{'V rámečku je trojciferné číslo, jehož první dvě číslice jsou 3 a 7 a poslední číslice chybí.','Doplňte u čísla v rámečku poslední číslici tak, aby dělení bylo beze zbytku, a vypočtěte podíl.','Do záznamového archu přepište celý zápis výpočtu (dělenec, dělitel i podíl).'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'Hledáme násobek osmi mezi 370 a 379. Platí $8\\cdot 46=368$ a $8\\cdot 47=376$, další násobek $8\\cdot 48=384$ je už větší než 379.','Jediná možnost je tedy $376:8=47$.'},
  '$376:8=47$',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
