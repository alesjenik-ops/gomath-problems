String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD22C0T02';
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
  'CERMAT M5B 2022 – úloha 13',
  new List<String>{'Na začátku hry si hráč vylosuje určitý počet žetonů. Během hry může žetony vyhrát, ale i prohrát. Na konci hry zjistí, kolik žetonů mu zůstalo. Následující tabulka udává některé údaje tří hráčů.','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Blance zůstala na konci hry jen třetina žetonů, které si na začátku vylosovala. Kolik žetonů Blanka během hry prohrála?','13.2 Emil si na začátku hry vylosoval o 8 žetonů více, než vyhrál během hry. Kolik žetonů si Emil vylosoval na začátku hry?','13.3 Ivana měla na konci hry o jednu šestinu žetonů více, než si vylosovala na začátku hry. Kolik žetonů si Ivana vylosovala na začátku hry?'},
  new List<String>{'A) $30$ žetonů','B) $32$ žetonů','C) $34$ žetonů','D) $36$ žetonů','E) $38$ žetonů','F) jiný počet žetonů'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 610 196" font-family="sans-serif"><line x1="10" y1="10" x2="10" y2="186" stroke="#000"/><line x1="120" y1="10" x2="120" y2="186" stroke="#000"/><line x1="240" y1="10" x2="240" y2="186" stroke="#000"/><line x1="360" y1="10" x2="360" y2="186" stroke="#000"/><line x1="480" y1="10" x2="480" y2="186" stroke="#000"/><line x1="600" y1="10" x2="600" y2="186" stroke="#000"/><line x1="10" y1="10" x2="600" y2="10" stroke="#000"/><line x1="10" y1="66" x2="600" y2="66" stroke="#000"/><line x1="10" y1="106" x2="600" y2="106" stroke="#000"/><line x1="10" y1="146" x2="600" y2="146" stroke="#000"/><line x1="10" y1="186" x2="600" y2="186" stroke="#000"/><text x="65.0" y="34" font-size="12" text-anchor="middle">Počet</text><text x="65.0" y="52" font-size="12" text-anchor="middle">žetonů</text><text x="180.0" y="34" font-size="12" text-anchor="middle">na začátku</text><text x="180.0" y="52" font-size="12" text-anchor="middle">hry</text><text x="300.0" y="34" font-size="12" text-anchor="middle">vyhraných</text><text x="300.0" y="52" font-size="12" text-anchor="middle">během hry</text><text x="420.0" y="34" font-size="12" text-anchor="middle">prohraných</text><text x="420.0" y="52" font-size="12" text-anchor="middle">během hry</text><text x="540.0" y="34" font-size="12" text-anchor="middle">na konci</text><text x="540.0" y="52" font-size="12" text-anchor="middle">hry</text><text x="18" y="90.0" font-size="13" text-anchor="start">Blanka</text><text x="180.0" y="90.0" font-size="13" text-anchor="middle">48</text><text x="300.0" y="90.0" font-size="13" text-anchor="middle">6</text><text x="18" y="130.0" font-size="13" text-anchor="start">Emil</text><text x="420.0" y="130.0" font-size="13" text-anchor="middle">0</text><text x="540.0" y="130.0" font-size="13" text-anchor="middle">52</text><text x="18" y="170.0" font-size="13" text-anchor="start">Ivana</text><text x="300.0" y="170.0" font-size="13" text-anchor="middle">18</text><text x="420.0" y="170.0" font-size="13" text-anchor="middle">12</text></svg>',
  'tabulka-zetony.svg',
  'Tabulka s údaji hráčů Blanka, Emil a Ivana o žetonech na začátku, vyhraných, prohraných a na konci hry.',
  'Údaje tří hráčů o žetonech',
  new List<String>{'13.1 Blance na konci zůstalo $\\frac{1}{3}\\cdot 48=16$ žetonů; z $48+6-$prohráno$=16$ plyne prohrála $48+6-16=38$ (E).','13.2 Emil: $52=$začátek$+$výhra a začátek$=$výhra$+8$; tedy $2\\cdot$výhra$+8=52$, výhra $22$, začátek $30$ (A).','13.3 Ivana: konec$=$začátek$+18-12=$začátek$+6$ a zároveň konec$=\\frac{7}{6}\\cdot$začátek; tedy $\\frac{1}{6}$začátku$=6$, začátek $36$ (D).'},
  '13.1: E ($38$ žetonů); 13.2: A ($30$ žetonů); 13.3: D ($36$ žetonů)',
  5, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
