String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD18C0T02';
Integer YEAR = 2018;

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
  'CERMAT M9B 2018 – úloha 6',
  new List<String>{'Tři chlapci se přemístili od startu do cíle po třech různých trasách $A$, $B$, $C$ vždy za stejný čas. Adam trasu $A$ dlouhou $1\\,500$ m ujel na koloběžce. Bedřich trasu $B$ dlouhou $600$ m ušel pěšky. Cyril na trase $C$ nasedl na koloběžku až po $90$ m pěší chůze, koloběžku pak zanechal $60$ m před cílem a do cíle došel pěšky.','Adam jezdí na koloběžce stejně rychle jako Cyril. Cyril chodí pěšky stejně rychle jako Bedřich. Časové ztráty při nasedání a odkládání koloběžky zanedbáváme.','6.1 Vypočtěte, kolikrát je jízda na koloběžce rychlejší než pěší chůze.','6.2 Adam s Cyrilem vystartovali současně. Vyjádřete zlomkem, jakou část trasy měl za sebou Adam v okamžiku, kdy Cyril nasedl na koloběžku.','6.3 Vypočtěte, kolik metrů ujel Cyril na koloběžce.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 340" font-family="sans-serif"> <circle cx="90" cy="220" r="4" fill="#000"/><text x="52" y="238" font-size="14">Start</text> <circle cx="560" cy="180" r="4" fill="#000"/><text x="574" y="176" font-size="14">Cíl</text> <path d="M90,220 C180,55 460,55 560,180" fill="none" stroke="#000" stroke-width="2.5"/> <circle cx="185" cy="140" r="13" fill="#fff" stroke="#000"/><text x="185" y="145" font-size="13" text-anchor="middle">A</text> <text x="320" y="80" font-size="13" text-anchor="middle">1 500 m</text> <line x1="90" y1="220" x2="560" y2="180" stroke="#000" stroke-width="2.5" stroke-dasharray="2 5"/> <circle cx="255" cy="207" r="13" fill="#fff" stroke="#000"/><text x="255" y="212" font-size="13" text-anchor="middle">B</text> <text x="370" y="192" font-size="13" text-anchor="middle">600 m</text> <path d="M90,220 C120,285 150,282 178,268" fill="none" stroke="#000" stroke-width="2.5" stroke-dasharray="2 5"/> <text x="112" y="300" font-size="12">90 m</text> <path d="M178,268 C300,320 470,300 545,213" fill="none" stroke="#000" stroke-width="2.5"/> <circle cx="305" cy="272" r="13" fill="#fff" stroke="#000"/><text x="305" y="277" font-size="13" text-anchor="middle">C</text> <text x="380" y="305" font-size="12" text-anchor="middle">? m</text> <path d="M545,213 C551,203 556,193 560,180" fill="none" stroke="#000" stroke-width="2.5" stroke-dasharray="2 5"/> <text x="500" y="233" font-size="12">60 m</text> <line x1="428" y1="320" x2="468" y2="320" stroke="#000" stroke-width="2.5" stroke-dasharray="2 5"/><text x="474" y="324" font-size="12">Pěšky</text> <line x1="428" y1="335" x2="468" y2="335" stroke="#000" stroke-width="2.5"/><text x="474" y="339" font-size="12">Na koloběžce</text> </svg>',
  'trasy-abc.svg',
  'Schéma tří tras od startu do cíle: trasa A 1 500 m na koloběžce, trasa B 600 m pěšky, trasa C 90 m pěšky, část na koloběžce a 60 m pěšky před cílem.',
  'Výchozí obrázek k úloze 6',
  new List<String>{'6.1 Všichni jeli stejný čas $t$. Adam ujel $1\\,500$ m na koloběžce, Bedřich ušel $600$ m pěšky. Poměr rychlostí koloběžka : chůze $=1\\,500:600=2{,}5$, jízda je $2{,}5$krát rychlejší.','6.2 Cyril šel prvních $90$ m pěšky; za tuto dobu ujel Adam na koloběžce (rychlejší $2{,}5$krát) $2{,}5\\cdot 90=225$ m. Z trasy $1\\,500$ m to je $\\frac{225}{1\\,500}=\\frac{3}{20}$.','6.3 Cyril jde pěšky $90+60=150$ m, zbytek jede na koloběžce. Kdyby šel celou dobu pěšky, ušel by $600$ m (jako Bedřich za stejný čas). Času, který místo chůze jel, odpovídá pěší dráha $600-150=450$ m; na koloběžce za něj ujede $2{,}5\\cdot 450=1\\,125$ m.'},
  '6.1: $2{,}5$krát; 6.2: $\\frac{3}{20}$; 6.3: $1\\,125$ m',
  4, 8, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','fyzika'}
);

System.debug('Vytvořeno úloh: '+c.created);
