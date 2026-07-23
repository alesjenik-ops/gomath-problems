String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
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
  'CERMAT M7D 2022 – úloha 10',
  new List<String>{'Ve čtvercové síti jsou z tmavých čtverců složeny tři útvary A, B, C. Každý z nich má pouze jednu osu souměrnosti. V každém útvaru přemístíme jediný tmavý čtverec tak, aby měl upravený útvar co nejvíce různých os souměrnosti (sestrojených svisle, vodorovně nebo šikmo).','Rozhodněte o každém z následujících tvrzení 10.1–10.3, zda je pravdivé (A), či nikoli (N).','10.1 Správně upravený útvar A má pouze $2$ osy souměrnosti.','10.2 Správně upravený útvar B má pouze $2$ osy souměrnosti.','10.3 Správně upravený útvar C má pouze $1$ osu souměrnosti.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 108" font-family="sans-serif"><text x="45" y="15" text-anchor="middle" font-size="12">A</text><g fill="#b9b9b9"><rect x="38" y="22" width="14" height="14"/><rect x="24" y="36" width="14" height="14"/><rect x="38" y="36" width="14" height="14"/><rect x="52" y="36" width="14" height="14"/><rect x="10" y="50" width="14" height="14"/><rect x="38" y="50" width="14" height="14"/><rect x="66" y="50" width="14" height="14"/><rect x="24" y="64" width="14" height="14"/><rect x="38" y="64" width="14" height="14"/><rect x="52" y="64" width="14" height="14"/></g><g stroke="#999" fill="none"><line x1="10" y1="22" x2="10" y2="92"/><line x1="10" y1="22" x2="80" y2="22"/><line x1="24" y1="22" x2="24" y2="92"/><line x1="10" y1="36" x2="80" y2="36"/><line x1="38" y1="22" x2="38" y2="92"/><line x1="10" y1="50" x2="80" y2="50"/><line x1="52" y1="22" x2="52" y2="92"/><line x1="10" y1="64" x2="80" y2="64"/><line x1="66" y1="22" x2="66" y2="92"/><line x1="10" y1="78" x2="80" y2="78"/><line x1="80" y1="22" x2="80" y2="92"/><line x1="10" y1="92" x2="80" y2="92"/></g><text x="155" y="15" text-anchor="middle" font-size="12">B</text><g fill="#b9b9b9"><rect x="148" y="22" width="14" height="14"/><rect x="134" y="36" width="14" height="14"/><rect x="162" y="36" width="14" height="14"/><rect x="120" y="50" width="14" height="14"/><rect x="148" y="50" width="14" height="14"/><rect x="176" y="50" width="14" height="14"/><rect x="134" y="64" width="14" height="14"/><rect x="162" y="64" width="14" height="14"/><rect x="148" y="78" width="14" height="14"/></g><g stroke="#999" fill="none"><line x1="120" y1="22" x2="120" y2="92"/><line x1="120" y1="22" x2="190" y2="22"/><line x1="134" y1="22" x2="134" y2="92"/><line x1="120" y1="36" x2="190" y2="36"/><line x1="148" y1="22" x2="148" y2="92"/><line x1="120" y1="50" x2="190" y2="50"/><line x1="162" y1="22" x2="162" y2="92"/><line x1="120" y1="64" x2="190" y2="64"/><line x1="176" y1="22" x2="176" y2="92"/><line x1="120" y1="78" x2="190" y2="78"/><line x1="190" y1="22" x2="190" y2="92"/><line x1="120" y1="92" x2="190" y2="92"/></g><text x="265" y="15" text-anchor="middle" font-size="12">C</text><g fill="#b9b9b9"><rect x="258" y="22" width="14" height="14"/><rect x="258" y="36" width="14" height="14"/><rect x="230" y="50" width="14" height="14"/><rect x="244" y="50" width="14" height="14"/><rect x="258" y="50" width="14" height="14"/><rect x="272" y="50" width="14" height="14"/><rect x="286" y="50" width="14" height="14"/><rect x="258" y="64" width="14" height="14"/><rect x="258" y="78" width="14" height="14"/></g><g stroke="#999" fill="none"><line x1="230" y1="22" x2="230" y2="92"/><line x1="230" y1="22" x2="300" y2="22"/><line x1="244" y1="22" x2="244" y2="92"/><line x1="230" y1="36" x2="300" y2="36"/><line x1="258" y1="22" x2="258" y2="92"/><line x1="230" y1="50" x2="300" y2="50"/><line x1="272" y1="22" x2="272" y2="92"/><line x1="230" y1="64" x2="300" y2="64"/><line x1="286" y1="22" x2="286" y2="92"/><line x1="230" y1="78" x2="300" y2="78"/><line x1="300" y1="22" x2="300" y2="92"/><line x1="230" y1="92" x2="300" y2="92"/></g></svg>',
  'utvary-ABC.svg',
  'Tři útvary A, B a C složené z tmavých čtverců ve čtvercové síti (schematicky).',
  'Útvary A, B, C (schematicky)',
  new List<String>{'10.1 Útvar A lze přemístěním jednoho čtverce upravit tak, aby měl právě $2$ osy souměrnosti. Tvrzení je pravdivé (Ano).','10.2 Nejlépe upravený útvar B nemá právě $2$ osy souměrnosti. Tvrzení je nepravdivé (Ne).','10.3 Nejlépe upravený útvar C nemá právě $1$ osu souměrnosti (má jich více). Tvrzení je nepravdivé (Ne).'},
  '10.1: Ano; 10.2: Ne; 10.3: Ne',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
