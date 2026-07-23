String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD22C0T03';
Integer YEAR = 2022;

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
  'CERMAT M7C 2022 – úloha 11',
  new List<String>{'V rovině leží čtyři přímky, z nichž dvě jsou rovnoběžné a zbývající dvě jsou na sebe kolmé (viz obrázek). U jednoho průsečíku jsou vyznačeny úhly $2\\alpha$ a $3\\alpha$, u jiného průsečíku úhel $\\beta$.','Jaká je velikost úhlu $\\beta$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $20^\\circ$','B) $20^\\circ$','C) $28^\\circ$','D) $34^\\circ$','E) větší než $34^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 400" font-family="sans-serif"><rect x="6" y="6" width="608" height="388" fill="none" stroke="#bbb"/><line x1="108" y1="236" x2="237" y2="64" stroke="#000" stroke-width="1.8"/><line x1="222" y1="73" x2="230" y2="65" stroke="#000"/><line x1="226" y1="77" x2="234" y2="69" stroke="#000"/><line x1="148" y1="95" x2="304" y2="316" stroke="#000" stroke-width="1.8"/><line x1="184" y1="284" x2="372" y2="152" stroke="#000" stroke-width="1.8"/><line x1="322" y1="207" x2="397" y2="107" stroke="#000" stroke-width="1.8"/><line x1="384" y1="114" x2="392" y2="106" stroke="#000"/><line x1="388" y1="118" x2="396" y2="110" stroke="#000"/><polyline points="259,231 252,221 242,228" fill="none" stroke="#000"/><circle cx="249" cy="238" r="1.6" fill="#000"/><text x="198" y="110" font-size="15" font-style="italic">2α</text><text x="138" y="142" font-size="15" font-style="italic">3α</text><text x="347" y="193" font-size="15" font-style="italic">β</text></svg>',
  'ctyri-primky-uhly.svg',
  'Čtyři přímky – dvě rovnoběžné a dvě navzájem kolmé; vyznačené úhly 2 alfa, 3 alfa, beta a jeden pravý úhel.',
  'Schematický nákres k úloze 11',
  new List<String>{'Úhly $2\\alpha$ a $3\\alpha$ jsou vedlejší (leží při téže přímce), proto $2\\alpha+3\\alpha=180^\\circ$, tedy $5\\alpha=180^\\circ$ a $\\alpha=36^\\circ$. Šikmá přímka svírá s rovnoběžkami úhel $2\\alpha=72^\\circ$. Druhá šikmá přímka je na ni kolmá, a proto s rovnoběžkami svírá úhel $\\beta=90^\\circ-72^\\circ=18^\\circ$, což je méně než $20^\\circ$.'},
  'A) menší než $20^\\circ$',
  2, 4, '4',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
