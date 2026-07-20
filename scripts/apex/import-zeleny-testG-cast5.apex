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
  'Zelený G13 – součet vnějších úhlů n-úhelníku',
  new List<String>{'Pro každý $n$-úhelník platí, že součet jeho vnitřních úhlů $=(n-2)\\cdot 180^\\circ$. Na obrázku je příklad jednoho z „vnějších" úhlů pětiúhelníku (doplněk vnitřního úhlu do plného úhlu $360^\\circ$).','Který z $n$-úhelníků (A–E) má součet svých „vnějších" úhlů roven $1800^\\circ$?'},
  new List<String>{'A) pětiúhelník','B) šestiúhelník','C) sedmiúhelník','D) osmiúhelník','E) devítiúhelník'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 290" font-family="sans-serif"> <polygon points="160,60 248,124 214,228 106,228 72,124" fill="#ffffff" stroke="#000000" stroke-width="2.5"/> <path d="M 248 90 A 42 42 0 1 1 286 148" fill="none" stroke="#000000" stroke-width="1.5"/> <text x="300" y="86" font-size="15" text-anchor="middle">vnější úhel</text> </svg>',
  'vnejsi-uhel.svg',
  'Pětiúhelník s vyznačeným „vnějším" úhlem u jednoho vrcholu (úhel doplňující vnitřní úhel do 360 stupňů).',
  'Schematický nákres „vnějšího" úhlu pětiúhelníku',
  new List<String>{'Každý „vnější" úhel je $360^\\circ$ minus vnitřní úhel. Součet $=n\\cdot 360^\\circ-(n-2)\\cdot 180^\\circ=180^\\circ n+360^\\circ$. Z rovnice $180n+360=1800$ plyne $n=8$, tedy osmiúhelník.'},
  'D) osmiúhelník',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený G14 – kruhová výseč (poměr obsahů)',
  new List<String>{'Na obrázku je $90^\\circ$ kruhová výseč rozdělená na bílou a šedou část. Délka $a$ a délka $b$ jsou si rovny.','V jakém vzájemném poměru jsou obsahy bílé a šedé části kruhové výseče?'},
  new List<String>{'A) $2:3$','B) $1:2$','C) $1:3$','D) $1:4$','E) jiný poměr'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 380" font-family="sans-serif"> <rect x="60" y="40" width="300" height="300" fill="#ffffff" stroke="#000000" stroke-width="0.8"/> <path d="M 60 40 A 300 300 0 0 1 360 340 L 60 340 Z" fill="#b9b9b9" stroke="#000000" stroke-width="1.5"/> <path d="M 60 190 A 150 150 0 0 1 210 340 L 60 340 Z" fill="#ffffff" stroke="#000000" stroke-width="1.5"/> <line x1="60" y1="360" x2="210" y2="360" stroke="#000000" stroke-width="1.2"/> <line x1="210" y1="360" x2="360" y2="360" stroke="#000000" stroke-width="1.2"/> <line x1="60" y1="352" x2="60" y2="368" stroke="#000000" stroke-width="1.2"/> <line x1="210" y1="352" x2="210" y2="368" stroke="#000000" stroke-width="1.2"/> <line x1="360" y1="352" x2="360" y2="368" stroke="#000000" stroke-width="1.2"/> <text x="135" y="378" font-size="16" text-anchor="middle" font-style="italic">a</text> <text x="285" y="378" font-size="16" text-anchor="middle" font-style="italic">b</text> </svg>',
  'kruhova-vysec.svg',
  'Čtvrtkruh o poloměru a plus b; vnitřní čtvrtkruh o poloměru a je bílý, vnější mezikruhová část je šedá.',
  'Kruhová výseč rozdělená na bílou a šedou část',
  new List<String>{'Vnitřní bílá čtvrtkruhová část má poloměr $a$, obsah $\\frac{1}{4}\\pi a^2$. Celá výseč má poloměr $a+b=2a$, obsah $\\frac{1}{4}\\pi(2a)^2=\\pi a^2$. Šedá část $\\pi a^2-\\frac{1}{4}\\pi a^2=\\frac{3}{4}\\pi a^2$. Poměr bílá : šedá $=1:3$.'},
  'C) $1:3$',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
