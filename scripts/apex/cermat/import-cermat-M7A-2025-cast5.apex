String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PAD25C0T01';
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
  'CERMAT M7A 2025 - uloha 14',
  new List<String>{'Z 12 shodnych kvadru jsou slepena dve telesa - krychle s hranou delky 9 cm a teleso tvaru schodiste.','O kolik cm2 se lisi povrch telesa tvaru schodiste a povrch krychle?'},
  new List<String>{'A) nelisi se','B) o 27,0 cm2','C) o 40,5 cm2','D) o 81,0 cm2','E) o 108,0 cm2'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 420 190" font-family="sans-serif"> <polygon points="40,70 120,70 120,150 40,150" fill="#eeeeee" stroke="#000" stroke-width="1.5"/> <polygon points="40,70 62,52 142,52 120,70" fill="#f6f6f6" stroke="#000" stroke-width="1.5"/> <polygon points="120,70 142,52 142,132 120,150" fill="#e2e2e2" stroke="#000" stroke-width="1.5"/> <text x="90" y="175" font-size="12" text-anchor="middle">krychle</text> <polygon points="250,150 250,70 292,70 292,100 334,100 334,130 376,130 376,150" fill="#eeeeee" stroke="#000" stroke-width="1.5"/> <line x1="250" y1="70" x2="270" y2="56" stroke="#000" stroke-width="1"/> <line x1="292" y1="70" x2="312" y2="56" stroke="#000" stroke-width="1"/> <text x="315" y="175" font-size="12" text-anchor="middle">schodiste</text> </svg>',
  'krychle-schodiste.svg',
  'Vlevo krychle slozena z 12 kvadru, vpravo teleso tvaru schodiste ze stejnych kvadru (schematicky).',
  'Schematicky nakres krychle a schodiste',
  new List<String>{'Krychle ma povrch $6\\cdot 9^2=486$ cm2. Obe telesa jsou slepena z tychz 12 shodnych kvadru, maji tedy stejny objem, ale schodiste ma vice odkrytych sten. Jeho povrch je o $81{,}0$ cm2 vetsi nez povrch krychle (tj. 567 cm2).'},
  'D) o 81,0 cm2',
  2, 5, '3',
  new List<String>{'zs2','r7','stereometrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M7A 2025 - uloha 15',
  new List<String>{'Na dvou jazykovych skolach se kazdy zak uci dva cizi jazyky. K anglictine, ktera je povinna pro vsechny, voli zaci jako druhy cizi jazyk nemcinu, francouzstinu, nebo spanelstinu. Grafy ukazuji volbu druheho ciziho jazyka na jednotlivych skolach.','Priradte ke kazde otazce (15.1-15.3) spravnou odpoved (A-F).','15.1 O kolik se lisi celkovy pocet zaku na prvni a na druhe skole?','15.2 Kolik zaku z obou skol dohromady se uci francouzstinu?','15.3 O kolik zaku vice se na prvni skole uci nemcinu nez francouzstinu?'},
  new List<String>{'A) 100 zaku','B) 120 zaku','C) 150 zaku','D) 180 zaku','E) 210 zaku','F) jiny pocet zaku'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 290" font-family="sans-serif"> <text x="130" y="22" font-size="14" text-anchor="middle" font-weight="bold">Prvni skola</text> <path d="M130 150 L130 75 A75 75 0 1 1 79 205 Z" fill="#d8d8d8" stroke="#000"/> <path d="M130 150 L79 205 A75 75 0 0 1 59 127 Z" fill="#ffffff" stroke="#000"/> <path d="M130 150 L59 127 A75 75 0 0 1 130 75 Z" fill="#555555" stroke="#000"/> <text x="155" y="170" font-size="13" text-anchor="middle">62 %</text> <text x="82" y="182" font-size="12" text-anchor="middle">18 %</text> <line x1="90" y1="54" x2="98" y2="92" stroke="#000" stroke-width="0.8"/> <text x="78" y="47" font-size="12" text-anchor="middle">100 zaku</text> <text x="440" y="22" font-size="14" text-anchor="middle" font-weight="bold">Druha skola</text> <line x1="330" y1="70" x2="330" y2="210" stroke="#000"/> <line x1="330" y1="210" x2="525" y2="210" stroke="#000"/> <rect x="345" y="80" width="45" height="130" fill="#d8d8d8" stroke="#000"/> <text x="367" y="72" font-size="12" text-anchor="middle">270 zaku</text> <rect x="410" y="152" width="45" height="58" fill="#ffffff" stroke="#000"/> <text x="432" y="145" font-size="12" text-anchor="middle">20 %</text> <rect x="475" y="109" width="45" height="101" fill="#555555" stroke="#000"/> <text x="497" y="102" font-size="12" text-anchor="middle">35 %</text> <rect x="40" y="258" width="12" height="12" fill="#d8d8d8" stroke="#000"/><text x="57" y="268" font-size="11">Nemcina</text> <rect x="150" y="258" width="12" height="12" fill="#ffffff" stroke="#000"/><text x="167" y="268" font-size="11">Francouzstina</text> <rect x="300" y="258" width="12" height="12" fill="#555555" stroke="#000"/><text x="317" y="268" font-size="11">Spanelstina</text> </svg>',
  'grafy-jazyky.svg',
  'Kruhovy graf prvni skoly (nemcina 62 %, francouzstina 18 %, spanelstina 20 % = 100 zaku) a sloupcovy graf druhe skoly (nemcina 270 zaku = 45 %, francouzstina 20 %, spanelstina 35 %).',
  'Volba druheho ciziho jazyka na dvou skolach',
  new List<String>{'Prvni skola: spanelstinu (100 zaku) voli 20 % zaku, celkem $100:0{,}2=500$ zaku (nemcina 62 % = 310, francouzstina 18 % = 90). Druha skola: nemcinu (270 zaku) voli 45 %, celkem $270:0{,}45=600$ zaku (francouzstina 20 % = 120, spanelstina 35 % = 210).','15.1 Rozdil poctu zaku $600-500=100$, tedy A.','15.2 Francouzstinu se uci $90+120=210$ zaku, tedy E.','15.3 Na prvni skole $310-90=220$ zaku; takova moznost neni, tedy F.'},
  '15.1: A (100 zaku); 15.2: E (210 zaku); 15.3: F (o 220 zaku)',
  6, 9, '3',
  new List<String>{'zs2','r7','statistika','vypocet','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
