String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD23C0T04';
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
  'CERMAT M9D 2023 – úloha 8',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C. Z každého útvaru vytvoříme odebráním jediného tmavého čtverce nový útvar, který je osově souměrný podle některé osy (svislé, vodorovné nebo šikmé). V jednotlivých útvarech je každý tmavý čtverec označen číslem (viz obrázek). Z útvaru A lze vytvořit osově souměrný útvar buď odebráním čtverce 2, nebo odebráním čtverce 8.','Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar. V každé části úlohy najděte obě řešení.','8.1 z útvaru B,','8.2 z útvaru C.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 410 175" font-family="sans-serif"><rect x="18" y="30" width="85" height="68" fill="none" stroke="#d0d0d0"/><g fill="#8a8a8a" stroke="#222" stroke-width="1"><rect x="52" y="30" width="17" height="17"/><rect x="35" y="47" width="17" height="17"/><rect x="52" y="47" width="17" height="17"/><rect x="69" y="47" width="17" height="17"/><rect x="18" y="64" width="17" height="17"/><rect x="35" y="64" width="17" height="17"/><rect x="52" y="64" width="17" height="17"/><rect x="69" y="64" width="17" height="17"/><rect x="35" y="81" width="17" height="17"/></g><g fill="#fff" font-size="10" text-anchor="middle"><text x="60" y="42">1</text><text x="43" y="59">2</text><text x="60" y="59">3</text><text x="77" y="59">4</text><text x="26" y="76">5</text><text x="43" y="76">6</text><text x="60" y="76">7</text><text x="77" y="76">8</text><text x="43" y="93">9</text></g><text x="60" y="24" font-size="13" text-anchor="middle" font-weight="bold">A</text><rect x="140" y="30" width="102" height="85" fill="none" stroke="#d0d0d0"/><g fill="#8a8a8a" stroke="#222" stroke-width="1"><rect x="191" y="30" width="17" height="17"/><rect x="208" y="30" width="17" height="17"/><rect x="157" y="47" width="17" height="17"/><rect x="174" y="47" width="17" height="17"/><rect x="208" y="47" width="17" height="17"/><rect x="225" y="47" width="17" height="17"/><rect x="157" y="64" width="17" height="17"/><rect x="191" y="64" width="17" height="17"/><rect x="225" y="64" width="17" height="17"/><rect x="140" y="81" width="17" height="17"/><rect x="157" y="81" width="17" height="17"/><rect x="191" y="81" width="17" height="17"/><rect x="157" y="98" width="17" height="17"/><rect x="174" y="98" width="17" height="17"/></g><g fill="#fff" font-size="10" text-anchor="middle"><text x="199" y="42">1</text><text x="216" y="42">2</text><text x="165" y="59">3</text><text x="182" y="59">4</text><text x="216" y="59">5</text><text x="233" y="59">6</text><text x="165" y="76">7</text><text x="199" y="76">8</text><text x="233" y="76">9</text><text x="148" y="93">10</text><text x="165" y="93">11</text><text x="199" y="93">12</text><text x="165" y="110">13</text><text x="182" y="110">14</text></g><text x="191" y="24" font-size="13" text-anchor="middle" font-weight="bold">B</text><rect x="288" y="25" width="102" height="102" fill="none" stroke="#d0d0d0"/><g fill="#8a8a8a" stroke="#222" stroke-width="1"><rect x="339" y="25" width="17" height="17"/><rect x="339" y="42" width="17" height="17"/><rect x="305" y="59" width="17" height="17"/><rect x="339" y="59" width="17" height="17"/><rect x="322" y="76" width="17" height="17"/><rect x="356" y="76" width="17" height="17"/><rect x="373" y="76" width="17" height="17"/><rect x="339" y="93" width="17" height="17"/><rect x="339" y="110" width="17" height="17"/></g><g fill="#fff" font-size="10" text-anchor="middle"><text x="347" y="37">1</text><text x="347" y="54">2</text><text x="313" y="71">3</text><text x="347" y="71">4</text><text x="330" y="88">5</text><text x="364" y="88">6</text><text x="381" y="88">7</text><text x="347" y="105">8</text><text x="347" y="122">9</text></g><text x="339" y="19" font-size="13" text-anchor="middle" font-weight="bold">C</text></svg>',
  'ctvercova-sit.svg',
  'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti; jednotlivé čtverce jsou očíslované.',
  'Útvary A, B, C ve čtvercové síti (schematický přepis)',
  new List<String>{'8.1 Z útvaru B vznikne osově souměrný útvar odebráním čtverce $6$, nebo čtverce $10$.','8.2 Z útvaru C vznikne osově souměrný útvar odebráním čtverce $1$, nebo čtverce $9$.'},
  '8.1: čtverce $6$ a $10$; 8.2: čtverce $1$ a $9$',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
