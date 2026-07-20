String SRC   = 'Matematika - Zelený';
String STYPE = 'Jiné';

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype){this.tx=tx;this.have=have;this.src=src;this.stype=stype;}
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
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
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
C c=new C(tx,have,SRC,STYPE);

c.add(
  'Zelený K14 – délka obrubníku',
  new List<String>{'Na obrázku je silnými čarami zvýrazněn obdélníkový travnatý pás o rozměrech $200\\times 60$ metrů. Je narušen šesti identickými kruhovými jezírky o průměru $40$ metrů.','Jaká je délka obrubníku vyznačeného na obrázku tlustou čarou? Výsledek zaokrouhlete na celé metry. ($\\pi=3{,}14$)'},
  new List<String>{'A) $520$ m','B) $617$ m','C) $657$ m','D) $1034$ m','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 500 400" font-family="sans-serif"> <path d="M50 140 L110 140 A40 40 0 0 0 190 140 L210 140 A40 40 0 0 0 290 140 L310 140 A40 40 0 0 0 390 140 L450 140 L450 260 L390 260 A40 40 0 0 0 310 260 L290 260 A40 40 0 0 0 210 260 L190 260 A40 40 0 0 0 110 260 L50 260 Z" fill="none" stroke="#000" stroke-width="3"/> <path d="M110 140 A40 40 0 0 1 190 140 M210 140 A40 40 0 0 1 290 140 M310 140 A40 40 0 0 1 390 140 M110 260 A40 40 0 0 0 190 260 M210 260 A40 40 0 0 0 290 260 M310 260 A40 40 0 0 0 390 260" fill="none" stroke="#888" stroke-width="1" stroke-dasharray="4 4"/> <line x1="50" y1="80" x2="450" y2="80" stroke="#444" stroke-width="1"/> <polygon points="50,80 58,76 58,84" fill="#444"/><polygon points="450,80 442,76 442,84" fill="#444"/> <text x="250" y="73" font-size="15" text-anchor="middle">200 m</text> <line x1="25" y1="140" x2="25" y2="260" stroke="#444" stroke-width="1"/> <polygon points="25,140 21,148 29,148" fill="#444"/><polygon points="25,260 21,252 29,252" fill="#444"/> <text x="16" y="200" font-size="14" text-anchor="middle" transform="rotate(-90 16 200)">60 m</text> <line x1="50" y1="118" x2="110" y2="118" stroke="#444" stroke-width="1"/> <text x="80" y="112" font-size="13" text-anchor="middle">30 m</text> <line x1="190" y1="118" x2="210" y2="118" stroke="#444" stroke-width="1"/> <text x="200" y="108" font-size="13" text-anchor="middle">10 m</text> <line x1="110" y1="345" x2="190" y2="345" stroke="#444" stroke-width="1"/> <polygon points="110,345 118,341 118,349" fill="#444"/><polygon points="190,345 182,341 182,349" fill="#444"/> <text x="150" y="363" font-size="13" text-anchor="middle">40 m</text> </svg>',
  'travnaty-pas.svg',
  'Obdélníkový travnatý pás 200 krát 60 metrů narušený šesti kruhovými jezírky o průměru 40 metrů, tři nahoře a tři dole; obrubník obchází jezírka po půlkružnicích.',
  'Travnatý pás s jezírky',
  new List<String>{'Rovné části: horní a dolní okraj mají po $200-3\\cdot 40=80$ m, boční strany po $60$ m. Rovně celkem $80+80+60+60=280$ m. Obrubník obchází $6$ půlkružnic o průměru $40$ m: $6\\cdot\\frac{1}{2}\\cdot\\pi\\cdot 40=120\\pi=120\\cdot 3{,}14=376{,}8$ m. Celkem $280+376{,}8=656{,}8\\doteq 657$ m.'},
  'C) $657$ m',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);
c.add(
  'Zelený K15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Po Vánocích zlevnil vytoužený mobil o šest stovek a v únoru ještě o $10\\,\\%$. Teď jej koupím za $4050$ Kč. Kolik korun stál mobil o Vánocích?','15.2 Akcie naší společnosti za posledních $5$ let ztratily čtvrtinu své hodnoty, ale za poslední týden se cena zvýšila o plnou třetinu na $4800$ Kč. Kolik korun stála jedna akcie před $5$ lety?','15.3 V nádobě je $1{,}3$ litru $20\\,\\%$ roztoku kyseliny solné. Chceme zvýšit koncentraci na $50\\,\\%$ a máme k dispozici $60\\,\\%$ roztok téže kyseliny. Kolik ml výsledného $50\\,\\%$ roztoku bude v nádobě?'},
  new List<String>{'A) $4800$','B) $4900$','C) $5000$','D) $5100$','E) $5200$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Před únorovým zlevněním stál mobil $4050:0{,}9=4500$ Kč, o Vánocích tedy $4500+600=5100$ Kč → D.','15.2 Po ztrátě čtvrtiny a růstu o třetinu: $\\frac{3}{4}\\cdot\\frac{4}{3}=1$, cena se nezměnila, takže před $5$ lety stála akcie $4800$ Kč → A.','15.3 Přidáme $x$ litrů $60\\,\\%$ roztoku: $1{,}3\\cdot 0{,}2+0{,}6x=(1{,}3+x)\\cdot 0{,}5$, odtud $0{,}1x=0{,}39$, $x=3{,}9$ l. Celkem $1{,}3+3{,}9=5{,}2$ l $=5200$ ml → E.'},
  '15.1: D ($5100$ Kč); 15.2: A ($4800$ Kč); 15.3: E ($5200$ ml)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
