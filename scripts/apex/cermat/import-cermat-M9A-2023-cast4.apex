String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD23C0T01';
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
  'CERMAT M9A 2023 – úloha 8',
  new List<String>{'Čtvercový pozemek má stejný obvod jako obdélníkový pozemek. Obdélníkový pozemek má jednu stranu o $25\\,\\%$ kratší než čtvercový pozemek a druhou stranu o $10$ m delší než čtvercový pozemek. Délku strany čtvercového pozemku označíme $a$.','8.1 Vyjádřete výrazem s proměnnou $a$ délku kratší strany obdélníkového pozemku.','8.2 Vypočtěte v metrech délku $a$ strany čtvercového pozemku.','8.3 Vypočtěte, o kolik m² se liší obsahy obdélníkového a čtvercového pozemku.'},
  null,
  4,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 200" font-family="sans-serif"> <rect x="40" y="45" width="110" height="110" fill="none" stroke="#000" stroke-width="2"/> <text x="95" y="105" font-size="15" text-anchor="middle" font-style="italic">a</text> <text x="95" y="175" font-size="12" text-anchor="middle">ctvercovy</text> <rect x="235" y="45" width="110" height="110" fill="none" stroke="#999" stroke-dasharray="5 4"/> <rect x="235" y="72" width="150" height="83" fill="none" stroke="#000" stroke-width="2"/> <text x="310" y="175" font-size="12" text-anchor="middle">obdelnikovy</text> </svg>',
  'pozemky.svg',
  'Čtvercový pozemek a vedle něj obdélníkový pozemek; čárkovaně je naznačen čtverec pro porovnání, obdélník má jednu stranu kratší a druhou delší než čtverec.',
  'Schematický nákres čtvercového a obdélníkového pozemku',
  new List<String>{'Kratší strana obdélníku (o $25\\,\\%$ kratší) je $0{,}75a$, delší strana je $a+10$.','8.1 Kratší strana obdélníkového pozemku má délku $0{,}75a$.','8.2 Ze shody obvodů: $4a=2\\cdot(0{,}75a+a+10)=3{,}5a+20$, odtud $0{,}5a=20$, $a=40$ m.','8.3 Rozměry obdélníku: $0{,}75\\cdot 40=30$ m a $40+10=50$ m; jeho obsah $30\\cdot 50=1500$ m². Čtverec má obsah $40^2=1600$ m². Liší se o $1600-1500=100$ m².'},
  '8.1: $0{,}75a$ (v klíči též $a-10$ m); 8.2: $a=40$ m; 8.3: o $100$ m²',
  4, 5, '3',
  new List<String>{'zs2','r9','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'CERMAT M9A 2023 – úloha 9 (konstrukce)',
  new List<String>{'V rovině leží body $A$, $C$, $M$ (viz obrázek). Body $A$, $C$ jsou vrcholy obdélníku $ABCD$. Bod $M$ leží na úhlopříčce $BD$ tohoto obdélníku.','Sestrojte vrcholy $B$, $D$ obdélníku $ABCD$, označte je písmeny a obdélník narýsujte.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 300" font-family="sans-serif"> <rect x="6" y="6" width="448" height="288" fill="none" stroke="#ccc"/> <text x="120" y="185" font-size="16" text-anchor="middle">x</text> <text x="104" y="182" font-size="15" font-style="italic">A</text> <text x="320" y="132" font-size="16" text-anchor="middle">x</text> <text x="326" y="128" font-size="15" font-style="italic">M</text> <text x="360" y="218" font-size="16" text-anchor="middle">x</text> <text x="366" y="222" font-size="15" font-style="italic">C</text> </svg>',
  'body-ACM.svg',
  'Tři body v rovině: bod A vlevo, bod M vpravo nahoře a bod C vpravo dole.',
  'Výchozí obrázek k úloze 9',
  new List<String>{'Úhlopříčky obdélníku se půlí ve společném středu $S$, který je středem úsečky $AC$; sestrojíme jej. Úhlopříčka $BD$ prochází bodem $S$ i bodem $M$, leží tedy na přímce $SM$. Protože úhlopříčky obdélníku jsou shodné, platí $|SB|=|SD|=|SA|=|SC|$. Vrcholy $B$, $D$ jsou proto průsečíky přímky $SM$ s kružnicí se středem $S$ a poloměrem $|SA|$. Doplníme obdélník $ABCD$.'},
  'Střed $S$ je střed úsečky $AC$; přímka $BD$ je přímka $SM$; vrcholy $B$, $D$ jsou průsečíky přímky $SM$ s kružnicí $k(S;|SA|)$ (viz náčrt konstrukce v klíči).',
  2, 4, '3',
  new List<String>{'zs2','r9','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
