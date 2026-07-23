String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD23C0T04';
Integer YEAR = 2023;

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
  'CERMAT M7D 2023 - uloha 6',
  new List<String>{'Na parkovisti je presne $105$ parkovacich mist pro osobni auta. Zaparkuje-li na parkovisti autobus, obsadi vzdy $4$ parkovaci mista pro osobni auta. (Parkoviste tedy zcela zaplni napr. $101$ osobnich aut a jeden autobus.)','6.1 Na zcela zaplnenem parkovisti je osobnich aut trikrat vice nez autobusu. Vypoctete, kolik je na parkovisti osobnich aut.','6.2 Na zcela zaplnenem parkovisti je osobnich aut o ctvrtinu vice nez autobusu. Vypoctete, kolik je na parkovisti autobusu.'},
  null,
  4,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Autobusu $b$, osobnich aut $3b$. Obsazena mista: $3b+4b=7b=105$, tedy $b=15$ a osobnich aut $3b=45$.','6.2 Osobnich aut $\\frac{5}{4}b$: $\\frac{5}{4}b+4b=\\frac{21}{4}b=105$, tedy $b=20$ autobusu (a $25$ osobnich aut, $25+80=105$).'},
  '6.1: $45$ osobnich aut; 6.2: $20$ autobusu',
  4, 6, '3',
  new List<String>{'zs2','r7','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7D 2023 - uloha 7',
  new List<String>{'Ve ctvercove siti jsou z tmavych ctvercu slozeny tri utvary $A$, $B$, $C$. Z kazdeho utvaru vytvorime odebranim jedineho tmaveho ctverce novy utvar, ktery je osove soumerny podle nektere osy (svisle, vodorovne nebo sikme). Kazdy tmavy ctverec je oznacen cislem. Z utvaru $A$ lze vytvorit osove soumerny utvar bud odebranim ctverce $2$, nebo odebranim ctverce $8$.','7.1 Urcete cisla ctvercu, jejichz odebranim vytvorime osove soumerny utvar z utvaru $B$ (najdete obe reseni).','7.2 Urcete cisla ctvercu, jejichz odebranim vytvorime osove soumerny utvar z utvaru $C$ (najdete obe reseni).'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 498 192" font-family="sans-serif"><g fill="#8a8a8a" stroke="#555"><rect x="56" y="40" width="18" height="18"/><rect x="38" y="58" width="18" height="18"/><rect x="56" y="58" width="18" height="18"/><rect x="74" y="58" width="18" height="18"/><rect x="38" y="76" width="18" height="18"/><rect x="56" y="76" width="18" height="18"/><rect x="74" y="76" width="18" height="18"/><rect x="92" y="76" width="18" height="18"/><rect x="56" y="94" width="18" height="18"/><rect x="222" y="40" width="18" height="18"/><rect x="240" y="40" width="18" height="18"/><rect x="204" y="58" width="18" height="18"/><rect x="222" y="58" width="18" height="18"/><rect x="258" y="58" width="18" height="18"/><rect x="276" y="58" width="18" height="18"/><rect x="204" y="76" width="18" height="18"/><rect x="240" y="76" width="18" height="18"/><rect x="276" y="76" width="18" height="18"/><rect x="204" y="94" width="18" height="18"/><rect x="222" y="94" width="18" height="18"/><rect x="258" y="94" width="18" height="18"/><rect x="222" y="112" width="18" height="18"/><rect x="240" y="112" width="18" height="18"/><rect x="388" y="40" width="18" height="18"/><rect x="388" y="58" width="18" height="18"/><rect x="370" y="76" width="18" height="18"/><rect x="406" y="76" width="18" height="18"/><rect x="388" y="94" width="18" height="18"/><rect x="424" y="94" width="18" height="18"/><rect x="442" y="94" width="18" height="18"/><rect x="388" y="112" width="18" height="18"/><rect x="388" y="130" width="18" height="18"/></g><g fill="#fff" font-size="10" text-anchor="middle"><text x="65" y="52">1</text><text x="47" y="70">2</text><text x="65" y="70">3</text><text x="83" y="70">4</text><text x="47" y="88">5</text><text x="65" y="88">6</text><text x="83" y="88">7</text><text x="101" y="88">8</text><text x="65" y="106">9</text><text x="231" y="52">1</text><text x="249" y="52">2</text><text x="213" y="70">3</text><text x="231" y="70">4</text><text x="267" y="70">5</text><text x="285" y="70">6</text><text x="213" y="88">7</text><text x="249" y="88">8</text><text x="285" y="88">9</text><text x="213" y="106">10</text><text x="231" y="106">11</text><text x="267" y="106">12</text><text x="231" y="124">13</text><text x="249" y="124">14</text><text x="397" y="52">1</text><text x="397" y="70">2</text><text x="379" y="88">3</text><text x="415" y="88">4</text><text x="397" y="106">5</text><text x="433" y="106">6</text><text x="451" y="106">7</text><text x="397" y="124">8</text><text x="397" y="142">9</text></g><g font-size="13" text-anchor="middle" font-weight="bold"><text x="83" y="26">A</text><text x="249" y="26">B</text><text x="415" y="26">C</text></g></svg>',
  'utvary-abc.svg',
  'Tri utvary A, B, C z tmavych ctvercu ve ctvercove siti, kazdy ctverec oznacen cislem.',
  'Utvary A, B, C (vychozi obrazek)',
  new List<String>{'7.1 Utvar $B$ je osove soumerny po odebrani ctverce $6$, nebo ctverce $10$.','7.2 Utvar $C$ je osove soumerny po odebrani ctverce $1$, nebo ctverce $9$.'},
  '7.1: $6$; $10$; 7.2: $1$; $9$',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
