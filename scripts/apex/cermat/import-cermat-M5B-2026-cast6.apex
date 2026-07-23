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
  'CERMAT M5B 2026 – úloha 10',
  new List<String>{'Ve čtvercové síti jsou zakresleny 4 obrazce označené písmeny A, B, C, D. V obrazcích má každá kružnice střed v mřížovém bodě a prochází čtyřmi mřížovými body. Všechny ostatní útvary mají vrcholy v mřížových bodech.','Který z obrazců není osově souměrný?'},
  new List<String>{'A) obrazec A','B) obrazec B','C) obrazec C','D) obrazec D','E) Všechny obrazce A–D jsou osově souměrné.'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 150" font-family="sans-serif"><rect x="20" y="20" width="100" height="100" fill="none" stroke="#ccc"/><text x="70" y="140" font-size="14" text-anchor="middle">A</text><rect x="145" y="20" width="100" height="100" fill="none" stroke="#ccc"/><text x="195" y="140" font-size="14" text-anchor="middle">B</text><rect x="270" y="20" width="100" height="100" fill="none" stroke="#ccc"/><text x="320" y="140" font-size="14" text-anchor="middle">C</text><rect x="395" y="20" width="100" height="100" fill="none" stroke="#ccc"/><text x="445" y="140" font-size="14" text-anchor="middle">D</text><polygon points="30,30 30,110 110,70" fill="none" stroke="#000"/><polygon points="110,30 110,110 30,70" fill="none" stroke="#000"/><circle cx="195" cy="70" r="46" fill="none" stroke="#000"/><polygon points="160,52 235,48 222,96 174,90" fill="none" stroke="#000"/><rect x="285" y="30" width="80" height="80" fill="none" stroke="#000"/><circle cx="315" cy="70" r="22" fill="none" stroke="#000"/><polygon points="325,48 365,30 365,110" fill="none" stroke="#000"/><rect x="410" y="30" width="80" height="80" fill="none" stroke="#000"/><circle cx="450" cy="70" r="30" fill="none" stroke="#000"/><line x1="410" y1="30" x2="490" y2="110" stroke="#000"/></svg>',
  'obrazce-osova.svg',
  'Čtyři obrazce A–D ve čtvercové síti: dvojice trojúhelníků, kružnice se čtyřúhelníkem, čtverec s kružnicí a trojúhelníkem, čtverec s kružnicí a úhlopříčkou.',
  'Schematický nákres obrazců A–D',
  new List<String>{'Obrazec B (kružnice s nesouměrně vepsaným čtyřúhelníkem) nemá žádnou osu souměrnosti; ostatní obrazce osu souměrnosti mají.'},
  'B) obrazec B',
  2, 3, '2',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5B 2026 – úlohy 11 a 12',
  new List<String>{'Záhon ve tvaru písmene L tvoří obrazec $ABCDEF$. Obrazec je rozdělen na 6 stejných čtverců, mezi nimiž jsou mezery tvaru obdélníku (viz obrázek). Všechny tyto obdélníky jsou stejné. Lomená čára $DEF$ (úsečky $DE$ a $EF$) má délku 550 cm. Lomená čára $ABC$ (úsečky $AB$ a $BC$) má délku 710 cm.','11 Jakou délku má úsečka $EF$?  A) 110 cm;  B) 118 cm;  C) 142 cm;  D) 160 cm;  E) jinou délku','12 Jaký je obvod jednoho čtverce?  A) 160 cm;  B) 280 cm;  C) 320 cm;  D) 360 cm;  E) jiný obvod'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif"><rect x="30" y="15" width="48" height="48" fill="#d9d9d9"/><rect x="30" y="63" width="48" height="18" fill="#9a9a9a"/><rect x="30" y="81" width="48" height="48" fill="#d9d9d9"/><rect x="78" y="81" width="18" height="48" fill="#9a9a9a"/><rect x="96" y="81" width="48" height="48" fill="#d9d9d9"/><rect x="144" y="81" width="18" height="48" fill="#9a9a9a"/><rect x="162" y="81" width="48" height="48" fill="#d9d9d9"/><rect x="210" y="81" width="18" height="48" fill="#9a9a9a"/><rect x="228" y="81" width="48" height="48" fill="#d9d9d9"/><rect x="276" y="81" width="18" height="48" fill="#9a9a9a"/><rect x="294" y="81" width="48" height="48" fill="#d9d9d9"/><polygon points="30,15 30,129 342,129 342,81 78,81 78,15" fill="none" stroke="#000" stroke-width="2"/><text x="16" y="10" font-size="13" font-style="italic">A</text><text x="16" y="145" font-size="13" font-style="italic">B</text><text x="346" y="145" font-size="13" font-style="italic">C</text><text x="346" y="76" font-size="13" font-style="italic">D</text><text x="82" y="76" font-size="13" font-style="italic">E</text><text x="76" y="10" font-size="13" font-style="italic">F</text><text x="120" y="190" font-size="12">DEF = 550 cm,  ABC = 710 cm</text></svg>',
  'zahon-L.svg',
  'Záhon tvaru L ze 6 stejných čtverců oddělených stejnými obdélníkovými mezerami, vrcholy A, B, C, D, E, F.',
  'Schematický nákres záhonu tvaru L',
  new List<String>{'Označíme stranu čtverce $s$ a šířku mezery $g$, celkovou výšku $H$ a šířku $W$. Platí $DEF = (W-s)+(H-s) = 550$ a $ABC = H+W = 710$. Odečtením: $2s = 160$, tedy $s = 80$ cm. Svislé rameno tvoří 2 čtverce (1 mezera): $H = 2s+g$; vodorovné rameno 5 čtverců (4 mezery): $W = 5s+4g$. Z $H+W = 7s+5g = 710$ plyne $g = 30$ cm.','11 $EF = H - s = s + g = 80 + 30 = 110$ cm → A.','12 Obvod jednoho čtverce $= 4s = 4\\cdot 80 = 320$ cm → C.'},
  '11: A) 110 cm; 12: C) 320 cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
