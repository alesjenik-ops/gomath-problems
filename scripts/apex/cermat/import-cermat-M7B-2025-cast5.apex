String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M7B 2025 – úloha 12',
  new List<String>{'Ve čtvercové síti, jejíž každé pole má obsah 25 cm², je umístěn osmiúhelník s vrcholy v mřížových bodech. Středy čtyř jeho stran jsou vrcholy čtverce $ABCD$ (viz obrázek).','O kolik cm² se liší obsah osmiúhelníku a obsah čtverce $ABCD$?'},
  new List<String>{'A) o $50{,}0$ cm²','B) o $62{,}5$ cm²','C) o $75{,}0$ cm²','D) o $87{,}5$ cm²','E) o $100{,}0$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 260 260" font-family="sans-serif"> <line x1="20" y1="20" x2="220" y2="20" stroke="#c9c9c9"/> <line x1="20" y1="70" x2="220" y2="70" stroke="#c9c9c9"/> <line x1="20" y1="120" x2="220" y2="120" stroke="#c9c9c9"/> <line x1="20" y1="170" x2="220" y2="170" stroke="#c9c9c9"/> <line x1="20" y1="220" x2="220" y2="220" stroke="#c9c9c9"/> <line x1="20" y1="20" x2="20" y2="220" stroke="#c9c9c9"/> <line x1="70" y1="20" x2="70" y2="220" stroke="#c9c9c9"/> <line x1="120" y1="20" x2="120" y2="220" stroke="#c9c9c9"/> <line x1="170" y1="20" x2="170" y2="220" stroke="#c9c9c9"/> <line x1="220" y1="20" x2="220" y2="220" stroke="#c9c9c9"/> <polygon points="70,20 170,20 220,70 220,170 170,220 70,220 20,170 20,70" fill="none" stroke="#000" stroke-width="2"/> <polygon points="45,195 195,195 195,45 45,45" fill="none" stroke="#000" stroke-width="1.6"/> <text x="34" y="212" font-size="14" font-style="italic">A</text> <text x="198" y="212" font-size="14" font-style="italic">B</text> <text x="198" y="42" font-size="14" font-style="italic">C</text> <text x="34" y="42" font-size="14" font-style="italic">D</text> </svg>',
  'osmiuhelnik-sit.svg',
  'Osmiúhelník s vrcholy v mřížových bodech čtvercové sítě a vepsaný čtverec ABCD.',
  'Schematický nákres k úloze 12',
  new List<String>{'Obsah osmiúhelníku i obsah čtverce $ABCD$ určíme z mřížky (jedno pole má obsah 25 cm², tj. strana 5 cm). Rozdíl obou obsahů vychází $75{,}0$ cm².'},
  'C) o $75{,}0$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r7','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
