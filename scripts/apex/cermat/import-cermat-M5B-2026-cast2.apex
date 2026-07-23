String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD26C0T02';
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
  'CERMAT M5B 2026 – úloha 4',
  new List<String>{'Na začátku ledna dostal Adam kapesné 1000 korun a utrácel z něj denně stejnou částku. Celé kapesné tak utratil již za 20 dní. Bořek dostal na začátku ledna kapesné 700 korun a kupoval si z něj každý den pouze noviny, a to vždy za stejnou cenu. Po 12 dnech od začátku ledna zbývala z kapesného oběma chlapcům stejná částka.','Vypočtěte:','4.1 kolik korun zbývalo Adamovi z kapesného po 12 dnech od začátku ledna,','4.2 za kolik dnů od začátku ledna utratil Bořek celé své kapesné.'},
  null,
  2,
  null,
  null,
  null,
  null,
  new List<String>{'4.1 Adam utrácel $1\\,000:20 = 50$ korun denně, po 12 dnech mu zbývalo $1\\,000 - 12\\cdot 50 = 400$ korun.','4.2 Bořkovi zbývalo po 12 dnech také $400$ korun, utratil tedy $700 - 400 = 300$ korun za 12 dní, tj. $25$ korun denně. Celé kapesné utratil za $700:25 = 28$ dní.'},
  '4.1: $400$ korun; 4.2: za $28$ dnů',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M5B 2026 – úloha 5',
  new List<String>{'Na papírové ruličce je navinuta stuha delší než 9 m. Na volném konci stuhy je bílý proužek délky 6 cm, následuje červený proužek délky 6 cm a dále se tyto proužky pravidelně střídají. Od volného konce jsme odměřili a odstřihli část stuhy délky 170 cm na pomlázku.','Určete:','5.1 kolik červených proužků je na odstřižené části stuhy na pomlázku,','5.2 kolik cm měří první necelý proužek na volném konci stuhy navinuté na ruličce po odstřižení části stuhy na pomlázku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 430 120" font-family="sans-serif"><circle cx="52" cy="60" r="34" fill="#ededed" stroke="#000"/><circle cx="52" cy="60" r="9" fill="#fff" stroke="#000"/><rect x="86" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="112" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><rect x="138" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="164" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><rect x="190" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="216" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><rect x="242" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="268" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><rect x="294" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="320" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><rect x="346" y="52" width="26" height="16" fill="#ffffff" stroke="#000"/><rect x="372" y="52" width="26" height="16" fill="#b0b0b0" stroke="#000"/><line x1="86" y1="45" x2="112" y2="45" stroke="#000"/><text x="90" y="40" font-size="11">6 cm</text><line x1="112" y1="86" x2="138" y2="86" stroke="#000"/><text x="116" y="100" font-size="11">6 cm</text><text x="360" y="66" font-size="11" fill="#666">…</text></svg>',
  'stuha-rulicka.svg',
  'Papírová rulička se stuhou, na níž se pravidelně střídají bílé a červené proužky po 6 cm.',
  'Schematický nákres ruličky se stuhou',
  new List<String>{'5.1 Proužky se střídají po 6 cm (bílý, červený, bílý, …), začínají bílým. $170:6 = 28$ celých proužků ($28\\cdot 6 = 168$ cm) a 2 cm z dalšího. Z 28 celých je 14 bílých a 14 červených.','5.2 Odstřižením končíme uprostřed 29. proužku (bílého) po 2 cm; na ruličce zůstává jeho zbytek $6 - 2 = 4$ cm jako první necelý proužek na volném konci.'},
  '5.1: $14$ červených proužků; 5.2: $4$ cm',
  3, 5, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
