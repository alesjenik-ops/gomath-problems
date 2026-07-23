String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD22C0T03';
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
  'CERMAT M9C 2022 – úloha 14',
  new List<String>{'Penál má tvar rotačního válce. Poloměr podstavy válce je $5$ cm a výška válce $20$ cm. Obě podstavy válce jsou bílé a plášť válce je tmavý (viz obrázek).','Kolikrát větší je obsah pláště válce než obsah jedné podstavy?'},
  new List<String>{'A) 4krát','B) 6krát','C) 8krát','D) 10krát','E) 20krát'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif"> <rect x="110" y="45" width="220" height="130" fill="#565656" stroke="none"/> <ellipse cx="110" cy="110" rx="26" ry="65" fill="#565656" stroke="#000" stroke-width="1.6"/> <line x1="110" y1="45" x2="330" y2="45" stroke="#000" stroke-width="1.6"/> <line x1="110" y1="175" x2="330" y2="175" stroke="#000" stroke-width="1.6"/> <ellipse cx="330" cy="110" rx="26" ry="65" fill="#ffffff" stroke="#000" stroke-width="1.6"/> </svg>',
  'valec-penal.svg',
  'Ležící rotační válec s tmavým pláštěm a bílou podstavou (penál).',
  'Válec – penál (plášť tmavý, podstavy bílé)',
  new List<String>{'Obsah pláště $S_{pl}=2\\pi r v=2\\pi\\cdot 5\\cdot 20=200\\pi$ cm². Obsah jedné podstavy $S_{p}=\\pi r^{2}=25\\pi$ cm². Poměr $200\\pi:25\\pi=8$.'},
  'C) 8krát',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2022 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Když firma odvezla do spalovny $60\\,\\%$ odpadu, zbylo jí ještě $1\\,200$ kg odpadu. Kolik kg odpadu firma odvezla do spalovny?','15.2 Stejné dlaždice byly umístěny ve stejném počtu na dvou paletách. Již se prodaly dvě pětiny dlaždic z první palety a $10\\,\\%$ dlaždic z druhé palety. Hmotnost všech těchto prodaných dlaždic byla $750$ kg. Kolik kg váží dosud neprodané dlaždice z obou palet?','15.3 Ve sběrných surovinách vykoupili v létě $1\\,500$ kg kovů, což je o $50\\,\\%$ více než na jaře a o $50\\,\\%$ méně než na podzim. O kolik kg kovů vykoupili na podzim více než na jaře?'},
  new List<String>{'A) $1\\,500$ kg','B) $1\\,800$ kg','C) $2\\,000$ kg','D) $2\\,100$ kg','E) $2\\,250$ kg','F) jiný počet kg'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Zbylých $1\\,200$ kg je $40\\,\\%$ odpadu, celý odpad $\\dfrac{1\\,200}{0{,}4}=3\\,000$ kg; odvezeno $60\\,\\%$, tj. $1\\,800$ kg → B.','15.2 Prodáno $\\dfrac{2}{5}+\\dfrac{1}{10}=\\dfrac{1}{2}$ obsahu jedné palety $=750$ kg, jedna paleta váží $1\\,500$ kg, obě $3\\,000$ kg. Neprodané $3\\,000-750=2\\,250$ kg → E.','15.3 Jaro $\\dfrac{1\\,500}{1{,}5}=1\\,000$ kg, podzim $\\dfrac{1\\,500}{0{,}5}=3\\,000$ kg. Rozdíl $3\\,000-1\\,000=2\\,000$ kg → C.'},
  '15.1: B ($1\\,800$ kg); 15.2: E ($2\\,250$ kg); 15.3: C ($2\\,000$ kg)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
