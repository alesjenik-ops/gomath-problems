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
  'CERMAT M7A 2021 – úloha 10',
  new List<String>{'Na vytvoření každého obrazce použijeme beze zbytku dva čtverce o straně délky $6$ cm. Čtverce rozstříháme a ze všech získaných dílů sestavíme obrazec, jehož strany (úsečky po obvodu) mají pouze dvě různé délky (viz obrázek).','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Nejdelší strana obrazce A je o třetinu kratší než nejdelší strana obrazce B.','10.2 Obvod obrazce A je roven součtu obvodů obou čtverců, z nichž byl vytvořen.','10.3 Obvod obrazce A je větší než obvod obrazce B.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 250" font-family="sans-serif" font-size="14"><text x="120" y="22" text-anchor="middle">Obrazec A</text><rect x="40" y="40" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="80" y="40" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="80" y="80" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="120" y="80" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="120" y="120" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="160" y="120" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="160" y="160" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="200" y="160" width="40" height="40" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><text x="410" y="22" text-anchor="middle">Obrazec B</text><rect x="320" y="40" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="350" y="40" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="380" y="40" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="410" y="40" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="350" y="70" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="380" y="70" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="410" y="70" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="440" y="70" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="380" y="100" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="410" y="100" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="440" y="100" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="470" y="100" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="410" y="130" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="440" y="130" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="470" y="130" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="440" y="160" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="470" y="160" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/><rect x="470" y="190" width="30" height="30" fill="#e6e6e6" stroke="#000" stroke-width="1.5"/></svg>',
  'obrazce-AB.svg',
  'Dva schodovité obrazce A a B složené z jednotkových čtverců (schematicky).',
  'Obrazce A a B (schematicky, obsah každého je 72 cm²)',
  new List<String>{'Obrazec A je schodovitý útvar z osmi čtverců o straně $3$ cm (obsah $8\\cdot 9=72$ cm²): nejdelší strana $6$ cm, obvod $18\\cdot 3=54$ cm. Obrazec B je z osmnácti čtverců o straně $2$ cm (obsah $18\\cdot 4=72$ cm²): nejdelší strana $8$ cm, obvod $24\\cdot 2=48$ cm.','10.1 $6$ cm proti $8$ cm je o čtvrtinu (ne o třetinu) kratší → Ne.','10.2 Obvod A $=54$ cm, součet obvodů čtverců $=2\\cdot 24=48$ cm → Ne.','10.3 Obvod A $=54$ cm $>48$ cm $=$ obvod B → Ano.'},
  '10.1: Ne; 10.2: Ne; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
