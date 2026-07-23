String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD21C0T02';
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
  'CERMAT M5B 2021 – úloha 11',
  new List<String>{'Na $23$denní tábor přivezl vedoucí malým skautům $16$ sáčků po $30$ bonbonech. Během tábora dal každému malému skautovi celkem $21$ bonbonů, a zbyly mu tak už jen bonbony v posledním načatém sáčku.','Kolik bonbonů zbylo vedoucímu v posledním načatém sáčku?'},
  new List<String>{'A) 18','B) 19','C) 20','D) 21','E) 22'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Celkem $16\\cdot 30=480$ bonbonů. $480=21\\cdot 22+18$, tj. $22$ skautům dal po $21$ bonbonech (celkem $462$) a v posledním načatém sáčku zbylo $18$ bonbonů.'},
  'A) 18',
  2, 4, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M5B 2021 – úloha 12',
  new List<String>{'Ve čtvercové síti leží pět tmavých útvarů A–E. Vrcholy všech útvarů leží v mřížových bodech. Některé útvary jsou souměrné podle osy (svislé, vodorovné nebo šikmé).','Který útvar není souměrný podle žádné osy?'},
  new List<String>{'A) útvar A','B) útvar B','C) útvar C','D) útvar D','E) útvar E'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 462 139" font-family="sans-serif"><line x1="15" y1="25" x2="15" y2="121" stroke="#dcdcdc"/><line x1="31" y1="25" x2="31" y2="121" stroke="#dcdcdc"/><line x1="47" y1="25" x2="47" y2="121" stroke="#dcdcdc"/><line x1="63" y1="25" x2="63" y2="121" stroke="#dcdcdc"/><line x1="79" y1="25" x2="79" y2="121" stroke="#dcdcdc"/><line x1="95" y1="25" x2="95" y2="121" stroke="#dcdcdc"/><line x1="111" y1="25" x2="111" y2="121" stroke="#dcdcdc"/><line x1="127" y1="25" x2="127" y2="121" stroke="#dcdcdc"/><line x1="143" y1="25" x2="143" y2="121" stroke="#dcdcdc"/><line x1="159" y1="25" x2="159" y2="121" stroke="#dcdcdc"/><line x1="175" y1="25" x2="175" y2="121" stroke="#dcdcdc"/><line x1="191" y1="25" x2="191" y2="121" stroke="#dcdcdc"/><line x1="207" y1="25" x2="207" y2="121" stroke="#dcdcdc"/><line x1="223" y1="25" x2="223" y2="121" stroke="#dcdcdc"/><line x1="239" y1="25" x2="239" y2="121" stroke="#dcdcdc"/><line x1="255" y1="25" x2="255" y2="121" stroke="#dcdcdc"/><line x1="271" y1="25" x2="271" y2="121" stroke="#dcdcdc"/><line x1="287" y1="25" x2="287" y2="121" stroke="#dcdcdc"/><line x1="303" y1="25" x2="303" y2="121" stroke="#dcdcdc"/><line x1="319" y1="25" x2="319" y2="121" stroke="#dcdcdc"/><line x1="335" y1="25" x2="335" y2="121" stroke="#dcdcdc"/><line x1="351" y1="25" x2="351" y2="121" stroke="#dcdcdc"/><line x1="367" y1="25" x2="367" y2="121" stroke="#dcdcdc"/><line x1="383" y1="25" x2="383" y2="121" stroke="#dcdcdc"/><line x1="399" y1="25" x2="399" y2="121" stroke="#dcdcdc"/><line x1="415" y1="25" x2="415" y2="121" stroke="#dcdcdc"/><line x1="431" y1="25" x2="431" y2="121" stroke="#dcdcdc"/><line x1="447" y1="25" x2="447" y2="121" stroke="#dcdcdc"/><line x1="15" y1="25" x2="447" y2="25" stroke="#dcdcdc"/><line x1="15" y1="41" x2="447" y2="41" stroke="#dcdcdc"/><line x1="15" y1="57" x2="447" y2="57" stroke="#dcdcdc"/><line x1="15" y1="73" x2="447" y2="73" stroke="#dcdcdc"/><line x1="15" y1="89" x2="447" y2="89" stroke="#dcdcdc"/><line x1="15" y1="105" x2="447" y2="105" stroke="#dcdcdc"/><line x1="15" y1="121" x2="447" y2="121" stroke="#dcdcdc"/><polygon points="47,65 47,81 55,81 55,89 71,89 71,81 79,81 79,65 71,65 71,57 55,57 55,65" fill="#9a9a9a" stroke="#000"/><text x="63" y="78" font-size="12" text-anchor="middle" font-weight="bold">A</text><polygon points="127,65 127,81 135,81 135,89 151,89 151,81 159,81 159,65 151,65 151,57 135,57 135,65" fill="#9a9a9a" stroke="#000"/><text x="143" y="78" font-size="12" text-anchor="middle" font-weight="bold">B</text><polygon points="207,65 207,81 215,81 215,89 231,89 231,81 239,81 239,65 231,65 231,57 215,57 215,65" fill="#9a9a9a" stroke="#000"/><text x="223" y="78" font-size="12" text-anchor="middle" font-weight="bold">C</text><polygon points="287,65 287,81 295,81 295,89 311,89 311,81 319,81 319,65 311,65 311,57 295,57 295,65" fill="#9a9a9a" stroke="#000"/><text x="303" y="78" font-size="12" text-anchor="middle" font-weight="bold">D</text><polygon points="367,57 391,57 391,65 399,65 399,81 383,81 383,89 367,89" fill="#9a9a9a" stroke="#000"/><text x="383" y="78" font-size="12" text-anchor="middle" font-weight="bold">E</text></svg>',
  'utvary-sit.svg',
  'Pět tmavých útvarů A–E ve čtvercové síti (schematicky).',
  'Útvary A–E ve čtvercové síti',
  new List<String>{'Útvary A, B, C, D mají alespoň jednu osu souměrnosti; útvar E nemá žádnou osu souměrnosti.'},
  'E) útvar E',
  2, 3, '2',
  new List<String>{'zs1','planimetrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
