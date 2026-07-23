String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M7A 2020 – úloha 11',
  new List<String>{'Na obrázku jsou dvě rovnoběžky (označené shodnými značkami) proťaté dvěma příčkami. Jsou vyznačeny úhly $118^\\circ$ a $142^\\circ$ a hledaný úhel $\\alpha$.','Jaká je velikost úhlu $\\alpha$? Velikosti úhlů neměřte, ale vypočtěte.'},
  new List<String>{'A) menší než $80^\\circ$','B) $80^\\circ$','C) $90^\\circ$','D) $100^\\circ$','E) větší než $100^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 330" font-family="sans-serif"> <line x1="40" y1="110" x2="490" y2="110" stroke="#000" stroke-width="2"/> <line x1="40" y1="270" x2="490" y2="270" stroke="#000" stroke-width="2"/> <line x1="445" y1="102" x2="453" y2="118" stroke="#000" stroke-width="2"/> <line x1="455" y1="102" x2="463" y2="118" stroke="#000" stroke-width="2"/> <line x1="445" y1="262" x2="453" y2="278" stroke="#000" stroke-width="2"/> <line x1="455" y1="262" x2="463" y2="278" stroke="#000" stroke-width="2"/> <line x1="240" y1="30" x2="132" y2="318" stroke="#000" stroke-width="2"/> <line x1="410" y1="36" x2="250" y2="300" stroke="#000" stroke-width="2"/> <text x="150" y="98" font-size="17">118°</text> <text x="92" y="258" font-size="17">142°</text> <text x="372" y="134" font-size="18">α</text> </svg>',
  'uhly-rovnobezky.svg',
  'Dvě rovnoběžky proťaté dvěma příčkami; vyznačené úhly 118° a 142° a hledaný úhel alfa.',
  'Výchozí obrázek k úloze 11',
  new List<String>{'Doplňkové úhly k vyznačeným jsou $180^\\circ-118^\\circ=62^\\circ$ a $180^\\circ-142^\\circ=38^\\circ$. Díky rovnoběžkám jsou to vnitřní úhly trojúhelníku, jehož třetí vrchol leží v průsečíku obou příček. Třetí úhel má velikost $180^\\circ-62^\\circ-38^\\circ=80^\\circ$ a úhel $\\alpha$ je s ním shodný (souhlasný přes rovnoběžky). Proto $\\alpha=80^\\circ$.'},
  'B) $80^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
