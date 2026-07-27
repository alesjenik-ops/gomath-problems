String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD17C0T02';
Integer YEAR = 2017;

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
  'CERMAT M9B 2017 – úloha 13',
  new List<String>{'Krabici tvaru kvádru lze naplnit až po okraj krychličkami s délkou hrany 2 cm. Na dno krabice se do jedné vrstvy naskládá bez mezer 20 krychliček a takové vrstvy mohou být v krabici nejvýše 4.','Ze zcela naplněné krabice vyjmeme všechny krychličky a vytvoříme z nich jedinou řadu.','Jak dlouhá bude řada?'},
  new List<String>{'A) $0{,}8$ m','B) $1{,}6$ m','C) $2{,}0$ m','D) $2{,}4$ m','E) delší než $2{,}4$ m'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 280" font-family="sans-serif"><g stroke="#000" fill="#fff"><polygon points="40,90 80,60 240,60 200,90" fill="#f2f2f2" stroke-width="2"/><polygon points="200,90 240,60 240,180 200,210" fill="#cfcfcf" stroke-width="2"/><rect x="40" y="90" width="160" height="120" stroke-width="2"/><rect x="44" y="62" width="28" height="28"/><polygon points="44,62 56,51 84,51 72,62" fill="#f2f2f2"/><rect x="76" y="62" width="28" height="28"/><polygon points="76,62 88,51 116,51 104,62" fill="#f2f2f2"/><rect x="108" y="62" width="28" height="28"/><polygon points="108,62 120,51 148,51 136,62" fill="#f2f2f2"/><rect x="140" y="62" width="28" height="28"/><polygon points="140,62 152,51 180,51 168,62" fill="#f2f2f2"/><polygon points="168,62 180,51 180,79 168,90" fill="#e0e0e0"/><rect x="60" y="258" width="20" height="18"/><polygon points="60,258 68,250 88,250 80,258" fill="#f2f2f2"/><rect x="80" y="258" width="20" height="18"/><polygon points="80,258 88,250 108,250 100,258" fill="#f2f2f2"/><rect x="100" y="258" width="20" height="18"/><polygon points="100,258 108,250 128,250 120,258" fill="#f2f2f2"/><rect x="120" y="258" width="20" height="18"/><polygon points="120,258 128,250 148,250 140,258" fill="#f2f2f2"/><rect x="140" y="258" width="20" height="18"/><polygon points="140,258 148,250 168,250 160,258" fill="#f2f2f2"/><rect x="160" y="258" width="20" height="18"/><polygon points="160,258 168,250 188,250 180,258" fill="#f2f2f2"/><rect x="180" y="258" width="20" height="18"/><polygon points="180,258 188,250 208,250 200,258" fill="#f2f2f2"/><rect x="200" y="258" width="20" height="18"/><polygon points="200,258 208,250 228,250 220,258" fill="#f2f2f2"/><rect x="220" y="258" width="20" height="18"/><polygon points="220,258 228,250 248,250 240,258" fill="#f2f2f2"/><rect x="240" y="258" width="20" height="18"/><polygon points="240,258 248,250 268,250 260,258" fill="#f2f2f2"/><rect x="260" y="258" width="20" height="18"/><polygon points="260,258 268,250 288,250 280,258" fill="#f2f2f2"/><rect x="280" y="258" width="20" height="18"/><polygon points="280,258 288,250 308,250 300,258" fill="#f2f2f2"/></g><text x="60" y="242" font-size="13">Z naplněné krabice vytvoříme z krychliček jedinou řadu:</text><text x="308" y="274" font-size="18">...</text></svg>',
  'krabice-krychlicky.svg',
  'Krabice tvaru kvádru naplňovaná krychličkami a řada krychliček vytvořená z obsahu krabice.',
  'Krabice s krychličkami a řada krychliček',
  new List<String>{'V krabici je $20\\cdot 4=80$ krychliček.','Řada má délku $80\\cdot 2=160$ cm $=1{,}6$ m.'},
  'B) $1{,}6$ m',
  2, 3, '2',
  new List<String>{'zs2','r9','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
