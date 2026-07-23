String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD25C0T02';
Integer YEAR = 2025;

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
  'CERMAT M9B 2025 - uloha 11',
  new List<String>{'V zahrade se pestuje 6 druhu rostlin. Diagram udava, jakou cast osazene plochy zahrady zabiraji jednotlive druhy rostlin; v kazde casti se pestuje pouze jeden druh. Magnolie zabiraji plochu o rozloze 20 m^2. U nekterych vyseci je uvedena velikost prislusneho uhlu.','Rozhodnete o kazdem z nasledujicich tvrzeni (11.1-11.3), zda je pravdive (A), ci nikoli (N).','11.1 Jablone zabiraji o 15 m^2 vetsi plochu, nez zabiraji magnolie.','11.2 Levandule a bazalka dohromady zabiraji 1,5krat vetsi plochu nez hortenzie.','11.3 Ruze zabiraji plochu mensi nez 30 m^2.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 470 300" font-family="sans-serif"><path d="M 150 150 L 150.0 32.0 A 118 118 0 0 1 180.5 36.0 Z" fill="#111111" stroke="#000"/><text x="159.9" y="75.1" font-size="11" text-anchor="middle">15 st.</text><path d="M 150 150 L 180.5 36.0 A 118 118 0 0 1 264.0 119.5 Z" fill="#d9d9d9" stroke="#000"/><text x="203.4" y="96.6" font-size="11" text-anchor="middle">60 st.</text><path d="M 150 150 L 264.0 119.5 A 118 118 0 0 1 150.0 268.0 Z" fill="#8f8f8f" stroke="#000"/><text x="209.9" y="196.0" font-size="11" text-anchor="middle">105 st.</text><path d="M 150 150 L 150.0 268.0 A 118 118 0 0 1 32.0 150.0 Z" fill="#b7b7b7" stroke="#000"/><text x="96.6" y="203.4" font-size="11" text-anchor="middle">90 st.</text><path d="M 150 150 L 32.0 150.0 A 118 118 0 0 1 47.8 91.0 Z" fill="#efefef" stroke="#000"/><text x="77.1" y="130.5" font-size="11" text-anchor="middle">30 st.</text><path d="M 150 150 L 47.8 91.0 A 118 118 0 0 1 150.0 32.0 Z" fill="#fbfbfb" stroke="#000"/><text x="112.2" y="84.6" font-size="11" text-anchor="middle">60 st.</text><rect x="300" y="46" width="14" height="14" fill="#d9d9d9" stroke="#000"/><text x="320" y="58" font-size="12">Magnolie</text><rect x="300" y="74" width="14" height="14" fill="#8f8f8f" stroke="#000"/><text x="320" y="86" font-size="12">Jablon</text><rect x="300" y="102" width="14" height="14" fill="#b7b7b7" stroke="#000"/><text x="320" y="114" font-size="12">Ruze</text><rect x="300" y="130" width="14" height="14" fill="#efefef" stroke="#000"/><text x="320" y="142" font-size="12">Hortenzie</text><rect x="300" y="158" width="14" height="14" fill="#fbfbfb" stroke="#000"/><text x="320" y="170" font-size="12">Levandule</text><rect x="300" y="186" width="14" height="14" fill="#111111" stroke="#000"/><text x="320" y="198" font-size="12">Bazalka</text></svg>',
  'graf-zahrada.svg',
  'Kruhovy diagram sesti druhu rostlin s uhly vyseci; magnolie 60 stupnu, jablon 105, ruze 90, bazalka 15, hortenzie 30, levandule 60.',
  'Rozdeleni plochy zahrady (velikosti uhlu ve stupnich)',
  new List<String>{'Magnolie $60^\\circ$ odpovida $20$ m$^2$, tedy $1^\\circ=\\frac{1}{3}$ m$^2$ a cela zahrada $360^\\circ=120$ m$^2$. Jablon $105^\\circ=35$ m$^2$, ruze $90^\\circ=30$ m$^2$, levandule $60^\\circ=20$ m$^2$, hortenzie $30^\\circ=10$ m$^2$, bazalka $15^\\circ=5$ m$^2$.','11.1 $35-20=15$ m$^2$, tedy pravdive (A).','11.2 Levandule a bazalka $20+5=25$ m$^2$; $1{,}5\\cdot 10=15$ m$^2$. Protoze $25\\neq 15$, nepravdive (N).','11.3 Ruze zabiraji $30$ m$^2$, coz neni mene nez $30$ m$^2$, tedy nepravdive (N).'},
  '11.1: A; 11.2: N; 11.3: N',
  4, 6, '3',
  new List<String>{'zs2','r9','statistika','argumentace','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
