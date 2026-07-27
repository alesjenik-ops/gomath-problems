String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD17C0T01';
Integer YEAR = 2017;

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
  'CERMAT M5A 2017 – úloha 13',
  new List<String>{'Těleso na obrázku je slepeno z devíti stejně velkých krychlí. Směry pohledů shora, zepředu a zprava jsou vyznačeny šipkami.','Každé situaci (13.1–13.3) přiřaďte odpovídající obrazec (A–F).','13.1 pohled na těleso zepředu','13.2 pohled na těleso shora','13.3 pohled na těleso zprava'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 570" font-family="sans-serif"><g fill="#fff" stroke="#000" stroke-width="2"><polygon points="181,164 227,164 247,144 201,144"/><polygon points="227,164 247,144 247,190 227,210" fill="#d0d0d0"/><rect x="181" y="164" width="46" height="46"/><polygon points="227,164 273,164 293,144 247,144"/><polygon points="273,164 293,144 293,190 273,210" fill="#d0d0d0"/><rect x="227" y="164" width="46" height="46"/><polygon points="161,184 207,184 227,164 181,164"/><polygon points="207,184 227,164 227,210 207,230" fill="#d0d0d0"/><rect x="161" y="184" width="46" height="46"/><polygon points="161,138 207,138 227,118 181,118"/><polygon points="207,138 227,118 227,164 207,184" fill="#d0d0d0"/><rect x="161" y="138" width="46" height="46"/><polygon points="161,92 207,92 227,72 181,72"/><polygon points="207,92 227,72 227,118 207,138" fill="#d0d0d0"/><rect x="161" y="92" width="46" height="46"/><polygon points="95,158 141,158 161,138 115,138"/><polygon points="141,158 161,138 161,184 141,204" fill="#d0d0d0"/><rect x="95" y="158" width="46" height="46"/><polygon points="141,158 187,158 207,138 161,138"/><polygon points="187,158 207,138 207,184 187,204" fill="#d0d0d0"/><rect x="141" y="158" width="46" height="46"/><polygon points="141,112 187,112 207,92 161,92"/><polygon points="187,112 207,92 207,138 187,158" fill="#d0d0d0"/><rect x="141" y="112" width="46" height="46"/><polygon points="187,112 233,112 253,92 207,92"/><polygon points="233,112 253,92 253,138 233,158" fill="#d0d0d0"/><rect x="187" y="112" width="46" height="46"/></g><path d="M180 20V66" stroke="#555" stroke-width="2"/><polygon points="180,74 174,60 186,60" fill="#555"/><text x="192" y="52" font-size="17">shora</text><text x="8" y="112" font-size="17">zepředu</text><path d="M52 120L118 158" stroke="#555" stroke-width="2"/><polygon points="126,163 112,161 118,151" fill="#555"/><text x="398" y="192" font-size="17">zprava</text><path d="M392 186L330 186" stroke="#555" stroke-width="2"/><polygon points="322,186 336,180 336,192" fill="#555"/><text x="28" y="360" font-size="18">A)</text><text x="208" y="360" font-size="18">B)</text><text x="388" y="360" font-size="18">C)</text><text x="28" y="490" font-size="18">D)</text><text x="208" y="490" font-size="18">E)</text><text x="388" y="490" font-size="18">F)</text><g fill="#b5b5b5" stroke="#000" stroke-width="2"><rect x="90" y="310" width="30" height="30"/><rect x="120" y="310" width="30" height="30"/><rect x="90" y="340" width="30" height="30"/><rect x="120" y="340" width="30" height="30"/><rect x="60" y="370" width="30" height="30"/><rect x="90" y="370" width="30" height="30"/><rect x="300" y="310" width="30" height="30"/><rect x="270" y="340" width="30" height="30"/><rect x="300" y="340" width="30" height="30"/><rect x="240" y="370" width="30" height="30"/><rect x="270" y="370" width="30" height="30"/><rect x="420" y="310" width="30" height="30"/><rect x="450" y="310" width="30" height="30"/><rect x="420" y="340" width="30" height="30"/><rect x="450" y="340" width="30" height="30"/><rect x="450" y="370" width="30" height="30"/><rect x="480" y="370" width="30" height="30"/><rect x="60" y="440" width="30" height="30"/><rect x="90" y="440" width="30" height="30"/><rect x="120" y="440" width="30" height="30"/><rect x="90" y="470" width="30" height="30"/><rect x="120" y="470" width="30" height="30"/><rect x="60" y="500" width="30" height="30"/><rect x="90" y="500" width="30" height="30"/><rect x="270" y="440" width="30" height="30"/><rect x="300" y="440" width="30" height="30"/><rect x="240" y="470" width="30" height="30"/><rect x="270" y="470" width="30" height="30"/><rect x="270" y="500" width="30" height="30"/><rect x="300" y="500" width="30" height="30"/><rect x="450" y="440" width="30" height="30"/><rect x="480" y="440" width="30" height="30"/><rect x="450" y="470" width="30" height="30"/><rect x="420" y="500" width="30" height="30"/><rect x="450" y="500" width="30" height="30"/><rect x="480" y="500" width="30" height="30"/></g></svg>',
  'teleso-pohledy.svg',
  'Těleso slepené z devíti krychlí se šipkami shora, zepředu a zprava a šest nabízených obrazců A až F složených z 5 až 7 čtverců.',
  'Schematický nákres tělesa a nabídka obrazců A–F',
  new List<String>{'Pohled zepředu tvoří šest čtverců uspořádaných do dvou horních vpravo, dvou prostředních vlevo a dvou spodních vpravo – obrazec E.','Pohled shora tvoří šest čtverců: dva v horní řadě vpravo, jeden uprostřed a tři ve spodní řadě – obrazec F.','Pohled zprava tvoří šest čtverců: čtverec $2\\times 2$ vlevo nahoře a dva čtverce vpravo dole – obrazec C.'},
  '13.1: E; 13.2: F; 13.3: C',
  5, 6, '3',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
