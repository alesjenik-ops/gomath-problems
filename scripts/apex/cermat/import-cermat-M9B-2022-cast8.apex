String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD22C0T02';
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
  'CERMAT M9B 2022 – úloha 16',
  new List<String>{'Ve čtvercové síti (krok $1$ cm) vytváříme různé obdélníky s vrcholy v mřížových bodech. Na obrázku je jeden z možných obdélníků, a to s rozměry $8$ cm a $4$ cm. Uvnitř obdélníku zakreslíme v každém mřížovém bodě hvězdičku. Hvězdičky nejblíže hranici obdélníku budou tmavé a ostatní bílé.','16.1 Určete počet všech hvězdiček v obdélníku s rozměry $81$ cm a $20$ cm.','16.2 Obdélník, jehož jeden rozměr je $50$ cm, obsahuje celkem $9\\,800$ hvězdiček. Určete v cm druhý rozměr tohoto obdélníku.','16.3 Vypočtěte, o kolik se liší počty bílých a tmavých hvězdiček v obdélníku s rozměry $41$ cm a $23$ cm.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif"><rect x="25" y="25" width="240" height="120" fill="none" stroke="#000" stroke-width="2"/><line x1="25" y1="25" x2="25" y2="145" stroke="#bbb"/><line x1="55" y1="25" x2="55" y2="145" stroke="#bbb"/><line x1="85" y1="25" x2="85" y2="145" stroke="#bbb"/><line x1="115" y1="25" x2="115" y2="145" stroke="#bbb"/><line x1="145" y1="25" x2="145" y2="145" stroke="#bbb"/><line x1="175" y1="25" x2="175" y2="145" stroke="#bbb"/><line x1="205" y1="25" x2="205" y2="145" stroke="#bbb"/><line x1="235" y1="25" x2="235" y2="145" stroke="#bbb"/><line x1="265" y1="25" x2="265" y2="145" stroke="#bbb"/><line x1="25" y1="25" x2="265" y2="25" stroke="#bbb"/><line x1="25" y1="55" x2="265" y2="55" stroke="#bbb"/><line x1="25" y1="85" x2="265" y2="85" stroke="#bbb"/><line x1="25" y1="115" x2="265" y2="115" stroke="#bbb"/><line x1="25" y1="145" x2="265" y2="145" stroke="#bbb"/><text x="55" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="55" y="90" font-size="16" text-anchor="middle" fill="#333">★</text><text x="55" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="85" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="85" y="90" font-size="16" text-anchor="middle" fill="#fff">☆</text><text x="85" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="115" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="115" y="90" font-size="16" text-anchor="middle" fill="#fff">☆</text><text x="115" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="145" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="145" y="90" font-size="16" text-anchor="middle" fill="#fff">☆</text><text x="145" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="175" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="175" y="90" font-size="16" text-anchor="middle" fill="#fff">☆</text><text x="175" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="205" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="205" y="90" font-size="16" text-anchor="middle" fill="#fff">☆</text><text x="205" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><text x="235" y="60" font-size="16" text-anchor="middle" fill="#333">★</text><text x="235" y="90" font-size="16" text-anchor="middle" fill="#333">★</text><text x="235" y="120" font-size="16" text-anchor="middle" fill="#333">★</text><line x1="235" y1="161" x2="265" y2="161" stroke="#000"/><text x="250" y="175" font-size="11" text-anchor="middle">1 cm</text></svg>',
  'sit-hvezdicky.svg',
  'Obdélník 8 krát 4 ve čtvercové síti, ve vnitřních mřížových bodech hvězdičky; hvězdičky u hranice tmavé, vnitřní bílé.',
  'Obdélník 8 cm krát 4 cm s hvězdičkami ve vnitřních mřížových bodech',
  new List<String>{'Hvězdičky leží ve vnitřních mřížových bodech: v obdélníku o rozměrech $m$ cm a $n$ cm jich je $(m-1)(n-1)$; tmavé jsou body na okraji této vnitřní mřížky, bílých je $(m-3)(n-3)$.','16.1 $(81-1)(20-1)=80\\cdot19=1520$ hvězdiček.','16.2 $(50-1)(x-1)=9\\,800$, tj. $49(x-1)=9\\,800$, $x-1=200$, $x=201$ cm.','16.3 Celkem $(41-1)(23-1)=40\\cdot22=880$. Bílé $(41-3)(23-3)=38\\cdot20=760$, tmavé $880-760=120$; liší se o $760-120=640$ hvězdiček.'},
  '16.1: $1520$ hvězdiček; 16.2: $201$ cm; 16.3: o $640$ hvězdiček',
  4, 8, '4',
  new List<String>{'zs2','r9','posloupnosti','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
