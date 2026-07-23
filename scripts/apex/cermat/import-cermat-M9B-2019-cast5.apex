String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
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
  'CERMAT M9B 2019 – úloha 11',
  new List<String>{'Do tabulky se zapisují počty telefonních hovorů tří dětí v prvním čtvrtletí kalendářního roku; některé údaje chybí. V lednu měly všechny tři děti stejný počet hovorů. Aleš měl v březnu o třetinu hovorů méně než v únoru. Běla měla v březnu o polovinu hovorů více než v únoru.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 V prvním čtvrtletí byl aritmetický průměr počtu hovorů Aleše za měsíc menší než $14$.','11.2 Běla měla za první čtvrtletí celkem $42$ hovorů.','11.3 V březnu měl Cyril třikrát méně hovorů než Běla.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 250" font-family="sans-serif" font-size="15"><rect x="20" y="20" width="560" height="210" fill="none" stroke="#000" stroke-width="1.6"/><line x1="150" y1="20" x2="150" y2="230" stroke="#000"/><line x1="450" y1="20" x2="450" y2="230" stroke="#000"/><line x1="250" y1="55" x2="250" y2="230" stroke="#000"/><line x1="350" y1="55" x2="350" y2="230" stroke="#000"/><line x1="150" y1="55" x2="450" y2="55" stroke="#000"/><line x1="20" y1="90" x2="580" y2="90" stroke="#000"/><line x1="20" y1="125" x2="580" y2="125" stroke="#000"/><line x1="20" y1="160" x2="580" y2="160" stroke="#000"/><line x1="20" y1="195" x2="580" y2="195" stroke="#000"/><text x="300" y="42" text-anchor="middle">Počet hovorů</text><text x="515" y="47" text-anchor="middle">Aritmetický průměr</text><text x="515" y="72" text-anchor="middle">za měsíc</text><text x="200" y="80" text-anchor="middle">Leden</text><text x="300" y="80" text-anchor="middle">Únor</text><text x="400" y="80" text-anchor="middle">Březen</text><text x="85" y="110" text-anchor="middle">Aleš</text><text x="85" y="145" text-anchor="middle">Běla</text><text x="85" y="180" text-anchor="middle">Cyril</text><text x="85" y="215" text-anchor="middle">Součet</text><text x="400" y="110" text-anchor="middle">12</text><text x="300" y="145" text-anchor="middle">12</text><text x="300" y="180" text-anchor="middle">9</text><text x="515" y="180" text-anchor="middle">9</text><text x="200" y="215" text-anchor="middle">36</text></svg>',
  'tabulka-hovory.svg',
  'Tabulka počtu hovorů (Leden, Únor, Březen, aritmetický průměr) pro Aleše, Bělu, Cyrila a řádek Součet; vyplněné údaje: Aleš březen 12, Běla únor 12, Cyril únor 9 a průměr 9, součet ledna 36.',
  'Počty telefonních hovorů (chybějící údaje jsou prázdné)',
  new List<String>{'V lednu měly děti stejně, součet $36$, tedy každé $12$. Cyril má průměr $9$, celkem $27$, v březnu $27-12-9=6$. Aleš březen $12=\\frac{2}{3}$ února, tedy únor $18$; Aleš celkem $12+18+12=42$, průměr $14$. Běla březen $=$ únor $+\\frac{1}{2}=18$; celkem $12+12+18=42$, průměr $14$.','11.1 Průměr Aleše je $14$, není menší než $14$ → N.','11.2 Běla celkem $42$ hovorů → A.','11.3 Cyril v březnu $6$, Běla $18$; $18=3\\cdot 6$, tj. třikrát méně → A.'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
