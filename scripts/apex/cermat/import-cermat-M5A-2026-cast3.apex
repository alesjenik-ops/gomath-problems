String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD26C0T01';
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
  'CERMAT M5A 2026 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží bod $T$ a přímky $k$, $p$ (viz obrázek).','Na přímce $p$ leží strana $EF$ obdélníku $EFGH$ a bod $T$ leží uvnitř strany $EH$. Body $T$ a $F$ mají od vrcholu $E$ stejnou vzdálenost. Na přímce $k$ leží vrchol $G$ obdélníku $EFGH$.','Sestrojte vrcholy obdélníku $EFGH$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="150" x2="420" y2="90" stroke="#000" stroke-width="2"/><text x="428" y="90" font-size="16" font-style="italic">k</text> <line x1="60" y1="90" x2="400" y2="230" stroke="#000" stroke-width="2"/><text x="405" y="240" font-size="16" font-style="italic">p</text> <text x="215" y="120" font-size="15" font-style="italic">T</text><text x="212" y="135" font-size="15">×</text> </svg>',
  'primky-kp.svg',
  'Bod T a dvě přímky k a p protínající se pod ostrým úhlem.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Vrchol $E$ je pata kolmice z $T$ na přímku $p$. Na $p$ naneseme $|EF|=|ET|$ (bod $F$). Ve vrcholu $F$ vztyčíme kolmici k $p$; její průsečík s přímkou $k$ je vrchol $G$. Bod $H$ doplníme tak, aby $EFGH$ byl obdélník.'},
  'Konstrukce obdélníku $EFGH$ ($E$ pata kolmice z $T$ na $p$, $|EF|=|ET|$, $G$ na přímce $k$) – viz obrázek v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2026 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $M$ (viz obrázek).','Body $A$, $M$ jsou vrcholy rovnostranného trojúhelníku $AMC$. Body $A$, $C$ jsou zároveň vrcholy trojúhelníku $ABC$. Bod $M$ leží uvnitř strany $BC$ trojúhelníku $ABC$ a strana $BC$ je dvakrát delší než strana $AC$.','Sestrojte vrcholy $B$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 300" font-family="sans-serif"> <rect x="10" y="10" width="400" height="280" fill="none" stroke="#ccc"/> <text x="205" y="150" font-size="15" font-style="italic">M</text><text x="202" y="164" font-size="15">×</text> <text x="140" y="235" font-size="15" font-style="italic">A</text><text x="137" y="225" font-size="15">×</text> </svg>',
  'body-AM.svg',
  'Body A a M v rovině.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Sestrojíme rovnostranný trojúhelník $AMC$ (dvě polohy $C$: $C_1$, $C_2$). $|AC|=|AM|$, strana $BC=2\\cdot|AC|$ a $M$ je střed $BC$, proto $|MB|=|MC|=|AC|$; bod $B$ leží na polopřímce $CM$ za bodem $M$ ve vzdálenosti $|CM|$. Dvě řešení.'},
  'Dvě řešení: rovnostranný trojúhelník $AMC$ (poloha $C_1$, $C_2$), $M$ střed $BC$, $|BC|=2|AC|$ – viz obrázek v klíči.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
