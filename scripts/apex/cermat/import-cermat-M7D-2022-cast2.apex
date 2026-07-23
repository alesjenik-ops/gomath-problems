String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD22C0T04';
Integer YEAR = 2022;

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
  'CERMAT M7D 2022 – úloha 4',
  new List<String>{'V každém nákresu se do prázdných kroužků a čtverečků doplňují pouze celá čísla větší než $0$. Podle vzoru se čísla v obou horních kroužcích sečtou do horního (silně ohraničeného) čtverečku; levý horní kroužek se vynásobí třemi a pravý čtyřmi, výsledky se zapíšou do dolních kroužků a jejich součet do dolního čtverečku. V I. i II. nákresu je v dolním čtverečku číslo $43$.','4.1 Doplňte v I. nákresu taková čísla, aby byl součet v silně ohraničeném (horním) čtverečku co nejmenší.','4.2 Doplňte ve II. nákresu taková čísla, aby byl součet v silně ohraničeném (horním) čtverečku co největší.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 180" font-family="sans-serif" font-size="14"><text x="90" y="18" text-anchor="middle" font-size="13">I. nákres</text><circle cx="40" cy="55" r="15" fill="none" stroke="#000"/><text x="66" y="60">+</text><circle cx="95" cy="55" r="15" fill="none" stroke="#000"/><text x="121" y="60">=</text><rect x="138" y="40" width="30" height="30" fill="none" stroke="#000" stroke-width="2"/><text x="30" y="98" font-size="12">· 3</text><text x="108" y="98" font-size="12">· 4</text><line x1="40" y1="72" x2="40" y2="118" stroke="#000"/><polygon points="40,122 36,114 44,114" fill="#000"/><line x1="95" y1="72" x2="95" y2="118" stroke="#000"/><polygon points="95,122 91,114 99,114" fill="#000"/><circle cx="40" cy="150" r="15" fill="none" stroke="#000"/><text x="66" y="155">+</text><circle cx="95" cy="150" r="15" fill="none" stroke="#000"/><text x="121" y="155">=</text><rect x="138" y="135" width="30" height="30" fill="none" stroke="#000"/><text x="153" y="156" text-anchor="middle" font-size="13">43</text><text x="320" y="18" text-anchor="middle" font-size="13">II. nákres</text><circle cx="270" cy="55" r="15" fill="none" stroke="#000"/><text x="296" y="60">+</text><circle cx="325" cy="55" r="15" fill="none" stroke="#000"/><text x="351" y="60">=</text><rect x="368" y="40" width="30" height="30" fill="none" stroke="#000" stroke-width="2"/><text x="260" y="98" font-size="12">· 3</text><text x="338" y="98" font-size="12">· 4</text><line x1="270" y1="72" x2="270" y2="118" stroke="#000"/><polygon points="270,122 266,114 274,114" fill="#000"/><line x1="325" y1="72" x2="325" y2="118" stroke="#000"/><polygon points="325,122 321,114 329,114" fill="#000"/><circle cx="270" cy="150" r="15" fill="none" stroke="#000"/><text x="296" y="155">+</text><circle cx="325" cy="150" r="15" fill="none" stroke="#000"/><text x="351" y="155">=</text><rect x="368" y="135" width="30" height="30" fill="none" stroke="#000"/><text x="383" y="156" text-anchor="middle" font-size="13">43</text></svg>',
  'nakresy.svg',
  'Dva shodné nákresy s horními kroužky, násobením třemi a čtyřmi a dolním čtverečkem s číslem 43.',
  'I. a II. nákres k úloze 4',
  new List<String>{'Označme čísla v horních kroužcích $a$ (vlevo) a $b$ (vpravo). Dolní kroužky jsou $3a$ a $4b$, jejich součet $3a+4b=43$. Do silně ohraničeného čtverečku patří $a+b$.','Celá kladná řešení: $(a,b)=(1,10),(5,7),(9,4),(13,1)$; součty $a+b$ jsou $11$, $12$, $13$, $14$.','4.1 Nejmenší součet je $11$ (pro $a=1$, $b=10$).','4.2 Největší součet je $14$ (pro $a=13$, $b=1$).'},
  '4.1: $11$; 4.2: $14$',
  4, 5, '3',
  new List<String>{'zs2','r7','aritmetika','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
