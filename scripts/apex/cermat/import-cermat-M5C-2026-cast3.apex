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
  'CERMAT M5C 2026 – úloha 5',
  new List<String>{'Na obrázku je plánek pozemku. Plánek je rozdělen čtvercovou sítí a obsahuje obrazce, které představují půdorysy tří objektů – bazénu, šaten a dětského hřiště. Všechny tyto obrazce mají vrcholy v mřížových bodech sítě. Jeden čtvereček čtvercové sítě v plánku představuje ve skutečnosti čtverec o obsahu 9 m².','5.1 Vypočtěte v m² skutečný obsah půdorysu objektu, který zabírá na pozemku největší plochu.','5.2 Vypočtěte v m² obsah celé části pozemku, která není obsazena žádným ze tří uvedených objektů.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 350 228" font-family="sans-serif"><line x1="20" y1="24" x2="20" y2="204" stroke="#bbb"/><line x1="50" y1="24" x2="50" y2="204" stroke="#bbb"/><line x1="80" y1="24" x2="80" y2="204" stroke="#bbb"/><line x1="110" y1="24" x2="110" y2="204" stroke="#bbb"/><line x1="140" y1="24" x2="140" y2="204" stroke="#bbb"/><line x1="170" y1="24" x2="170" y2="204" stroke="#bbb"/><line x1="200" y1="24" x2="200" y2="204" stroke="#bbb"/><line x1="230" y1="24" x2="230" y2="204" stroke="#bbb"/><line x1="260" y1="24" x2="260" y2="204" stroke="#bbb"/><line x1="20" y1="24" x2="260" y2="24" stroke="#bbb"/><line x1="20" y1="54" x2="260" y2="54" stroke="#bbb"/><line x1="20" y1="84" x2="260" y2="84" stroke="#bbb"/><line x1="20" y1="114" x2="260" y2="114" stroke="#bbb"/><line x1="20" y1="144" x2="260" y2="144" stroke="#bbb"/><line x1="20" y1="174" x2="260" y2="174" stroke="#bbb"/><line x1="20" y1="204" x2="260" y2="204" stroke="#bbb"/><rect x="20" y="24" width="240" height="180" fill="none" stroke="#000"/><polygon points="20,54 110,84 110,114 20,144" fill="#d0d0d0" stroke="#000"/><text x="28" y="110" font-size="12">Bazén</text><rect x="170" y="24" width="60" height="30" fill="#9a9a9a" stroke="#000"/><text x="176" y="45" font-size="11">Šatny</text><polygon points="134,99 176,99 191,114 191,156 176,171 134,171 119,156 119,114" fill="#efefef" stroke="#000"/><text x="155" y="133" font-size="10" text-anchor="middle">Dětské</text><text x="155" y="145" font-size="10" text-anchor="middle">hřiště</text><line x1="300" y1="159" x2="264" y2="159" stroke="#000"/><polygon points="264,159 274,155 274,163" fill="#000"/><text x="304" y="163" font-size="12">9 m²</text></svg>',
  'planek.svg',
  'Plánek pozemku ve čtvercové síti s bazénem, šatnami a dětským hřištěm.',
  'Schematický nákres (jeden čtvereček = 9 m²)',
  new List<String>{'Jeden čtvereček má obsah $9$ m².','5.1 Objekt s největší plochou zabírá $8$ čtverečků, tj. $8\\cdot 9 = 72$ m².','5.2 Volná část pozemku zabírá $27$ čtverečků, tj. $27\\cdot 9 = 243$ m².'},
  '5.1: $72$ m²; 5.2: $243$ m²',
  4, 5, '3',
  new List<String>{'zs1','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
