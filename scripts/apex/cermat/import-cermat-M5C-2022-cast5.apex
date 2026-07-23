String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD22C0T03';
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
  'CERMAT M5C 2022 – úloha 11',
  new List<String>{'Ve čtvercové síti sestrojíme dva obdélníky s vrcholy v mřížových bodech podle vzoru na obrázku. Kratší strana obdélníku má vždy délku $9$ cm a obsahuje $10$ mřížových bodů. Nejmenší čtverec s vrcholy v mřížových bodech má obsah $1$ cm².','První sestrojený obdélník obsahuje celkem $120$ mřížových bodů (včetně mřížových bodů po jeho obvodu). Jaký je obsah tohoto obdélníku?'},
  new List<String>{'A) $90$ cm²','B) $99$ cm²','C) $108$ cm²','D) $120$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 250" font-family="sans-serif"><circle cx="80" cy="25" r="2.4" fill="#000"/><circle cx="98" cy="25" r="2.4" fill="#000"/><circle cx="116" cy="25" r="2.4" fill="#000"/><circle cx="134" cy="25" r="2.4" fill="#000"/><circle cx="152" cy="25" r="2.4" fill="#000"/><circle cx="80" cy="43" r="2.4" fill="#000"/><circle cx="98" cy="43" r="2.4" fill="#000"/><circle cx="116" cy="43" r="2.4" fill="#000"/><circle cx="134" cy="43" r="2.4" fill="#000"/><circle cx="152" cy="43" r="2.4" fill="#000"/><circle cx="80" cy="61" r="2.4" fill="#000"/><circle cx="98" cy="61" r="2.4" fill="#000"/><circle cx="116" cy="61" r="2.4" fill="#000"/><circle cx="134" cy="61" r="2.4" fill="#000"/><circle cx="152" cy="61" r="2.4" fill="#000"/><circle cx="80" cy="79" r="2.4" fill="#000"/><circle cx="98" cy="79" r="2.4" fill="#000"/><circle cx="116" cy="79" r="2.4" fill="#000"/><circle cx="134" cy="79" r="2.4" fill="#000"/><circle cx="152" cy="79" r="2.4" fill="#000"/><circle cx="80" cy="97" r="2.4" fill="#000"/><circle cx="98" cy="97" r="2.4" fill="#000"/><circle cx="116" cy="97" r="2.4" fill="#000"/><circle cx="134" cy="97" r="2.4" fill="#000"/><circle cx="152" cy="97" r="2.4" fill="#000"/><circle cx="80" cy="115" r="2.4" fill="#000"/><circle cx="98" cy="115" r="2.4" fill="#000"/><circle cx="116" cy="115" r="2.4" fill="#000"/><circle cx="134" cy="115" r="2.4" fill="#000"/><circle cx="152" cy="115" r="2.4" fill="#000"/><circle cx="80" cy="133" r="2.4" fill="#000"/><circle cx="98" cy="133" r="2.4" fill="#000"/><circle cx="116" cy="133" r="2.4" fill="#000"/><circle cx="134" cy="133" r="2.4" fill="#000"/><circle cx="152" cy="133" r="2.4" fill="#000"/><circle cx="80" cy="151" r="2.4" fill="#000"/><circle cx="98" cy="151" r="2.4" fill="#000"/><circle cx="116" cy="151" r="2.4" fill="#000"/><circle cx="134" cy="151" r="2.4" fill="#000"/><circle cx="152" cy="151" r="2.4" fill="#000"/><circle cx="80" cy="169" r="2.4" fill="#000"/><circle cx="98" cy="169" r="2.4" fill="#000"/><circle cx="116" cy="169" r="2.4" fill="#000"/><circle cx="134" cy="169" r="2.4" fill="#000"/><circle cx="152" cy="169" r="2.4" fill="#000"/><circle cx="80" cy="187" r="2.4" fill="#000"/><circle cx="98" cy="187" r="2.4" fill="#000"/><circle cx="116" cy="187" r="2.4" fill="#000"/><circle cx="134" cy="187" r="2.4" fill="#000"/><circle cx="152" cy="187" r="2.4" fill="#000"/><line x1="80" y1="25" x2="80" y2="187" stroke="#000" stroke-width="2"/><line x1="80" y1="25" x2="152" y2="25" stroke="#000" stroke-width="2"/><line x1="64" y1="25" x2="64" y2="187" stroke="#000"/><line x1="60" y1="25" x2="68" y2="25" stroke="#000"/><line x1="60" y1="187" x2="68" y2="187" stroke="#000"/><text x="58" y="110.0" font-size="12" text-anchor="end">9 cm</text><text x="245" y="150" font-size="22">…</text><circle cx="330" cy="150" r="2.4" fill="#000"/><circle cx="348" cy="150" r="2.4" fill="#000"/><circle cx="366" cy="150" r="2.4" fill="#000"/><circle cx="330" cy="168" r="2.4" fill="#000"/><circle cx="348" cy="168" r="2.4" fill="#000"/><circle cx="366" cy="168" r="2.4" fill="#000"/><circle cx="330" cy="186" r="2.4" fill="#000"/><circle cx="348" cy="186" r="2.4" fill="#000"/><circle cx="366" cy="186" r="2.4" fill="#000"/><rect x="330" y="150" width="18" height="18" fill="none" stroke="#000"/><text x="358" y="174" font-size="11">1 cm²</text></svg>',
  'sit-obdelnik.svg',
  'Čtvercová síť s obdélníkem; kratší strana 9 cm obsahuje 10 mřížových bodů, nejmenší čtverec má obsah 1 cm na druhou.',
  'Čtvercová síť s obdélníky (vzor k úlohám 11 a 12)',
  new List<String>{'Kratší strana $9$ cm má $10$ mřížových bodů. Počet mřížových bodů obdélníku je $(9+1) \\cdot (b+1)$, kde $b$ je délka delší strany v cm. Z $10 \\cdot (b+1) = 120$ plyne $b+1 = 12$, tedy $b = 11$ cm. Obsah $= 9 \\cdot 11 = 99$ cm².'},
  'B) $99$ cm²',
  2, 4, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
