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
  'CERMAT M5D 2026 – úloha 13',
  new List<String>{'Každý vyplněný diagram obsahuje čtyři čísla, která splňují následující podmínky: v bílém čtverci je součet čísel zapsaných v šedých kroužcích; v bílém trojúhelníku je rozdíl čísel v šedých kroužcích (menšitel je vždy ve spodním kroužku). Vzor: horní kroužek $9$, spodní kroužek $2$, čtverec $11$, trojúhelník $7$.','Přiřaďte ke každému diagramu (13.1–13.3) číslo (A–F), které v diagramu patří na místo otazníku.'},
  new List<String>{'A) $1$','B) $3$','C) $5$','D) $7$','E) $9$','F) $10$'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 180" font-family="sans-serif"><text x="95" y="33" font-size="12" text-anchor="middle">VZOR</text><path d="M43,95 Q67,43 95,55" fill="none" stroke="#000"/><path d="M95,55 Q123,43 147,95" fill="none" stroke="#000"/><path d="M147,95 Q123,147 95,135" fill="none" stroke="#000"/><path d="M95,135 Q67,147 43,95" fill="none" stroke="#000"/><rect x="28" y="80" width="30" height="30" fill="#fff" stroke="#000"/><text x="43" y="100" font-size="13" text-anchor="middle">11</text><circle cx="95" cy="55" r="15" fill="#c9c9c9" stroke="#000"/><text x="95" y="60" font-size="13" text-anchor="middle">9</text><polygon points="133,80 163,95 133,110" fill="#fff" stroke="#000"/><text x="144" y="100" font-size="13" text-anchor="middle">7</text><circle cx="95" cy="135" r="15" fill="#c9c9c9" stroke="#000"/><text x="95" y="140" font-size="13" text-anchor="middle">2</text><text x="255" y="33" font-size="12" text-anchor="middle">13.1</text><path d="M203,95 Q227,43 255,55" fill="none" stroke="#000"/><path d="M255,55 Q283,43 307,95" fill="none" stroke="#000"/><path d="M307,95 Q283,147 255,135" fill="none" stroke="#000"/><path d="M255,135 Q227,147 203,95" fill="none" stroke="#000"/><rect x="188" y="80" width="30" height="30" fill="#fff" stroke="#000"/><text x="203" y="100" font-size="13" text-anchor="middle">23</text><circle cx="255" cy="55" r="15" fill="#c9c9c9" stroke="#000"/><text x="255" y="60" font-size="13" text-anchor="middle">16</text><polygon points="293,80 323,95 293,110" fill="#fff" stroke="#000"/><text x="304" y="100" font-size="13" text-anchor="middle">?</text><circle cx="255" cy="135" r="15" fill="#c9c9c9" stroke="#000"/><text x="255" y="140" font-size="13" text-anchor="middle"></text><text x="415" y="33" font-size="12" text-anchor="middle">13.2</text><path d="M363,95 Q387,43 415,55" fill="none" stroke="#000"/><path d="M415,55 Q443,43 467,95" fill="none" stroke="#000"/><path d="M467,95 Q443,147 415,135" fill="none" stroke="#000"/><path d="M415,135 Q387,147 363,95" fill="none" stroke="#000"/><rect x="348" y="80" width="30" height="30" fill="#fff" stroke="#000"/><text x="363" y="100" font-size="13" text-anchor="middle">16</text><circle cx="415" cy="55" r="15" fill="#c9c9c9" stroke="#000"/><text x="415" y="60" font-size="13" text-anchor="middle"></text><polygon points="453,80 483,95 453,110" fill="#fff" stroke="#000"/><text x="464" y="100" font-size="13" text-anchor="middle">14</text><circle cx="415" cy="135" r="15" fill="#c9c9c9" stroke="#000"/><text x="415" y="140" font-size="13" text-anchor="middle">?</text><text x="575" y="33" font-size="12" text-anchor="middle">13.3</text><path d="M523,95 Q547,43 575,55" fill="none" stroke="#000"/><path d="M575,55 Q603,43 627,95" fill="none" stroke="#000"/><path d="M627,95 Q603,147 575,135" fill="none" stroke="#000"/><path d="M575,135 Q547,147 523,95" fill="none" stroke="#000"/><rect x="508" y="80" width="30" height="30" fill="#fff" stroke="#000"/><text x="523" y="100" font-size="13" text-anchor="middle">5</text><circle cx="575" cy="55" r="15" fill="#c9c9c9" stroke="#000"/><text x="575" y="60" font-size="13" text-anchor="middle">?</text><polygon points="613,80 643,95 613,110" fill="#fff" stroke="#000"/><text x="624" y="100" font-size="13" text-anchor="middle">5</text><circle cx="575" cy="135" r="15" fill="#c9c9c9" stroke="#000"/><text x="575" y="140" font-size="13" text-anchor="middle"></text></svg>',
  'diagramy.svg',
  'Vzorový diagram a tři diagramy 13.1–13.3 se čtvercem, trojúhelníkem a dvěma šedými kroužky; na místě otazníku chybí číslo.',
  'Vzor a diagramy 13.1–13.3',
  new List<String>{'Podle vzoru platí: čtverec $=$ horní kroužek $+$ spodní kroužek; trojúhelník $=$ horní kroužek $-$ spodní kroužek.','13.1 Spodní kroužek $=23-16=7$; otazník (trojúhelník) $=16-7=9$ → E.','13.2 Součet kroužků je $16$ a jejich rozdíl $14$, tedy horní kroužek $=15$ a spodní kroužek (otazník) $=1$ → A.','13.3 Součet kroužků je $5$ a jejich rozdíl $5$, tedy horní kroužek (otazník) $=5$ a spodní kroužek $=0$ → C.'},
  '13.1: E ($9$); 13.2: A ($1$); 13.3: C ($5$)',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
