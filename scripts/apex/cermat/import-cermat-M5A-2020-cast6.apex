String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M5A 2020 – úloha 13',
  new List<String>{'Ve stavebnici je 18 stejných krychlí. Krychle mají na každé stěně jeden puntík. Na každé krychli jsou 2 bílé a 4 černé puntíky. Bílé puntíky jsou na krychli umístěny vždy proti sobě (buď nahoře a dole, nebo vpředu a vzadu, nebo vpravo a vlevo). Slepili jsme první a druhé těleso, každé z 6 krychlí. První těleso má na celém svém povrchu (tedy i zespodu) 26 puntíků (bílých i černých dohromady). Podle schématu slepíme ze zbývajících 6 krychlí třetí těleso.','Přiřaďte ke každé otázce (13.1–13.3) správnou odpověď (A–F).','13.1 Jaký je počet černých puntíků na povrchu prvního tělesa?','13.2 Jaký je počet černých puntíků na povrchu druhého tělesa?','13.3 Jaký je největší možný počet černých puntíků na povrchu třetího tělesa?'},
  new List<String>{'A) 17','B) 18','C) 19','D) 20','E) 21','F) jiný počet'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 130" font-family="sans-serif"> <text x="280" y="52" font-size="13" text-anchor="middle">První, druhé a třetí těleso, každé ze šesti krychlí s bílými a černými puntíky.</text> <text x="280" y="80" font-size="11" text-anchor="middle" fill="#666">Prostorová tělesa a rozmístění puntíků nelze věrně přenést; posuzuje se podle testového sešitu.</text> </svg>',
  'tri-telesa.svg',
  'Tři tělesa, každé slepené ze šesti krychlí s bílými a černými puntíky (schematická poznámka).',
  'Schematický nákres – tělesa viz testový sešit',
  new List<String>{'Každá stěna krychle nese právě jeden puntík; počet puntíků na povrchu tělesa se rovná počtu jeho vnějších stěn a černých je tolik, kolik zbude po odečtení bílých puntíků viditelných na povrchu.','13.1 Na povrchu prvního tělesa je $26$ puntíků, z nichž je $18$ černých → odpověď B.','13.2 Na povrchu druhého tělesa je $17$ černých puntíků → odpověď A.','13.3 Krychle třetího tělesa lze natočit tak, aby na povrchu zůstalo co nejméně bílých puntíků; největší možný počet černých je $20$ → odpověď D.'},
  '13.1: B (18 puntíků); 13.2: A (17 puntíků); 13.3: D (20 puntíků)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','porozumeni','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
