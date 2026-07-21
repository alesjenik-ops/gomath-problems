String SRC   = 'CERMAT – Jednotná přijímací zkouška 2023, druhý náhradní termín (M9D)';
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
  'CERMAT 2023 M9D · úloha 8',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C; v každém je každý tmavý čtverec označen číslem (viz obrázek). Z každého útvaru vytvoříme odebráním jediného tmavého čtverce nový útvar, který je osově souměrný podle některé osy (svislé, vodorovné nebo šikmé). Z útvaru A lze vytvořit osově souměrný útvar odebráním čtverce $2$, nebo odebráním čtverce $8$.','Určete číslo čtverce, jehož odebráním vytvoříme osově souměrný útvar 8.1 z útvaru B, 8.2 z útvaru C. V každé části najděte obě řešení.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 472 182"><path d="M4 4L5 4L5 159L4 159Z" style="fill:#000000"/><path d="M467 4L468 4L468 159L467 159Z" style="fill:#000000"/><path d="M4 159L5 159L5 178L4 178Z" style="fill:#000000"/><path d="M467 159L468 159L468 178L467 178Z" style="fill:#000000"/><path d="M76 57L93 57L93 74L76 74Z" style="fill:#7f7f7f"/><path d="M59 74L76 74L76 91L59 91Z" style="fill:#7f7f7f"/><path d="M76 74L93 74L93 91L76 91Z" style="fill:#7f7f7f"/><path d="M93 74L110 74L110 91L93 91Z" style="fill:#7f7f7f"/><path d="M59 91L76 91L76 108L59 108Z" style="fill:#7f7f7f"/><path d="M76 91L93 91L93 108L76 108Z" style="fill:#7f7f7f"/><path d="M93 91L110 91L110 108L93 108Z" style="fill:#7f7f7f"/><path d="M110 91L127 91L127 108L110 108Z" style="fill:#7f7f7f"/><path d="M76 108L93 108L93 125L76 125Z" style="fill:#7f7f7f"/><path d="M16 40L153 40M16 57L153 57M16 74L153 74M16 91L153 91M16 108L153 108M16 125L153 125M16 142L153 142M25 150L25 31M42 150L42 31M59 150L59 31M76 150L76 31M93 150L93 31M110 150L110 31M127 150L127 31M144 150L144 31M168 40L304 40M168 57L304 57M168 74L304 74M168 91L304 91M168 108L304 108M168 125L304 125M168 142L304 142M177 150L177 31M194 150L194 31M211 150L211 31M228 150L228 31M245 150L245 31M262 150L262 31M279 150L279 31M296 150L296 31M320 40L456 40M320 57L456 57M320 74L456 74M320 91L456 91M320 108L456 108M320 125L456 125M320 142L456 142M328 150L328 31M345 150L345 31M362 150L362 31M379 150L379 31M396 150L396 31M413 150L413 31M430 150L430 31M447 150L447 31" style="fill:none;stroke:#000000;stroke-width:1"/><path d="M211 40L228 40L228 57L211 57Z" style="fill:#7f7f7f"/><path d="M228 40L245 40L245 57L228 57Z" style="fill:#7f7f7f"/><path d="M194 57L211 57L211 74L194 74Z" style="fill:#7f7f7f"/><path d="M211 57L228 57L228 74L211 74Z" style="fill:#7f7f7f"/><path d="M245 57L262 57L262 74L245 74Z" style="fill:#7f7f7f"/><path d="M262 57L279 57L279 74L262 74Z" style="fill:#7f7f7f"/><path d="M262 74L279 74L279 91L262 91Z" style="fill:#7f7f7f"/><path d="M228 74L245 74L245 91L228 91Z" style="fill:#7f7f7f"/><path d="M194 74L211 74L211 91L194 91Z" style="fill:#7f7f7f"/><path d="M194 91L211 91L211 108L194 108Z" style="fill:#7f7f7f"/><path d="M211 91L228 91L228 108L211 108Z" style="fill:#7f7f7f"/><path d="M245 91L262 91L262 108L245 108Z" style="fill:#7f7f7f"/><path d="M211 108L228 108L228 125L211 125Z" style="fill:#7f7f7f"/><path d="M228 108L245 108L245 125L228 125Z" style="fill:#7f7f7f"/><path d="M362 40L379 40L379 57L362 57Z" style="fill:#7f7f7f"/><path d="M362 57L379 57L379 74L362 74Z" style="fill:#7f7f7f"/><path d="M345 74L362 74L362 91L345 91Z" style="fill:#7f7f7f"/><path d="M379 74L396 74L396 91L379 91Z" style="fill:#7f7f7f"/><path d="M362 91L379 91L379 108L362 108Z" style="fill:#7f7f7f"/><path d="M396 91L413 91L413 108L396 108Z" style="fill:#7f7f7f"/><path d="M413 91L430 91L430 108L413 108Z" style="fill:#7f7f7f"/><path d="M379 108L396 108L396 125L379 125Z" style="fill:#7f7f7f"/><path d="M379 125L396 125L396 142L379 142Z" style="fill:#7f7f7f"/><text x="86" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="86" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="69" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="86" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3</text><text x="103" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="69" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">5</text><text x="86" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6</text><text x="103" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">7</text><text x="120" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="86" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">9</text><text x="237" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="220" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="237" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="203" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3</text><text x="220" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="254" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">5</text><text x="271" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6</text><text x="271" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">9</text><text x="237" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="203" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">7</text><text x="203" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">10</text><text x="220" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">11</text><text x="254" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">12</text><text x="220" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">13</text><text x="237" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">14</text><text x="389" y="28" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text><text x="372" y="54" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">1</text><text x="372" y="71" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">2</text><text x="355" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">3</text><text x="389" y="88" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">4</text><text x="372" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">5</text><text x="406" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">6</text><text x="423" y="105" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">7</text><text x="389" y="122" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">8</text><text x="389" y="139" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">9</text></svg>',
  'obr.svg',
  'Ve čtvercové síti tři útvary A, B, C složené z tmavých čtverců, každý tmavý čtverec je označen číslem.',
  '',
  new List<String>{'8.1: útvar B je osově souměrný po odebrání čtverce $6$, nebo čtverce $10$.','8.2: útvar C je osově souměrný po odebrání čtverce $1$, nebo čtverce $9$.'},
  '8.1: čtverec $6$ nebo $10$; 8.2: čtverec $1$ nebo $9$',
  4, 6, '4',
  new List<String>{'zs2','r9','planimetrie','geometrie','soumernost','uvazovani','bez-kalkulacky'},
  'M9PDD23C0T04', 2023
);

System.debug('Vytvořeno úloh: '+c.created);
