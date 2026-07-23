String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PBD23C0T02';
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
  'CERMAT M9B 2023 – úloha 10 (konstrukce)',
  new List<String>{'V rovině leží body $C$, $Q$ a kružnice $k$ se středem $S$, která prochází bodem $C$ (viz obrázek). Bod $C$ je vrchol trojúhelníku $ABC$ s pravým úhlem při vrcholu $C$. Na kružnici $k$ leží také zbývající dva vrcholy $A$, $B$ tohoto trojúhelníku a bodem $Q$ prochází jedna jeho strana.','Sestrojte vrcholy $A$, $B$ trojúhelníku $ABC$, označte je písmeny a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif"> <rect x="4" y="4" width="352" height="312" fill="none" stroke="#bbb"/> <circle cx="180" cy="165" r="135" fill="none" stroke="#000" stroke-width="2"/> <line x1="176" y1="26" x2="184" y2="40" stroke="#000"/> <text x="172" y="24" font-size="15" font-style="italic">C</text> <text x="176" y="170" font-size="15">×</text> <text x="184" y="184" font-size="15" font-style="italic">S</text> <text x="236" y="140" font-size="15">×</text> <text x="244" y="154" font-size="15" font-style="italic">Q</text> <text x="300" y="272" font-size="15" font-style="italic">k</text> </svg>',
  'kruznice-c-q.svg',
  'Kružnice k se středem S, bod C na kružnici nahoře a bod Q uvnitř kružnice.',
  'Výchozí obrázek k úloze 10',
  new List<String>{'Protože je úhel při vrcholu $C$ pravý a všechny tři vrcholy leží na kružnici $k$, je přepona $AB$ průměrem kružnice $k$ (Thaletova věta) a prochází středem $S$. Podle toho, která strana prochází bodem $Q$, dostáváme dvě řešení: (1) bodem $Q$ prochází přepona $AB$ – sestrojíme přímku $SQ$, jejíž průsečíky s kružnicí $k$ jsou vrcholy $A$ a $B$; (2) bodem $Q$ prochází odvěsna – sestrojíme přímku $CQ$, jejíž druhý průsečík s kružnicí $k$ je jeden vrchol a druhý vrchol je s ním souměrný podle středu $S$ (druhý konec průměru).'},
  'Dvě řešení: přepona $AB$ je průměr kružnice $k$ procházející středem $S$. Buď bodem $Q$ prochází přepona ($A$, $B$ jsou průsečíky přímky $SQ$ s $k$), nebo odvěsna (jeden vrchol je druhý průsečík přímky $CQ$ s $k$, druhý vrchol je jeho obraz ve středové souměrnosti podle $S$) – viz nákres v klíči.',
  3, 7, '4',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9B 2023 – úloha 11',
  new List<String>{'Obdélník se stranami délek 8 cm a 3 cm se skládá ze čtyř shodných trojúhelníků (viz obrázek). Přemístěním trojúhelníků vznikl kosočtverec.','Rozhodněte o každém z následujících tvrzení (11.1–11.3), zda je pravdivé (A), či nikoli (N).','11.1 Obsah kosočtverce je větší než obsah obdélníku.','11.2 Strana kosočtverce měří 5 cm.','11.3 Výška kosočtverce měří 4,8 cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 170" font-family="sans-serif"> <rect x="30" y="35" width="200" height="75" fill="none" stroke="#000" stroke-width="1.8"/> <line x1="130" y1="35" x2="130" y2="110" stroke="#000" stroke-width="1.2"/> <line x1="30" y1="35" x2="130" y2="110" stroke="#000" stroke-width="1.2"/> <line x1="130" y1="110" x2="230" y2="35" stroke="#000" stroke-width="1.2"/> <text x="130" y="130" font-size="13" text-anchor="middle">8 cm</text> <text x="238" y="78" font-size="13">3 cm</text> <polygon points="330,72 410,25 490,72 410,119" fill="none" stroke="#000" stroke-width="1.8"/> <line x1="330" y1="72" x2="490" y2="72" stroke="#000" stroke-width="1.2"/> <line x1="410" y1="25" x2="410" y2="119" stroke="#000" stroke-width="1.2"/> </svg>',
  'obdelnik-kosoctverec.svg',
  'Obdélník se stranami 8 cm a 3 cm rozdělený na čtyři shodné trojúhelníky a kosočtverec s vyznačenými úhlopříčkami.',
  'Schematický nákres obdélníku a kosočtverce',
  new List<String>{'11.1 Kosočtverec vznikl pouze přemístěním trojúhelníků z obdélníku, obsah se tedy zachovává ($8\\cdot 3=24$ cm$^2$) a není větší – tvrzení není pravdivé (N).','11.2 Každý ze čtyř shodných pravoúhlých trojúhelníků má odvěsny $4$ cm a $3$ cm, přepona (a tedy strana kosočtverce) měří $\\sqrt{4^2+3^2}=5$ cm – pravdivé (A).','11.3 Ze vztahu obsah $=$ strana $\\cdot$ výška plyne $5\\cdot v=24$, tedy $v=4{,}8$ cm – pravdivé (A).'},
  '11.1: N; 11.2: A; 11.3: A',
  4, 5, '3',
  new List<String>{'zs2','r9','planimetrie','argumentace','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
