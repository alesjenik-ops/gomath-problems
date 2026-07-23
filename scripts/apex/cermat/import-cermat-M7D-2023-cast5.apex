String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
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
  'CERMAT M7D 2023 - uloha 10',
  new List<String>{'Kazdy rok pracuji v parku jednak brigadnici, kteri tam pracovali v predchozim roce, jednak nove prijati brigadnici. Na konci kazdeho roku nekteri z nich z parku odchazeji a dalsi rok v nem nepracuji. V grafu jsou znazorneny pocty brigadniku v letech $2018$ az $2022$, tri udaje vsak chybi. Napr. v roce $2022$ pracovalo v parku $9$ brigadniku, kteri tam pracovali i v roce $2021$, a $6$ nove prijatych brigadniku. Z techto $15$ brigadniku jich $8$ na konci roku $2022$ odeslo.','Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (A), ci nikoli (N).','10.1 V roce $2019$ pracovalo v parku $16$ brigadniku, kteri tam pracovali i v roce $2018$.','10.2 V roce $2020$ pracovalo mene nez $7$ nove prijatych brigadniku.','10.3 Na konci roku $2021$ z parku odeslo vice nez $12$ brigadniku.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 630 300" font-family="sans-serif"><line x1="70" y1="30" x2="70" y2="255" stroke="#000"/><line x1="70" y1="150" x2="470" y2="150" stroke="#000"/><g font-size="10" text-anchor="end"><text x="64" y="153">0</text><text x="64" y="129">4</text><text x="64" y="105">8</text><text x="64" y="81">12</text><text x="64" y="57">16</text><text x="64" y="33">20</text><text x="64" y="177">4</text><text x="64" y="201">8</text><text x="64" y="225">12</text><text x="64" y="249">16</text></g><rect x="86" y="66" width="20" height="84" fill="#8a8a8a" stroke="#000"/><rect x="109" y="90" width="20" height="60" fill="#e2e2e2" stroke="#000"/><rect x="97" y="150" width="20" height="48" fill="#111" stroke="#000"/><text x="106" y="222" font-size="11" text-anchor="middle">2018</text><rect x="187" y="126" width="20" height="24" fill="#e2e2e2" stroke="#000"/><rect x="175" y="150" width="20" height="42" fill="#111" stroke="#000"/><text x="184" y="222" font-size="11" text-anchor="middle">2019</text><rect x="242" y="72" width="20" height="78" fill="#8a8a8a" stroke="#000"/><rect x="253" y="150" width="20" height="12" fill="#111" stroke="#000"/><text x="262" y="222" font-size="11" text-anchor="middle">2020</text><rect x="320" y="54" width="20" height="96" fill="#8a8a8a" stroke="#000"/><rect x="343" y="120" width="20" height="30" fill="#e2e2e2" stroke="#000"/><text x="340" y="222" font-size="11" text-anchor="middle">2021</text><rect x="398" y="96" width="20" height="54" fill="#8a8a8a" stroke="#000"/><rect x="421" y="114" width="20" height="36" fill="#e2e2e2" stroke="#000"/><rect x="409" y="150" width="20" height="48" fill="#111" stroke="#000"/><text x="418" y="222" font-size="11" text-anchor="middle">2022</text><g font-size="10"><rect x="478" y="42" width="12" height="12" fill="#8a8a8a" stroke="#000"/><text x="494" y="52">z predch. roku</text><rect x="478" y="60" width="12" height="12" fill="#e2e2e2" stroke="#000"/><text x="494" y="70">nove prijati</text><rect x="478" y="78" width="12" height="12" fill="#111" stroke="#000"/><text x="494" y="88">odesli</text></g></svg>',
  'graf-brigadnici.svg',
  'Sloupcovy graf poctu brigadniku 2018-2022: z predchoziho roku, nove prijati a ti, kteri na konci roku odesli; tri udaje chybi.',
  'Pocty brigadniku v letech 2018-2022',
  new List<String>{'Pocet pracujicich v roce $Y$ = (loni pracujici) + (nove prijati); z predchoziho roku zustavaji ti, kdo neodesli. 2018: $14+10=24$, odeslo $8$, tedy 2019 pracovalo z predchoziho roku $24-8=16$.','10.1 $16$ z predchoziho roku v 2019 -> Ano.','10.2 V 2020 pracovalo celkem $16+2=18$ (z 2021 zbylo 16, odeslo 2), z toho z predchoziho roku $13$, nove prijatych $18-13=5<7$ -> Ano.','10.3 V 2021 pracovalo $16+5=21$; do 2022 zustalo $9$, odeslo $21-9=12$, coz neni vice nez $12$ -> Ne.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ne',
  4, 7, '3',
  new List<String>{'zs2','r7','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
