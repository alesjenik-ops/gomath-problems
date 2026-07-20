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
  'Zelený D9 – konstrukce nepravidelného šestiúhelníku',
  new List<String>{'V rovině leží úsečka $AD$ o délce $8$ cm.','Sestrojte nepravidelný šestiúhelník $ABCDEF$. Každý z jeho vrcholů $B$, $C$, $E$, $F$ je vzdálen od bodu $A$ $9$ cm a leží na jedné z přímek procházejících bodem $D$, které svírají s úsečkou $AD$ úhel $75^\\circ$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 120" font-family="sans-serif"><line x1="50" y1="70" x2="410" y2="70" stroke="#000" stroke-width="1.5"/><line x1="120" y1="58" x2="120" y2="82" stroke="#000" stroke-width="2"/><line x1="360" y1="58" x2="360" y2="82" stroke="#000" stroke-width="2"/><text x="120" y="102" font-size="18" text-anchor="middle" font-style="italic" font-weight="bold">A</text><text x="360" y="102" font-size="18" text-anchor="middle" font-style="italic" font-weight="bold">D</text><text x="240" y="55" font-size="14" text-anchor="middle">8 cm</text></svg>',
  'usecka-AD.svg',
  'Vodorovná úsečka AD délky 8 cm s krajními body A a D.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Sestrojíme úsečku $AD=8$ cm. Bodem $D$ vedeme dvě přímky $p$, $q$ svírající s přímkou $AD$ úhel $75^\\circ$. Kružnice se středem $A$ a poloměrem $9$ cm protne tyto přímky ve čtyřech bodech: $B$, $C$ (nad $AD$) a $E$, $F$ (pod $AD$). Šestiúhelník $ABCDEF$ dostaneme spojením vrcholů v pořadí $A, B, C, D, E, F$.'},
  'Konstrukce: bodem $D$ dvě přímky svírající s $AD$ úhel $75^\\circ$; kružnice se středem $A$ a poloměrem $9$ cm protne přímky ve vrcholech $B$, $C$, $E$, $F$; šestiúhelník $ABCDEF$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený D10 – konstrukce lichoběžníku STUV',
  new List<String>{'V rovině leží body $S$ a $T$ od sebe vzdálené $8$ cm.','Sestrojte lichoběžník $STUV$ se základnou $ST$, jehož výška je $5$ cm, úhel $TUV$ má $75^\\circ$ a úhel $UVS$ $120^\\circ$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 320" font-family="sans-serif"><line x1="112" y1="82" x2="128" y2="98" stroke="#000" stroke-width="2"/><line x1="128" y1="82" x2="112" y2="98" stroke="#000" stroke-width="2"/><text x="98" y="86" font-size="18" font-style="italic" font-weight="bold">S</text><line x1="292" y1="242" x2="308" y2="258" stroke="#000" stroke-width="2"/><line x1="308" y1="242" x2="292" y2="258" stroke="#000" stroke-width="2"/><text x="282" y="274" font-size="18" font-style="italic" font-weight="bold">T</text></svg>',
  'body-ST.svg',
  'Dva body S a T označené křížky, vzdálené 8 cm.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'V lichoběžníku $STUV$ je $ST\\parallel UV$. Protože úhel $UVS=120^\\circ$, je úhel při vrcholu $S$ roven $180^\\circ-120^\\circ=60^\\circ$; protože úhel $TUV=75^\\circ$, je úhel při vrcholu $T$ roven $180^\\circ-75^\\circ=105^\\circ$. Sestrojíme základnu $ST=8$ cm a rovnoběžku ve vzdálenosti $5$ cm; ramena vedená z $S$ pod úhlem $60^\\circ$ a z $T$ pod úhlem $105^\\circ$ protnou rovnoběžku ve vrcholech $V$ a $U$.'},
  'Konstrukce lichoběžníku $STUV$: základna $ST=8$ cm, rovnoběžka ve vzdálenosti $5$ cm, úhel při $S$ $60^\\circ$ a při $T$ $105^\\circ$; ramena protnou rovnoběžku v $V$ a $U$ (viz obrázek v klíči).',
  2, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
