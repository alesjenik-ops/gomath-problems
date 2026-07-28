String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD16C0T01';
Integer YEAR = 2016;

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
  'CERMAT M7A 2016 – úloha 13',
  new List<String>{'Trojúhelník $ABC$ je rozdělen na dva rovnoramenné trojúhelníky (viz obrázek).','Jaká je velikost úhlu $\\alpha$? Úhel $\\alpha$ neměřte, ale vypočtěte.'},
  new List<String>{'A) $48^\\circ$','B) $52^\\circ$','C) $58^\\circ$','D) $64^\\circ$','E) jiná velikost'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 262" font-family="sans-serif"><line x1="60.0" y1="220.0" x2="480.0" y2="220.0" stroke="#000" stroke-width="2"/><line x1="60.0" y1="220.0" x2="149.0" y2="37.0" stroke="#000" stroke-width="2"/><line x1="149.0" y1="37.0" x2="480.0" y2="220.0" stroke="#000" stroke-width="2"/><line x1="149.0" y1="37.0" x2="264.0" y2="220.0" stroke="#000" stroke-width="2"/><path d="M 104.0,220.0 A 44,44 0 0 0 79.2,180.4" fill="none" stroke="#000" stroke-width="1.6"/><text x="112.6" y="192.1" font-size="16" text-anchor="middle">α</text><path d="M 441.5,198.7 A 44,44 0 0 0 436.0,220.0" fill="none" stroke="#000" stroke-width="1.6"/><text x="418.0" y="209.0" font-size="15" text-anchor="middle">29°</text><path d="M 133.3,69.4 A 36,36 0 0 0 168.2,67.5" fill="none" stroke="#000" stroke-width="1.6"/><text x="151.8" y="93.9" font-size="16" text-anchor="middle">φ</text><path d="M 165.0,62.4 A 30,30 0 0 0 175.3,51.5" fill="none" stroke="#000" stroke-width="1.6"/><text x="183.9" y="75.0" font-size="15" text-anchor="middle">29°</text><path d="M 245.9,191.2 A 34,34 0 0 1 298.0,220.0" fill="none" stroke="#000" stroke-width="1.6"/><text x="288.2" y="181.2" font-size="16" text-anchor="middle">φ</text><text x="143" y="26" font-size="17" font-style="italic">C</text><text x="40" y="240" font-size="17" font-style="italic">A</text><text x="492" y="234" font-size="17" font-style="italic">B</text></svg>',
  'trojuhelnik-uhly.svg',
  'Trojúhelník ABC rozdělený úsečkou z vrcholu C na dva rovnoramenné trojúhelníky; u vrcholu A je úhel alfa, u C jsou úhly fí a 29 stupňů, u dělicího bodu je úhel fí a u B je 29 stupňů.',
  'Trojúhelník ABC rozdělený na dva rovnoramenné trojúhelníky',
  new List<String>{'Označme $D$ bod, v němž dělicí úsečka protíná stranu $AB$.','V trojúhelníku $DCB$ jsou úhly u vrcholů $C$ i $B$ rovny $29^\\circ$, proto $|\\angle CDB|=180^\\circ-2\\cdot 29^\\circ=122^\\circ$ a vedlejší úhel $|\\angle ADC|=58^\\circ$, tedy $\\varphi=58^\\circ$.','V trojúhelníku $ACD$ je $|\\angle ACD|=|\\angle ADC|=58^\\circ$, proto $\\alpha=180^\\circ-2\\cdot 58^\\circ=64^\\circ$.'},
  'D) $64^\\circ$',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2016 – úloha 14',
  new List<String>{'Při vydatném dešti napršelo na záhon o rozloze jeden metr čtvereční 30 litrů vody. Toto množství vody by naplnilo $2{,}5$ kbelíku.','Jaký je objem jednoho kbelíku?'},
  new List<String>{'A) $0{,}012$ m³','B) $0{,}075$ m³','C) $7{,}5$ m³','D) $12$ m³','E) jiný objem'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Objem jednoho kbelíku je $30:2{,}5=12$ litrů.','$12$ litrů $=12$ dm³ $=0{,}012$ m³.'},
  'A) $0{,}012$ m³',
  2, 3, '2',
  new List<String>{'zs2','r7','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
