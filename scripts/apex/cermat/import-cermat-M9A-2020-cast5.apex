String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M9PAD20C0T01';
Integer YEAR = 2020;

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
  'CERMAT M9A 2020 – úloha 13',
  new List<String>{'Podstavou kolmého trojbokého hranolu $ABCDEF$ je pravoúhlý trojúhelník s odvěsnami délek $a = 9$ cm a $b = 12$ cm. Obsah největší boční stěny $ABED$ je $300$ cm² (viz obrázek).','Jaký je povrch hranolu?'},
  new List<String>{'A) $828$ cm²','B) $888$ cm²','C) $936$ cm²','D) $1\\,008$ cm²','E) $1\\,080$ cm²'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 300" font-family="sans-serif"> <polygon points="70,250 250,250 250,90 70,90" fill="#f4f4f4" stroke="#000" stroke-width="2"/> <line x1="70" y1="90" x2="205" y2="50" stroke="#000" stroke-width="2"/> <line x1="250" y1="90" x2="205" y2="50" stroke="#000" stroke-width="2"/> <line x1="205" y1="50" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="70" y1="250" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <line x1="250" y1="250" x2="205" y2="210" stroke="#000" stroke-width="1" stroke-dasharray="4 4"/> <text x="56" y="92" font-size="15" font-style="italic">D</text><text x="256" y="92" font-size="15" font-style="italic">E</text> <text x="200" y="44" font-size="15" font-style="italic">F</text> <text x="58" y="267" font-size="15" font-style="italic">A</text><text x="252" y="267" font-size="15" font-style="italic">B</text> <text x="212" y="226" font-size="15" font-style="italic">C</text> <text x="128" y="242" font-size="14" font-style="italic">b</text><text x="232" y="242" font-size="14" font-style="italic">a</text> </svg>',
  'hranol.svg',
  'Kolmý trojboký hranol ABCDEF s pravoúhlou trojúhelníkovou podstavou (odvěsny a, b) a obdélníkovou boční stěnou ABED.',
  'Kolmý trojboký hranol ABCDEF',
  new List<String>{'Přepona podstavy $c = \\sqrt{9^2+12^2} = \\sqrt{225} = 15$ cm. Největší stěna leží na přeponě: $300 = 15\\cdot v \\Rightarrow v = 20$ cm (výška hranolu). Obsah podstavy $S_p = \\frac{1}{2}\\cdot 9\\cdot 12 = 54$ cm². Plášť $= (9+12+15)\\cdot 20 = 36\\cdot 20 = 720$ cm². Povrch $= 2\\cdot 54 + 720 = 828$ cm².'},
  'A) $828$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r9','stereometrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M9A 2020 – úloha 14',
  new List<String>{'Pravoúhlý trojúhelník s odvěsnami délek $12$ cm a $6$ cm je dvěma úsečkami rovnoběžnými s kratší odvěsnou rozdělen na tři rovinné útvary. Úsečky rozdělily delší odvěsnu na tři úseky délek $6$ cm, $4$ cm a $2$ cm (viz obrázek).','Jaký je obsah tmavého útvaru?'},
  new List<String>{'A) $16$ cm²','B) $18$ cm²','C) $20$ cm²','D) $21$ cm²','E) jiný obsah'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 260" font-family="sans-serif"> <polygon points="40,220 400,220 400,40" fill="none" stroke="#000" stroke-width="2"/> <polygon points="220,220 340,220 340,70 220,130" fill="#c2c2c2" stroke="#000" stroke-width="1.5"/> <line x1="220" y1="220" x2="220" y2="130" stroke="#000" stroke-width="1.5"/> <line x1="340" y1="220" x2="340" y2="70" stroke="#000" stroke-width="1.5"/> <line x1="416" y1="40" x2="416" y2="220" stroke="#000" stroke-width="1"/> <polygon points="416,40 412,50 420,50" fill="#000"/><polygon points="416,220 412,210 420,210" fill="#000"/> <text x="424" y="135" font-size="14">6 cm</text> <text x="130" y="240" font-size="13" text-anchor="middle">6 cm</text> <text x="280" y="240" font-size="13" text-anchor="middle">4 cm</text> <text x="370" y="240" font-size="13" text-anchor="middle">2 cm</text> </svg>',
  'trojuhelnik-utvary.svg',
  'Pravoúhlý trojúhelník s odvěsnami 12 cm a 6 cm rozdělený dvěma svislými úsečkami; prostřední (tmavý) útvar je vyznačen šedě.',
  'Rozdělení trojúhelníku na tři útvary',
  new List<String>{'Výška útvaru roste od nulového vrcholu lineárně ($y = \\frac{x}{2}$). Dělící úsečky jsou ve vzdálenostech $6$ cm a $10$ cm od tohoto vrcholu a mají délky $3$ cm a $5$ cm. Tmavý (prostřední) útvar je lichoběžník se základnami $3$ cm a $5$ cm a výškou $4$ cm: $S = \\frac{3+5}{2}\\cdot 4 = 16$ cm².'},
  'A) $16$ cm²',
  2, 4, '3',
  new List<String>{'zs2','r9','planimetrie','vypocet','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
