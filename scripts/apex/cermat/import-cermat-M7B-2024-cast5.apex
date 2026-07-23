String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD24C0T02';
Integer YEAR = 2024;

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
  'CERMAT M7B 2024 - uloha 10',
  new List<String>{'Ve ctvercove siti jsou umisteny dva obrazce (utvary $A$ a $B$). Jejich vrcholy lezi v mrizovych bodech. Sit je tvorena ctverecky s obsahem $16$ cm2.','Rozhodnete o kazdem z nasledujicich tvrzeni (10.1-10.3), zda je pravdive (A), ci nikoli (N).','10.1 Obsah utvaru $A$ je $256$ cm2.','10.2 Obsah utvaru $A$ je k obsahu utvaru $B$ v pomeru $7:4$.','10.3 Obvody obou utvaru se lisi o $16$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 352 208" font-family="sans-serif"><line x1="20" y1="20" x2="20" y2="188" stroke="#bbb"/><line x1="44" y1="20" x2="44" y2="188" stroke="#bbb"/><line x1="68" y1="20" x2="68" y2="188" stroke="#bbb"/><line x1="92" y1="20" x2="92" y2="188" stroke="#bbb"/><line x1="116" y1="20" x2="116" y2="188" stroke="#bbb"/><line x1="140" y1="20" x2="140" y2="188" stroke="#bbb"/><line x1="164" y1="20" x2="164" y2="188" stroke="#bbb"/><line x1="188" y1="20" x2="188" y2="188" stroke="#bbb"/><line x1="212" y1="20" x2="212" y2="188" stroke="#bbb"/><line x1="236" y1="20" x2="236" y2="188" stroke="#bbb"/><line x1="260" y1="20" x2="260" y2="188" stroke="#bbb"/><line x1="284" y1="20" x2="284" y2="188" stroke="#bbb"/><line x1="308" y1="20" x2="308" y2="188" stroke="#bbb"/><line x1="332" y1="20" x2="332" y2="188" stroke="#bbb"/><line x1="20" y1="20" x2="332" y2="20" stroke="#bbb"/><line x1="20" y1="44" x2="332" y2="44" stroke="#bbb"/><line x1="20" y1="68" x2="332" y2="68" stroke="#bbb"/><line x1="20" y1="92" x2="332" y2="92" stroke="#bbb"/><line x1="20" y1="116" x2="332" y2="116" stroke="#bbb"/><line x1="20" y1="140" x2="332" y2="140" stroke="#bbb"/><line x1="20" y1="164" x2="332" y2="164" stroke="#bbb"/><line x1="20" y1="188" x2="332" y2="188" stroke="#bbb"/><polygon points="44,68 116,44 116,140 44,140" fill="none" stroke="#000" stroke-width="2"/><polygon points="188,92 260,68 236,164" fill="none" stroke="#000" stroke-width="2"/><text x="68" y="116" font-size="15" font-weight="bold">A</text><text x="212" y="116" font-size="15" font-weight="bold">B</text><rect x="284" y="20" width="24" height="24" fill="#c8c8c8" stroke="#000"/><text x="328" y="56" font-size="10" text-anchor="end">16 cm2</text></svg>',
  'sit-utvary-AB.svg',
  'Ctvercova sit s utvarem A (ctyruhelnik) a utvarem B (trojuhelnik), vrcholy v mrizovych bodech.',
  'Schematicky nakres (jeden ctverecek ma obsah 16 cm2)',
  new List<String>{'Jeden ctverecek ma obsah $16$ cm2, jeho strana meri $4$ cm.','10.1 Utvar $A$ zabira $16$ ctverecku, jeho obsah je $16\\cdot 16 = 256$ cm2 - pravda (A).','10.2 Pomer obsahu utvaru $A$ a $B$ neni $7:4$ - nepravda (N).','10.3 Obvody obou utvaru se lisi o $16$ cm - pravda (A).'},
  '10.1: A; 10.2: N; 10.3: A',
  3, 5, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
