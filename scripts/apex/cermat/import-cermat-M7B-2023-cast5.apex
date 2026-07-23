String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PBD23C0T02';
Integer YEAR = 2023;

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
  'CERMAT M7B 2023 - uloha 10',
  new List<String>{'Ve ctvercove siti jsou zakresleny bile obrazce A, C, E a tmave obrazce B, D, F. Vrcholy vsech obrazcu lezi v mrizovych bodech ctvercove site.','Rozhodnete o kazdem z nasledujicich tvrzeni 10.1-10.3, zda je pravdive (Ano), ci nikoli (Ne).','10.1 Obsah obrazce B je ctvrtinou obsahu obrazce A.','10.2 Obsah obrazce C je trikrat vetsi nez obsah obrazce D.','10.3 Obsah obrazce E je o tretinu vetsi nez obsah obrazce F.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 530 144" font-family="sans-serif"><line x1="25" y1="30" x2="25" y2="110" stroke="#ccc" stroke-width="1"/><line x1="41" y1="30" x2="41" y2="110" stroke="#ccc" stroke-width="1"/><line x1="57" y1="30" x2="57" y2="110" stroke="#ccc" stroke-width="1"/><line x1="73" y1="30" x2="73" y2="110" stroke="#ccc" stroke-width="1"/><line x1="89" y1="30" x2="89" y2="110" stroke="#ccc" stroke-width="1"/><line x1="105" y1="30" x2="105" y2="110" stroke="#ccc" stroke-width="1"/><line x1="121" y1="30" x2="121" y2="110" stroke="#ccc" stroke-width="1"/><line x1="137" y1="30" x2="137" y2="110" stroke="#ccc" stroke-width="1"/><line x1="153" y1="30" x2="153" y2="110" stroke="#ccc" stroke-width="1"/><line x1="169" y1="30" x2="169" y2="110" stroke="#ccc" stroke-width="1"/><line x1="185" y1="30" x2="185" y2="110" stroke="#ccc" stroke-width="1"/><line x1="201" y1="30" x2="201" y2="110" stroke="#ccc" stroke-width="1"/><line x1="217" y1="30" x2="217" y2="110" stroke="#ccc" stroke-width="1"/><line x1="233" y1="30" x2="233" y2="110" stroke="#ccc" stroke-width="1"/><line x1="249" y1="30" x2="249" y2="110" stroke="#ccc" stroke-width="1"/><line x1="265" y1="30" x2="265" y2="110" stroke="#ccc" stroke-width="1"/><line x1="281" y1="30" x2="281" y2="110" stroke="#ccc" stroke-width="1"/><line x1="297" y1="30" x2="297" y2="110" stroke="#ccc" stroke-width="1"/><line x1="313" y1="30" x2="313" y2="110" stroke="#ccc" stroke-width="1"/><line x1="329" y1="30" x2="329" y2="110" stroke="#ccc" stroke-width="1"/><line x1="345" y1="30" x2="345" y2="110" stroke="#ccc" stroke-width="1"/><line x1="361" y1="30" x2="361" y2="110" stroke="#ccc" stroke-width="1"/><line x1="377" y1="30" x2="377" y2="110" stroke="#ccc" stroke-width="1"/><line x1="393" y1="30" x2="393" y2="110" stroke="#ccc" stroke-width="1"/><line x1="409" y1="30" x2="409" y2="110" stroke="#ccc" stroke-width="1"/><line x1="425" y1="30" x2="425" y2="110" stroke="#ccc" stroke-width="1"/><line x1="441" y1="30" x2="441" y2="110" stroke="#ccc" stroke-width="1"/><line x1="457" y1="30" x2="457" y2="110" stroke="#ccc" stroke-width="1"/><line x1="473" y1="30" x2="473" y2="110" stroke="#ccc" stroke-width="1"/><line x1="489" y1="30" x2="489" y2="110" stroke="#ccc" stroke-width="1"/><line x1="505" y1="30" x2="505" y2="110" stroke="#ccc" stroke-width="1"/><line x1="25" y1="30" x2="505" y2="30" stroke="#ccc" stroke-width="1"/><line x1="25" y1="46" x2="505" y2="46" stroke="#ccc" stroke-width="1"/><line x1="25" y1="62" x2="505" y2="62" stroke="#ccc" stroke-width="1"/><line x1="25" y1="78" x2="505" y2="78" stroke="#ccc" stroke-width="1"/><line x1="25" y1="94" x2="505" y2="94" stroke="#ccc" stroke-width="1"/><line x1="25" y1="110" x2="505" y2="110" stroke="#ccc" stroke-width="1"/><polygon points="41,46 105,46 41,78" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="57" y="59.6" font-size="11">A</text><polygon points="137,62 169,62 137,78" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/><text x="173.8" y="73.2" font-size="11">B</text><rect x="201" y="46" width="48" height="48" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="221.8" y="76.4" font-size="11">C</text><polygon points="281,46 329,46 281,78" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/><text x="285.8" y="60.4" font-size="11" fill="#fff">D</text><polygon points="361,78 425,78 361,46" fill="#fff" stroke="#000" stroke-width="1.5"/><text x="369.0" y="73.2" font-size="11">E</text><polygon points="441,78 489,78 441,46" fill="#4a4a4a" stroke="#000" stroke-width="1.5"/><text x="445.8" y="73.2" font-size="11" fill="#fff">F</text></svg>',
  'sit-obrazce.svg',
  'Ctvercova sit s bilymi obrazci A, C, E a tmavymi obrazci B, D, F.',
  'Schematicky nakres (obsahy dle klice)',
  new List<String>{'10.1 Obsahy: $S_A=4$, $S_B=1$ ctverecky; $1=\\frac{1}{4}\\cdot 4$, tvrzeni je pravdive (Ano).','10.2 Obsahy: $S_C=9$, $S_D=3$ ctverecky; $9=3\\cdot 3$, tvrzeni je pravdive (Ano).','10.3 Obsahy: $S_E=4$, $S_F=3$ ctverecky; $4=3+\\frac{1}{3}\\cdot 3$, tj. o tretinu vice, tvrzeni je pravdive (Ano).'},
  '10.1: Ano; 10.2: Ano; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
