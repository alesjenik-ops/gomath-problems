String SRC   = 'CERMAT – Ilustrační test 2019, matematika 9 (čtyřleté obory)';
String STYPE = 'CERMAT';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes,String ccode,Integer yr){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',CERMAT_Code__c=ccode,Source_Year__c=yr,Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'CERMAT 2019 M9I · úloha 10',
  new List<String>{'V rovině leží trojúhelník $ABC$ (viz obrázek). Všechny vrcholy trojúhelníku $ABC$ leží na kružnici $k$.','10.1 \\quad Sestrojte kružnici $k$ a vyznačte její střed $S$.','10.2 \\quad Bod $C$ je vrchol čtverce $CDEF$. Zbývající vrcholy $D$, $E$, $F$ čtverce $CDEF$ leží rovněž na kružnici $k$. Sestrojte čtverec $CDEF$ a označte jeho vrcholy.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 250 208"><path d="M13 153L13 153L13 12C13 12 13 11 14 11C14 11 14 11 14 11L237 184C237 184 237 185 237 185C237 185 237 185 236 185L13 153C13 153 13 153 13 153L13 153L13 152L234 184L15 13L14 153L13 153L13 152L13 153Z" style="fill:#231f20"/><text x="7" y="167" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">A</text><text x="240" y="202" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">B</text><text x="7" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">C</text></svg>',
  'obr.svg',
  'Trojúhelník ABC s vrcholem A vlevo dole, vrcholem B vpravo dole a vrcholem C vlevo nahoře.',
  '',
  new List<String>{'10.1: střed $S$ kružnice opsané je průsečík os stran trojúhelníku (osy $AB$ a $BC$); kružnice $k$ má poloměr $|SC|$.','10.2: čtverec vepsaný do kružnice $k$ má úhlopříčky procházející středem $S$. Vrchol $E$ je souměrný s $C$ podle $S$ (úsečka $CE$ je průměr); vrcholy $D$, $F$ leží na průměru kolmém k $CE$ vedeném bodem $S$.'},
  'Konstrukce kružnice opsané ($S$ = průsečík os stran) a čtverce $CDEF$ vepsaného do $k$ (úhlopříčky $CE$, $DF$ jsou navzájem kolmé průměry se středem $S$).',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','planimetrie','geometrie','rysovani','soumernost','bez-kontextu'},
  'M9PID19C0T01', 2019
);
c.add(
  'CERMAT 2019 M9I · úloha 11',
  new List<String>{'První obrazec je tvořen dvěma bílými čtverci a jedním tmavým čtvercem (viz obrázek). Obvod bílého čtverce je dvakrát menší než obvod tmavého čtverce. Obvod celého prvního obrazce je $96\\ \\mathrm{cm}$.','Druhý i třetí obrazec se skládá ze dvou prvních obrazců.','Rozhodněte o každém z tvrzení 11.1–11.3, zda je pravdivé (A), či nikoli (N).','11.1 \\quad Obvod jednoho tmavého čtverce je $48\\ \\mathrm{cm}$.','11.2 \\quad Obvod celého druhého obrazce je $192\\ \\mathrm{cm}$.','11.3 \\quad Obvod celého třetího obrazce je o $48\\ \\mathrm{cm}$ větší než obvod celého druhého obrazce.'},
  null,
  null,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 482 112"><path d="M4 107L478 107L478 108L4 108Z" style="fill:#231f20"/><path d="M26 44L45 44L45 63L26 63ZM45 24L84 24L84 64L45 64ZM84 44L104 44L104 64L84 64ZM160 44L179 44L179 63L160 63ZM179 24L218 24L218 63L179 63ZM218 44L238 44L238 63L218 63ZM160 63L179 63L179 83L160 83ZM179 63L218 63L218 103L179 103ZM218 63L238 63L238 83L218 83ZM288 44L308 44L308 64L288 64ZM308 24L347 24L347 64L308 64ZM347 44L366 44L366 64L347 64ZM367 44L386 44L386 64L367 64ZM386 24L425 24L425 63L386 63ZM425 44L444 44L444 63L425 63Z" style="fill:none;stroke:#231f20;stroke-width:2"/><path d="M45 24L84 24L84 64L45 64Z" style="fill:#c7c8ca"/><path d="M179 24L218 24L218 63L179 63Z" style="fill:#c7c8ca"/><path d="M179 63L218 63L218 103L179 103Z" style="fill:#c7c8ca"/><path d="M308 24L347 24L347 64L308 64Z" style="fill:#c7c8ca"/><path d="M386 24L425 24L425 63L386 63Z" style="fill:#c7c8ca"/><text x="66" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">První obrazec</text><text x="200" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Druhý obrazec</text><text x="368" y="12" font-size="12" fill="#000" text-anchor="middle" font-family="sans-serif">Třetí obrazec</text></svg>',
  'obr.svg',
  'První, druhý a třetí obrazec složené z bílých a tmavých (šedých) čtverců; tmavý čtverec má dvojnásobnou stranu než bílý.',
  '',
  new List<String>{'Nechť bílý čtverec má stranu $a$; obvod tmavého je dvakrát větší, proto tmavý má stranu $2a$. Obvod prvního obrazce je $12a=96\\Rightarrow a=8\\ \\mathrm{cm}$, tmavý čtverec má stranu $16\\ \\mathrm{cm}$.','11.1: obvod tmavého čtverce $=4\\cdot 16=64\\ \\mathrm{cm}\\ne 48\\ \\mathrm{cm}$ — \\textbf{N}.','11.2: druhý obrazec má obvod $16a=128\\ \\mathrm{cm}\\ne 192\\ \\mathrm{cm}$ — \\textbf{N}.','11.3: třetí obrazec má obvod $22a=176\\ \\mathrm{cm}$; $176-128=48\\ \\mathrm{cm}$ — \\textbf{A}.'},
  '11.1: N; 11.2: N; 11.3: A',
  4, 8, '4',
  new List<String>{'zs2','r9','obvod','planimetrie','geometrie','uvazovani','vypocet','bez-kalkulacky'},
  'M9PID19C0T01', 2019
);

System.debug('Vytvořeno úloh: '+c.created);
