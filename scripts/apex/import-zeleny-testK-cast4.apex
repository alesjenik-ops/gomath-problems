String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

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
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
  'Zelený K10 – trojúhelník PQR a kružnice vepsaná',
  new List<String>{'V rovině jsou dány body $P$ a $Q$ od sebe vzdálené $6$ cm.','Sestrojte trojúhelník $PQR$, jehož vnitřní úhly u vrcholů $P$ a $R$ jsou $30°$, a dále kružnici $u$ se středem $U$ trojúhelníku $PQR$ vepsanou.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif"> <line x1="130" y1="90" x2="150" y2="90" stroke="#000" stroke-width="2"/> <line x1="140" y1="80" x2="140" y2="100" stroke="#000" stroke-width="2"/> <text x="118" y="96" font-size="18" font-weight="bold">P</text> <line x1="370" y1="270" x2="390" y2="270" stroke="#000" stroke-width="2"/> <line x1="380" y1="260" x2="380" y2="280" stroke="#000" stroke-width="2"/> <text x="398" y="278" font-size="18" font-weight="bold">Q</text> <line x1="140" y1="90" x2="380" y2="270" stroke="#777" stroke-width="1" stroke-dasharray="4 5"/> <text x="255" y="168" font-size="15" fill="#555">6 cm</text> </svg>',
  'body-pq.svg',
  'Dva body P a Q v rovině vzdálené 6 cm.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Sestrojíme úsečku $PQ=6$ cm. Úhly při $P$ a $R$ jsou $30°$, proto úhel při $Q$ je $180°-2\\cdot 30°=120°$. V bodě $P$ naneseme úhel $30°$ a v bodě $Q$ úhel $120°$; průsečík ramen je vrchol $R$. Osy vnitřních úhlů $o_p$ a $o_q$ se protnou ve středu $U$ kružnice vepsané $u$, kterou narýsujeme s poloměrem rovným vzdálenosti $U$ od stran trojúhelníku.'},
  'Trojúhelník $PQR$ s úhly $30°$, $120°$, $30°$; střed $U$ vepsané kružnice $u$ je průsečík os vnitřních úhlů $o_p$ a $o_q$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený K11 – napouštění vany',
  new List<String>{'Do vany ze třetiny naplněné vodou o teplotě 40 °C začínáme připouštět vodu ze dvou kohoutků – studenou o teplotě 10 °C a teplou o teplotě 60 °C. Přítok studené vody je dvakrát silnější než přítok teplé. Kdybychom doplňovali vanu pouze studenou vodou, byla by plná za $10$ minut.','Rozhodněte o každém z následujících tvrzení 11.1–11.3, zda je pravdivé (Ano), či nikoli (Ne).','11.1 Za pět minut klesne teplota vody ve vaně o 8 °C.','11.2 Až bude vana plná, bude teplota vody ve vaně zhruba 31 °C.','11.3 Oběma kohoutky naplníme vanu za $400$ sekund.'},
  null,
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Studená voda naplní zbylé dvě třetiny vany za $10$ minut, tedy studený přítok je $\\frac{2}{3}V$ za $10$ min, tj. $\\frac{V}{15}$ za minutu. Teplý přítok je poloviční, tj. $\\frac{V}{30}$ za minutu; dohromady $\\frac{V}{10}$ za minutu.','11.3 Zbývá naplnit $\\frac{2}{3}V$; čas $=\\frac{2}{3}V:\\frac{V}{10}=\\frac{20}{3}$ min $=400$ s. Pravda (Ano).','11.1 Za $5$ min přiteče studené $\\frac{V}{3}$ (10 °C) a teplé $\\frac{V}{6}$ (60 °C). Objem $\\frac{V}{3}+\\frac{V}{3}+\\frac{V}{6}=\\frac{5V}{6}$, teplota $\\frac{\\frac{V}{3}\\cdot 40+\\frac{V}{3}\\cdot 10+\\frac{V}{6}\\cdot 60}{\\frac{5V}{6}}=32$ °C. Pokles o $8$ °C (Ano).','11.2 Plná vana: přiteklo $\\frac{4V}{9}$ studené a $\\frac{2V}{9}$ teplé. Teplota $\\frac{\\frac{V}{3}\\cdot 40+\\frac{4V}{9}\\cdot 10+\\frac{2V}{9}\\cdot 60}{V}=\\frac{280}{9}\\doteq 31$ °C (Ano).'},
  '11.1: Ano; 11.2: Ano; 11.3: Ano',
  3, 8, '4',
  new List<String>{'zs2','r9','aritmetika','argumentace','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
