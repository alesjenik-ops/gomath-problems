String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD24C0T03';
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
  'CERMAT M7C 2024 – úloha 9',
  new List<String>{'Adam se rozhodl, že si vyrobí originální šachový stolek. Koupil si černou a bílou samolepící folii a šedý stůl o rozměrech $80$ cm a $56$ cm polepil tak, jak je znázorněno na obrázku. Šachovnice je tvořena čtverci o straně $4$ cm, pruh je tvořený kosodélníky a trojúhelníky a má šířku $4$ cm.','9.1 Kolik procent z celé desky stolu překrývá 1 pruh?','9.2 V jakém poměru je nepolepená část desky stolu k celé desce stolu?','9.3 V jakém poměru jsou černé a bílé plochy na desce stolu?'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 250" font-family="sans-serif"><rect x="10" y="10" width="320" height="224" fill="#9a9a9a"/><rect x="106" y="58" width="128" height="128" fill="#fff" stroke="#000"/><rect x="106" y="58" width="16" height="16"/><rect x="106" y="90" width="16" height="16"/><rect x="106" y="122" width="16" height="16"/><rect x="106" y="154" width="16" height="16"/><rect x="122" y="74" width="16" height="16"/><rect x="122" y="106" width="16" height="16"/><rect x="122" y="138" width="16" height="16"/><rect x="122" y="170" width="16" height="16"/><rect x="138" y="58" width="16" height="16"/><rect x="138" y="90" width="16" height="16"/><rect x="138" y="122" width="16" height="16"/><rect x="138" y="154" width="16" height="16"/><rect x="154" y="74" width="16" height="16"/><rect x="154" y="106" width="16" height="16"/><rect x="154" y="138" width="16" height="16"/><rect x="154" y="170" width="16" height="16"/><rect x="170" y="58" width="16" height="16"/><rect x="170" y="90" width="16" height="16"/><rect x="170" y="122" width="16" height="16"/><rect x="170" y="154" width="16" height="16"/><rect x="186" y="74" width="16" height="16"/><rect x="186" y="106" width="16" height="16"/><rect x="186" y="138" width="16" height="16"/><rect x="186" y="170" width="16" height="16"/><rect x="202" y="58" width="16" height="16"/><rect x="202" y="90" width="16" height="16"/><rect x="202" y="122" width="16" height="16"/><rect x="202" y="154" width="16" height="16"/><rect x="218" y="74" width="16" height="16"/><rect x="218" y="106" width="16" height="16"/><rect x="218" y="138" width="16" height="16"/><rect x="218" y="170" width="16" height="16"/><rect x="26" y="10" width="16" height="224" fill="#e6e6e6" stroke="#000"/><line x1="26" y1="10" x2="42" y2="26" stroke="#000"/><line x1="26" y1="42" x2="42" y2="58" stroke="#000"/><line x1="26" y1="74" x2="42" y2="90" stroke="#000"/><line x1="26" y1="106" x2="42" y2="122" stroke="#000"/><line x1="26" y1="138" x2="42" y2="154" stroke="#000"/><line x1="26" y1="170" x2="42" y2="186" stroke="#000"/><line x1="26" y1="202" x2="42" y2="218" stroke="#000"/><rect x="50" y="10" width="16" height="224" fill="#e6e6e6" stroke="#000"/><line x1="50" y1="10" x2="66" y2="26" stroke="#000"/><line x1="50" y1="42" x2="66" y2="58" stroke="#000"/><line x1="50" y1="74" x2="66" y2="90" stroke="#000"/><line x1="50" y1="106" x2="66" y2="122" stroke="#000"/><line x1="50" y1="138" x2="66" y2="154" stroke="#000"/><line x1="50" y1="170" x2="66" y2="186" stroke="#000"/><line x1="50" y1="202" x2="66" y2="218" stroke="#000"/><rect x="278" y="10" width="16" height="224" fill="#e6e6e6" stroke="#000"/><line x1="278" y1="10" x2="294" y2="26" stroke="#000"/><line x1="278" y1="42" x2="294" y2="58" stroke="#000"/><line x1="278" y1="74" x2="294" y2="90" stroke="#000"/><line x1="278" y1="106" x2="294" y2="122" stroke="#000"/><line x1="278" y1="138" x2="294" y2="154" stroke="#000"/><line x1="278" y1="170" x2="294" y2="186" stroke="#000"/><line x1="278" y1="202" x2="294" y2="218" stroke="#000"/><rect x="302" y="10" width="16" height="224" fill="#e6e6e6" stroke="#000"/><line x1="302" y1="10" x2="318" y2="26" stroke="#000"/><line x1="302" y1="42" x2="318" y2="58" stroke="#000"/><line x1="302" y1="74" x2="318" y2="90" stroke="#000"/><line x1="302" y1="106" x2="318" y2="122" stroke="#000"/><line x1="302" y1="138" x2="318" y2="154" stroke="#000"/><line x1="302" y1="170" x2="318" y2="186" stroke="#000"/><line x1="302" y1="202" x2="318" y2="218" stroke="#000"/></svg>',
  'sachovy-stolek.svg',
  'Šedá deska stolu s šachovnicí uprostřed a čtyřmi svislými pruhy (schematicky).',
  'Šachový stolek (schematický nákres)',
  new List<String>{'Deska stolu má obsah $80\\cdot 56=4480$ cm².','9.1 Jeden pruh je $4$ cm $\\times\\, 56$ cm $=224$ cm², což je $\\frac{224}{4480}=0{,}05=5\\,\\%$ desky.','9.2 Šachovnice ($32\\times 32$ cm) má obsah $1024$ cm², čtyři pruhy $4\\cdot 224=896$ cm². Polepeno je $1920$ cm², nepolepeno $4480-1920=2560$ cm². Poměr nepolepené k celé desce je $2560:4480=4:7$.','9.3 Na šachovnici je stejně černých i bílých polí a i v pruzích se černá a bílá plocha rovnají, proto černé : bílé $=1:1$.'},
  '9.1: $5\\,\\%$; 9.2: $4:7$; 9.3: $1:1$',
  3, 7, '4',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
