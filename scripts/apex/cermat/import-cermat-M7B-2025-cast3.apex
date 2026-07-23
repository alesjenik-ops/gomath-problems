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
  'CERMAT M7B 2025 – úloha 8 (konstrukce)',
  new List<String>{'V rovině leží body $B$, $C$ a přímka $p$ (viz obrázek). Body $B$, $C$ jsou vrcholy obdélníku $ABCD$. Na přímce $p$ leží střed $S$ tohoto obdélníku. (Středem $S$ procházejí osy souměrnosti obdélníku.)','8.1 Sestrojte střed $S$ obdélníku $ABCD$ a označte ho písmenem.','8.2 Sestrojte vrcholy $A$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif"> <rect x="8" y="8" width="404" height="304" fill="none" stroke="#ccc"/> <line x1="120" y1="40" x2="300" y2="290" stroke="#000" stroke-width="2"/> <text x="298" y="305" font-size="16" font-style="italic">p</text> <text x="300" y="150" font-size="15" font-style="italic">C</text><text x="296" y="164" font-size="14">×</text> <text x="332" y="238" font-size="15" font-style="italic">B</text><text x="326" y="228" font-size="14">×</text> </svg>',
  'body-BC-p.svg',
  'Body B a C a přímka p ležící v rovině.',
  'Výchozí obrázek k úloze 8',
  new List<String>{'Střed $S$ je stejně vzdálen od $B$ i $C$, leží tedy na ose úsečky $BC$; současně leží na přímce $p$. Bod $S$ je proto průsečík osy úsečky $BC$ s přímkou $p$. Vrchol $A$ je obrazem vrcholu $C$ ve středové souměrnosti se středem $S$, vrchol $D$ je obrazem vrcholu $B$ ve středové souměrnosti se středem $S$. Spojením vznikne obdélník $ABCD$.'},
  'Střed $S$ je průsečík osy úsečky $BC$ s přímkou $p$; vrcholy $A$ a $D$ jsou obrazy bodů $C$ a $B$ ve středové souměrnosti se středem $S$ – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7B 2025 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $C^{\\prime}$ a přímka $o$ procházející bodem $S^{\\prime}$ (viz obrázek). Bod $A$ je vrchol trojúhelníku $ABC$. Přímka $o$ je osou osové souměrnosti, v níž se trojúhelník $ABC$ zobrazí na trojúhelník $A^{\\prime}B^{\\prime}C^{\\prime}$. Bod $S^{\\prime}$ je střed strany $B^{\\prime}C^{\\prime}$ trojúhelníku $A^{\\prime}B^{\\prime}C^{\\prime}$.','9.1 Sestrojte a označte bod $C$, jehož obrazem v osové souměrnosti s osou $o$ je bod $C^{\\prime}$.','9.2 Sestrojte vrchol $B$ trojúhelníku $ABC$, označte ho písmenem a trojúhelník $ABC$ narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <rect x="8" y="8" width="444" height="284" fill="none" stroke="#ccc"/> <line x1="60" y1="240" x2="420" y2="110" stroke="#000" stroke-width="2"/> <text x="425" y="108" font-size="16" font-style="italic">o</text> <line x1="212" y1="172" x2="222" y2="182" stroke="#000" stroke-width="1.4"/> <text x="204" y="205" font-size="15" font-style="italic">S′</text> <text x="176" y="118" font-size="15" font-style="italic">C′</text><text x="182" y="134" font-size="14">×</text> <text x="320" y="104" font-size="15" font-style="italic">A</text><text x="317" y="120" font-size="14">×</text> </svg>',
  'body-A-Cprime-o.svg',
  'Body A a C s čárkou a přímka o procházející bodem S s čárkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'9.1 Bod $C$ je obraz bodu $C^{\\prime}$ v osové souměrnosti s osou $o$ (spustíme kolmici z $C^{\\prime}$ na $o$ a naneseme stejnou vzdálenost na druhou stranu osy).','9.2 Bod $S^{\\prime}$ leží na ose $o$, je tedy svým vlastním obrazem a zároveň středem $S$ strany $BC$. Vrchol $B$ je proto obraz bodu $C$ ve středové souměrnosti se středem $S=S^{\\prime}$. Spojením $A$, $B$, $C$ vznikne trojúhelník $ABC$.'},
  '$C$ je obraz $C^{\\prime}$ v osové souměrnosti s osou $o$; protože $S=S^{\\prime}$ je střed $BC$, je $B$ obraz $C$ ve středové souměrnosti se středem $S^{\\prime}$ – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r7','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
