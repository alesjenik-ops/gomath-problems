String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M5C 2023 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží úsečka $KL$ a přímka $a$ (viz obrázek).','Body $K$, $L$ leží uvnitř dvou různých stran obdélníku $ABCD$. Strana $AB$ tohoto obdélníku leží na přímce $a$. Některá strana obdélníku $ABCD$ je dvakrát delší než úsečka $KL$.','Sestrojte všechny vrcholy obdélníku $ABCD$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 220" font-family="sans-serif"> <line x1="30" y1="200" x2="300" y2="90" stroke="#000" stroke-width="2"/> <text x="305" y="88" font-size="15" font-style="italic">a</text> <line x1="80" y1="70" x2="80" y2="150" stroke="#000" stroke-width="2"/> <line x1="72" y1="70" x2="88" y2="70" stroke="#000" stroke-width="2"/> <line x1="72" y1="150" x2="88" y2="150" stroke="#000" stroke-width="2"/> <text x="64" y="66" font-size="15" font-style="italic">L</text> <text x="64" y="164" font-size="15" font-style="italic">K</text> </svg>',
  'usecka-KL-primka-a.svg',
  'Svislá úsečka KL a šikmá přímka a.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Strana $AB$ leží na přímce $a$; body $K$, $L$ leží uvnitř dvou různých stran obdélníku. Z podmínky, že některá strana je dvakrát delší než $KL$, a z polohy bodů $K$, $L$ vyplývají dvě řešení obdélníku (viz náčrt v klíči).'},
  'Konstrukce obdélníku $ABCD$ se stranou $AB$ na přímce $a$, body $K$, $L$ uvnitř dvou různých stran a jednou stranou délky $2\\cdot|KL|$; úloha má dvě řešení – viz náčrt v klíči.',
  3, 6, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2023 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží přímka $p$ a přímka $q$ procházející bodem $R$ (viz obrázek).','Bod $R$ je vrchol pravoúhlého rovnoramenného trojúhelníku $PQR$ se základnou $PQ$. Na přímce $p$ leží vrchol $P$ a na přímce $q$ leží vrchol $Q$ trojúhelníku $PQR$.','Sestrojte vrcholy $P$, $Q$ trojúhelníku $PQR$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 340 220" font-family="sans-serif"> <line x1="30" y1="70" x2="310" y2="95" stroke="#000" stroke-width="2"/> <text x="315" y="98" font-size="15" font-style="italic">p</text> <line x1="30" y1="190" x2="310" y2="120" stroke="#000" stroke-width="2"/> <text x="315" y="123" font-size="15" font-style="italic">q</text> <line x1="176" y1="146" x2="184" y2="158" stroke="#000" stroke-width="2"/> <text x="172" y="172" font-size="15" font-style="italic">R</text> </svg>',
  'primky-p-q.svg',
  'Přímka p a přímka q procházející bodem R.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Trojúhelník $PQR$ je pravoúhlý rovnoramenný s pravým úhlem u vrcholu $R$ (přepona $PQ$), tedy $|RP|=|RQ|$ a $RP\\perp RQ$. Vrchol $Q$ získáme jako průsečík přímky $q$ s obrazem přímky $p$ při otočení kolem bodu $R$ o $90^\\circ$; vrchol $P$ pak leží na přímce $p$. Otočení o $+90^\\circ$ i $-90^\\circ$ dává dvě řešení (viz náčrt v klíči).'},
  'Dvě řešení: $|RP|=|RQ|$ a $RP\\perp RQ$; $Q$ je průsečík přímky $q$ s obrazem přímky $p$ otočené kolem $R$ o $90^\\circ$ – viz náčrt v klíči.',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
