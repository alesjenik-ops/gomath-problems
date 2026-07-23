String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD23C0T01';
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
  'CERMAT M5A 2023 – úloha 7.2 (konstrukce)',
  new List<String>{'V rovině leží body $K$, $S$ a přímka $p$ procházející bodem $S$ (viz obrázek).','Bod $K$ je vrchol obdélníku $KLMN$. Bod $S$ je střed strany $KL$ tohoto obdélníku. Přímka $p$ prochází středem $S$ strany $KL$ a středem ještě jedné strany obdélníku $KLMN$.','Sestrojte vrcholy $L$, $M$, $N$ obdélníku $KLMN$, označte je písmeny a obdélník narýsujte. Najděte všechna řešení.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 340" font-family="sans-serif"> <line x1="40" y1="290" x2="420" y2="120" stroke="#000" stroke-width="2"/><text x="426" y="120" font-size="16" font-style="italic">p</text> <text x="234" y="205" font-size="15">×</text><text x="244" y="216" font-size="15" font-style="italic">S</text> <text x="196" y="253" font-size="15">×</text><text x="206" y="266" font-size="15" font-style="italic">K</text> </svg>',
  'body-KS-p.svg',
  'Body K a S a přímka p procházející bodem S.',
  'Výchozí obrázek k úloze 7.2',
  new List<String>{'Vrchol $L$ je obrazem bodu $K$ ve středové souměrnosti se středem $S$ (protože $S$ je střed strany $KL$); strana $KL$ je tím dána. V bodech $K$ a $L$ vztyčíme kolmice ke straně $KL$. Přímka $p$ prochází i středem sousední strany: její průsečík s kolmicí v bodě $L$ je střed strany $LM$ (jedno řešení), její průsečík s kolmicí v bodě $K$ je střed strany $NK$ (druhé řešení). Zbývající vrcholy doplníme. Úloha má dvě řešení.'},
  'Dvě řešení: $L$ je obraz $K$ ve středové souměrnosti podle $S$; obdélník se dourčí tak, aby přímka $p$ procházela středem strany $LM$, resp. $NK$ (viz obrázek v klíči).',
  3, 7, '4',
  new List<String>{'zs1','konstrukce','porozumeni','konstrukcni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 8',
  new List<String>{'Desetiúhelník na obrázku se skládá z jednoho rovnostranného trojúhelníku, pěti stejných čtverců, jednoho šedého obdélníku a dvou stejných šedých trojúhelníků. Nejkratší strana desetiúhelníku měří 4 cm, nejdelší 20 cm.','Rozhodněte o každém z následujících tvrzení 8.1–8.3, zda je pravdivé (A), či nikoli (N).','8.1 Obvod rovnostranného trojúhelníku je 12 cm.','8.2 Obvod šedého obdélníku je 56 cm.','8.3 Obvod šedého trojúhelníku je větší než 50 cm.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 320" font-family="sans-serif"> <polygon points="150,45 320,225 150,225" fill="#b9b9b9" stroke="#000"/> <rect x="110" y="225" width="130" height="55" fill="#b9b9b9" stroke="#000"/> <rect x="150" y="145" width="40" height="40" fill="#fff" stroke="#000"/> <rect x="150" y="185" width="40" height="40" fill="#fff" stroke="#000"/> <rect x="150" y="225" width="40" height="40" fill="#fff" stroke="#000"/> <rect x="72" y="112" width="40" height="40" fill="#fff" stroke="#000"/> <polygon points="72,112 112,112 92,77" fill="#fff" stroke="#000"/> <text x="252" y="150" font-size="11" fill="#333">šedý obrazec</text> </svg>',
  'desetiuhelnik.svg',
  'Desetiúhelník složený z rovnostranného trojúhelníku, pěti čtverců, šedého obdélníku a dvou šedých trojúhelníků (schematicky).',
  'Schematický nákres desetiúhelníku',
  new List<String>{'Strana čtverce je nejkratší strana, tj. $4$ cm. Rovnostranný trojúhelník má stranu $8$ cm, šedý obdélník rozměry $20$ cm a $8$ cm, šedý trojúhelník je pravoúhlý s odvěsnami $12$ cm a $16$ cm a přeponou $20$ cm.','8.1 Obvod rovnostranného trojúhelníku je $3\\cdot 8=24$ cm, ne $12$ cm, tvrzení je nepravdivé → N.','8.2 Obvod šedého obdélníku je $2\\cdot(20+8)=56$ cm → A.','8.3 Obvod šedého trojúhelníku je $12+16+20=48$ cm, což není více než $50$ cm → N.'},
  '8.1: N; 8.2: A; 8.3: N',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','argumentace','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5A 2023 – úloha 9',
  new List<String>{'Maminka koupila v cukrárně tři různé zákusky. První zákusek stál 72 korun. Druhý zákusek byl o čtvrtinu levnější než první. Cena třetího zákusku byla třetinou celkové ceny všech tří zákusků.','O kolik korun byl třetí zákusek dražší než druhý?'},
  new List<String>{'A) o méně než 12 korun','B) o 12 korun','C) o 15 korun','D) o 18 korun','E) o více než 18 korun'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'Druhý zákusek: $72\\cdot\\tfrac{3}{4}=54$ korun. Třetí je třetina celku, tedy první a druhý tvoří dvě třetiny: $72+54=126$ korun je $\\tfrac{2}{3}$ celku, celek $=189$ korun, třetí $=189:3=63$ korun. Rozdíl $63-54=9$ korun, což je méně než 12.'},
  'A) o méně než 12 korun',
  2, 3, '3',
  new List<String>{'zs1','aritmetika','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
