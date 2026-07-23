String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PDD22C0T04';
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
  'CERMAT M9D 2022 – úloha 11',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$; každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (svislých, vodorovných nebo šikmých).','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).','11.1 Správně upravený útvar $A$ má pouze $2$ osy souměrnosti.','11.2 Správně upravený útvar $B$ má pouze $2$ osy souměrnosti.','11.3 Správně upravený útvar $C$ má pouze $1$ osu souměrnosti.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 580 190" font-family="sans-serif"><g fill="#a9a9a9"><rect x="50" y="30" width="20" height="20"/><rect x="70" y="30" width="20" height="20"/><rect x="30" y="50" width="20" height="20"/><rect x="90" y="50" width="20" height="20"/><rect x="10" y="70" width="20" height="20"/><rect x="30" y="70" width="20" height="20"/><rect x="90" y="70" width="20" height="20"/><rect x="110" y="70" width="20" height="20"/><rect x="10" y="90" width="20" height="20"/><rect x="50" y="90" width="20" height="20"/><rect x="10" y="110" width="20" height="20"/><rect x="30" y="110" width="20" height="20"/><rect x="90" y="110" width="20" height="20"/><rect x="110" y="110" width="20" height="20"/><rect x="30" y="130" width="20" height="20"/><rect x="90" y="130" width="20" height="20"/><rect x="50" y="150" width="20" height="20"/><rect x="70" y="150" width="20" height="20"/><rect x="230" y="50" width="20" height="20"/><rect x="250" y="50" width="20" height="20"/><rect x="290" y="50" width="20" height="20"/><rect x="310" y="50" width="20" height="20"/><rect x="230" y="70" width="20" height="20"/><rect x="270" y="70" width="20" height="20"/><rect x="310" y="70" width="20" height="20"/><rect x="210" y="90" width="20" height="20"/><rect x="330" y="90" width="20" height="20"/><rect x="230" y="110" width="20" height="20"/><rect x="310" y="110" width="20" height="20"/><rect x="230" y="130" width="20" height="20"/><rect x="250" y="130" width="20" height="20"/><rect x="290" y="130" width="20" height="20"/><rect x="310" y="130" width="20" height="20"/><rect x="270" y="150" width="20" height="20"/><rect x="490" y="30" width="20" height="20"/><rect x="450" y="50" width="20" height="20"/><rect x="470" y="50" width="20" height="20"/><rect x="450" y="70" width="20" height="20"/><rect x="490" y="70" width="20" height="20"/><rect x="530" y="70" width="20" height="20"/><rect x="430" y="90" width="20" height="20"/><rect x="470" y="90" width="20" height="20"/><rect x="490" y="90" width="20" height="20"/><rect x="510" y="90" width="20" height="20"/><rect x="490" y="110" width="20" height="20"/><rect x="470" y="130" width="20" height="20"/></g><path d="M10 30V170M30 30V170M50 30V170M70 30V170M90 30V170M110 30V170M130 30V170M150 30V170M170 30V170M10 30H170M10 50H170M10 70H170M10 90H170M10 110H170M10 130H170M10 150H170M10 170H170" fill="none" stroke="#000"/><text x="90" y="20" font-size="15" text-anchor="middle">A</text><path d="M210 30V170M230 30V170M250 30V170M270 30V170M290 30V170M310 30V170M330 30V170M350 30V170M370 30V170M210 30H370M210 50H370M210 70H370M210 90H370M210 110H370M210 130H370M210 150H370M210 170H370" fill="none" stroke="#000"/><text x="290" y="20" font-size="15" text-anchor="middle">B</text><path d="M410 30V170M430 30V170M450 30V170M470 30V170M490 30V170M510 30V170M530 30V170M550 30V170M570 30V170M410 30H570M410 50H570M410 70H570M410 90H570M410 110H570M410 130H570M410 150H570M410 170H570" fill="none" stroke="#000"/><text x="490" y="20" font-size="15" text-anchor="middle">C</text></svg>',
  'utvary-ABC.svg',
  'Tři útvary A, B, C složené z tmavých čtverců ve čtvercové síti (schematicky podle testového sešitu).',
  'Výchozí útvary A, B, C (schematicky)',
  new List<String>{'Po nejvýhodnějším přemístění jediného čtverce získá útvar $A$ právě $2$ osy souměrnosti (tvrzení Ano). Útvar $B$ lze upravit tak, aby měl více než $2$ osy, proto tvrzení o pouze $2$ osách neplatí (Ne). Útvar $C$ lze upravit tak, aby měl více než $1$ osu, proto tvrzení o pouze $1$ ose neplatí (Ne).'},
  '11.1: Ano; 11.2: Ne; 11.3: Ne',
  4, 6, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
