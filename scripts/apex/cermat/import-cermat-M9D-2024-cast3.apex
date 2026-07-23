String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M9D 2024 – úloha 8',
  new List<String>{'V prvním grafu je průměrné časové rozložení všech denních činností paní Kratochvílové v pracovní den (celkem $24$ hodin): zaměstnání $25\\,\\%$, spánek $35\\,\\%$, denní povinnosti $30\\,\\%$, volný čas $10\\,\\%$. Ve druhém grafu je rozložení jejího volného času: TV $35\\,\\%$, sport $40\\,\\%$, četba $25\\,\\%$.','8.1 Kolik hodin denně paní Kratochvílová tráví v zaměstnání?','8.2 Kolik minut denně paní Kratochvílová sportuje? Výsledek zaokrouhlete na celé minuty.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" font-family="sans-serif"><text x="120" y="22" font-size="13" text-anchor="middle" font-weight="bold">Denni cinnosti (24 hodin)</text><path d="M120,150 L120.0,68.0 A82,82 0 0,1 202.0,150.0 Z" fill="#f0f0f0" stroke="#000" stroke-width="1"/><text x="155.9" y="114.1" font-size="12" text-anchor="middle" fill="#000">25 %</text><path d="M120,150 L202.0,150.0 A82,82 0 0,1 71.8,216.3 Z" fill="#b0b0b0" stroke="#000" stroke-width="1"/><text x="143.1" y="195.3" font-size="12" text-anchor="middle" fill="#000">35 %</text><path d="M120,150 L71.8,216.3 A82,82 0 0,1 71.8,83.7 Z" fill="#707070" stroke="#000" stroke-width="1"/><text x="69.2" y="150.0" font-size="12" text-anchor="middle" fill="#000">30 %</text><path d="M120,150 L71.8,83.7 A82,82 0 0,1 120.0,68.0 Z" fill="#202020" stroke="#000" stroke-width="1"/><text x="104.3" y="101.6" font-size="12" text-anchor="middle" fill="#fff">10 %</text><rect x="235" y="110" width="12" height="12" fill="#f0f0f0" stroke="#000"/><text x="252" y="121" font-size="11">zamestnani</text><rect x="235" y="130" width="12" height="12" fill="#b0b0b0" stroke="#000"/><text x="252" y="141" font-size="11">spanek</text><rect x="235" y="150" width="12" height="12" fill="#707070" stroke="#000"/><text x="252" y="161" font-size="11">denni povinnosti</text><rect x="235" y="170" width="12" height="12" fill="#202020" stroke="#000"/><text x="252" y="181" font-size="11">volny cas</text><text x="450" y="22" font-size="13" text-anchor="middle" font-weight="bold">Volny cas</text><path d="M450,150 L450.0,68.0 A82,82 0 0,1 516.3,198.2 Z" fill="#b0b0b0" stroke="#000" stroke-width="1"/><text x="495.3" y="126.9" font-size="12" text-anchor="middle" fill="#000">35 %</text><path d="M450,150 L516.3,198.2 A82,82 0 0,1 368.0,150.0 Z" fill="#f0f0f0" stroke="#000" stroke-width="1"/><text x="434.3" y="198.4" font-size="12" text-anchor="middle" fill="#000">40 %</text><path d="M450,150 L368.0,150.0 A82,82 0 0,1 450.0,68.0 Z" fill="#202020" stroke="#000" stroke-width="1"/><text x="414.1" y="114.1" font-size="12" text-anchor="middle" fill="#fff">25 %</text><rect x="558" y="120" width="12" height="12" fill="#b0b0b0" stroke="#000"/><text x="575" y="131" font-size="11">TV</text><rect x="558" y="140" width="12" height="12" fill="#f0f0f0" stroke="#000"/><text x="575" y="151" font-size="11">sport</text><rect x="558" y="160" width="12" height="12" fill="#202020" stroke="#000"/><text x="575" y="171" font-size="11">cetba</text></svg>',
  'grafy-cas.svg',
  'Dva kolacove grafy: denni cinnosti (zamestnani 25 %, spanek 35 %, denni povinnosti 30 %, volny cas 10 %) a rozlozeni volneho casu (TV 35 %, sport 40 %, cetba 25 %).',
  'Rozložení denních činností a volného času',
  new List<String>{'8.1 Zaměstnání tvoří $25\\,\\%$ z $24$ hodin, tj. $0{,}25\\cdot 24=6$ hodin.','8.2 Volný čas je $10\\,\\%$ z $24$ hodin $=2{,}4$ hodiny $=144$ minut. Sport je $40\\,\\%$ volného času: $0{,}4\\cdot 144=57{,}6$ minuty, po zaokrouhlení $58$ minut.'},
  '8.1: $6$ hodin; 8.2: $58$ minut',
  4, 5, '3',
  new List<String>{'zs2','r9','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
