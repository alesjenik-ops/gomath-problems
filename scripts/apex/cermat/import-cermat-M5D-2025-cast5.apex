String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD25C0T04';
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
  'CERMAT M5D 2025 - uloha 11',
  new List<String>{'Lucka si ukladala do kasicky jen desetikoruny. Na konci kazdeho mesice vsechny penize v kasicce spocitala, celou castku zaokrouhlila na stovky korun a zaznamenala do grafu. Nasledujici graf zobrazuje tyto zaokrouhlene castky v prvnich ctyrech mesicich roku. V tomto obdobi Lucka penize pouze ukladala, z kasicky nic nevybirala.','Jakou nejvyssi castku mohla mit Lucka v kasicce na konci brezna?'},
  new List<String>{'A) $650$ korun','B) $690$ korun','C) $740$ korun','D) $750$ korun','E) jinou castku'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 340" font-family="sans-serif" font-size="11"><line x1="70" y1="20" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="480" y2="300" stroke="#000"/><line x1="66" y1="300.0" x2="70" y2="300.0" stroke="#000"/><text x="62" y="304.0" text-anchor="end">0</text><line x1="66" y1="270.0" x2="70" y2="270.0" stroke="#000"/><text x="62" y="274.0" text-anchor="end">100</text><line x1="66" y1="240.0" x2="70" y2="240.0" stroke="#000"/><text x="62" y="244.0" text-anchor="end">200</text><line x1="66" y1="210.0" x2="70" y2="210.0" stroke="#000"/><text x="62" y="214.0" text-anchor="end">300</text><line x1="66" y1="180.0" x2="70" y2="180.0" stroke="#000"/><text x="62" y="184.0" text-anchor="end">400</text><line x1="66" y1="150.0" x2="70" y2="150.0" stroke="#000"/><text x="62" y="154.0" text-anchor="end">500</text><line x1="66" y1="120.0" x2="70" y2="120.0" stroke="#000"/><text x="62" y="124.0" text-anchor="end">600</text><line x1="66" y1="90.0" x2="70" y2="90.0" stroke="#000"/><text x="62" y="94.0" text-anchor="end">700</text><line x1="66" y1="60.0" x2="70" y2="60.0" stroke="#000"/><text x="62" y="64.0" text-anchor="end">800</text><rect x="110" y="180.0" width="50" height="120.0" fill="#666666" stroke="#000"/><text x="135.0" y="316" text-anchor="middle">Leden</text><rect x="200" y="120.0" width="50" height="180.0" fill="#666666" stroke="#000"/><text x="225.0" y="316" text-anchor="middle">Unor</text><rect x="290" y="90.0" width="50" height="210.0" fill="#666666" stroke="#000"/><text x="315.0" y="316" text-anchor="middle">Brezen</text><rect x="380" y="90.0" width="50" height="210.0" fill="#666666" stroke="#000"/><text x="405.0" y="316" text-anchor="middle">Duben</text><text x="24" y="160" font-size="11" text-anchor="middle" transform="rotate(-90 24 160)">Zaokrouhlena castka v korunach</text></svg>',
  'graf-lucka.svg',
  'Sloupcovy graf zaokrouhlenych castek: leden 400, unor 600, brezen 700, duben 700 korun.',
  'Zaokrouhlene castky v kasicce (leden az duben)',
  new List<String>{'Na konci brezna je zaokrouhlena castka $700$ korun, skutecna castka tedy lezi v rozmezi od $650$ do $749$ korun. Protoze Lucka uklada pouze desetikoruny, je nejvyssi mozna castka $740$ korun (castka $750$ by se zaokrouhlila na $800$).'},
  'C) $740$ korun',
  2, 3, '3',
  new List<String>{'zs1','statistika','porozumeni','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
