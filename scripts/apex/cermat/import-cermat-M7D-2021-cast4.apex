String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD21C0T04';
Integer YEAR = 2021;

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
  'CERMAT M7D 2021 – úloha 10',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary $A$, $B$, $C$ (viz obrázek). Ke každému útvaru doplňte jediný tmavý čtverec tak, aby byl útvar osově souměrný a měl co nejvíce různých os souměrnosti.','Rozhodněte o každém z tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 Útvar $A$ doplněný o požadovaný čtverec má $4$ osy souměrnosti.','10.2 Útvar $B$ doplněný o požadovaný čtverec má $2$ osy souměrnosti.','10.3 Útvar $C$ doplněný o požadovaný čtverec má pouze $1$ osu souměrnosti.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 170" font-family="sans-serif"><g transform="translate(0,0)"><rect x="67" y="20" width="21" height="21" fill="#b0b0b0"/><rect x="46" y="41" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="41" width="21" height="21" fill="#b0b0b0"/><rect x="25" y="62" width="21" height="21" fill="#b0b0b0"/><rect x="46" y="83" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="83" width="21" height="21" fill="#b0b0b0"/><rect x="67" y="104" width="21" height="21" fill="#b0b0b0"/><line x1="4" y1="20" x2="4" y2="146" stroke="#000"/><line x1="25" y1="20" x2="25" y2="146" stroke="#000"/><line x1="46" y1="20" x2="46" y2="146" stroke="#000"/><line x1="67" y1="20" x2="67" y2="146" stroke="#000"/><line x1="88" y1="20" x2="88" y2="146" stroke="#000"/><line x1="109" y1="20" x2="109" y2="146" stroke="#000"/><line x1="130" y1="20" x2="130" y2="146" stroke="#000"/><line x1="151" y1="20" x2="151" y2="146" stroke="#000"/><line x1="4" y1="20" x2="151" y2="20" stroke="#000"/><line x1="4" y1="41" x2="151" y2="41" stroke="#000"/><line x1="4" y1="62" x2="151" y2="62" stroke="#000"/><line x1="4" y1="83" x2="151" y2="83" stroke="#000"/><line x1="4" y1="104" x2="151" y2="104" stroke="#000"/><line x1="4" y1="125" x2="151" y2="125" stroke="#000"/><line x1="4" y1="146" x2="151" y2="146" stroke="#000"/><text x="77.5" y="14" font-size="14" text-anchor="middle" font-weight="bold">A</text></g><g transform="translate(185,0)"><rect x="46" y="20" width="21" height="21" fill="#b0b0b0"/><rect x="25" y="41" width="21" height="21" fill="#b0b0b0"/><rect x="46" y="41" width="21" height="21" fill="#b0b0b0"/><rect x="67" y="62" width="21" height="21" fill="#b0b0b0"/><rect x="67" y="83" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="104" width="21" height="21" fill="#b0b0b0"/><rect x="109" y="104" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="125" width="21" height="21" fill="#b0b0b0"/><line x1="4" y1="20" x2="4" y2="146" stroke="#000"/><line x1="25" y1="20" x2="25" y2="146" stroke="#000"/><line x1="46" y1="20" x2="46" y2="146" stroke="#000"/><line x1="67" y1="20" x2="67" y2="146" stroke="#000"/><line x1="88" y1="20" x2="88" y2="146" stroke="#000"/><line x1="109" y1="20" x2="109" y2="146" stroke="#000"/><line x1="130" y1="20" x2="130" y2="146" stroke="#000"/><line x1="151" y1="20" x2="151" y2="146" stroke="#000"/><line x1="4" y1="20" x2="151" y2="20" stroke="#000"/><line x1="4" y1="41" x2="151" y2="41" stroke="#000"/><line x1="4" y1="62" x2="151" y2="62" stroke="#000"/><line x1="4" y1="83" x2="151" y2="83" stroke="#000"/><line x1="4" y1="104" x2="151" y2="104" stroke="#000"/><line x1="4" y1="125" x2="151" y2="125" stroke="#000"/><line x1="4" y1="146" x2="151" y2="146" stroke="#000"/><text x="77.5" y="14" font-size="14" text-anchor="middle" font-weight="bold">B</text></g><g transform="translate(370,0)"><rect x="67" y="41" width="21" height="21" fill="#b0b0b0"/><rect x="67" y="62" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="62" width="21" height="21" fill="#b0b0b0"/><rect x="88" y="83" width="21" height="21" fill="#b0b0b0"/><line x1="4" y1="20" x2="4" y2="146" stroke="#000"/><line x1="25" y1="20" x2="25" y2="146" stroke="#000"/><line x1="46" y1="20" x2="46" y2="146" stroke="#000"/><line x1="67" y1="20" x2="67" y2="146" stroke="#000"/><line x1="88" y1="20" x2="88" y2="146" stroke="#000"/><line x1="109" y1="20" x2="109" y2="146" stroke="#000"/><line x1="130" y1="20" x2="130" y2="146" stroke="#000"/><line x1="151" y1="20" x2="151" y2="146" stroke="#000"/><line x1="4" y1="20" x2="151" y2="20" stroke="#000"/><line x1="4" y1="41" x2="151" y2="41" stroke="#000"/><line x1="4" y1="62" x2="151" y2="62" stroke="#000"/><line x1="4" y1="83" x2="151" y2="83" stroke="#000"/><line x1="4" y1="104" x2="151" y2="104" stroke="#000"/><line x1="4" y1="125" x2="151" y2="125" stroke="#000"/><line x1="4" y1="146" x2="151" y2="146" stroke="#000"/><text x="77.5" y="14" font-size="14" text-anchor="middle" font-weight="bold">C</text></g></svg>',
  'symetrie-ABC.svg',
  'Tři čtvercové sítě s tmavými útvary označenými A, B a C.',
  'Útvary A, B, C ve čtvercové síti',
  new List<String>{'10.1 Útvar $A$ lze doplnit na obrazec se $4$ osami souměrnosti → Ano.','10.2 Útvar $B$ doplněný o čtverec nemá $2$ osy souměrnosti (má jich méně) → Ne.','10.3 Útvar $C$ doplněný o čtverec nemá pouze $1$ osu souměrnosti (má jich více) → Ne.'},
  '10.1: Ano; 10.2: Ne; 10.3: Ne',
  4, 5, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
