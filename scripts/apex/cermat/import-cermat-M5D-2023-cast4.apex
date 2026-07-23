String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD23C0T04';
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
  'CERMAT M5D 2023 – úloha 7.1 (konstrukce)',
  new List<String>{'V rovině leží body $P$, $Q$, $R$ a přímka $a$ (viz obrázek).','Na přímce $a$ leží strana $AB$ čtverce $ABCD$. Dva ze tří bodů $P$, $Q$, $R$ leží uvnitř dvou různých stran tohoto čtverce a třetí bod leží vně čtverce $ABCD$.','Sestrojte všechny vrcholy čtverce $ABCD$, označte je písmeny a čtverec narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 270" font-family="sans-serif"> <line x1="50" y1="200" x2="410" y2="238" stroke="#000" stroke-width="2"/> <text x="58" y="192" font-size="15" font-style="italic">a</text> <text x="207" y="108" font-size="15" font-style="italic">Q</text><text x="205" y="123" font-size="14">x</text> <text x="168" y="150" font-size="15" font-style="italic">P</text><text x="182" y="150" font-size="14">x</text> <text x="330" y="168" font-size="14">x</text><text x="342" y="168" font-size="15" font-style="italic">R</text> </svg>',
  'body-pqr-a.svg',
  'Body P, Q, R a přímka a v rovině.',
  'Výchozí obrázek k úloze 7.1',
  new List<String>{'Strana $AB$ leží na přímce $a$, strany $BC$ a $AD$ jsou k ní kolmé, strana $CD$ je s ní rovnoběžná. Dva ze zadaných bodů leží na stranách čtverce, třetí vně. Sestrojíme kolmice k přímce $a$ a rovnoběžky s ní procházející danými body; jejich průsečíky určí vrcholy čtverce. Úloha má dvě řešení, čtverce $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ (viz obrázek v klíči).'},
  'Dvě řešení – čtverce $A_1B_1C_1D_1$ a $A_2B_2C_2D_2$ se stranou $AB$ na přímce $a$ (viz obrázek v klíči).',
  3, 7, '3',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2023 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží úsečka $KL$ a bod $U$ (viz obrázek).','Úsečka $KL$ je strana trojúhelníku $KLM$. Jedna ze dvou zbývajících stran tohoto trojúhelníku má stejnou délku jako strana $KL$ a druhá z nich prochází bodem $U$.','Sestrojte vrchol $M$ trojúhelníku $KLM$, označte ho písmenem a trojúhelník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 270" font-family="sans-serif"> <line x1="145" y1="225" x2="315" y2="80" stroke="#000" stroke-width="2"/> <text x="322" y="78" font-size="15" font-style="italic">K</text> <text x="126" y="236" font-size="15" font-style="italic">L</text> <text x="238" y="158" font-size="15" font-style="italic">U</text><text x="250" y="160" font-size="14">x</text> </svg>',
  'usecka-kl-u.svg',
  'Úsečka KL a bod U v rovině.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Vrchol $M$ leží na kružnici se středem v jednom krajním bodě úsečky $KL$ a poloměrem $|KL|$ (rovnost délek stran) a zároveň na přímce procházející druhým krajním bodem a bodem $U$. Pro střed $K$ je $M$ průsečík kružnice $k(K;|KL|)$ s přímkou $LU$, pro střed $L$ průsečík kružnice $k(L;|KL|)$ s přímkou $KU$. Odtud dvě řešení $M_1$ a $M_2$ (viz obrázek v klíči).'},
  'Dvě řešení $M_1$, $M_2$: $M$ na kružnici $k(K;|KL|)$, resp. $k(L;|KL|)$, a na přímce $LU$, resp. $KU$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
