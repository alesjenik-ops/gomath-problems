String SRC   = 'CERMAT – Jednotná přijímací zkouška 2022, 2. řádný termín (M9B)';
String STYPE = 'CERMAT';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'CERMAT 2022 M9B · úloha 16',
  new List<String>{'Ve čtvercové síti (krok $1\\ \\mathrm{cm}$) vytváříme různé obdélníky s vrcholy v mřížových bodech. Uvnitř obdélníku zakreslíme v každém vnitřním mřížovém bodě hvězdičku. Hvězdičky nejblíže hranici obdélníku jsou tmavé, ostatní bílé. (Na obrázku je příklad obdélníku $8\\ \\mathrm{cm}\\times4\\ \\mathrm{cm}$ se $7\\cdot3=21$ hvězdičkami, z nichž vnitřní jsou bílé a vnější tmavé.)','Obdélník o rozměrech $a\\ \\mathrm{cm}\\times b\\ \\mathrm{cm}$ má $(a-1)(b-1)$ hvězdiček; bílých je $(a-3)(b-3)$ a zbytek jsou tmavé.','16.1 Určete počet všech hvězdiček v obdélníku s rozměry $81\\ \\mathrm{cm}$ a $20\\ \\mathrm{cm}$.','16.2 Obdélník, jehož jeden rozměr je $50\\ \\mathrm{cm}$, obsahuje celkem $9\\,800$ hvězdiček. Určete v cm druhý rozměr tohoto obdélníku.','16.3 Vypočtěte, o kolik se liší počty bílých a tmavých hvězdiček v obdélníku s rozměry $41\\ \\mathrm{cm}$ a $23\\ \\mathrm{cm}$.'},
  null,
  null,
  null,
  null,
  null,
  null,
  new List<String>{'Počet všech hvězdiček (vnitřních mřížových bodů) obdélníku $a\\times b$ je $(a-1)(b-1)$; bílé tvoří vnitřní pole $(a-3)(b-3)$, tmavé jsou zbývající vnější řada.','16.1: $(81-1)(20-1)=80\\cdot19=1\\,520$ hvězdiček.','16.2: $(50-1)(b-1)=9\\,800\\Rightarrow49(b-1)=9\\,800\\Rightarrow b-1=200\\Rightarrow b=201\\ \\mathrm{cm}$.','16.3: všech $=(41-1)(23-1)=40\\cdot22=880$; bílých $=(41-3)(23-3)=38\\cdot20=760$; tmavých $=880-760=120$; liší se o $760-120=640$.'},
  '16.1: $1\\,520$ hvězdiček; 16.2: $201\\ \\mathrm{cm}$; 16.3: o $640$ hvězdiček',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','algebra','vypocet','slovni','bez-kalkulacky'},
  'M9PBD22C0T02', 2022
);

System.debug('Vytvořeno úloh: '+c.created);
