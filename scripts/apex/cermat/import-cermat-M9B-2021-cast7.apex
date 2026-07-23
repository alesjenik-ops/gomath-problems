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
  'CERMAT M9B 2021 – úloha 14',
  new List<String>{'Ve třídě 9. A je počet dívek o $4$ větší než počet chlapců. Na exkurzi se přihlásila čtvrtina dívek a polovina chlapců. Mezi přihlášenými žáky 9. A bylo dívek o $2$ méně než chlapců. Neznámou $d$ je označen počet dívek 9. A.','Ze které rovnice lze v souladu se zadáním určit počet dívek třídy 9. A?'},
  new List<String>{'A) $\\frac{d}{2}-2=\\frac{d+4}{4}$','B) $\\frac{d}{2}+2=\\frac{d-4}{4}$','C) $\\frac{d}{4}-2=\\frac{d+4}{2}$','D) $\\frac{d}{4}+2=\\frac{d-4}{2}$','E) $\\frac{d}{4}+2=\\frac{d+4}{2}$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Počet chlapců je $d-4$. Přihlášených dívek je $\\frac{d}{4}$, přihlášených chlapců $\\frac{d-4}{2}$. Přihlášených dívek je o $2$ méně než chlapců: $\\frac{d}{4}=\\frac{d-4}{2}-2$, tedy $\\frac{d}{4}+2=\\frac{d-4}{2}$.'},
  'D) $\\frac{d}{4}+2=\\frac{d-4}{2}$',
  2, 3, '3',
  new List<String>{'zs2','r9','rovnice','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9B 2021 – úloha 15',
  new List<String>{'Mezi třemi sloupy $A$, $B$, $C$ jsou uchycena lana. Délka lana uchyceného mezi dvěma sloupy je vždy o $20\\,\\%$ větší než vzdálenost těchto sloupů. Vzdálenost sloupů $A$, $B$ je $20$ m, délka lana mezi sloupy $A$, $C$ je $36$ m a vzdálenost sloupů $B$, $C$ je o $20\\,\\%$ menší než vzdálenost sloupů $A$, $B$ (viz obrázek).','Přiřaďte ke každé otázce (15.1–15.3) správnou odpověď (A–F).','15.1 Jaká je délka lana mezi sloupy $A$, $B$?','15.2 Jaká je vzdálenost sloupů $A$, $C$?','15.3 Jaká je délka lana mezi sloupy $B$, $C$?'},
  new List<String>{'A) $19{,}2$ m','B) $20$ m','C) $24$ m','D) $28{,}8$ m','E) $30$ m','F) jiná'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 320" font-family="sans-serif"> <line x1="40" y1="290" x2="490" y2="290" stroke="#999" stroke-width="1"/> <line x1="110" y1="170" x2="110" y2="290" stroke="#000" stroke-width="3"/> <line x1="300" y1="205" x2="300" y2="290" stroke="#000" stroke-width="3"/> <line x1="440" y1="110" x2="440" y2="290" stroke="#000" stroke-width="3"/> <line x1="110" y1="170" x2="300" y2="205" stroke="#000" stroke-width="1.5"/> <line x1="300" y1="205" x2="440" y2="110" stroke="#000" stroke-width="1.5"/> <line x1="110" y1="170" x2="440" y2="110" stroke="#000" stroke-width="1.5"/> <text x="98" y="162" font-size="15" font-weight="bold">A</text> <text x="292" y="226" font-size="15" font-weight="bold">B</text> <text x="448" y="104" font-size="15" font-weight="bold">C</text> <text x="188" y="205" font-size="13">20 m</text> <text x="252" y="138" font-size="13">36 m</text> </svg>',
  'sloupy-lana.svg',
  'Tři sloupy A, B, C spojené lany; vyznačena vzdálenost A–B 20 m a délka lana A–C 36 m.',
  'Sloupy A, B, C s lany',
  new List<String>{'15.1 Lano $AB$ je o $20\\,\\%$ delší než vzdálenost $20$ m: $20\\cdot 1{,}2=24$ m → C.','15.2 Lano $AC$ měří $36$ m a je o $20\\,\\%$ delší než vzdálenost $AC$: vzdálenost $=36:1{,}2=30$ m → E.','15.3 Vzdálenost $BC=20\\cdot 0{,}8=16$ m, lano $BC=16\\cdot 1{,}2=19{,}2$ m → A.'},
  '15.1: C ($24$ m); 15.2: E ($30$ m); 15.3: A ($19{,}2$ m)',
  6, 6, '3',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
