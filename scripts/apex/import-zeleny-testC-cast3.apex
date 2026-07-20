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
  'Zelený C9 – množina bodů (S, T)',
  new List<String>{'Jsou dány body $S$ a $T$ vzdálené od sebe $5$ cm.','Vyznačte množinu všech bodů, které jsou od bodu $S$ vzdáleny $3$ cm a současně jejich vzdálenost od bodu $T$ není menší než $4$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 150" font-family="sans-serif"> <text x="90" y="80" font-size="22" text-anchor="middle">×</text> <text x="90" y="106" font-size="18" text-anchor="middle" font-weight="bold">S</text> <text x="310" y="80" font-size="22" text-anchor="middle">×</text> <text x="310" y="106" font-size="18" text-anchor="middle" font-weight="bold">T</text> <text x="200" y="60" font-size="14" text-anchor="middle" fill="#555">5 cm</text> <line x1="105" y1="72" x2="295" y2="72" stroke="#999" stroke-width="1" stroke-dasharray="4 4"/> </svg>',
  'body-S-T.svg',
  'Dva body S a T ve vzdálenosti 5 cm od sebe.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Body vzdálené $3$ cm od $S$ tvoří kružnici $k_1(S, 3$ cm$)$. Podmínka „vzdálenost od $T$ není menší než $4$ cm“ znamená ležet vně nebo na kružnici $k_2(T, 4$ cm$)$.','Hledanou množinou je oblouk kružnice $k_1$ ležící vně kružnice $k_2$; jeho krajní body jsou průsečíky kružnic $k_1$ a $k_2$ (v nich je vzdálenost od $T$ přesně $4$ cm).'},
  'Oblouk kružnice $k_1(S, 3$ cm$)$ ležící vně kružnice $k_2(T, 4$ cm$)$, včetně krajních bodů, což jsou průsečíky obou kružnic (viz obrázek v klíči).',
  2, 5, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C10 – rovnoramenný pravoúhlý trojúhelník',
  new List<String>{'V rovině leží bod $C$.','Sestrojte rovnoramenný pravoúhlý trojúhelník $ABC$ s pravým úhlem u vrcholu $C$, jehož přepona je dlouhá $6$ cm. Při konstrukci nepoužívejte úhloměr. Zapište postup konstrukce.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 120" font-family="sans-serif"> <text x="150" y="72" font-size="24" text-anchor="middle">×</text> <text x="150" y="52" font-size="18" text-anchor="middle" font-weight="bold">C</text> </svg>',
  'bod-C.svg',
  'Jeden bod C ležící v rovině.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Přepona $AB = 6$ cm leží proti pravému úhlu. Střed přepony $S_t$ má od vrcholu $C$ vzdálenost $3$ cm (polovina přepony) a u rovnoramenného trojúhelníku je úsečka $CS_t$ kolmá na přeponu.','1. Bodem $C$ veďte dvě navzájem kolmé přímky $a$, $b$ (ramena pravého úhlu).','2. Sestrojte osu $o$ pravého úhlu mezi přímkami $a$ a $b$.','3. Na ose $o$ vyznačte bod $S_t$ tak, že $|CS_t| = 3$ cm.','4. Bodem $S_t$ veďte přímku $t$ kolmou k ose $o$; její průsečík s přímkou $a$ je bod $A$, s přímkou $b$ bod $B$.','5. Trojúhelník $ABC$ je hledaný ($|AB| = 6$ cm).'},
  'Konstrukce rovnoramenného pravoúhlého trojúhelníku $ABC$ s pravým úhlem u $C$ a přeponou $|AB| = 6$ cm; střed přepony $S_t$ leží na ose pravého úhlu ve vzdálenosti $3$ cm od $C$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
