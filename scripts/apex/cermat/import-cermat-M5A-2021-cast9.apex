String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
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
  'CERMAT M5A 2021 – úloha 14',
  new List<String>{'První obrazec tvoří jediný puntík. V dalších obrazcích jsou puntíky uspořádány ve čtvercích. Strana hraničního čtverce u druhého obrazce obsahuje $3$ puntíky a u každého následujícího obrazce má vždy o $2$ puntíky více. Počínaje třetím obrazcem vidíme uvnitř hraničního čtverce vždy celý obrazec, který má pořadové číslo o $2$ menší.','14.1 Určete, kolik puntíků obsahuje jedna strana hraničního čtverce $10.$ obrazce.','14.2 Určete, o kolik se liší počty puntíků v $9.$ a $11.$ obrazci.','14.3 Určete, u kolikátého obrazce se počty puntíků v okolních dvou obrazcích liší o $120$ (okolními rozumíme obrazec těsně před a těsně za hledaným obrazcem).'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 330 175"><g fill="#000"><circle cx="30" cy="90" r="2"/><circle cx="58" cy="82" r="2"/><circle cx="58" cy="90" r="2"/><circle cx="58" cy="98" r="2"/><circle cx="66" cy="82" r="2"/><circle cx="66" cy="98" r="2"/><circle cx="74" cy="82" r="2"/><circle cx="74" cy="90" r="2"/><circle cx="74" cy="98" r="2"/><circle cx="102" cy="74" r="2"/><circle cx="102" cy="82" r="2"/><circle cx="102" cy="90" r="2"/><circle cx="102" cy="98" r="2"/><circle cx="102" cy="106" r="2"/><circle cx="110" cy="74" r="2"/><circle cx="110" cy="106" r="2"/><circle cx="118" cy="74" r="2"/><circle cx="118" cy="106" r="2"/><circle cx="126" cy="74" r="2"/><circle cx="126" cy="106" r="2"/><circle cx="134" cy="74" r="2"/><circle cx="134" cy="82" r="2"/><circle cx="134" cy="90" r="2"/><circle cx="134" cy="98" r="2"/><circle cx="134" cy="106" r="2"/><circle cx="118" cy="90" r="2"/><circle cx="162" cy="66" r="2"/><circle cx="162" cy="74" r="2"/><circle cx="162" cy="82" r="2"/><circle cx="162" cy="90" r="2"/><circle cx="162" cy="98" r="2"/><circle cx="162" cy="106" r="2"/><circle cx="162" cy="114" r="2"/><circle cx="170" cy="66" r="2"/><circle cx="170" cy="114" r="2"/><circle cx="178" cy="66" r="2"/><circle cx="178" cy="114" r="2"/><circle cx="186" cy="66" r="2"/><circle cx="186" cy="114" r="2"/><circle cx="194" cy="66" r="2"/><circle cx="194" cy="114" r="2"/><circle cx="202" cy="66" r="2"/><circle cx="202" cy="114" r="2"/><circle cx="210" cy="66" r="2"/><circle cx="210" cy="74" r="2"/><circle cx="210" cy="82" r="2"/><circle cx="210" cy="90" r="2"/><circle cx="210" cy="98" r="2"/><circle cx="210" cy="106" r="2"/><circle cx="210" cy="114" r="2"/><circle cx="178" cy="82" r="2"/><circle cx="178" cy="90" r="2"/><circle cx="178" cy="98" r="2"/><circle cx="186" cy="82" r="2"/><circle cx="186" cy="98" r="2"/><circle cx="194" cy="82" r="2"/><circle cx="194" cy="90" r="2"/><circle cx="194" cy="98" r="2"/><circle cx="238" cy="58" r="2"/><circle cx="238" cy="66" r="2"/><circle cx="238" cy="74" r="2"/><circle cx="238" cy="82" r="2"/><circle cx="238" cy="90" r="2"/><circle cx="238" cy="98" r="2"/><circle cx="238" cy="106" r="2"/><circle cx="238" cy="114" r="2"/><circle cx="238" cy="122" r="2"/><circle cx="246" cy="58" r="2"/><circle cx="246" cy="122" r="2"/><circle cx="254" cy="58" r="2"/><circle cx="254" cy="122" r="2"/><circle cx="262" cy="58" r="2"/><circle cx="262" cy="122" r="2"/><circle cx="270" cy="58" r="2"/><circle cx="270" cy="122" r="2"/><circle cx="278" cy="58" r="2"/><circle cx="278" cy="122" r="2"/><circle cx="286" cy="58" r="2"/><circle cx="286" cy="122" r="2"/><circle cx="294" cy="58" r="2"/><circle cx="294" cy="122" r="2"/><circle cx="302" cy="58" r="2"/><circle cx="302" cy="66" r="2"/><circle cx="302" cy="74" r="2"/><circle cx="302" cy="82" r="2"/><circle cx="302" cy="90" r="2"/><circle cx="302" cy="98" r="2"/><circle cx="302" cy="106" r="2"/><circle cx="302" cy="114" r="2"/><circle cx="302" cy="122" r="2"/><circle cx="254" cy="74" r="2"/><circle cx="254" cy="82" r="2"/><circle cx="254" cy="90" r="2"/><circle cx="254" cy="98" r="2"/><circle cx="254" cy="106" r="2"/><circle cx="262" cy="74" r="2"/><circle cx="262" cy="106" r="2"/><circle cx="270" cy="74" r="2"/><circle cx="270" cy="106" r="2"/><circle cx="278" cy="74" r="2"/><circle cx="278" cy="106" r="2"/><circle cx="286" cy="74" r="2"/><circle cx="286" cy="82" r="2"/><circle cx="286" cy="90" r="2"/><circle cx="286" cy="98" r="2"/><circle cx="286" cy="106" r="2"/><circle cx="270" cy="90" r="2"/></g><g font-family="sans-serif" font-size="12" text-anchor="middle"><text x="30" y="78">1.</text><text x="66" y="70">2.</text><text x="118" y="62">3.</text><text x="186" y="54">4.</text><text x="270" y="46">5.</text></g></svg>',
  'puntiky-obrazce.svg',
  'První až pátý obrazec: puntíky v soustředných čtvercových rámečcích (1, 8, 17, 32 a 49 puntíků).',
  '1. až 5. obrazec',
  new List<String>{'Strana hraničního čtverce $n$-tého obrazce má $2n-1$ puntíků. Od $3.$ obrazce je počet puntíků roven hraničnímu čtverci plus obrazec o dvě menší: $1, 8, 17, 32, 49, \\dots$','14.1 Strana $10.$ obrazce: $2\\cdot 10-1=19$ puntíků.','14.2 $11.$ obrazec má $241$, $9.$ obrazec $161$ puntíků; rozdíl $241-161=80$.','14.3 Rozdíl počtů v obrazcích $n+1$ a $n-1$ je $8n$; z $8n=120$ plyne $n=15$, tedy u $15.$ obrazce.'},
  '14.1: $19$ puntíků; 14.2: o $80$ puntíků; 14.3: u $15.$ obrazce',
  4, 6, '3',
  new List<String>{'zs1','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
