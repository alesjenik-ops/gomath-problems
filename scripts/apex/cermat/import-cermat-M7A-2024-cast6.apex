String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD24C0T01';
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
  'CERMAT M7A 2024 – úloha 16',
  new List<String>{'Hranol o výšce $15$ cm se skládá ze dvou shodných kvádrů s obdélníkovou podstavou a jednoho kvádru se čtvercovou podstavou. Podstava hranolu i s rozměry je na obrázku.','16.1 Vypočítejte povrch tělesa. Výsledek uveďte v cm².','16.2 Vypočítejte objem tělesa. Výsledek uveďte v cm³.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 350" font-family="sans-serif"> <polygon points="118,310 196,310 196,232 274,232 274,154 196,154 196,76 40,76 40,154 118,154" fill="#ffffff" stroke="#000" stroke-width="2"/> <line x1="118" y1="154" x2="196" y2="154" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/> <line x1="196" y1="154" x2="196" y2="232" stroke="#000" stroke-width="1" stroke-dasharray="5 4"/> <text x="118" y="66" font-size="15" text-anchor="middle">6 cm</text> <text x="20" y="120" font-size="15" text-anchor="middle">3 cm</text> <text x="96" y="245" font-size="15" text-anchor="middle">6 cm</text> <text x="157" y="330" font-size="15" text-anchor="middle">3 cm</text> <text x="292" y="197" font-size="15" text-anchor="middle">3 cm</text> <text x="235" y="250" font-size="15" text-anchor="middle">3 cm</text> </svg>',
  'podstava-hranolu.svg',
  'Podstava hranolu slozena ze dvou obdelniku 6 krat 3 cm a jednoho ctverce 3 krat 3 cm.',
  'Podstava hranolu s rozměry',
  new List<String>{'Obsah podstavy: dva obdélníky $6\\cdot 3$ a jeden čtverec $3\\cdot 3$, tj. $18+18+9=45$ cm². Obvod podstavy je $36$ cm.','16.1 Povrch $=2\\cdot 45+36\\cdot 15=90+540=630$ cm².','16.2 Objem $=45\\cdot 15=675$ cm³.'},
  '16.1: $630$ cm²; 16.2: $675$ cm³',
  4, 6, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
