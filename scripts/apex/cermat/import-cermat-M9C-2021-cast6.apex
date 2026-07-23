String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PCD21C0T03';
Integer YEAR = 2021;

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
  'CERMAT M9C 2021 – úloha 14',
  new List<String>{'Kolmý šestiboký hranol byl vytvořen opracováním krychle o hraně délky 8 cm. Podstava hranolu vznikne ze čtvercové stěny původní krychle oddělením 4 shodných pravoúhlých trojúhelníků s odvěsnami délek 3 cm a 4 cm. Výška hranolu je 8 cm (viz obrázek).','Jaký je povrch šestibokého hranolu?'},
  new List<String>{'A) $160$ cm²','B) $192$ cm²','C) $240$ cm²','D) $272$ cm²','E) $336$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 210" font-family="sans-serif"><text x="92" y="16" font-size="13" text-anchor="middle">Podstava hranolu</text><rect x="20" y="30" width="144" height="144" fill="#ededed" stroke="#999" stroke-width="1"/><polygon points="74,30 110,30 164,102 110,174 74,174 20,102" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/><text x="137" y="24" font-size="13" text-anchor="middle">3 cm</text><text x="170" y="72" font-size="13">4 cm</text><text x="92" y="192" font-size="13" text-anchor="middle">8 cm</text><polygon points="441,25 463,25 496,69 463,113 441,113 408,69" fill="#f2f2f2" stroke="#777" stroke-width="1.2"/><line x1="415" y1="55" x2="463" y2="25" stroke="#777" stroke-width="1.2"/><line x1="448" y1="99" x2="496" y2="69" stroke="#777" stroke-width="1.2"/><line x1="415" y1="143" x2="463" y2="113" stroke="#777" stroke-width="1.2"/><line x1="393" y1="55" x2="441" y2="25" stroke="#777" stroke-width="1.2"/><polygon points="393,55 415,55 448,99 415,143 393,143 360,99" fill="#c9c9c9" stroke="#000" stroke-width="1.8"/><text x="470" y="50" font-size="13">8 cm</text></svg>',
  'sestiboky-hranol.svg',
  'Podstava – šestiúhelník vzniklý ze čtverce 8×8 cm oddělením rohových trojúhelníků (odvěsny 3 a 4 cm) – a šestiboký hranol výšky 8 cm.',
  'Podstava a šestiboký hranol (výška 8 cm)',
  new List<String>{'Obsah podstavy je $40$ cm². Přepona každého odděleného trojúhelníku má délku $\\sqrt{3^{2}+4^{2}}=5$ cm; obvod šestiúhelníkové podstavy tvoří čtyři přepony po 5 cm a dvě zbylé strany po 2 cm, tj. $4\\cdot 5+2\\cdot 2=24$ cm. Plášť $=24\\cdot 8=192$ cm². Povrch $=2\\cdot 40+192=272$ cm².'},
  'D) $272$ cm²',
  2, 5, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9C 2021 – úloha 15',
  new List<String>{'Přiřaďte ke každé úloze (15.1–15.3) odpovídající výsledek (A–F).','15.1 V domově pro seniory je 120 klientů a 84 z nich bylo očkováno. Kolik procent klientů domova pro seniory nebylo očkováno?','15.2 Vláďa má 40 kartiček. Roman má o čtvrtinu kartiček více než Vláďa. O kolik procent má Vláďa méně kartiček než Roman?','15.3 Cena za víkendový pobyt činila 2 000 korun a zahrnovala pouze dopravu, ubytování a stravování. Cena dopravy tvořila čtvrtinu ceny pobytu, ubytování stálo 800 korun. Kolik procent ceny pobytu tvořila cena stravování?'},
  new List<String>{'A) $20\\,\\%$','B) $25\\,\\%$','C) $30\\,\\%$','D) $33\\,\\%$','E) $35\\,\\%$','F) jiný počet procent'},
  0,
  null,
  null,
  null,
  null,
  new List<String>{'15.1 Neočkovaných je $120-84=36$, tj. $\\dfrac{36}{120}=0{,}3=30\\,\\%$ → C.','15.2 Roman má $40\\cdot 1{,}25=50$ kartiček. Vláďa má o $\\dfrac{50-40}{50}=\\dfrac{10}{50}=20\\,\\%$ méně → A.','15.3 Doprava $\\dfrac{1}{4}\\cdot 2\\,000=500$ Kč, ubytování 800 Kč, stravování $2\\,000-500-800=700$ Kč, tj. $\\dfrac{700}{2\\,000}=35\\,\\%$ → E.'},
  '15.1: C ($30\\,\\%$); 15.2: A ($20\\,\\%$); 15.3: E ($35\\,\\%$)',
  6, 9, '4',
  new List<String>{'zs2','r9','procenta','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
