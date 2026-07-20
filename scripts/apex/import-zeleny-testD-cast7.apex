String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený D16 – tabulka známek (průměr, procenta)',
  new List<String>{'Žádná velká sláva. Tak takto dopadl náš ročník na vysvědčení z matematiky a češtiny. V tabulce je zaznamenán počet žáků, kteří dostali na vysvědčení příslušnou kombinaci známek (řádky = čeština, sloupce = matematika).','16.1 Vypočtěte průměrnou známku z matematiky a z češtiny a určete, o kolik klasifikačních stupňů se od sebe liší průměrné známky z těchto předmětů.','16.2 Vypočtěte, u kolika procent žáků se klasifikace z matematiky a klasifikace z češtiny lišila o více než jeden klasifikační stupeň.','16.3 Vypočtěte, kolik procent žáků získalo z těchto dvou předmětů průměr lepší než $2{,}5$.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 432 236" font-family="sans-serif" font-size="15"><rect x="6" y="6" width="418" height="222" fill="none" stroke="#000" stroke-width="1.5"/><line x1="64" y1="6" x2="64" y2="228" stroke="#000"/><line x1="124" y1="32" x2="124" y2="228" stroke="#000"/><line x1="184" y1="32" x2="184" y2="228" stroke="#000"/><line x1="244" y1="32" x2="244" y2="228" stroke="#000"/><line x1="304" y1="32" x2="304" y2="228" stroke="#000"/><line x1="364" y1="32" x2="364" y2="228" stroke="#000"/><line x1="64" y1="32" x2="424" y2="32" stroke="#000"/><line x1="6" y1="60" x2="424" y2="60" stroke="#000"/><line x1="6" y1="88" x2="424" y2="88" stroke="#000"/><line x1="6" y1="116" x2="424" y2="116" stroke="#000"/><line x1="6" y1="144" x2="424" y2="144" stroke="#000"/><line x1="6" y1="172" x2="424" y2="172" stroke="#000"/><line x1="6" y1="200" x2="424" y2="200" stroke="#000"/><text x="35" y="26" text-anchor="middle" font-size="10">VŠICHNI</text><text x="35" y="40" text-anchor="middle" font-size="10">ŽÁCI</text><text x="35" y="54" text-anchor="middle" font-size="10">ČEŠTINA</text><text x="244" y="25" text-anchor="middle" font-weight="bold">MATEMATIKA</text><text x="94" y="52" text-anchor="middle" font-size="15">1</text><text x="154" y="52" text-anchor="middle" font-size="15">2</text><text x="214" y="52" text-anchor="middle" font-size="15">3</text><text x="274" y="52" text-anchor="middle" font-size="15">4</text><text x="334" y="52" text-anchor="middle" font-size="15">5</text><text x="394" y="52" text-anchor="middle" font-size="10">CELKEM</text><text x="35" y="79" text-anchor="middle" font-size="15">1</text><text x="94" y="79" text-anchor="middle">4</text><text x="154" y="79" text-anchor="middle">8</text><text x="214" y="79" text-anchor="middle">2</text><text x="394" y="79" text-anchor="middle">14</text><text x="35" y="107" text-anchor="middle" font-size="15">2</text><text x="94" y="107" text-anchor="middle">4</text><text x="154" y="107" text-anchor="middle">6</text><text x="214" y="107" text-anchor="middle">6</text><text x="274" y="107" text-anchor="middle">8</text><text x="394" y="107" text-anchor="middle">24</text><text x="35" y="135" text-anchor="middle" font-size="15">3</text><text x="94" y="135" text-anchor="middle">2</text><text x="154" y="135" text-anchor="middle">4</text><text x="214" y="135" text-anchor="middle">16</text><text x="274" y="135" text-anchor="middle">16</text><text x="334" y="135" text-anchor="middle">4</text><text x="394" y="135" text-anchor="middle">42</text><text x="35" y="163" text-anchor="middle" font-size="15">4</text><text x="154" y="163" text-anchor="middle">2</text><text x="214" y="163" text-anchor="middle">4</text><text x="274" y="163" text-anchor="middle">10</text><text x="334" y="163" text-anchor="middle">2</text><text x="394" y="163" text-anchor="middle">18</text><text x="35" y="191" text-anchor="middle" font-size="15">5</text><text x="334" y="191" text-anchor="middle">2</text><text x="394" y="191" text-anchor="middle">2</text><text x="35" y="219" text-anchor="middle" font-size="10">CELKEM</text><text x="94" y="219" text-anchor="middle">10</text><text x="154" y="219" text-anchor="middle">20</text><text x="214" y="219" text-anchor="middle">28</text><text x="274" y="219" text-anchor="middle">34</text><text x="334" y="219" text-anchor="middle">8</text><text x="394" y="219" text-anchor="middle">100</text></svg>',
  'tabulka-znamek.svg',
  'Tabulka počtu žáků podle kombinace známek z matematiky (sloupce 1 až 5) a z češtiny (řádky 1 až 5) s celkovými součty 100 žáků.',
  'Počty žáků podle kombinace známek z matematiky a češtiny',
  new List<String>{'16.1 Průměr z matematiky: $\\frac{1\\cdot 10+2\\cdot 20+3\\cdot 28+4\\cdot 34+5\\cdot 8}{100}=\\frac{310}{100}=3{,}1$. Průměr z češtiny: $\\frac{1\\cdot 14+2\\cdot 24+3\\cdot 42+4\\cdot 18+5\\cdot 2}{100}=\\frac{270}{100}=2{,}7$. Liší se o $0{,}4$ stupně.','16.2 Žáci s rozdílem známek alespoň $2$: $2+8+(2+4)+2=18$, tj. $18\\,\\%$.','16.3 Průměr lepší než $2{,}5$ znamená součet známek nejvýše $4$: $(4+8+2)+(4+6)+2=26$ žáků, tj. $26\\,\\%$.'},
  '16.1: MA $3{,}1$, ČJ $2{,}7$, rozdíl $0{,}4$; 16.2: $18\\,\\%$; 16.3: $26\\,\\%$',
  6, 9, '4',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
