String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PZD15C0T01';
Integer YEAR = 2015;

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
  'CERMAT M7A 2015 – úloha 15',
  new List<String>{'V grafu jsou znázorněny počty dětí ve všech 7. třídách školy kromě počtu dívek v 7. C.','Počet dětí v 7. C je aritmetickým průměrem počtu dětí v 7. A a 7. B.','Kolik dívek je ve třídě 7. C?'},
  new List<String>{'A) méně než 12','B) 12','C) 13','D) 14','E) více než 14'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 330" font-family="sans-serif"><text x="250" y="22" font-size="14" font-weight="bold" text-anchor="middle">Počty chlapců a dívek v 7. třídách</text><line x1="62" y1="268" x2="440" y2="268" stroke="#c8c8c8"/><text x="54" y="272" font-size="11" text-anchor="end">0</text><line x1="62" y1="246" x2="440" y2="246" stroke="#c8c8c8"/><text x="54" y="250" font-size="11" text-anchor="end">2</text><line x1="62" y1="224" x2="440" y2="224" stroke="#c8c8c8"/><text x="54" y="228" font-size="11" text-anchor="end">4</text><line x1="62" y1="202" x2="440" y2="202" stroke="#c8c8c8"/><text x="54" y="206" font-size="11" text-anchor="end">6</text><line x1="62" y1="180" x2="440" y2="180" stroke="#c8c8c8"/><text x="54" y="184" font-size="11" text-anchor="end">8</text><line x1="62" y1="158" x2="440" y2="158" stroke="#c8c8c8"/><text x="54" y="162" font-size="11" text-anchor="end">10</text><line x1="62" y1="136" x2="440" y2="136" stroke="#c8c8c8"/><text x="54" y="140" font-size="11" text-anchor="end">12</text><line x1="62" y1="114" x2="440" y2="114" stroke="#c8c8c8"/><text x="54" y="118" font-size="11" text-anchor="end">14</text><line x1="62" y1="92" x2="440" y2="92" stroke="#c8c8c8"/><text x="54" y="96" font-size="11" text-anchor="end">16</text><line x1="62" y1="70" x2="440" y2="70" stroke="#c8c8c8"/><text x="54" y="74" font-size="11" text-anchor="end">18</text><line x1="62" y1="48" x2="440" y2="48" stroke="#c8c8c8"/><text x="54" y="52" font-size="11" text-anchor="end">20</text><line x1="62" y1="40" x2="62" y2="268" stroke="#000"/><line x1="62" y1="268" x2="440" y2="268" stroke="#000"/><rect x="84" y="136" width="42" height="132" fill="#fff" stroke="#000"/><rect x="130" y="114" width="42" height="154" fill="#8f8f8f" stroke="#000"/><text x="128" y="286" font-size="12" text-anchor="middle">třída 7. A</text><rect x="210" y="70" width="42" height="198" fill="#fff" stroke="#000"/><rect x="256" y="136" width="42" height="132" fill="#8f8f8f" stroke="#000"/><text x="254" y="286" font-size="12" text-anchor="middle">třída 7. B</text><rect x="336" y="92" width="42" height="176" fill="#fff" stroke="#000"/><rect x="382" y="202" width="42" height="66" fill="#e8e8e8" stroke="#000" stroke-dasharray="5 4"/><text x="403" y="191" font-size="17" font-weight="bold" text-anchor="middle">?</text><text x="380" y="286" font-size="12" text-anchor="middle">třída 7. C</text><rect x="452" y="120" width="14" height="14" fill="#fff" stroke="#000"/><text x="472" y="132" font-size="12">chlapci</text><rect x="452" y="145" width="14" height="14" fill="#8f8f8f" stroke="#000"/><text x="472" y="157" font-size="12">dívky</text></svg>',
  'graf-tridy.svg',
  'Sloupcový graf počtů chlapců a dívek ve třídách 7. A (12 a 14), 7. B (18 a 12) a 7. C (16 chlapců, počet dívek neznámý).',
  'Počty chlapců a dívek v 7. třídách',
  new List<String>{'V 7. A je $12+14=26$ dětí, v 7. B je $18+12=30$ dětí.','Průměr: $(26+30):2=28$ dětí v 7. C.','Chlapců je v 7. C 16, tedy dívek je $28-16=12$.'},
  'B) 12',
  2, 4, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M7A 2015 – úloha 16',
  new List<String>{'Přiřaďte ke každé úloze (16.1–16.3) odpovídající výsledek (A–F).','16.1 Které číslo získáme zvětšením čísla 400 o 20 %?','16.2 Které číslo se po odečtení čísla 100 zmenší o 20 %?','16.3 Které číslo je třeba zvětšit o 20 %, aby vzniklo číslo 540?'},
  new List<String>{'A) 400','B) 432','C) 450','D) 480','E) 500','F) žádné z uvedených'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'16.1 $400\\cdot 1{,}2=480$ → D.','16.2 Odečtení 100 znamená zmenšení o 20 %, tedy $0{,}2x=100$ a $x=500$ → E.','16.3 $1{,}2x=540$, tedy $x=540:1{,}2=450$ → C.'},
  '16.1: D ($480$); 16.2: E ($500$); 16.3: C ($450$)',
  6, 6, '3',
  new List<String>{'zs2','r7','procenta','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
