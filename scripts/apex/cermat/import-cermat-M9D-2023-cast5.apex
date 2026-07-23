String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 11',
  new List<String>{'Každý rok pracují v parku jednak brigádníci, kteří tam pracovali v předchozím roce, jednak nově přijatí brigádníci. Na konci každého roku někteří ze všech těchto brigádníků z parku odcházejí a další rok v něm nepracují. V grafu jsou znázorněny počty brigádníků v letech 2018 až 2022, tři údaje však chybí. Například v roce 2022 pracovalo v parku 9 brigádníků, kteří tam pracovali i v roce 2021, a 6 nově přijatých brigádníků; z těchto 15 brigádníků jich 8 na konci roku 2022 odešlo (viz obrázek).','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 V roce 2019 pracovalo v parku 16 brigádníků, kteří tam pracovali i v roce 2018.','11.2 V roce 2020 pracovalo méně než 7 nově přijatých brigádníků.','11.3 Na konci roku 2021 z parku odešlo více než 12 brigádníků.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 235" font-family="sans-serif"><line x1="54" y1="125" x2="432" y2="125" stroke="#000" stroke-width="1.2"/><line x1="54" y1="18" x2="54" y2="205" stroke="#000" stroke-width="1.2"/><g font-size="9" text-anchor="end"><text x="48" y="109">4</text><text x="48" y="89">8</text><text x="48" y="69">12</text><text x="48" y="49">16</text><text x="48" y="149">4</text><text x="48" y="169">8</text><text x="48" y="129">0</text></g><rect x="64" y="55" width="16" height="70" fill="#8a8a8a" stroke="#000"/><rect x="83" y="75" width="16" height="50" fill="#ffffff" stroke="#000"/><rect x="72" y="125" width="16" height="40" fill="#111" stroke="#000"/><text x="80" y="187" font-size="11" text-anchor="middle">2018</text><rect x="140" y="91" width="16" height="34" fill="none" stroke="#888" stroke-dasharray="3 3"/><text x="148" y="112" font-size="12" text-anchor="middle">?</text><rect x="159" y="105" width="16" height="20" fill="#ffffff" stroke="#000"/><rect x="148" y="125" width="16" height="35" fill="#111" stroke="#000"/><text x="156" y="187" font-size="11" text-anchor="middle">2019</text><rect x="216" y="60" width="16" height="65" fill="#8a8a8a" stroke="#000"/><rect x="235" y="91" width="16" height="34" fill="none" stroke="#888" stroke-dasharray="3 3"/><text x="243" y="112" font-size="12" text-anchor="middle">?</text><rect x="224" y="125" width="16" height="10" fill="#111" stroke="#000"/><text x="232" y="187" font-size="11" text-anchor="middle">2020</text><rect x="292" y="45" width="16" height="80" fill="#8a8a8a" stroke="#000"/><rect x="311" y="100" width="16" height="25" fill="#ffffff" stroke="#000"/><rect x="300" y="125" width="16" height="34" fill="none" stroke="#888" stroke-dasharray="3 3"/><text x="308" y="146" font-size="12" text-anchor="middle">?</text><text x="308" y="187" font-size="11" text-anchor="middle">2021</text><rect x="368" y="80" width="16" height="45" fill="#8a8a8a" stroke="#000"/><rect x="387" y="95" width="16" height="30" fill="#ffffff" stroke="#000"/><rect x="376" y="125" width="16" height="40" fill="#111" stroke="#000"/><text x="384" y="187" font-size="11" text-anchor="middle">2022</text><rect x="436" y="40" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="453" y="50" font-size="10">brigadnici z predchoziho roku</text><rect x="436" y="60" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="453" y="70" font-size="10">nove prijati brigadnici</text><rect x="436" y="80" width="12" height="12" fill="#111" stroke="#000"/><text x="453" y="90" font-size="10">odesli na konci roku</text></svg>',
  'graf-brigadnici.svg',
  'Sloupcový graf počtu brigádníků v letech 2018 až 2022: sloupce brigádníků z předchozího roku a nově přijatých směřují nahoru, sloupec odcházejících dolů; tři sloupce (2019 z předchozího roku, 2020 nově přijatí, 2021 odešlí) chybí a jsou označeny otazníkem.',
  'Počty brigádníků v letech 2018–2022 (tři údaje chybí)',
  new List<String>{'Počet brigádníků z předchozího roku v daném roce je roven počtu všech brigádníků v předchozím roce zmenšenému o počet těch, kteří na konci předchozího roku odešli.','11.1 V roce 2018 pracovalo $14+10=24$ brigádníků a $8$ jich na konci roku odešlo; v roce 2019 tedy pokračovalo $24-8=16$ z nich — pravdivé (A).','11.2 V roce 2020 pokračovalo $13$ brigádníků a na konci roku jich $2$ odešli; protože v roce 2021 pokračovalo $16$, muselo v roce 2020 pracovat celkem $16+2=18$ brigádníků. Nově přijatých bylo $18-13=5$, což je méně než $7$ — pravdivé (A).','11.3 V roce 2021 pracovalo $16+5=21$ brigádníků; protože v roce 2022 z nich pokračovalo $9$, na konci roku 2021 odešlo $21-9=12$ brigádníků. $12$ není více než $12$ — nepravdivé (N).'},
  '11.1: Ano (A); 11.2: Ano (A); 11.3: Ne (N)',
  4, 7, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
