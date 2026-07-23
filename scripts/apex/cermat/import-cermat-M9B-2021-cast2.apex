String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD21C0T02';
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
  'CERMAT M9B 2021 – úloha 6',
  new List<String>{'Přímá trasa z místa $A$ do místa $B$ měří $4$ km. Přesně v polovině této trasy je místo $S$. Z místa $A$ vystartovali současně 3 kamarádi a za stejný čas zdolali na této trase úseky různých délek. Každý z kamarádů se pohyboval stálou rychlostí.','Soňa došla pěšky pouze do místa $S$ ($A\\to S$).','Barbora doběhla až do místa $B$ ($A\\to S\\to B$).','Karel na kole dojel nejprve do místa $B$, pak se vrátil zpět do $A$ a nakonec zamířil do místa $S$, kam dorazil ve stejném okamžiku jako Soňa ($A\\to S\\to B\\to S\\to A\\to S$).','Vypočtěte:','6.1 kolikrát větší byla rychlost Karla než rychlost Barbory,','6.2 kolik km od místa $A$ byl vzdálen Karel v okamžiku, kdy Barbora míjela místo $S$,','6.3 kolik m od sebe byli vzdáleni Karel s Barborou v okamžiku, kdy Soňa urazila prvních $400$ m.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 130" font-family="sans-serif"> <text x="260" y="30" font-size="14" text-anchor="middle">4 km</text> <line x1="60" y1="50" x2="460" y2="50" stroke="#555" stroke-width="1"/> <polygon points="60,50 69,46 69,54" fill="#555"/> <polygon points="460,50 451,46 451,54" fill="#555"/> <line x1="60" y1="75" x2="460" y2="75" stroke="#000" stroke-width="2.5"/> <line x1="60" y1="66" x2="60" y2="84" stroke="#000" stroke-width="2"/> <line x1="260" y1="66" x2="260" y2="84" stroke="#000" stroke-width="2"/> <line x1="460" y1="66" x2="460" y2="84" stroke="#000" stroke-width="2"/> <text x="60" y="104" font-size="15" text-anchor="middle" font-style="italic">A</text> <text x="260" y="104" font-size="15" text-anchor="middle" font-style="italic">S</text> <text x="460" y="104" font-size="15" text-anchor="middle" font-style="italic">B</text> </svg>',
  'trasa-ASB.svg',
  'Číselná osa s body A, S, B; S je střed úsečky AB dlouhé 4 km.',
  'Trasa A–S–B (S je střed)',
  new List<String>{'Za stejný čas urazí: Soňa $2$ km, Barbora $4$ km, Karel $2+2+2+2+2=10$ km.','6.1 Rychlost Karla je $10:4=2{,}5$krát větší než rychlost Barbory.','6.2 Když Barbora míjí $S$, urazila $2$ km, tj. polovinu své trasy; za stejný čas urazí Karel polovinu své trasy, tedy $5$ km. Karel je pak $1$ km za bodem $B$ na cestě zpět, tj. $3$ km od $A$.','6.3 Když Soňa urazí $400$ m (pětinu své trasy), urazí Barbora $800$ m a Karel $2\\,000$ m, tj. je právě v místě $S$. Vzdálenost Karla a Barbory je $2\\,000-800=1\\,200$ m.'},
  '6.1: $2{,}5$krát; 6.2: $3$ km; 6.3: $1\\,200$ m',
  3, 6, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
