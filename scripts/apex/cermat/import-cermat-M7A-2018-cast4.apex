String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M7A 2018 – úloha 10',
  new List<String>{'Čtvercová síť je tvořena čtverečky s obsahem $4$ cm². Ve čtvercové síti jsou zakresleny bílé obrazce $A$, $B$ s vrcholy v mřížových bodech (viz obrázek).','Rozhodněte o každém z následujících tvrzení (10.1–10.3), zda je pravdivé (A), či nikoli (N).','10.1 Obsah obrazce $A$ je $40$ cm².','10.2 Obsah obrazce $B$ je třikrát menší než obsah obrazce $A$.','10.3 Obvod obrazce $B$ je o $8$ cm menší než obvod obrazce $A$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 332 286" font-family="sans-serif" font-size="15"><line x1="30" y1="20" x2="30" y2="258" stroke="#777"/><line x1="64" y1="20" x2="64" y2="258" stroke="#777"/><line x1="98" y1="20" x2="98" y2="258" stroke="#777"/><line x1="132" y1="20" x2="132" y2="258" stroke="#777"/><line x1="166" y1="20" x2="166" y2="258" stroke="#777"/><line x1="200" y1="20" x2="200" y2="258" stroke="#777"/><line x1="234" y1="20" x2="234" y2="258" stroke="#777"/><line x1="268" y1="20" x2="268" y2="258" stroke="#777"/><line x1="302" y1="20" x2="302" y2="258" stroke="#777"/><line x1="30" y1="20" x2="302" y2="20" stroke="#777"/><line x1="30" y1="54" x2="302" y2="54" stroke="#777"/><line x1="30" y1="88" x2="302" y2="88" stroke="#777"/><line x1="30" y1="122" x2="302" y2="122" stroke="#777"/><line x1="30" y1="156" x2="302" y2="156" stroke="#777"/><line x1="30" y1="190" x2="302" y2="190" stroke="#777"/><line x1="30" y1="224" x2="302" y2="224" stroke="#777"/><line x1="30" y1="258" x2="302" y2="258" stroke="#777"/><rect x="268" y="224" width="34" height="34" fill="#b9b9b9" stroke="#000"/><polygon points="30,54 234,54 132,156 64,156" fill="#ffffff" stroke="#000" stroke-width="2.2"/><polygon points="234,54 302,54 200,190" fill="#ffffff" stroke="#000" stroke-width="2.2"/><text x="98" y="94" font-weight="bold">A</text><text x="242" y="88" font-weight="bold">B</text><text x="285" y="278" text-anchor="middle" font-size="12">4 cm&#178;</text></svg>',
  'sit-AB.svg',
  'Čtvercová síť 8 krát 7 čtverečků s bílými obrazci A (čtyřúhelník vlevo) a B (úzký trojúhelník vpravo); vpravo dole je vyznačen čtvereček o obsahu 4 cm².',
  'Bílé obrazce A a B ve čtvercové síti',
  new List<String>{'Jeden čtvereček má obsah $4$ cm² (strana $2$ cm). Obrazec $A$ zabírá $12$ čtverečků, tj. $12\\cdot 4=48$ cm²; obrazec $B$ zabírá $4$ čtverečky, tj. $4\\cdot 4=16$ cm².','10.1 Obsah obrazce $A$ je $48$ cm², nikoli $40$ cm² → Ne.','10.2 Platí $48:16=3$, obsah obrazce $B$ je třikrát menší než obsah obrazce $A$ → Ano.','10.3 Obvody obou obrazců určíme z obrázku (strana čtverečku měří $2$ cm); obvod obrazce $B$ je o $8$ cm menší než obvod obrazce $A$ → Ano.'},
  '10.1: Ne; 10.2: Ano; 10.3: Ano',
  4, 6, '3',
  new List<String>{'zs2','r7','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2018 – úloha 11',
  new List<String>{'V $7$ h začalo pršet. Dešťová voda stékala ze střechy do jímky s dutinou tvaru kvádru. Kvádr má podstavu o rozměrech $50$ cm $\\times 40$ cm a výšku $70$ cm. Před deštěm sahala voda v jímce do výšky $10$ cm. Při dešti se za každou minutu objem vody v jímce zvětšil o $5$ litrů.','Kdy začala jímka přetékat?'},
  new List<String>{'A) v 7 h 20 min','B) v 7 h 24 min','C) v 7 h 28 min','D) v 7 h 30 min','E) v jiném okamžiku'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Jímka je plná při výšce $70$ cm; doplnit je třeba $70-10=60$ cm. Objem $=50\\cdot 40\\cdot 60=120\\,000$ cm³ $=120$ litrů. Při přírůstku $5$ litrů za minutu to trvá $120:5=24$ minut, tedy jímka začala přetékat v $7$ h $24$ min.'},
  'B) v 7 h 24 min',
  2, 4, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
