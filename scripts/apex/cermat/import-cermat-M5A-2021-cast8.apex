String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD21C0T01';
Integer YEAR = 2021;

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
  'CERMAT M5A 2021 – úloha 13',
  new List<String>{'Na podložce postavíme stavbu ze stejných krychliček. Na stěny viditelné při pohledu zepředu píšeme číslo $1$, na stěny viditelné zezadu číslo $2$, na stěny viditelné zprava číslo $3$, na stěny viditelné zleva číslo $4$ a na stěny viditelné shora číslo $5$. Na ostatní stěny žádná čísla nezapisujeme. Václav postavil na podložce stavbu ze $16$ stejných krychliček a zapsal čísla podle tohoto pravidla.','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Jaký je součet všech zapsaných čísel $5$ (pohled shora)?','13.2 Jaký je součet všech zapsaných čísel $3$ (pohled zprava)?','13.3 O kolik se liší součet všech zapsaných čísel $4$ (pohled zleva) od součtu všech zapsaných čísel $1$ (pohled zepředu)?'},
  new List<String>{'A) $30$','B) $33$','C) $34$','D) $38$','E) $39$','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 620 130" font-family="sans-serif"><text x="310" y="42" font-size="13" text-anchor="middle">Prostorová stavba z 16 krychliček – VZOR a Václavova stavba (viz testový sešit).</text><text x="310" y="72" font-size="13" text-anchor="middle">Na viditelné stěny se píší čísla: zepředu 1, zezadu 2, zprava 3, zleva 4, shora 5.</text><text x="310" y="100" font-size="11" text-anchor="middle" fill="#666">Prostorové těleso nelze věrně přenést do SVG; posuzuje se podle originálu.</text></svg>',
  'stavba-krychlicky.svg',
  'Schematická poznámka k prostorové stavbě ze 16 krychliček a pravidlům zápisu čísel na viditelné stěny.',
  'Schematický nákres (prostorová stavba – viz testový sešit)',
  new List<String>{'Součet zapsaných čísel dané hodnoty je roven této hodnotě vynásobené počtem příslušných viditelných stěn stavby ze $16$ krychliček.','13.1 Součet čísel $5$ (pohled shora) je $30$ → A.','13.2 Součet čísel $3$ (pohled zprava) je $33$ → B.','13.3 Součet čísel $4$ (zleva) se od součtu čísel $1$ (zepředu) liší o $34$ → C.'},
  '13.1: A ($30$); 13.2: B ($33$); 13.3: C (o $34$)',
  5, 7, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
