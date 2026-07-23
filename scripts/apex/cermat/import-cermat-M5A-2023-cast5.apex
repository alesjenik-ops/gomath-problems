String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD23C0T01';
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
  'CERMAT M5A 2023 – úloha 13',
  new List<String>{'Graf udává, kolik kg odpadu vytřídily tři skautské oddíly R, S a T.','Do každé neúplné věty (13.1–13.3) doplňte na vynechané místo chybějící část (A–F) tak, aby vzniklo pravdivé tvrzení.','13.1 Oddíl R vytřídil ...... méně kg papíru než oddíl S.','13.2 Oddíly S a T dohromady vytřídily ...... více kg plastu než oddíl R.','13.3 Všechny tři oddíly dohromady vytřídily ...... více kg papíru než kovů.'},
  new List<String>{'A) o šestinu','B) o pětinu','C) o čtvrtinu','D) o třetinu','E) o polovinu','F) dvakrát'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 673 270" font-family="sans-serif"><line x1="60" y1="30" x2="60" y2="204" stroke="#ccc" stroke-width="1"/><text x="60" y="220" font-size="11" text-anchor="middle">0</text><line x1="117" y1="30" x2="117" y2="204" stroke="#ccc" stroke-width="1"/><text x="117" y="220" font-size="11" text-anchor="middle">3</text><line x1="174" y1="30" x2="174" y2="204" stroke="#ccc" stroke-width="1"/><text x="174" y="220" font-size="11" text-anchor="middle">6</text><line x1="231" y1="30" x2="231" y2="204" stroke="#ccc" stroke-width="1"/><text x="231" y="220" font-size="11" text-anchor="middle">9</text><line x1="288" y1="30" x2="288" y2="204" stroke="#ccc" stroke-width="1"/><text x="288" y="220" font-size="11" text-anchor="middle">12</text><line x1="345" y1="30" x2="345" y2="204" stroke="#ccc" stroke-width="1"/><text x="345" y="220" font-size="11" text-anchor="middle">15</text><line x1="402" y1="30" x2="402" y2="204" stroke="#ccc" stroke-width="1"/><text x="402" y="220" font-size="11" text-anchor="middle">18</text><line x1="459" y1="30" x2="459" y2="204" stroke="#ccc" stroke-width="1"/><text x="459" y="220" font-size="11" text-anchor="middle">21</text><line x1="516" y1="30" x2="516" y2="204" stroke="#ccc" stroke-width="1"/><text x="516" y="220" font-size="11" text-anchor="middle">24</text><line x1="573" y1="30" x2="573" y2="204" stroke="#ccc" stroke-width="1"/><text x="573" y="220" font-size="11" text-anchor="middle">27</text><text x="307" y="238" font-size="12" text-anchor="middle">počet kg</text><rect x="60" y="30" width="114" height="34" fill="#c9c9c9" stroke="#000"/><rect x="174" y="30" width="285" height="34" fill="#ffffff" stroke="#000"/><rect x="459" y="30" width="57" height="34" fill="#555555" stroke="#000"/><text x="48" y="51.0" font-size="13" text-anchor="end" font-weight="bold">R</text><rect x="60" y="86" width="152" height="34" fill="#c9c9c9" stroke="#000"/><rect x="212" y="86" width="209" height="34" fill="#ffffff" stroke="#000"/><rect x="421" y="86" width="57" height="34" fill="#555555" stroke="#000"/><text x="48" y="107.0" font-size="13" text-anchor="end" font-weight="bold">S</text><rect x="60" y="142" width="19" height="34" fill="#c9c9c9" stroke="#000"/><rect x="79" y="142" width="171" height="34" fill="#ffffff" stroke="#000"/><rect x="250" y="142" width="76" height="34" fill="#555555" stroke="#000"/><text x="48" y="163.0" font-size="13" text-anchor="end" font-weight="bold">T</text><rect x="591" y="30" width="14" height="14" fill="#c9c9c9" stroke="#000"/><text x="611" y="42" font-size="12">papír</text><rect x="591" y="52" width="14" height="14" fill="#ffffff" stroke="#000"/><text x="611" y="64" font-size="12">plast</text><rect x="591" y="74" width="14" height="14" fill="#555555" stroke="#000"/><text x="611" y="86" font-size="12">kovy</text></svg>',
  'graf-odpad.svg',
  'Skládaný pruhový graf množství vytříděného papíru, plastu a kovů pro oddíly R, S a T.',
  'Vytříděný odpad oddílů R, S, T (kg)',
  new List<String>{'Z grafu (v kg): R papír $6$, plast $15$, kovy $3$; S papír $8$, plast $11$, kovy $3$; T papír $1$, plast $9$, kovy $4$.','13.1 R má $6$ kg papíru, S má $8$ kg; $8-6=2$ a $2$ je čtvrtina z $8$ → C (o čtvrtinu).','13.2 S a T mají plastu $11+9=20$ kg, R má $15$ kg; $20-15=5$ a $5$ je třetina z $15$ → D (o třetinu).','13.3 Papíru je celkem $6+8+1=15$ kg, kovů $3+3+4=10$ kg; $15-10=5$ a $5$ je polovina z $10$ → E (o polovinu).'},
  '13.1: C (o čtvrtinu); 13.2: D (o třetinu); 13.3: E (o polovinu)',
  5, 6, '3',
  new List<String>{'zs1','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
