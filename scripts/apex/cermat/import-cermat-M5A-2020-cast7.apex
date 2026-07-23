String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M5A 2020 – úloha 14',
  new List<String>{'První obrazec je sestaven z 9 sirek, druhý obrazec je sestaven ze 13 sirek a třetí i všechny následující obrazce se postupně zvětšují podle téhož pravidla.','14.1 Určete, o kolik sirek má 5. obrazec více než 3. obrazec.','14.2 Určete, z kolika sirek je sestaven 20. obrazec.','14.3 Určete, kolikátý obrazec je sestaven ze 129 sirek.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 150" font-family="sans-serif"><text x="59" y="34" font-size="13" text-anchor="middle">1. obrazec</text><line x1="20" y1="77" x2="42" y2="50" stroke="#000" stroke-width="2"/><line x1="20" y1="77" x2="42" y2="104" stroke="#000" stroke-width="2"/><line x1="42" y1="50" x2="42" y2="104" stroke="#000" stroke-width="2"/><line x1="42" y1="50" x2="76" y2="50" stroke="#000" stroke-width="2"/><line x1="42" y1="104" x2="76" y2="104" stroke="#000" stroke-width="2"/><line x1="42" y1="50" x2="76" y2="104" stroke="#000" stroke-width="2"/><line x1="76" y1="50" x2="76" y2="104" stroke="#000" stroke-width="2"/><line x1="76" y1="50" x2="98" y2="77" stroke="#000" stroke-width="2"/><line x1="76" y1="104" x2="98" y2="77" stroke="#000" stroke-width="2"/><text x="246" y="34" font-size="13" text-anchor="middle">2. obrazec</text><line x1="190" y1="77" x2="212" y2="50" stroke="#000" stroke-width="2"/><line x1="190" y1="77" x2="212" y2="104" stroke="#000" stroke-width="2"/><line x1="212" y1="50" x2="212" y2="104" stroke="#000" stroke-width="2"/><line x1="212" y1="50" x2="246" y2="50" stroke="#000" stroke-width="2"/><line x1="212" y1="104" x2="246" y2="104" stroke="#000" stroke-width="2"/><line x1="212" y1="50" x2="246" y2="104" stroke="#000" stroke-width="2"/><line x1="246" y1="50" x2="246" y2="104" stroke="#000" stroke-width="2"/><line x1="246" y1="50" x2="280" y2="50" stroke="#000" stroke-width="2"/><line x1="246" y1="104" x2="280" y2="104" stroke="#000" stroke-width="2"/><line x1="246" y1="50" x2="280" y2="104" stroke="#000" stroke-width="2"/><line x1="280" y1="50" x2="280" y2="104" stroke="#000" stroke-width="2"/><line x1="280" y1="50" x2="302" y2="77" stroke="#000" stroke-width="2"/><line x1="280" y1="104" x2="302" y2="77" stroke="#000" stroke-width="2"/><text x="453" y="34" font-size="13" text-anchor="middle">3. obrazec</text><line x1="380" y1="77" x2="402" y2="50" stroke="#000" stroke-width="2"/><line x1="380" y1="77" x2="402" y2="104" stroke="#000" stroke-width="2"/><line x1="402" y1="50" x2="402" y2="104" stroke="#000" stroke-width="2"/><line x1="402" y1="50" x2="436" y2="50" stroke="#000" stroke-width="2"/><line x1="402" y1="104" x2="436" y2="104" stroke="#000" stroke-width="2"/><line x1="402" y1="50" x2="436" y2="104" stroke="#000" stroke-width="2"/><line x1="436" y1="50" x2="436" y2="104" stroke="#000" stroke-width="2"/><line x1="436" y1="50" x2="470" y2="50" stroke="#000" stroke-width="2"/><line x1="436" y1="104" x2="470" y2="104" stroke="#000" stroke-width="2"/><line x1="436" y1="50" x2="470" y2="104" stroke="#000" stroke-width="2"/><line x1="470" y1="50" x2="470" y2="104" stroke="#000" stroke-width="2"/><line x1="470" y1="50" x2="504" y2="50" stroke="#000" stroke-width="2"/><line x1="470" y1="104" x2="504" y2="104" stroke="#000" stroke-width="2"/><line x1="470" y1="50" x2="504" y2="104" stroke="#000" stroke-width="2"/><line x1="504" y1="50" x2="504" y2="104" stroke="#000" stroke-width="2"/><line x1="504" y1="50" x2="526" y2="77" stroke="#000" stroke-width="2"/><line x1="504" y1="104" x2="526" y2="77" stroke="#000" stroke-width="2"/><text x="600" y="83" font-size="22">…</text></svg>',
  'sirky-obrazce.svg',
  'První, druhý a třetí obrazec ze sirek: dva krajní trojúhelníky a mezi nimi 1, 2 a 3 čtverce s úhlopříčkou.',
  '1., 2. a 3. obrazec ze sirek',
  new List<String>{'Každý další obrazec má o $4$ sirky více; $n$-tý obrazec je z $9+4\\cdot(n-1)=4n+5$ sirek.','14.1 $5$. obrazec: $4\\cdot 5+5=25$; $3$. obrazec: $4\\cdot 3+5=17$; rozdíl $25-17=8$ sirek.','14.2 $20$. obrazec: $4\\cdot 20+5=85$ sirek.','14.3 $4n+5=129\\Rightarrow 4n=124\\Rightarrow n=31$; je to $31.$ obrazec.'},
  '14.1: o $8$ sirek; 14.2: z $85$ sirek; 14.3: $31.$ obrazec',
  4, 5, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
