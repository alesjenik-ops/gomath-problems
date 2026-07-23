String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD21C0T04';
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
  'CERMAT M5D 2021 – úloha 10',
  new List<String>{'Všechny díly stavebnice jsou pravidelné čtyřboké hranoly s rozměry $1$ cm $\\times$ $1$ cm $\\times$ $2$ cm. Ve stavbě, která má podobu tří spojených kvádrů, jsou díly naskládány bez mezer tak, aby stavba obsahovala co největší počet stojících dílů. Stojící díl má dole čtvercovou stěnu, ležící díl nikoli. Rozměry v obrázku jsou v cm.','Kolik ležících dílů stavba obsahuje?'},
  new List<String>{'A) $0$','B) $6$','C) $12$','D) $18$','E) $24$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif"><text x="150" y="20" font-size="14" text-anchor="middle">Stavba</text><rect x="40" y="110" width="60" height="120" fill="#fff" stroke="#000" stroke-width="1.4"/><polygon points="40,110 100,110 134,86 74,86" fill="#f2f2f2" stroke="#000" stroke-width="1.2"/><rect x="100" y="90" width="60" height="140" fill="#fff" stroke="#000" stroke-width="1.4"/><polygon points="100,90 160,90 194,66 134,66" fill="#f2f2f2" stroke="#000" stroke-width="1.2"/><rect x="160" y="130" width="60" height="100" fill="#fff" stroke="#000" stroke-width="1.4"/><polygon points="160,130 220,130 254,106 194,106" fill="#f2f2f2" stroke="#000" stroke-width="1.2"/><polygon points="220,130 254,106 254,206 220,230" fill="#e8e8e8" stroke="#000" stroke-width="1.2"/><text x="30" y="170" font-size="13" text-anchor="end">6</text><text x="262" y="166" font-size="13">5</text><text x="226" y="114" font-size="13">2</text><text x="70" y="246" font-size="13" text-anchor="middle">3</text><text x="130" y="246" font-size="13" text-anchor="middle">3</text><text x="190" y="246" font-size="13" text-anchor="middle">3</text><text x="51" y="92" font-size="13">4</text></svg>',
  'stavba-kvadry.svg',
  'Stavba ze tří spojených kvádrů o výškách 6, 7 a 5 cm, šířkách 3 cm a hloubce 4 cm.',
  'Stavba ze tří spojených kvádrů',
  new List<String>{'Každý kvádr má podstavu $3\\times 4=12$ sloupečků. Výšky kvádrů jsou $6$, $7$ a $5$ cm, stojící díl je vysoký $2$ cm. Ve sloupci sudé výšky ($6$) vystačí jen stojící díly. U výšek $7$ a $5$ (lichých) zbude nahoře vrstva vysoká $1$ cm o $12$ čtverečcích, kterou vyplní ležící díly: $12:2=6$ v každém z těchto dvou kvádrů, celkem $12$ ležících dílů.'},
  'C) $12$',
  2, 5, '4',
  new List<String>{'zs1','stereometrie','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2021 – úloha 11',
  new List<String>{'Provaz je $216$ cm dlouhý. Třetina tohoto provazu je dvakrát delší než nit. Nit rozstřihneme na tři stejně dlouhé části.','O kolik cm je provaz delší než jedna část niti?'},
  new List<String>{'A) o $108$ cm','B) o $168$ cm','C) o $180$ cm','D) o $204$ cm','E) o jiný počet cm'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Třetina provazu je $216:3=72$ cm, což je dvakrát délka niti, tedy nit měří $36$ cm. Jedna část niti je $36:3=12$ cm. Provaz je delší o $216-12=204$ cm.'},
  'D) o $204$ cm',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
