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
  'Zelený C13 – obvod kruhové výseče',
  new List<String>{'Na obrázku je šedě podbarvený útvar tvaru kruhové výseče o poloměru $20$ metrů.','Jaký je obvod šedě podbarveného útvaru? Výsledek zaokrouhlete na celé metry. ($\\pi = 3{,}14$)'},
  new List<String>{'A) $104$ m','B) $123$ m','C) $124$ m','D) $134$ m','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 460 430" font-family="sans-serif"> <path d="M 240 210 L 390 210 A 150 150 0 1 0 165 340 Z" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <line x1="55" y1="210" x2="425" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="6 5"/> <line x1="330" y1="55" x2="150" y2="365" stroke="#000" stroke-width="1" stroke-dasharray="6 5"/> <line x1="240" y1="210" x2="134" y2="104" stroke="#000" stroke-width="1.5"/> <polygon points="134,104 145,110 128,118" fill="#000"/> <text x="188" y="150" font-size="16" transform="rotate(-45 188 150)">20 m</text> <text x="152" y="300" font-size="16" font-weight="bold">60°</text> </svg>',
  'kruhova-vysec.svg',
  'Šedě podbarvená kruhová výseč o poloměru 20 m; vynechaná bílá výseč svírá s vodorovným průměrem úhel 60°.',
  'Schematický nákres k úloze 13',
  new List<String>{'Průměry svírají úhel $60^\\circ$; vynechaná bílá výseč má středový úhel $180^\\circ - 60^\\circ = 120^\\circ$, šedá výseč tedy $360^\\circ - 120^\\circ = 240^\\circ$.','Obvod = dva poloměry + délka oblouku: $2 \\cdot 20 + \\dfrac{240}{360} \\cdot 2 \\cdot 3{,}14 \\cdot 20 = 40 + 83{,}73 \\doteq 124$ m.'},
  'C) $124$ m',
  2, 5, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C14 – kruh vepsaný do čtverce',
  new List<String>{'Na obrázku je kruh vepsaný do čtverce.','Vyjádřete v procentech podíl, který z obsahu čtverce zabírá obsah kruhu do čtverce vepsaného.'},
  new List<String>{'A) $62{,}5\\,\\%$','B) $72{,}5\\,\\%$','C) $78{,}5\\,\\%$','D) $89{,}2\\,\\%$','E) jiný výsledek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 360 360" font-family="sans-serif"> <rect x="40" y="40" width="280" height="280" fill="#c9c9c9" stroke="#000" stroke-width="2"/> <circle cx="180" cy="180" r="140" fill="#ffffff" stroke="#000" stroke-width="2"/> </svg>',
  'kruh-ctverec.svg',
  'Kruh vepsaný do čtverce; kruh se dotýká všech čtyř stran čtverce.',
  'Kruh vepsaný do čtverce',
  new List<String>{'Je-li strana čtverce $a$, poloměr vepsaného kruhu je $r = \\dfrac{a}{2}$.','Podíl $= \\dfrac{\\pi r^2}{a^2} = \\dfrac{\\pi \\left(\\frac{a}{2}\\right)^2}{a^2} = \\dfrac{\\pi}{4} = \\dfrac{3{,}14}{4} = 0{,}785 = 78{,}5\\,\\%$.'},
  'C) $78{,}5\\,\\%$',
  2, 4, '2',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'Zelený C15 – procenta (přiřazování)',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 Cena zboží v obchodě se skládá ze základní ceny a tzv. daně z přidané hodnoty. Ta je dána procentem ze základní ceny zboží. Stát zvýšil daň z $10\\,\\%$ na $20\\,\\%$. O kolik korun bude po změně daně dražší nákup, který dříve stál $1100$ Kč?','15.2 Konečně slevy! Barbus zlevnil ohýbák na rohlíky o pětinu. A u Trambuse šli dolů s cenou dokonce o třetinu. O kolik korun se lišily ceny v těchto obchodech před slevami, víme-li, že nyní stojí ohýbák v obou obchodech $800$ korun?','15.3 Všichni očekávali, že letos roční jízdenky zlevní o osminu původní ceny. Místo toho jejich cena stoupla o čtvrtinu. O kolik korun se liší realita od očekávání, jestli před úpravou ceny stála jízdenka $800$ Kč?'},
  new List<String>{'A) $0$','B) $100$','C) $200$','D) $300$','E) $400$','F) jiný výsledek'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Původní cena $1100$ Kč $=$ základ $+ 10\\,\\%$, tedy základ $= 1000$ Kč. Nová cena $= 1000 \\cdot 1{,}2 = 1200$ Kč. Zdražení $= 1200 - 1100 = 100$ Kč → B.','15.2 Barbus: $0{,}8 \\cdot x = 800 \\Rightarrow x = 1000$. Trambus: $\\dfrac{2}{3} \\cdot y = 800 \\Rightarrow y = 1200$. Rozdíl před slevami $= 1200 - 1000 = 200$ Kč → C.','15.3 Očekávání: $800 \\cdot \\dfrac{7}{8} = 700$. Realita: $800 \\cdot \\dfrac{5}{4} = 1000$. Rozdíl $= 1000 - 700 = 300$ Kč → D.'},
  '15.1: B ($100$ Kč); 15.2: C ($200$ Kč); 15.3: D ($300$ Kč)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','finance'}
);

System.debug('Vytvořeno úloh: '+c.created);
