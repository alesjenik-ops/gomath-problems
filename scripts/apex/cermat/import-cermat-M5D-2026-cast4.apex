String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD26C0T04';
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
  'CERMAT M5D 2026 – úloha 8',
  new List<String>{'Pavle je $17$ let. Od $12$ let si vždy v den narozenin zapisuje svou výšku v celých cm. V grafu jsou zaznamenány tři z těchto zapsaných výšek, zbývající tři údaje chybí.','Během tří let od $12$ do $15$ narozenin povyrostla Pavla každým rokem o stejný počet cm. Počet cm, o které Pavla vyrostla během dvou let od $13$ do $15$ narozenin, byl o polovinu větší než počet cm, o které vyrostla během dalších dvou let (od $15$ do $17$ narozenin).','Rozhodněte o každém z následujících tvrzení (8.1–8.3), zda je pravdivé (A), nebo nepravdivé (N).','8.1 V den 14. narozenin měřila Pavla $167$ cm.','8.2 Od 16. do 17. narozenin vyrostla Pavla o $1$ cm.','8.3 Od 12. do 17. narozenin vyrostla Pavla celkem o $12$ cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 340" font-family="sans-serif"><line x1="70" y1="300.0" x2="510" y2="300.0" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="304.0" font-size="11" text-anchor="end">158</text><line x1="70" y1="267.5" x2="510" y2="267.5" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="271.5" font-size="11" text-anchor="end">160</text><line x1="70" y1="235.0" x2="510" y2="235.0" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="239.0" font-size="11" text-anchor="end">162</text><line x1="70" y1="202.5" x2="510" y2="202.5" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="206.5" font-size="11" text-anchor="end">164</text><line x1="70" y1="170.0" x2="510" y2="170.0" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="174.0" font-size="11" text-anchor="end">166</text><line x1="70" y1="137.5" x2="510" y2="137.5" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="141.5" font-size="11" text-anchor="end">168</text><line x1="70" y1="105.0" x2="510" y2="105.0" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="109.0" font-size="11" text-anchor="end">170</text><line x1="70" y1="72.5" x2="510" y2="72.5" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="76.5" font-size="11" text-anchor="end">172</text><line x1="70" y1="40.0" x2="510" y2="40.0" stroke="#d0d0d0" stroke-width="1"/><text x="62" y="44.0" font-size="11" text-anchor="end">174</text><line x1="70" y1="40" x2="70" y2="300" stroke="#000"/><line x1="70" y1="300" x2="510" y2="300" stroke="#000"/><text x="26" y="180" font-size="12" text-anchor="middle" transform="rotate(-90 26 180)">Výška v cm</text><text x="113.5" y="318" font-size="12" text-anchor="middle">12 let</text><rect x="167.5" y="218.8" width="42" height="81.2" fill="#a9a9a9" stroke="#000"/><text x="188.5" y="318" font-size="12" text-anchor="middle">13 let</text><text x="263.5" y="318" font-size="12" text-anchor="middle">14 let</text><rect x="317.5" y="121.2" width="42" height="178.8" fill="#a9a9a9" stroke="#000"/><text x="338.5" y="318" font-size="12" text-anchor="middle">15 let</text><rect x="392.5" y="88.8" width="42" height="211.2" fill="#a9a9a9" stroke="#000"/><text x="413.5" y="318" font-size="12" text-anchor="middle">16 let</text><text x="488.5" y="318" font-size="12" text-anchor="middle">17 let</text></svg>',
  'graf-vyska.svg',
  'Sloupcový graf výšek Pavly ve 13 letech (163 cm), 15 letech (169 cm) a 16 letech (171 cm); ostatní sloupce chybí.',
  'Zaznamenané výšky Pavly (cm)',
  new List<String>{'Roční přírůstek od $12$ do $15$ let je stejný: z $163$ cm ve $13$ letech a $169$ cm v $15$ letech plyne $6$ cm za dva roky, tj. $3$ cm ročně. Proto $12$ let $=160$ cm, $14$ let $=166$ cm. Přírůstek $13\\to 15$ je $6$ cm, a to je o polovinu více než přírůstek $15\\to 17$, ten je tedy $4$ cm; $17$ let $=169+4=173$ cm.','8.1 Ve $14$ letech měřila $166$ cm, ne $167$ cm → Ne.','8.2 Od $16$ do $17$ let vyrostla $173-171=2$ cm, ne $1$ cm → Ne.','8.3 Od $12$ do $17$ let vyrostla $173-160=13$ cm, ne $12$ cm → Ne.'},
  '8.1: Ne; 8.2: Ne; 8.3: Ne',
  4, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
