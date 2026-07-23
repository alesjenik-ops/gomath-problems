String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
Integer YEAR = 2026;

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
  'CERMAT M5D 2026 – úloha 4',
  new List<String>{'Na obrázku je ve čtvercové síti zakreslen čtyřúhelník a sedmiúhelník. Všechny vrcholy obou obrazců leží v mřížových bodech sítě. Každý čtvereček čtvercové sítě má stranu délky $1$ cm a obsah $1$ cm².','Vypočtěte:','4.1 v cm² obsah čtyřúhelníku,','4.2 v cm² obsah sedmiúhelníku,','4.3 v cm, o kolik se liší obvod čtyřúhelníku a obvod sedmiúhelníku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 404 264" font-family="sans-serif"><line x1="20" y1="20" x2="20" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="48" y1="20" x2="48" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="76" y1="20" x2="76" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="104" y1="20" x2="104" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="132" y1="20" x2="132" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="160" y1="20" x2="160" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="188" y1="20" x2="188" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="216" y1="20" x2="216" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="244" y1="20" x2="244" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="272" y1="20" x2="272" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="300" y1="20" x2="300" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="328" y1="20" x2="328" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="356" y1="20" x2="356" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="384" y1="20" x2="384" y2="244" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="20" x2="384" y2="20" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="48" x2="384" y2="48" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="76" x2="384" y2="76" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="104" x2="384" y2="104" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="132" x2="384" y2="132" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="160" x2="384" y2="160" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="188" x2="384" y2="188" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="216" x2="384" y2="216" stroke="#c4c4c4" stroke-width="1"/><line x1="20" y1="244" x2="384" y2="244" stroke="#c4c4c4" stroke-width="1"/><polygon points="48,48 188,76 188,216 76,160" fill="#c9c9c9" stroke="#000" stroke-width="2"/><polygon points="244,76 356,48 328,104 384,132 328,160 356,216 244,188" fill="#c9c9c9" stroke="#000" stroke-width="2"/></svg>',
  'sit-obrazce.svg',
  'Čtvercová síť s šedým čtyřúhelníkem vlevo a šedým sedmiúhelníkem vpravo, vrcholy v mřížových bodech.',
  'Schematický nákres (obsahy dle klíče)',
  new List<String>{'4.1 Obsah čtyřúhelníku určíme z mřížky (rozkladem na části, popř. Pickovou větou): $18$ cm².','4.2 Obsah sedmiúhelníku: $16$ cm².','4.3 Obvody obou obrazců změřené v mřížce se liší o $4$ cm.'},
  '4.1: $18$ cm²; 4.2: $16$ cm²; 4.3: o $4$ cm',
  5, 7, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2026 – úloha 5',
  new List<String>{'Obdélník $ABCD$ je složen z bílého a šedého obdélníku jako na obrázku. Obvod obdélníku $ABCD$ je $68$ cm a délka strany $BC$ je $10$ cm. Obvod šedého obdélníku je o $12$ cm větší než obvod bílého obdélníku.','Vypočtěte v cm:','5.1 délku strany $AB$ obdélníku $ABCD$,','5.2 obvod šedého obdélníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 220" font-family="sans-serif"> <rect x="40" y="35" width="280" height="150" fill="#fff" stroke="#000" stroke-width="2"/> <rect x="145" y="35" width="175" height="150" fill="#b9b9b9" stroke="#000" stroke-width="2"/> <line x1="145" y1="35" x2="145" y2="185" stroke="#000" stroke-width="2"/> <text x="30" y="30" font-size="16" font-style="italic">D</text> <text x="322" y="30" font-size="16" font-style="italic">C</text> <text x="30" y="205" font-size="16" font-style="italic">A</text> <text x="322" y="205" font-size="16" font-style="italic">B</text> </svg>',
  'obdelnik-abcd.svg',
  'Obdélník ABCD rozdělený svislou úsečkou na bílou levou a šedou pravou část.',
  'Obdélník ABCD složený z bílého a šedého obdélníku',
  new List<String>{'5.1 Obvod $ABCD=2\\cdot(AB+BC)=68$, tedy $AB+10=34$ a $AB=24$ cm.','5.2 Součet šířek bílé a šedé části je $24$ cm, oba obdélníky mají výšku $10$ cm. Rozdíl obvodů je $12$ cm, takže šedá část je o $6$ cm širší. Ze součtu $24$ a rozdílu $6$ vychází šedá šířka $15$ cm; obvod šedého obdélníku $=2\\cdot(15+10)=50$ cm.'},
  '5.1: $24$ cm; 5.2: $50$ cm',
  3, 5, '2',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
