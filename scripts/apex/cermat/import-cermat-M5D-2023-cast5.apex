String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M5D 2023 – úloha 8',
  new List<String>{'Každý rok pracují v parku jednak brigádníci, kteří tam pracovali v předchozím roce, jednak nově přijatí brigádníci. Na konci každého roku někteří z nich odejdou a další rok už nepracují. V grafu jsou znázorněny počty brigádníků v letech 2018 až 2022, tři údaje však chybí. Např. v roce 2022 pracovalo v parku 9 brigádníků, kteří tam pracovali i v roce 2021, a 6 nově přijatých; z těchto 15 brigádníků jich 8 na konci roku 2022 odešlo.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 V roce 2019 pracovalo v parku 16 brigádníků, kteří tam pracovali i v roce 2018.','8.2 V roce 2020 pracovalo v parku méně než 7 nově přijatých brigádníků.','8.3 Na konci roku 2021 z parku odešlo více než 12 brigádníků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 320" font-family="sans-serif"><line x1="70" y1="24" x2="70" y2="252" stroke="#000" stroke-width="1.5"/><line x1="70" y1="150" x2="512" y2="150" stroke="#000" stroke-width="1.5"/><line x1="66" y1="126" x2="70" y2="126" stroke="#000"/><text x="63" y="130" font-size="10" text-anchor="end">4</text><line x1="66" y1="102" x2="70" y2="102" stroke="#000"/><text x="63" y="106" font-size="10" text-anchor="end">8</text><line x1="66" y1="78" x2="70" y2="78" stroke="#000"/><text x="63" y="82" font-size="10" text-anchor="end">12</text><line x1="66" y1="54" x2="70" y2="54" stroke="#000"/><text x="63" y="58" font-size="10" text-anchor="end">16</text><line x1="66" y1="30" x2="70" y2="30" stroke="#000"/><text x="63" y="34" font-size="10" text-anchor="end">20</text><line x1="66" y1="174" x2="70" y2="174" stroke="#000"/><text x="63" y="178" font-size="10" text-anchor="end">4</text><line x1="66" y1="198" x2="70" y2="198" stroke="#000"/><text x="63" y="202" font-size="10" text-anchor="end">8</text><line x1="66" y1="222" x2="70" y2="222" stroke="#000"/><text x="63" y="226" font-size="10" text-anchor="end">12</text><line x1="66" y1="246" x2="70" y2="246" stroke="#000"/><text x="63" y="250" font-size="10" text-anchor="end">16</text><rect x="90" y="66" width="12" height="84" fill="#8a8a8a" stroke="#000"/><rect x="105" y="90" width="12" height="60" fill="#ececec" stroke="#000"/><rect x="97" y="150" width="12" height="48" fill="#111" stroke="#000"/><text x="102" y="266" font-size="11" text-anchor="middle">2018</text><rect x="176" y="54" width="12" height="96" fill="none" stroke="#000" stroke-dasharray="3 3"/><rect x="191" y="126" width="12" height="24" fill="#ececec" stroke="#000"/><rect x="183" y="150" width="12" height="42" fill="#111" stroke="#000"/><text x="188" y="266" font-size="11" text-anchor="middle">2019</text><rect x="262" y="72" width="12" height="78" fill="#8a8a8a" stroke="#000"/><rect x="277" y="120" width="12" height="30" fill="none" stroke="#000" stroke-dasharray="3 3"/><rect x="269" y="150" width="12" height="12" fill="#111" stroke="#000"/><text x="274" y="266" font-size="11" text-anchor="middle">2020</text><rect x="348" y="54" width="12" height="96" fill="#8a8a8a" stroke="#000"/><rect x="363" y="120" width="12" height="30" fill="#ececec" stroke="#000"/><rect x="355" y="150" width="12" height="72" fill="none" stroke="#000" stroke-dasharray="3 3"/><text x="360" y="266" font-size="11" text-anchor="middle">2021</text><rect x="434" y="96" width="12" height="54" fill="#8a8a8a" stroke="#000"/><rect x="449" y="114" width="12" height="36" fill="#ececec" stroke="#000"/><rect x="441" y="150" width="12" height="48" fill="#111" stroke="#000"/><text x="446" y="266" font-size="11" text-anchor="middle">2022</text><rect x="70" y="292" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="86" y="302" font-size="10">z predchoziho roku</text><rect x="230" y="292" width="12" height="12" fill="#ececec" stroke="#000"/><text x="246" y="302" font-size="10">nove prijati</text><rect x="350" y="292" width="12" height="12" fill="#111" stroke="#000"/><text x="366" y="302" font-size="10">odesli na konci roku</text></svg>',
  'graf-brigadnici.svg',
  'Sloupcový graf počtu brigádníků 2018 až 2022 (z předchozího roku, nově přijatí, odešlí na konci roku); tři sloupce chybí.',
  'Počty brigádníků v letech 2018–2022 (tři údaje chybí)',
  new List<String>{'8.1 Brigádníci z předchozího roku v roce 2019 $=$ (v 2018 celkem) $-$ (odešlí na konci 2018) $=(14+10)-8=16$. Tvrzení je pravdivé (Ano).','8.2 V roce 2021 bylo z předchozího roku 16 brigádníků a na konci 2020 odešli 2, takže v roce 2020 pracovalo celkem $16+2=18$; z toho z předchozího roku 13, tedy nově přijatých $18-13=5$, což je méně než 7. Pravdivé (Ano).','8.3 V roce 2022 bylo z předchozího roku 9, v roce 2021 pracovalo celkem $16+5=21$, na konci 2021 tedy odešlo $21-9=12$, ne více než 12. Nepravdivé (Ne).'},
  '8.1: Ano; 8.2: Ano; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
