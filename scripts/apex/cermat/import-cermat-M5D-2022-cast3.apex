String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD22C0T04';
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
  'CERMAT M5D 2022 – úloha 4',
  new List<String>{'Do prázdných kroužků a čtverečků se v souladu s uvedenými výpočty doplňují pouze celá čísla větší než 0. Horní dvě čísla se sčítají do silně ohraničeného čtverečku, každé z nich se násobí ($\\cdot 3$ vlevo, $\\cdot 4$ vpravo) a dolní dvě čísla dávají součet $43$.','Doplňte taková čísla, aby byl součet v silně ohraničeném čtverečku','4.1 v I. nákresu co nejmenší,','4.2 ve II. nákresu co největší.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 140" font-family="sans-serif"><text x="100" y="22" font-size="12" text-anchor="middle">VZOR</text><circle cx="36" cy="46" r="13" fill="none" stroke="#666"/><text x="36" y="50" font-size="12" text-anchor="middle">2</text><circle cx="80" cy="46" r="13" fill="none" stroke="#666"/><text x="80" y="50" font-size="12" text-anchor="middle">3</text><text x="58" y="51" font-size="13" text-anchor="middle">+</text><text x="102" y="51" font-size="13" text-anchor="middle">=</text><rect x="116" y="33" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/><text x="129" y="50" font-size="12" text-anchor="middle">5</text><text x="24" y="74" font-size="10">·3</text><text x="68" y="74" font-size="10">·4</text><line x1="36" y1="60" x2="36" y2="84" stroke="#000"/><line x1="80" y1="60" x2="80" y2="84" stroke="#000"/><circle cx="36" cy="100" r="13" fill="none" stroke="#666"/><text x="36" y="104" font-size="12" text-anchor="middle">6</text><circle cx="80" cy="100" r="13" fill="none" stroke="#666"/><text x="80" y="104" font-size="12" text-anchor="middle">12</text><text x="58" y="105" font-size="13" text-anchor="middle">+</text><text x="102" y="105" font-size="13" text-anchor="middle">=</text><rect x="116" y="87" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/><text x="129" y="104" font-size="12" text-anchor="middle">18</text><text x="260" y="22" font-size="12" text-anchor="middle">I. nákres</text><circle cx="196" cy="46" r="13" fill="none" stroke="#666"/><text x="196" y="50" font-size="12" text-anchor="middle"></text><circle cx="240" cy="46" r="13" fill="none" stroke="#666"/><text x="240" y="50" font-size="12" text-anchor="middle"></text><text x="218" y="51" font-size="13" text-anchor="middle">+</text><text x="262" y="51" font-size="13" text-anchor="middle">=</text><rect x="276" y="33" width="26" height="26" fill="none" stroke="#000" stroke-width="2.5"/><text x="289" y="50" font-size="12" text-anchor="middle"></text><text x="184" y="74" font-size="10">·3</text><text x="228" y="74" font-size="10">·4</text><line x1="196" y1="60" x2="196" y2="84" stroke="#000"/><line x1="240" y1="60" x2="240" y2="84" stroke="#000"/><circle cx="196" cy="100" r="13" fill="none" stroke="#666"/><text x="196" y="104" font-size="12" text-anchor="middle"></text><circle cx="240" cy="100" r="13" fill="none" stroke="#666"/><text x="240" y="104" font-size="12" text-anchor="middle"></text><text x="218" y="105" font-size="13" text-anchor="middle">+</text><text x="262" y="105" font-size="13" text-anchor="middle">=</text><rect x="276" y="87" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/><text x="289" y="104" font-size="12" text-anchor="middle">43</text><text x="420" y="22" font-size="12" text-anchor="middle">II. nákres</text><circle cx="356" cy="46" r="13" fill="none" stroke="#666"/><text x="356" y="50" font-size="12" text-anchor="middle"></text><circle cx="400" cy="46" r="13" fill="none" stroke="#666"/><text x="400" y="50" font-size="12" text-anchor="middle"></text><text x="378" y="51" font-size="13" text-anchor="middle">+</text><text x="422" y="51" font-size="13" text-anchor="middle">=</text><rect x="436" y="33" width="26" height="26" fill="none" stroke="#000" stroke-width="2.5"/><text x="449" y="50" font-size="12" text-anchor="middle"></text><text x="344" y="74" font-size="10">·3</text><text x="388" y="74" font-size="10">·4</text><line x1="356" y1="60" x2="356" y2="84" stroke="#000"/><line x1="400" y1="60" x2="400" y2="84" stroke="#000"/><circle cx="356" cy="100" r="13" fill="none" stroke="#666"/><text x="356" y="104" font-size="12" text-anchor="middle"></text><circle cx="400" cy="100" r="13" fill="none" stroke="#666"/><text x="400" y="104" font-size="12" text-anchor="middle"></text><text x="378" y="105" font-size="13" text-anchor="middle">+</text><text x="422" y="105" font-size="13" text-anchor="middle">=</text><rect x="436" y="87" width="26" height="26" fill="none" stroke="#000" stroke-width="1"/><text x="449" y="104" font-size="12" text-anchor="middle">43</text></svg>',
  'nakresy.svg',
  'Vzor a dva prázdné nákresy: nahoře dva kroužky a silně ohraničený čtvereček pro jejich součet, dole dva kroužky (trojnásobek a čtyřnásobek) se součtem 43.',
  'Vzor a nákresy I a II',
  new List<String>{'Označíme horní čísla $a$ (vlevo) a $b$ (vpravo). Dole platí $3a + 4b = 43$. Řešení v celých kladných číslech jsou $(a,b) = (1,10), (5,7), (9,4), (13,1)$, takže součet $a + b$ nabývá hodnot $11, 12, 13, 14$.','4.1 Nejmenší součet je $11$ (pro $a = 1$, $b = 10$).','4.2 Největší součet je $14$ (pro $a = 13$, $b = 1$).'},
  '4.1: $11$; 4.2: $14$',
  4, 6, '3',
  new List<String>{'zs1','aritmetika','modelovani','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
