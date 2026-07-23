String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M7B 2019 – úloha 10',
  new List<String>{'Čtvercová síť je tvořena čtverečky s délkou strany 1 cm. Ve čtvercové síti je zakreslen obdélník $12$ cm $\\times$ $6$ cm rozdělený na 5 trojúhelníků $A$ až $E$ a tmavý obrazec. Vrcholy všech útvarů leží v mřížových bodech.','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsahy trojúhelníků $A$, $C$ jsou stejné.','10.2 Obsah celého obdélníku je 12krát větší než obsah trojúhelníku $D$.','10.3 Obsah tmavého obrazce je větší než $24$ cm².'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 426 220" font-family="sans-serif"><polygon points="138,126 242,74 346,100 346,178 190,178" fill="#cfcfcf" stroke="none"/><line x1="34" y1="178" x2="34" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="60" y1="178" x2="60" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="86" y1="178" x2="86" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="112" y1="178" x2="112" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="138" y1="178" x2="138" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="164" y1="178" x2="164" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="190" y1="178" x2="190" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="216" y1="178" x2="216" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="242" y1="178" x2="242" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="268" y1="178" x2="268" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="294" y1="178" x2="294" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="320" y1="178" x2="320" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="346" y1="178" x2="346" y2="22" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="178" x2="346" y2="178" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="152" x2="346" y2="152" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="126" x2="346" y2="126" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="100" x2="346" y2="100" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="74" x2="346" y2="74" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="48" x2="346" y2="48" stroke="#c9c9c9" stroke-width="1"/><line x1="34" y1="22" x2="346" y2="22" stroke="#c9c9c9" stroke-width="1"/><rect x="34" y="22" width="312" height="156" fill="none" stroke="#000" stroke-width="2"/><line x1="34" y1="178" x2="346" y2="22" stroke="#000" stroke-width="1.6"/><line x1="34" y1="22" x2="190" y2="178" stroke="#000" stroke-width="1.6"/><line x1="34" y1="22" x2="346" y2="100" stroke="#000" stroke-width="1.6"/><text x="67.80000000000001" y="110.39999999999999" font-size="15" font-style="italic">A</text><text x="148.4" y="84.4" font-size="15" font-style="italic">B</text><text x="213.4" y="48.0" font-size="15" font-style="italic">C</text><text x="283.6" y="63.599999999999994" font-size="15" font-style="italic">D</text><text x="125.0" y="152.0" font-size="15" font-style="italic">E</text><text x="169.20000000000002" y="202" font-size="13">12 cm</text><text x="354" y="105" font-size="13">6 cm</text></svg>',
  'sit-trojuhelniky.svg',
  'Obdélník 12 krát 6 na čtvercové síti rozdělený třemi úsečkami na trojúhelníky A až E a šedý pětiúhelník.',
  'Obdélník rozdělený na útvary (obsahy v cm²)',
  new List<String>{'Obsahy (v cm²): $A=12$, $B=12$, $C=12$, $D=6$, $E=6$, tmavý obrazec $=72-48=24$.','10.1 $A=C=12$ cm² → Ano.','10.2 Obdélník $=72$ cm² $=12\\cdot 6=12\\cdot D$ → Ano.','10.3 Tmavý obrazec má obsah přesně $24$ cm², není větší než $24$ cm² → Ne.'},
  '10.1: Ano; 10.2: Ano; 10.3: Ne',
  4, 5, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
