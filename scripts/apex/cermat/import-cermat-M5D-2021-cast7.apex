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
  'CERMAT M5D 2021 – úloha 12',
  new List<String>{'Podél řeky byl z dlouhých a krátkých tyček postaven plot. Každá opěra je sestavena ze dvou dlouhých tyček opatřených patkami. Plot začíná i končí opěrou a opěry se pravidelně opakují. Mezi každými dvěma sousedními opěrami jsou už jen svislé tyčky bez patek, a to vždy tři dlouhé a čtyři krátké. Všech dlouhých tyček (s patkami i bez patek) je v celém plotu o $80$ více než krátkých.','Kolik patek bylo použito na stavbu celého plotu?'},
  new List<String>{'A) $156$ patek','B) $158$ patek','C) $160$ patek','D) $162$ patek','E) jiný počet patek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 190" font-family="sans-serif"> <line x1="20" y1="150" x2="400" y2="150" stroke="#000" stroke-width="1.5"/> <line x1="40" y1="60" x2="60" y2="150" stroke="#000" stroke-width="2"/> <line x1="60" y1="60" x2="40" y2="150" stroke="#000" stroke-width="2"/> <polygon points="40,150 34,160 46,160" fill="#888" stroke="#000"/> <polygon points="60,150 54,160 66,160" fill="#888" stroke="#000"/> <line x1="90" y1="72" x2="90" y2="150" stroke="#000"/> <line x1="110" y1="74" x2="110" y2="150" stroke="#000"/> <line x1="130" y1="76" x2="130" y2="150" stroke="#000"/> <line x1="150" y1="78" x2="150" y2="150" stroke="#000"/> <line x1="170" y1="80" x2="170" y2="150" stroke="#000"/> <line x1="190" y1="82" x2="190" y2="150" stroke="#000"/> <line x1="210" y1="84" x2="210" y2="150" stroke="#000"/> <line x1="340" y1="70" x2="360" y2="150" stroke="#000" stroke-width="2"/> <line x1="360" y1="70" x2="340" y2="150" stroke="#000" stroke-width="2"/> <polygon points="340,150 334,160 346,160" fill="#888" stroke="#000"/> <polygon points="360,150 354,160 366,160" fill="#888" stroke="#000"/> <line x1="40" y1="66" x2="360" y2="90" stroke="#000" stroke-width="1.4"/> <line x1="270" y1="176" x2="345" y2="158" stroke="#000" stroke-width="0.8"/> <text x="230" y="182" font-size="12" text-anchor="end">patka</text> </svg>',
  'plot.svg',
  'Plot z dlouhých a krátkých tyček s opěrami opatřenými patkami.',
  'Plot s opěrami (schematicky)',
  new List<String>{'Nechť je $p$ opěr; mezer mezi nimi je $p-1$. Dlouhých tyček je $2p+3(p-1)=5p-3$, krátkých $4(p-1)=4p-4$. Z podmínky $(5p-3)-(4p-4)=80$ plyne $p+1=80$, tedy $p=79$. Každá opěra má $2$ patky, celkem $2\\cdot 79=158$ patek.'},
  'B) $158$ patek',
  2, 5, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
