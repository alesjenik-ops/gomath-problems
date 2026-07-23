String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
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
  'CERMAT M5D 2023 – úloha 6',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C (viz obrázek). Z každého útvaru vytvoříme odebráním jediného tmavého čtverce nový útvar, který je osově souměrný podle některé osy (svislé, vodorovné nebo šikmé). V jednotlivých útvarech je každý tmavý čtverec označen číslem. Z útvaru A lze osově souměrný útvar vytvořit buď odebráním čtverce 2, nebo odebráním čtverce 8.','6.1 Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar z útvaru B.','6.2 Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar z útvaru C.','V každé části úlohy najděte obě řešení.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 190" font-family="sans-serif" font-size="14" text-anchor="middle"><g fill="#7a7a7a" stroke="#000"><rect x="56" y="42" width="18" height="18"/><rect x="38" y="60" width="18" height="18"/><rect x="56" y="60" width="18" height="18"/><rect x="74" y="60" width="18" height="18"/><rect x="20" y="78" width="18" height="18"/><rect x="38" y="78" width="18" height="18"/><rect x="56" y="78" width="18" height="18"/><rect x="74" y="78" width="18" height="18"/><rect x="38" y="96" width="18" height="18"/><rect x="193" y="42" width="18" height="18"/><rect x="211" y="42" width="18" height="18"/><rect x="175" y="60" width="18" height="18"/><rect x="193" y="60" width="18" height="18"/><rect x="229" y="60" width="18" height="18"/><rect x="247" y="60" width="18" height="18"/><rect x="175" y="78" width="18" height="18"/><rect x="211" y="78" width="18" height="18"/><rect x="247" y="78" width="18" height="18"/><rect x="175" y="96" width="18" height="18"/><rect x="193" y="96" width="18" height="18"/><rect x="229" y="96" width="18" height="18"/><rect x="193" y="114" width="18" height="18"/><rect x="211" y="114" width="18" height="18"/><rect x="368" y="42" width="18" height="18"/><rect x="368" y="60" width="18" height="18"/><rect x="350" y="78" width="18" height="18"/><rect x="386" y="78" width="18" height="18"/><rect x="350" y="96" width="18" height="18"/><rect x="386" y="96" width="18" height="18"/><rect x="404" y="96" width="18" height="18"/><rect x="368" y="114" width="18" height="18"/><rect x="368" y="132" width="18" height="18"/></g><g font-size="10" fill="#fff"><text x="65" y="55">1</text><text x="47" y="73">2</text><text x="65" y="73">3</text><text x="83" y="73">4</text><text x="29" y="91">5</text><text x="47" y="91">6</text><text x="65" y="91">7</text><text x="83" y="91">8</text><text x="47" y="109">9</text><text x="202" y="55">1</text><text x="220" y="55">2</text><text x="184" y="73">3</text><text x="202" y="73">4</text><text x="238" y="73">5</text><text x="256" y="73">6</text><text x="184" y="91">7</text><text x="220" y="91">8</text><text x="256" y="91">9</text><text x="184" y="109">10</text><text x="202" y="109">11</text><text x="238" y="109">12</text><text x="202" y="127">13</text><text x="220" y="127">14</text><text x="377" y="55">1</text><text x="377" y="73">2</text><text x="359" y="91">3</text><text x="395" y="91">4</text><text x="359" y="109">5</text><text x="395" y="109">6</text><text x="413" y="109">7</text><text x="377" y="127">8</text><text x="377" y="145">9</text></g><text x="56" y="26" font-weight="bold">A</text><text x="211" y="26" font-weight="bold">B</text><text x="386" y="26" font-weight="bold">C</text></svg>',
  'utvary-abc.svg',
  'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti; každý čtverec je označen číslem.',
  'Schematický nákres útvarů A, B, C (přesné rozmístění viz testový sešit)',
  new List<String>{'6.1 Útvar B je osově souměrný po odebrání čtverce 6, nebo po odebrání čtverce 10.','6.2 Útvar C je osově souměrný po odebrání čtverce 1, nebo po odebrání čtverce 9.'},
  '6.1: $6$; $10$; 6.2: $1$; $9$',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
