String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M9B 2019 – úloha 6',
  new List<String>{'Zadaná práce byla rozdělena na dvě stejné části. První polovinu práce vykonal minibagr za $10$ hodin. Druhou polovinu práce pak vykonali společně $4$ dělníci. Minibagr udělá za každých $5$ hodin stejný díl práce jako $5$ dělníků za $8$hodinovou pracovní dobu. (Každý dělník vykoná za hodinu stejné množství práce.) Za půjčení $1$ minibagru se platí jednorázový poplatek $1\\,500$ korun, každá hodina práce minibagru (i s obsluhou) stojí $600$ korun a hodina práce $1$ dělníka $150$ korun.','6.1 Vypočtěte, kolik korun se celkem zaplatilo za půjčení a práci minibagru (i s obsluhou).','6.2 Vypočtěte, kolik korun stála práce vykonaná dělníky.','6.3 Vypočtěte, kolik hodin musel odpracovat každý ze $4$ dělníků.'},
  null,
  3,
  null,
  null,
  null,
  null,
  new List<String>{'6.1 Poplatek $1\\,500$ Kč a $10$ hodin práce po $600$ Kč: $1\\,500+10\\cdot 600=7\\,500$ korun.','První polovinu práce zvládl minibagr za $10$ h, což je $2\\times$ výkon „$5$ dělníků za $8$ h", tj. $2\\cdot 5\\cdot 8=80$ dělníkohodin. Druhá (stejná) polovina je také $80$ dělníkohodin.','6.2 Dělníci odpracovali $80$ hodin po $150$ Kč: $80\\cdot 150=12\\,000$ korun.','6.3 $80$ dělníkohodin rozdělených mezi $4$ dělníky: $80:4=20$ hodin na každého.'},
  '6.1: $7\\,500$ korun; 6.2: $12\\,000$ korun; 6.3: $20$ hodin',
  4, 7, '4',
  new List<String>{'zs2','r9','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2019 – úloha 7',
  new List<String>{'Nájezdová rampa sestavená ze čtyř dřevotřískových desek je přistavena ke schodu. Nakloněnou čtvercovou desku rampy podpírají tři stejné trojúhelníkové desky. Hloubka rampy je $12$ dm a výška rampy je $5$ dm. Tloušťku desky neuvažujte.','Vypočtěte, kolik dm² dřevotřísky je v hotové rampě použito','7.1 na všechny tři trojúhelníkové desky dohromady,','7.2 na čtvercovou desku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 480 260" font-family="sans-serif"> <polygon points="150,50 400,180 445,150 195,20" fill="#d7d7d7" stroke="#000" stroke-width="2"/> <polygon points="90,70 90,200 400,200" fill="#efefef" stroke="#000" stroke-width="2"/> <polygon points="150,50 150,180 400,180" fill="none" stroke="#000" stroke-width="1.5" stroke-dasharray="5 4"/> <line x1="90" y1="70" x2="150" y2="50" stroke="#000" stroke-width="1.5"/> <line x1="90" y1="200" x2="150" y2="180" stroke="#000" stroke-width="1.5"/> <line x1="400" y1="200" x2="400" y2="180" stroke="#000" stroke-width="1.5"/> <path d="M 106 200 L 106 184 L 90 184" fill="none" stroke="#000" stroke-width="1.2"/> <text x="70" y="140" font-size="15" text-anchor="middle">5 dm</text> <text x="245" y="220" font-size="15" text-anchor="middle">12 dm</text> <text x="300" y="95" font-size="14" text-anchor="middle" fill="#333">čtvercová deska</text> </svg>',
  'rampa.svg',
  'Nájezdová rampa jako trojboký hranol; svislá výška 5 dm, vodorovná hloubka 12 dm, nakloněná čtvercová deska nahoře.',
  'Schematický nákres rampy (výška 5 dm, hloubka 12 dm)',
  new List<String>{'7.1 Každá trojúhelníková deska je pravoúhlý trojúhelník s odvěsnami $5$ dm a $12$ dm, obsah $\\frac{5\\cdot 12}{2}=30$ dm². Tři desky: $3\\cdot 30=90$ dm².','7.2 Strana čtvercové desky je přepona: $\\sqrt{5^2+12^2}=\\sqrt{169}=13$ dm. Obsah $13^2=169$ dm².'},
  '7.1: $90$ dm²; 7.2: $169$ dm²',
  3, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
