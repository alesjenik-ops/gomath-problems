String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PDD24C0T04';
Integer YEAR = 2024;

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
  'CERMAT M7D 2024 – úloha 15',
  new List<String>{'V září byla cena trička $240$ Kč.','Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V říjnu bylo toto tričko zdraženo na $300$ Kč. O kolik $\\%$ bylo v říjnu zdraženo?','15.2 V prosinci bylo toto tričko zlevněno o $90$ Kč z říjnové ceny $300$ Kč. Kolik $\\%$ činila sleva?','15.3 O kolik $\\%$ bylo tričko po prosincové slevě levnější než v září?'},
  new List<String>{'A) $12{,}5\\,\\%$','B) $25\\,\\%$','C) $30\\,\\%$','D) $32{,}5\\,\\%$','E) $37{,}5\\,\\%$','F) $40\\,\\%$'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Zdražení o $300-240=60$ Kč z $240$ Kč, tj. $\\frac{60}{240}=25\\,\\%$ → B.','15.2 Sleva $90$ Kč z $300$ Kč, tj. $\\frac{90}{300}=30\\,\\%$ → C.','15.3 Prosincová cena je $300-90=210$ Kč; oproti září ($240$ Kč) o $30$ Kč levnější, tj. $\\frac{30}{240}=12{,}5\\,\\%$ → A.'},
  '15.1: B ($25\\,\\%$); 15.2: C ($30\\,\\%$); 15.3: A ($12{,}5\\,\\%$)',
  6, 8, '3',
  new List<String>{'zs2','r7','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);
c.add(
  'CERMAT M7D 2024 – úloha 16',
  new List<String>{'Jsou dány hranoly s podstavou čtverce, trojúhelníku a kosodélníku. Všechny hranoly jsou vysoké $20$ cm. Rozměry podstav: $1.$ hranol – čtverec se stranou $a=4$ cm; $2.$ hranol – trojúhelník $a=6$ cm, $b=5$ cm, $c=5$ cm, $v_a=4$ cm; $3.$ hranol – kosodélník $a=6$ cm, $b=4$ cm, $v_a=3$ cm.','V jakém poměru jsou objemy těchto hranolů? Poměr udejte v pořadí $1.$ hranol $:2.$ hranol $:3.$ hranol.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 230" font-family="sans-serif"> <text x="90" y="28" font-size="12" text-anchor="middle">1. hranol</text> <rect x="50" y="66" width="80" height="80" fill="none" stroke="#000"/> <text x="40" y="110" font-size="13" font-style="italic" text-anchor="end">a</text> <text x="90" y="162" font-size="13" font-style="italic" text-anchor="middle">a</text> <text x="90" y="196" font-size="11" text-anchor="middle">a = 4 cm</text> <text x="290" y="28" font-size="12" text-anchor="middle">2. hranol</text> <polygon points="230,146 350,146 290,56" fill="none" stroke="#000"/> <line x1="290" y1="146" x2="290" y2="56" stroke="#000" stroke-dasharray="4 4"/> <text x="250" y="102" font-size="13" font-style="italic">c</text> <text x="324" y="102" font-size="13" font-style="italic">b</text> <text x="290" y="164" font-size="13" font-style="italic" text-anchor="middle">a</text> <text x="298" y="120" font-size="11">va</text> <text x="290" y="196" font-size="11" text-anchor="middle">a = 6, b = 5, c = 5, va = 4 cm</text> <text x="480" y="28" font-size="12" text-anchor="middle">3. hranol</text> <polygon points="430,146 510,146 540,86 460,86" fill="none" stroke="#000"/> <line x1="510" y1="146" x2="510" y2="86" stroke="#000" stroke-dasharray="4 4"/> <text x="470" y="164" font-size="13" font-style="italic" text-anchor="middle">a</text> <text x="536" y="120" font-size="13" font-style="italic">b</text> <text x="516" y="120" font-size="11">va</text> <text x="480" y="196" font-size="11" text-anchor="middle">a = 6, b = 4, va = 3 cm</text> </svg>',
  'podstavy-hranolu.svg',
  'Podstavy tří hranolů: čtverec, trojúhelník a kosodélník s vyznačenými rozměry.',
  'Podstavy hranolů (výška hranolů 20 cm)',
  new List<String>{'Všechny hranoly mají stejnou výšku $20$ cm, poměr objemů je proto roven poměru obsahů podstav.','Čtverec: $S_1=4^2=16$ cm². Trojúhelník: $S_2=\\frac{a\\cdot v_a}{2}=\\frac{6\\cdot 4}{2}=12$ cm². Kosodélník: $S_3=a\\cdot v_a=6\\cdot 3=18$ cm².','Poměr $16:12:18=8:6:9$.'},
  '$8:6:9$',
  2, 5, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
