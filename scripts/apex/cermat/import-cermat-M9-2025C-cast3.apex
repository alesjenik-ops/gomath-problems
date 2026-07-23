String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD25C0T03';
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
  'CERMAT M9C 2025 – úloha 8',
  new List<String>{'Celá podlaha chodby je vydlážděna stejnými dlaždicemi tvaru čtverce se stranou délky $20$ cm. Každá dlaždice je ozdobena čtvrtkruhem a malým kruhem (viz obrázek vlevo). Dlaždice se pokládaly pravidelně ve čtveřicích (viz obrázek vpravo), přičemž se začalo v rohu chodby celou touto čtveřicí.','8.1 Vypočtěte v cm² obsah jednoho malého kruhu. Výsledek zaokrouhlete na celé cm².','8.2 Podlaha chodby má tvar obdélníku s rozměry $2$ m a $3{,}2$ m. (Dlaždice jsou položeny těsně vedle sebe, šířku spár zanedbáváme.) Určete, o kolik se liší počet malých a velkých kruhů na podlaze chodby.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 220" font-family="sans-serif"> <rect x="40" y="30" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/> <path d="M40 30 L100 30 A60 60 0 0 1 40 90 Z" fill="#b9b9b9" stroke="#000"/> <circle cx="110" cy="112" r="30" fill="#b9b9b9" stroke="#000"/> <text x="100" y="172" font-size="12" text-anchor="middle">20 cm</text> <text x="30" y="95" font-size="12" text-anchor="middle" transform="rotate(-90 30 95)">10 cm</text> <text x="76" y="24" font-size="12" text-anchor="middle">10 cm</text> <rect x="230" y="30" width="120" height="120" fill="none" stroke="#000" stroke-width="2"/> <line x1="290" y1="30" x2="290" y2="150" stroke="#000"/> <line x1="230" y1="90" x2="350" y2="90" stroke="#000"/> <circle cx="290" cy="90" r="55" fill="#b9b9b9" stroke="#000"/> <circle cx="250" cy="50" r="18" fill="#b9b9b9" stroke="#000"/> <circle cx="330" cy="50" r="18" fill="#b9b9b9" stroke="#000"/> <circle cx="250" cy="130" r="18" fill="#b9b9b9" stroke="#000"/> <circle cx="330" cy="130" r="18" fill="#b9b9b9" stroke="#000"/> <text x="290" y="172" font-size="12" text-anchor="middle">ctverice dlazdic</text> </svg>',
  'dlazdice.svg',
  'Dlaždice tvaru čtverce 20 cm se čtvrtkruhem o poloměru 10 cm a malým kruhem; vpravo čtveřice dlaždic s velkým kruhem uprostřed a čtyřmi malými kruhy.',
  'Schematický nákres dlaždice a čtveřice',
  new List<String>{'8.1 Malý kruh má poloměr $5$ cm, jeho obsah je $\\pi\\cdot 5^2=25\\pi\\doteq 79$ cm².','8.2 Podlaha $200$ cm $\\times$ $320$ cm dá $10\\cdot 16=160$ dlaždic, tedy $160$ malých kruhů (jeden na dlaždici). Čtvrtkruhy se ve čtveřici skládají do velkých kruhů: čtveřic je $5\\cdot 8=40$, tedy $40$ velkých kruhů. Rozdíl je $160-40=120$.'},
  '8.1: $79$ cm²; 8.2: o $120$ (malých $160$, velkých $40$)',
  3, 7, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9C 2025 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $B$, $M$ a přímka $q$ (viz obrázek).','Bod $B$ je vrchol rovnoramenného trojúhelníku $ABC$ se základnou $AB$. Úsečka $BM$ je jednou z výšek tohoto trojúhelníku a bod $M$ leží na straně $AC$. Na přímce $q$ leží vrchol $A$ trojúhelníku $ABC$.','Sestrojte vrcholy $A$, $C$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <line x1="40" y1="150" x2="420" y2="150" stroke="#000" stroke-width="2"/> <text x="428" y="156" font-size="16" font-style="italic">q</text> <text x="240" y="98" font-size="14" text-anchor="middle">x</text> <text x="240" y="86" font-size="15" font-style="italic" text-anchor="middle">M</text> <text x="300" y="238" font-size="14" text-anchor="middle">x</text> <text x="300" y="252" font-size="15" font-style="italic" text-anchor="middle">B</text> </svg>',
  'body-BM-q.svg',
  'Vodorovná přímka q, bod M nad přímkou a bod B pod přímkou.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Výška $BM$ je kolmá na stranu $AC$, proto strana $AC$ leží na kolmici vedené bodem $M$ k přímce $BM$. Průsečík této kolmice s přímkou $q$ je vrchol $A$. Trojúhelník je rovnoramenný se základnou $AB$, tedy $|CA|=|CB|$; vrchol $C$ je průsečík přímky $AC$ s osou úsečky $AB$.'},
  'Konstrukce trojúhelníku $ABC$: přímka $AC$ je kolmice k $BM$ v bodě $M$, $A$ je její průsečík s $q$, $C$ leží na $AC$ a na ose úsečky $AB$ (viz obrázek v klíči).',
  3, 6, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
