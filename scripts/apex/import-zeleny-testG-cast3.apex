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
  'Zelený G9 – množina vrcholů obdélníků PQRS',
  new List<String>{'V rovině leží body $P$ a $R$ vzdálené od sebe $6$ cm.','Vyznačte množinu vrcholů $Q$ a $S$ všech obdélníků $PQRS$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 240" font-family="sans-serif"> <line x1="110" y1="80" x2="315" y2="175" stroke="#999999" stroke-width="1" stroke-dasharray="4 5"/> <text x="205" y="118" font-size="15" text-anchor="middle" fill="#333333">6 cm</text> <line x1="100" y1="80" x2="120" y2="80" stroke="#000000" stroke-width="1.6"/> <line x1="110" y1="70" x2="110" y2="90" stroke="#000000" stroke-width="1.6"/> <text x="97" y="66" font-size="18" font-weight="bold" font-style="italic">P</text> <line x1="305" y1="175" x2="325" y2="175" stroke="#000000" stroke-width="1.6"/> <line x1="315" y1="165" x2="315" y2="185" stroke="#000000" stroke-width="1.6"/> <text x="326" y="172" font-size="18" font-weight="bold" font-style="italic">R</text> </svg>',
  'body-PR.svg',
  'Dva body P a R v rovině vzdálené 6 cm od sebe, každý označený křížkem.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'V obdélníku $PQRS$ jsou $P$, $R$ protilehlé vrcholy (úhlopříčka). Úhly u $Q$ a $S$ jsou pravé, proto $Q$ i $S$ leží na Thaletově kružnici nad průměrem $PR$ (střed je střed úsečky $PR$, poloměr $3$ cm). Vynecháme body $P$, $R$ (útvar by degeneroval) a dva body, v nichž by $PQRS$ byl čtverec, nikoli obdélník.'},
  'Zvýrazněná Thaletova kružnice nad průměrem $PR$ (poloměr $3$ cm) s výjimkou bodů $P$, $R$ a dvou bodů, pro něž by $PQRS$ byl čtverec.',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G10 – konstrukce trojúhelníku z těžnic',
  new List<String>{'V rovině je dán bod $T$, který je těžištěm trojúhelníku $ABC$.','Sestrojte trojúhelník $ABC$, víme-li, že jeho těžnice $t_a=9$ cm a $t_b=6$ cm spolu svírají pravý úhel.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 200" font-family="sans-serif"> <line x1="140" y1="100" x2="160" y2="100" stroke="#000000" stroke-width="1.8"/> <line x1="150" y1="90" x2="150" y2="110" stroke="#000000" stroke-width="1.8"/> <text x="166" y="98" font-size="18" font-weight="bold" font-style="italic">T</text> </svg>',
  'teziste-T.svg',
  'Bod T označený křížkem v rovině (těžiště hledaného trojúhelníku ABC).',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Těžiště dělí těžnice v poměru $2:1$: $|TA|=\\frac{2}{3}\\cdot 9=6$ cm, $|TS_a|=3$ cm, $|TB|=\\frac{2}{3}\\cdot 6=4$ cm, $|TS_b|=2$ cm. V bodě $T$ sestrojíme pravý úhel, na jedno rameno naneseme $A$ a na opačnou polopřímku $S_a$, na druhé rameno $B$ a na opačnou polopřímku $S_b$. Bod $C$ dopočteme z toho, že $S_a$ je střed $BC$ a $S_b$ střed $AC$.'},
  'Konstrukce trojúhelníku $ABC$ s těžištěm $T$ (těžnice $t_a=9$ cm a $t_b=6$ cm svírají pravý úhel; $|TA|=6$, $|TB|=4$ cm), viz obrázek v klíči.',
  2, 6, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
