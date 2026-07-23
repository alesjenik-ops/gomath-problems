String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M7A 2018 – úloha 12',
  new List<String>{'Na obrázku jsou vyznačeny úhly o velikostech $60^\\circ$, $40^\\circ$, $30^\\circ$ a neznámé úhly $\\alpha$, $\\beta$, $\\gamma$, $\\delta$. Velikosti úhlů neměřte.','Jaký je součet velikostí $\\alpha+\\beta+\\gamma+\\delta$?'},
  new List<String>{'A) menší než $340^\\circ$','B) $340^\\circ$','C) $350^\\circ$','D) $360^\\circ$','E) větší než $360^\\circ$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 360" font-family="sans-serif" font-size="15"> <line x1="20" y1="250" x2="505" y2="250" stroke="#000" stroke-width="1.6"/> <line x1="95" y1="340" x2="185" y2="35" stroke="#000" stroke-width="1.6"/> <line x1="120" y1="250" x2="430" y2="124" stroke="#000" stroke-width="1.6"/> <line x1="175" y1="55" x2="495" y2="290" stroke="#000" stroke-width="1.6"/> <text x="150" y="228" font-size="13">60&#176;</text> <text x="188" y="244" font-style="italic">&#946;</text> <text x="96" y="278" font-style="italic">&#947;</text> <text x="158" y="92" font-style="italic">&#948;</text> <text x="290" y="150" font-size="13">40&#176;</text> <text x="352" y="150" font-style="italic">&#945;</text> <text x="408" y="242" font-size="13">30&#176;</text> </svg>',
  'uhly.svg',
  'Tři přímky protínající vodorovnou přímku a navzájem; vyznačeny úhly 60°, 40°, 30° a neznámé úhly alfa, beta, gama, delta.',
  'Výchozí obrázek k úloze 12',
  new List<String>{'Neznámé úhly $\\alpha$, $\\beta$, $\\gamma$, $\\delta$ se dopočítají z označených úhlů $60^\\circ$, $40^\\circ$, $30^\\circ$ pomocí součtu vnitřních úhlů trojúhelníku ($180^\\circ$) a vlastností vedlejších a vrcholových úhlů. Součet vychází $\\alpha+\\beta+\\gamma+\\delta=360^\\circ$.'},
  'D) $360^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
