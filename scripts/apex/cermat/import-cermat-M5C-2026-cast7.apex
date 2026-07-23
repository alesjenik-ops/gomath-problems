String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD26C0T03';
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
  'CERMAT M5C 2026 – úloha 9',
  new List<String>{'Do příslušného pole tabulky patří vždy součin kladného celého čísla uvedeného ve stejném řádku vlevo a kladného celého čísla uvedeného ve stejném sloupci nahoře (viz vzor).','Které číslo patří do tabulky vpravo na místo otazníku?'},
  new List<String>{'A) 42','B) 48','C) 54','D) 60','E) 81'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 510 214" font-family="sans-serif"><text x="115" y="34" font-size="12" text-anchor="middle">Vzor pro násobení</text><text x="375" y="34" font-size="12" text-anchor="middle">Násobení</text><rect x="20" y="44" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="70" y="44" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="120" y="44" width="60" height="30" fill="#d9d9d9" stroke="#000"/><text x="150.0" y="63.0" font-size="12" text-anchor="middle">b</text><rect x="180" y="44" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="20" y="74" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="70" y="74" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="120" y="74" width="60" height="30" fill="#d9d9d9" stroke="#000"/><rect x="180" y="74" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="20" y="104" width="50" height="30" fill="#d9d9d9" stroke="#000"/><text x="45.0" y="123.0" font-size="12" text-anchor="middle">a</text><rect x="70" y="104" width="50" height="30" fill="#d9d9d9" stroke="#000"/><rect x="120" y="104" width="60" height="30" fill="#d9d9d9" stroke="#000"/><text x="150.0" y="123.0" font-size="12" text-anchor="middle">a·b</text><rect x="180" y="104" width="50" height="30" fill="#d9d9d9" stroke="#000"/><rect x="20" y="134" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="70" y="134" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="120" y="134" width="60" height="30" fill="#d9d9d9" stroke="#000"/><rect x="180" y="134" width="50" height="30" fill="#ffffff" stroke="#000"/><rect x="270" y="44" width="52" height="30" fill="#ffffff" stroke="#000"/><rect x="322" y="44" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="364" y="44" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="406" y="44" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="448" y="44" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="270" y="74" width="52" height="30" fill="#ffffff" stroke="#000"/><rect x="322" y="74" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="364" y="74" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="406" y="74" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="427.0" y="93.0" font-size="12" text-anchor="middle">10</text><rect x="448" y="74" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="469.0" y="93.0" font-size="12" text-anchor="middle">15</text><rect x="270" y="104" width="52" height="30" fill="#ffffff" stroke="#000"/><rect x="322" y="104" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="364" y="104" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="385.0" y="123.0" font-size="12" text-anchor="middle">28</text><rect x="406" y="104" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="448" y="104" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="469.0" y="123.0" font-size="12" text-anchor="middle">21</text><rect x="270" y="134" width="52" height="30" fill="#ffffff" stroke="#000"/><rect x="322" y="134" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="343.0" y="153.0" font-size="12" text-anchor="middle">?</text><rect x="364" y="134" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="406" y="134" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="448" y="134" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="469.0" y="153.0" font-size="12" text-anchor="middle">18</text><rect x="270" y="164" width="52" height="30" fill="#ffffff" stroke="#000"/><rect x="322" y="164" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="343.0" y="183.0" font-size="12" text-anchor="middle">72</text><rect x="364" y="164" width="42" height="30" fill="#ffffff" stroke="#000"/><text x="385.0" y="183.0" font-size="12" text-anchor="middle">32</text><rect x="406" y="164" width="42" height="30" fill="#ffffff" stroke="#000"/><rect x="448" y="164" width="42" height="30" fill="#ffffff" stroke="#000"/></svg>',
  'nasobeni.svg',
  'Vzor násobící tabulky a tabulka Násobení s doplněnými součiny a otazníkem.',
  'Vzor a tabulka Násobení',
  new List<String>{'V každém poli je součin čísla vlevo v řádku a čísla nahoře ve sloupci. Z daných součinů dopočteme činitele: řádky mají činitele $5$, $7$, $6$, $8$ a sloupce $9$, $4$, $2$, $3$.','Na místě otazníku je součin $6\\cdot 9 = 54$.'},
  'C) 54',
  2, 3, '2',
  new List<String>{'zs1','aritmetika','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
