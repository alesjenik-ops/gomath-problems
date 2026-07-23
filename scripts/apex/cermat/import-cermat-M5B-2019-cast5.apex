String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M5B 2019 – úloha 11',
  new List<String>{'V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem $30$ žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má $3$ sourozence. Skupina žáků se $2$ sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), je dvakrát více než těch, kteří žádného sourozence nemají.','Kolik žáků třídy nemá žádného sourozence?'},
  new List<String>{'A) $8$','B) $10$','C) $11$','D) $12$','E) $15$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"><path d="M 210.0 155.0 L 210.0 63.0 A 92 92 0 0 1 229.1 65.0 Z" fill="#8a8a8a" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 229.1 65.0 A 92 92 0 0 1 278.4 216.6 Z" fill="#bdbdbd" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 278.4 216.6 A 92 92 0 0 1 130.3 109.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 130.3 109.0 A 92 92 0 0 1 210.0 63.0 Z" fill="#e4e4e4" stroke="#000" stroke-width="1.4"/><text x="221.7" y="43.6" font-size="12" text-anchor="middle">žáci se 3 sourozenci</text><text x="316.5" y="120.4" font-size="12" text-anchor="start">žáci bez sourozenců</text><text x="144.2" y="245.6" font-size="12" text-anchor="end">žáci s 1 sourozencem</text><text x="154.0" y="58.0" font-size="12" text-anchor="end">žáci se 2 sourozenci</text></svg>',
  'graf-sourozenci.svg',
  'Kruhový graf žáků třídy rozdělených podle počtu sourozenců do čtyř skupin: bez sourozenců, s 1, se 2 a se 3 sourozenci.',
  'Rozdělení žáků třídy podle počtu sourozenců',
  new List<String>{'Bez sourozenců je $b$ žáků, s nějakým sourozencem $2b$; celkem $3b = 30$, tedy $b = 10$.'},
  'B) $10$',
  2, 3, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2019 – úloha 12',
  new List<String>{'V grafu jsou všichni žáci třídy rozděleni podle počtu svých sourozenců do čtyř skupin. Ve třídě je celkem $30$ žáků a s nimi do třídy nechodí žádný z jejich sourozenců. Pouze jeden žák má $3$ sourozence. Skupina žáků se $2$ sourozenci tvoří šestinu žáků třídy. Žáků, kteří mají nějakého sourozence (jednoho, dva, nebo tři), je dvakrát více než těch, kteří žádného sourozence nemají.','Kolik sourozenců mají dohromady všichni žáci třídy?'},
  new List<String>{'A) $27$','B) $28$','C) $29$','D) $30$','E) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 320" font-family="sans-serif"><path d="M 210.0 155.0 L 210.0 63.0 A 92 92 0 0 1 229.1 65.0 Z" fill="#8a8a8a" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 229.1 65.0 A 92 92 0 0 1 278.4 216.6 Z" fill="#bdbdbd" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 278.4 216.6 A 92 92 0 0 1 130.3 109.0 Z" fill="#ffffff" stroke="#000" stroke-width="1.4"/><path d="M 210.0 155.0 L 130.3 109.0 A 92 92 0 0 1 210.0 63.0 Z" fill="#e4e4e4" stroke="#000" stroke-width="1.4"/><text x="221.7" y="43.6" font-size="12" text-anchor="middle">žáci se 3 sourozenci</text><text x="316.5" y="120.4" font-size="12" text-anchor="start">žáci bez sourozenců</text><text x="144.2" y="245.6" font-size="12" text-anchor="end">žáci s 1 sourozencem</text><text x="154.0" y="58.0" font-size="12" text-anchor="end">žáci se 2 sourozenci</text></svg>',
  'graf-sourozenci.svg',
  'Kruhový graf žáků třídy rozdělených podle počtu sourozenců do čtyř skupin: bez sourozenců, s 1, se 2 a se 3 sourozenci.',
  'Rozdělení žáků třídy podle počtu sourozenců',
  new List<String>{'Bez sourozenců $10$, se $2$ sourozenci $\\frac{30}{6} = 5$, se $3$ sourozenci $1$, s $1$ sourozencem $30 - 10 - 5 - 1 = 14$. Součet sourozenců $14 \\cdot 1 + 5 \\cdot 2 + 1 \\cdot 3 = 27$.'},
  'A) $27$',
  2, 3, '3',
  new List<String>{'zs1','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
