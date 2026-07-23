String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
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
  'CERMAT M7A 2020 – úloha 13',
  new List<String>{'Všichni žáci tříd 7. A a 7. B se zúčastnili soutěže, v níž mohl každý získat $0$ až $3$ body. V grafu jsou počty žáků, kteří získali daný počet bodů; počet žáků 7. B se $3$ body chybí.','Žáci 7. A získali v soutěži celkem o $2$ body méně než žáci 7. B. Kolik žáků chodí do třídy 7. B?'},
  new List<String>{'A) méně než $24$ žáků','B) $24$ žáků','C) $25$ žáků','D) $26$ žáků','E) více než $26$ žáků'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 320" font-family="sans-serif"><line x1="60" y1="30" x2="60" y2="250" stroke="#000"/><line x1="60" y1="250" x2="470" y2="250" stroke="#000"/><line x1="56" y1="250" x2="60" y2="250" stroke="#000"/><text x="51" y="254" font-size="11" text-anchor="end">0</text><line x1="56" y1="218" x2="60" y2="218" stroke="#000"/><text x="51" y="222" font-size="11" text-anchor="end">2</text><line x1="56" y1="186" x2="60" y2="186" stroke="#000"/><text x="51" y="190" font-size="11" text-anchor="end">4</text><line x1="56" y1="154" x2="60" y2="154" stroke="#000"/><text x="51" y="158" font-size="11" text-anchor="end">6</text><line x1="56" y1="122" x2="60" y2="122" stroke="#000"/><text x="51" y="126" font-size="11" text-anchor="end">8</text><line x1="56" y1="90" x2="60" y2="90" stroke="#000"/><text x="51" y="94" font-size="11" text-anchor="end">10</text><line x1="56" y1="58" x2="60" y2="58" stroke="#000"/><text x="51" y="62" font-size="11" text-anchor="end">12</text><text x="26" y="150" font-size="12" text-anchor="middle" transform="rotate(-90 26 150)">Počet žáků</text><rect x="86" y="202" width="26" height="48" fill="#666" stroke="#000"/><rect x="112" y="170" width="26" height="80" fill="#cfcfcf" stroke="#000"/><text x="112" y="266" font-size="11" text-anchor="middle">0 bodů</text><rect x="178" y="90" width="26" height="160" fill="#666" stroke="#000"/><rect x="204" y="186" width="26" height="64" fill="#cfcfcf" stroke="#000"/><text x="204" y="266" font-size="11" text-anchor="middle">1 bod</text><rect x="270" y="122" width="26" height="128" fill="#666" stroke="#000"/><rect x="296" y="106" width="26" height="144" fill="#cfcfcf" stroke="#000"/><text x="296" y="266" font-size="11" text-anchor="middle">2 body</text><rect x="362" y="186" width="26" height="64" fill="#666" stroke="#000"/><rect x="388" y="154" width="26" height="96" fill="none" stroke="#888" stroke-dasharray="4 4"/><text x="401.0" y="148" font-size="16" text-anchor="middle">?</text><text x="388" y="266" font-size="11" text-anchor="middle">3 body</text><rect x="392" y="60" width="13" height="13" fill="#666" stroke="#000"/><text x="410" y="71" font-size="12">7. A</text><rect x="392" y="80" width="13" height="13" fill="#cfcfcf" stroke="#000"/><text x="410" y="91" font-size="12">7. B</text></svg>',
  'graf-body-13.svg',
  'Skupinový sloupcový graf počtu žáků tříd 7. A a 7. B podle získaných bodů (0 až 3); údaj pro 7. B se 3 body chybí.',
  'Počty žáků podle získaných bodů',
  new List<String>{'Body 7. A: $1\\cdot 10+2\\cdot 8+3\\cdot 4=10+16+12=38$. Body 7. B jsou o $2$ více, tedy $40$. Známé body 7. B: $1\\cdot 4+2\\cdot 9=22$; pro žáky se $3$ body platí $3x=40-22=18\\Rightarrow x=6$. Počet žáků 7. B: $5+4+9+6=24$.'},
  'B) $24$ žáků',
  2, 5, '3',
  new List<String>{'zs2','r7','statistika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2020 – úloha 14',
  new List<String>{'Adéla a Hana dostaly stejnou knihu. Hana přečetla z knihy denně $10$ stran. Adéla přečetla celou knihu za $8$ dní a každý den z ní přečetla o polovinu více stran než Hana.','Za kolik dní přečetla celou knihu Hana?'},
  new List<String>{'A) za méně než $10$ dní','B) za $10$ dní','C) za $12$ dní','D) za $15$ dní','E) za více než $15$ dní'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Adéla čte denně $10+5=15$ stran, za $8$ dní přečte $15\\cdot 8=120$ stran — to je celá kniha. Hana čte $10$ stran denně, potřebuje $120:10=12$ dní.'},
  'C) za $12$ dní',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
